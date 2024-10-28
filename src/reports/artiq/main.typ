#import "/templates/main.typ": simple, preamble, thm_vanilla
#import "@preview/fletcher:0.5.2" as fletcher: diagram, node, edge

#show: simple.with(
  title: "ARTIQ Diagnostic Streaming Project Report",
  authors: ((name: "Kanyang Ying", email: "kanyang.ying@worc.ox.ac.uk"),),
  disp_content: true,
)
#import preamble: *
#import thm_vanilla: eg, thm_setup
#show: setup
#show figure: set block(breakable: true)
#show: thm_setup

#pagebreak()

= Introduction
#link("https://github.com/m-labs/artiq/")[ARTIQ] is an open source control system used for quantum information experiments. #link("https://sinara-hw.github.io/")[Sinara] is the open source hardware project used by ARTIQ system.

The streamer prototype we implemented in this project is capapble of streaming the samples from Sinara "Sampler" ADC (analogue-to-digital convertor) to ARTIQ Dashboard. It is designed to be compatible with messages in ARTIQ analyzer, hence through extension it can in principle stream a broad range of messages.

User should be noted that the performance of the prototype isn't entirely desirable, and some understanding of the design/implementation would be useful to achieve desirable outcome.

This document is written for the git revision `c6a9057a07950ccaa01adf7515938f03fc865bfb`.

= Usage
The basic setup is as following
#let colors = (maroon, olive, eastern)

#figure(
diagram(
	edge-stroke: 1pt,
	node-corner-radius: 3pt,
	mark-scale: 80%,

	node((0,-0.5), [Kasli], fill: colors.at(0)),
        node((0,0), [$dots.v$]),
	node((0,0.5), [Kasli], fill: colors.at(0)),
	edge("-|>", label: "UDP"),
	edge((0,-0.5), (2, 0), "-|>", label: "UDP"),
	node((2, 0), [`artiq_streamer` \ publisher], fill: colors.at(1)),
        edge("-|>", label: "ZMQ"),
	node((4,0.5), [ARTIQ Dashboard], fill: colors.at(2)),
        node((4,0), [$dots.v$]),
	edge((2,0), (4, -0.5), "-|>", label: "ZMQ"),
	node((4,-0.5), [ARTIQ Dashboard], fill: colors.at(2)),
),
caption: [Basic setup]
)<fig:basic-setup>

#info[Currently, only the `master` variant of Kasli is supported.]

== Basic Idea<sec:basic-idea>
#figure(
  diagram(
    edge-stroke: 1pt,

    edge((0,0), (5,0), "-|>", label: $t$, label-anchor: "north", label-sep: -0.5em),
    edge((1,0), (4,0), "|-|", label: [Streaming Window]),
    edge((0.5, 2), (0.5, 0), "..*", label: [`trigger`], label-angle: auto, label-side: left),
    edge((1, 1), (1, 0), "..*", label: [`start`], label-angle: auto, label-side: right),
    edge((4, 1), (4, 0), "..*", label: [`end`], label-angle: auto, label-side: right)
  ),
  caption: [Triggering Setup]
)<fig:trigger>
In a usual setup, we set `start` and `end` manually (via `artiq_streamer set`) or in experiment code via ```python self.streamer.set_window(start, end)``` where `start, end` are in machine unit (nanosecond) relative to the trigger timestamp.

After relevant setup, we would call ```python self.streamer.set_trigger()``` in the experiment code which sets the trigger timestamp. And streaming will enable when we are in the _streaming window_.

== Kasli Setup
=== Building the gateware<sec:kasli-target-setup>
The ```python eem.SUServo.add_std()``` function has been patched to return a tuple ```python suservo, sample_tap``` instead of `suservo` only.

To use the ```python sample_tap```, the streamer gateware needs to be created in the target file:
```python
# Create the streamer using sample_tap as the source.
self.submodules.streamer = ClockDomainsRenamer("rio_phy")(
    streamer.Streamer(
      self.rtio_tsc,
      self.get_native_sdram_if(),
      [sample_tap],
      cpu_dw=self.cpu_dw,
    )
)
# Firmware needs to setup buffer adddresses etc via CSR.
self.csr_devices.append("streamer")
```
Another submodule `artiq.gateware.rtio.phy.servo.StreamerTrigger` is needed to control the streamer (set streaming window, enable/disable the streamer). Thus also needed in target:
```python
# RTIO component used to control the streamer.
self.submodules.streamer_ctrl = rtservo.StreamerTrigger(
    self.rtio_tsc, self.streamer
)
self.rtio_channels.append(rtio.Channel.from_phy(self.streamer_ctrl))
```
See also `artiq.gateware.targets.kasli_stream_test` as an example of a simple modified target.
=== Configure the publisher endpoint<sec:pub-endpoint>
Kasli needs to know where the `artiq_streamer` publisher (@fig:basic-setup) is to send data. This is configured using `flash_storage.img`.

Specifically, we make the flash_storage
```bash
artiq_mkfs -s mac KASLI_MAC -s ip KASLI_STATIC_IP -s streaming_publisher 10.255.6.1:5005 flash_storage_streaming.img
```
where `10.255.6.1:5005` should be substituted based on the address you plan to use for publisher.

And we flash it to kasli using
```bash
sudo artiq_flash -f flash_storage_streaming.img storage start
```

== Publisher Setup<sec:publisher-setup>
`artiq_streamer` is a standalone tool which can ran publisher or set up streaming window on-fly etc.

To use it as a publisher, by using nix,
```bash
git clone https://github.com/LEXUGE/artiq_streamer
nix run .#artiq_streamer -- publisher "tcp://0.0.0.0:5006" "0.0.0.0:5005"
```
where `0.0.0.0:5005` should be in accordance with `10.255.6.1:5005` previously (@sec:pub-endpoint). The address `tcp://0.0.0.0:5006` is where dashboard binds to send data via ZMQ (See also @fig:basic-setup).

Alternatively, you can directly compile and run `artiq_streamer` if you have Rust toolchain installed by `cargo run --release`

For more detail, see the help by ```bash
$ nix run .#artiq_streamer -- --help
Usage: artiq_streamer publish [PUBLISHER_ADDR] [UDP_ADDR]

Arguments:
  [PUBLISHER_ADDR]  [default: tcp://0.0.0.0:5006]
  [UDP_ADDR]        [default: 0.0.0.0:5005]

Options:
  -h, --help  Print help
```

== Experiment and Dashboard Setup
=== `device_db`
The `device_db` has to include the following two RTIO components:
1. a `StreamerTap` module which controls the prescaling/enable of the `sample_tap`.
2. a `Streamer` module which controls the enable/streaming window of the streamer.

```python
    "sample_tap" = {
        "type": "local",
        "module": "artiq.coredevice.suservo",
        "class": "StreamerTap",
        "arguments": {"channel": SAMPLE_TAP_CHANNEL },
    }
    "streamer" = {
        "type": "local",
        "module": "artiq.coredevice.suservo",
        "class": "Streamer",
        "arguments": {"channel": STREAMER_CHANNEL },
    }
```

The `SAMPLE_TAP_CHANNEL` has to be manually calculated, and is the added as the last RTIO component in the ```python eem.SUServo.add_std()```. See the function code for more detail.

The `STREAMER_CHANNEL` also needs to be manually calculated, and it depends on where you added `StreamerTrigger` in your target code (as in @sec:kasli-target-setup).

For example, see `artiq/examples/streaming` for a simple setup.

#warning[
As of now, ARTIQ master may have some issue with updating `device_db.py`, not showing up the newly added core devices. If necessary, restart the ARTIQ master.
]

=== Experiment/Kernel code
Refer to @sec:basic-idea first.

See also ```python artiq.coredevice.suservo``` for details on RTIO methods available in ARTIQ kernel. And also `artiq/examples/streaming` for a simple experiment.

=== Dashboard Setup
There is a `Streamer` tab in the dashboard, and different channels can be selected in that tab. When experiment is running, the plot will be automatically updated in accordance to trigger/streaming window settings.

#warning[
  Currently the publisher address that dashboard listens to (`tcp://0.0.0.0:5006` in @sec:publisher-setup) is _harcoded_ in `artiq/dashboard/streamer.py`. You would need to manually change it to `tcp://PUBLISHER_IP:PUBLISHER_PORT` in the code.
]

The result looks like this in dashboard:
#figure(
  image("imgs/sinwave.png", width: 100%),
  caption: [
    Plot of streamed ADC samples with a connected function generator, viewed in dashboard
  ],
)
#figure(
  image("imgs/single-qubit-gate.png", width: 100%),
  caption: [
    Plot of streamed ADC samples about laser pulses in a single qubit gate experiment, viewed in dashboard
  ],
)

== Set Streaming Window on-fly
Instead of setting streaming window using
```python
self.streamer.set_window(delta_start=START, delta_end=END)
```
in experiment code, we can also set it on fly using `artiq_streamer` by
```bash
nix run .#artiq_streamer -- set KASLI_IP:2001 START END
```
So if the IP address of Kasli is `10.255.6.177`, we would run

```bash
nix run .#artiq_streamer -- set 10.255.6.177:2001 START END
```
Note the port `2001` is static and set in firmware (`artiq/firmware/runtime/stream.rs`).

#pagebreak()

= Design
The prototype consists of
- A module in ARTIQ gateware used to intercept ("tap") the samples.
- A module in ARTIQ firmware to send tapped samples over Ethernet to PC.
- A standalone `artiq_streamer` command-line tool used as a publisher (see @fig:basic-setup).
- A module in ARTIQ dashboard used to plot and display data.

We will focus on the design of how firmware and gateware work together.
== Basic Data Structure
The idea is to implement a simple ring-buffer with gateware as producer and firmware as consumer. The producer writes `message` (a 32 bytes long payload) and consumer reads it. In practice, there are two types of messages:
1. `SampleMessage`
2. `StopMessage`
and the `StopMessage` will be appended automatically at the end of the streaming window (@fig:trigger). See `artiq/gateware/streamer.py` for the exact message format.

Every `SEGMENT_SIZE` number of consecutive `message`s will form a `segment`. The buffer size (in unit of `message`) is `buffer.len() = NUM_SEGMENT * SEGMENT_SIZE`.

Let `base_address` and `last_address` be the start and end addresses of the buffer respectively. For the sake of simplicity of illustration, *we treat each address as if corresponding to one `message`-long memory.* In other words, the machine is `message`-addressing.

Firmware will place a guard when it's reading, and gateware will fallback to protect the segment in use from overwritten by gateware.

In Rust-style psedo-code, the design looks like
#figure(
```rust
let mut guard = 0;

// Consumer (Firmware)

// The number of segment that we have already read.
// 0 represents nothing read yet. Pointer can be wrap around and be larger than or equal to NUM_SEGMENT.
// Since we label the segment from 0, this also represents (after mod NUM_SEGMENT) the segment that we are _about_ to read.
let mut consumer_pointer: usize = 0;

loop {
    // Get the number of segment the gateware has written completely.
    let producer_pointer = addr / SEGMENT_SIZE;

    // If we have still some completely-written segments not read.
    if consumer_pointer < producer_pointer {
        // As commented before, consumer_pointer also represents the segment we are _about_ to read after % NUM_SEGMENT.
        let wrapped_pointer = consumer_pointer % NUM_SEGMENT;

        // Place the guard so if gateware is about to be running into the segment we are curently reading, it will stop.
        guard = wrapped_pointer;

        // Read the `wrapped_pointer` segment in the buffer. And each segment is sent in a single UDP packet to the publisher.
        read_and_send_segment(wrapped_pointer);

        // We have read another segment, increment the pointer by definition.
        consumer_pointer += 1;
    }
}

// Producer (Gateware)

let mut addr = base_address;

// sample_tap_fifo is where sample tap feeds messages into the gateware.
while !sample_tap_fifo.is_empty() {
    write_message_to_memory(sample_tap_fifo.get_message());

    // ((addr + 1) / SEGMENT_SIZE) % NUM_SEGMENT: which segment our next message is gonna be in.
    // If the next message is gonna be in the segment which is currently guarded (i.e. currently reading)
    if ((addr + 1) / SEGMENT_SIZE) % NUM_SEGMENT == guard {
        // Fallback to the beginning of the current segment.
        // The next message will then start overwriting the current segment.
        addr -= (SEGMENT_SIZE - 1);
    } else {
        // Otherwise we are safe.

        // Increment the address, when reaching the end, start from the beginning.
        if addr == last_address {
            addr = base_address;
        } else {
            addr += 1;
        }
    }
}
```,
caption: [Pseudo-code of the firmware/gateware logic]
)<data-structure>


== Publisher and Dashboard
The simple gateware#footnote[It corresponds to the `DMAWriter` logic in `artiq/gateware/streamer.py`] presented in @data-structure doesn't care about what messages it's writing.
Each segment is sent in a single UDP packet to the publisher. The publisher will parse the packet and messages within it, and publishes each `message` as a ZMQ message, based on the RTIO channel contained within each message#footnote[`StopMessage` doesn't have a RTIO channel, and is sent in a ZMQ channel of its own: `STOP_CHANNEL`.].

And the dashboard will subscribe to the corresponding ZMQ channel, based on the `device_db` provided by dashboard, when user opens a new waveform. And dashboard then parses the `message`s received. When a `StopMessage` is received, the waveform is refreshed (*This is not a desirable implementation, see Future Improvements.*).

== Correctness and Existing Problems<sec:existing-problems>
In the end, we want to prioritize these goals for correctness:

#task[
1. `message`s' timestamps received by publisher should be in strictly increasing order. In particular
  1. timestamps of `message`s within each segment MUST be increasing.
  2. even between different segment, the timestamp should still be in order.
2. The timestamp between every `SampleMessage` to their next nearest `StopMessage` received by the publisher should be smaller than the streaming window length (see @fig:trigger).
  $ #text[`NextStopMessage.time`] - #text[`SampleMessage.time`] lt.eq #text[Streaming window length] $
  In other words, *the streaming window user sees on the dashboard should be strictly within the streaming window they set.*
3. The ratio
  $ #text[Number of messages contributing to a complete streaming window]/#text[Total number of messages] $
  should be as high as possible while maintaining reasonable throughput and delay.
]

The first goal is in practice achieved by our current design, as we are only reading complete segment, and each complete segment by definition contains consecutive messages. And guard protects us from data races and corruption.

Moreover, even though UDP protocol doesn't guarantee order of packets, in lab environment, we haven't encountered any out of order issue between segments under prolonged streaming (more than one hour).

The second goal is *not* achieved by the current design due to the following counterexample:

#eg[`StopMessage` period is not guaranteed][
  If `guard` is currently at 3, and the gateware has written a `StopMessage(time=t1)` in segment 2. Then in the next streaming window, if the guard doesn't move and streaming window is long enough, the `StopMessage(t1)` written will be overwritten.

  And user will see a prolonged streaming window due to the missing `StopMessage(t1)`.
]

In fact, the second goal is in theory unlikely to be completely achieved. Because it boils down to preserving all `StopMessage`s, and given in the extreme case a limited buffer size and a immobile guard, the gateware can not preserve all `StopMessage`s.

The last goal is not what our design is optimized for. This is evident as
#eg[`message` sent are not optimized for complete segment][
If the gateware runs into the guard, the last segment is overwritten, then current streaming window is already not complete.

  However, the firmware will still read the previous segments of the current streaming window, leading to wasted bandwidth/throughput.

  In the extreme case of long streaming window and low buffer size, we will get frequent but short (very short compared to streaming window set) waveform, which is not useful.

  It's more useful to stream less frequent but complete streaming window.
]<eg:incomplete-window>

An example of the @eg:incomplete-window is
#figure(
  image("imgs/incomplete-waveform.png"),
  caption: [An example of incomplete waveform streamed, the streaming window set is 1 second.]
)<fig:incomplete-waveform>

Seems like the limit for snappy response is at 8000 messages/second
- 100ms headroom, 10 ms streaming window seems to give no glitch.
- longer headroom seems to adversely affecting responsiveness.
- set tap window + headroom = streaming window will cause trouble

There are two parts that could cause delay:
- When there is very little headroom, firmware could have problem to catch up, causing delay in displaying data.
- When the update is very frequent, the dashboard has problem to flush them in time.

= Implementation Details
This section will contain detail and existing problems used to implement the design.

== Gateware
The gateware part of the streamer prototype lies in:
- `artiq/gateware/streamer.py`: `Streamer` and `message` encoding and buffer writing.
- `artiq/gateware/rtio/phy/servo.py`: `StreamerTrigger` and `TriggeredSampleTap` used for controlling streamer and sample tap via RTIO.
- `artiq/gateware/suservo/adc_ser.py`: `DownSampler` which can downsample and enable/disable tapping for ADC.
- `artiq/coredevice/suservo.py`: Contains modules used in kernel code to interface with `Streamer` and `DownSampler`.

#figure(
  diagram(
    node((0,0), [`Streamer` \ `streamer.py`], name: <streamer>),
    node((2,0), [`DownSampler` \ `suservo/adc_ser.py`], name: <sampler>),

    node((0,-2), [`StreamerTrigger` \ `rtio/phy/servo.py`], name: <streamer-ctrl>),
    node((2,-2), [`TriggeredSampleTap` \ `rtio/phy/servo.py`], name: <sampler-ctrl>),
    edge(<streamer-ctrl>, <streamer>, "-|>", label: [Controls]),
    edge(<sampler-ctrl>, <sampler>, "-|>", label: [Controls]),
    edge(<sampler>, <streamer>, "-|>", label: [Provides Data]),

    node((0,-4), [`Streamer` \ `coredevice/suservo.py`], name: <streamer-kernel-mod>),
    node((2,-4), [`StreamerTap` \ `coredevice/suservo.py`], name: <tap-kernel-mod>),

    edge(<streamer-kernel-mod>, <streamer-ctrl>, "-|>", label: [Issues RTIO output]),
    edge(<tap-kernel-mod>, <sampler-ctrl>, "-|>", label: [Issues RTIO output]),

    node((1, -5), [Kernel], name: <kernel>),

    edge(<kernel>, <streamer-kernel-mod>, "-|>", label: [Calls]),
    edge(<kernel>, <tap-kernel-mod>, "-|>", label: [Calls]),
  ),
  caption: [Gateware architecture, all paths under `artiq/gateware` except `coredevice/suservo.py`]
)<fig:gateware-architecture>

Specific details can be found in the respective source code.

And the streamer contains various different submodules,

#figure(
  diagram(
    node((-1, -5), [`DownSampler`], name: <sampler1>),
    node((1, -5), [`DownSampler`], name: <sampler2>),
    edge(<sampler1>, <multi-tap>, "-|>"),
    edge(<sampler2>, <multi-tap>, "-|>"),
    node(enclose: (<dma>, <msg-encoder>, <multi-tap>), // a node spanning multiple centers
inset: 20pt, stroke: teal, fill: teal.lighten(90%), name: <streamer>),
    node((0,0), [`DMAWriter`], name: <dma>),

    node((0,-2), [`MessageEncoder`], name: <msg-encoder>),
    edge(<msg-encoder>, <dma>, "-|>", label: [Feeds into \ `FIFO` \ `Convertor` \ finally]),

    node((0,-4), [`MultiSampleTap`], name: <multi-tap>),

    edge(<multi-tap>, <msg-encoder>, "-|>"),
  ),
  caption: [`streamer.py` architecture, `Streamer` basically aggregates the submodules in blue.]
)

Notably, we slightly adapted the logic in @data-structure because:
1. The memory is not actually `message`-addressable.
2. The gateware doesn't support modulo operation well.

=== MiSoC patch
An important patch `misoc_wishbone_add_uncached.patch` is needed for the gateware-firmware pair to function normally. The patch allows us to disable the CPU L2 cache for a certain user-specified memory region. In our case, this region is our buffer.

This allows us to always get the correct data instead of outdated data in L2 cache. *The reason this patch is needed is SDRAM (where our buffer lives) isn't really designed to be used by components other than CPU.*

== Firmware
We implemented UDP support using `smoltcp` in `artiq/firmware/runtime/sched.rs`, and the only other change is `artiq/firmware/runtime/stream.rs` where a logic very similar to @data-structure is implemented.

The `stream.rs` also implements the ```rust ctrl_thread()``` function which spawns the control logic that allows `artiq_streamer` (or any other tool) to set streaming window on-fly.

== `artiq_streamer`
The `artiq_streamer` uses `nom`, a parser combinator, to parse the `message` and segments received from Kasli. The parsing logic is located in `src/parser.rs` where relevant unit tests also reside.

To support additional messages, additional parsers should be written. The simple parser contained within doesn't support skipping unkown messages as of now.

== Dashboard
The main changes are:
- `artiq/dashboard/streamer.py`: where waveform plotting, ZMQ subscriber are handled.
- `artiq/dashboard/streamer_helper.py`: where decoding, device_db handling are done.
Both parts are rather hacky, and would benefit a lot from future improvements.

#pagebreak()

= Future Improvements
Many future improvements could be done. As for design problems, refer to @sec:existing-problems.

== Firmware
- The `artiq/firmware/runtime/stream.rs` module should be feature gated to allow disabling streamer in compile time for minimal overhead.
- It is found by empirical observation that the firmware consumes segments in a spiky pattern: blocks for certain time and consumes a lot in a short interval. This could be due to some scheduling problem.
  Solving this could potentially allow us to have less incomplete waveform as seen in @fig:incomplete-waveform, as even very low (~300 messages per second) throughput demand will suffer from this issue.

  More specifically, setting streaming window to `10ms` and trigger every `20ms` with downsampling rate of $16$ (i.e. sample every 16 samples) will produce the incomplete-waveform. Assuming a sampling rate of This parameter has a througput demand of
  $ 10^6 times 1/16 times 1 / 2 times 1/ 32 = 976.5625 #text[packets per second] $
  which is completely within the firmware performance limit of `~1400 pps`. Thus it should be scheduling issue limiting us from complete traces.
- A very simple modification is to disable the streamer when the user doesn't include `streaming_publisher` key in their config.
- Similar to `artiq_streamer`'s setting streaming window capability, a capability to trigger on-fly can also be implemented.

== Gateware
- The `MultiSampleTap` will lose samples if multiple samples arrive at the same time.
- The `message_count` in `DMAWriter` has hardcoded relation regarding whether `message_len` or `cpu_dw` is longer, which is not robust.
- A gateware-based consumer will be desirable as it should significantly improve the performance. Gateware-based UDP has already been implemented in the latest version of #link("https://github.com/enjoy-digital/liteeth")[LiteETH].

== Dashboard
- The plotting code `artiq/dashboard/streamer.py` has bad performance probably due to autoscaling on every refresh. In particular, the function
  ```python on_dump_receive(self, dump)
  ```
  should be fixed.
- The plotting could crash the dashboard, and the update has some signficant delay when the streaming window is small (i.e. dashboard refreshing rate is high).
- The publisher address should not be hardcoded.

= Some Measurements
#figure(
  image("imgs/wireshark-udp-1-byte.png"),
  caption: [UDP throughput of Kasli over Ethernet with 1 byte of payload.]
)

#figure(
  image("imgs/wireshark-udp-1024-bytes.png"),
  caption: [UDP throughput of Kasli over Ethernet with 1024 bytes of payload.]
)

#figure(
  image("imgs/maximum-streaming-throughput.png"),
  caption: [Streaming throughput of Kasli over Ethernet with 1024 bytes long segment/packet.]
)
