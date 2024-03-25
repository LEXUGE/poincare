// Modified by Kanyang Ying
/*
  pf3
  Written by Maxwell Thum (@maxwell-thum on GitHub)
  Last modified: September 5, 2023

  Based on the LaTeX style "pf2" by Leslie Lamport (https://lamport.azurewebsites.net/latex/pf2.sty)
  See also "How to Write a 21st Century Proof" by Lamport (2011) (https://lamport.azurewebsites.net/pubs/proof.pdf)
*/
/*
  TODO:
  - When custom elements are added to Typst, make #pfstep one so that its behaviors can be customized throughout a document using set rules.
*/
#let current_step = state("current_step", (0,)) // array of integers representing the current step

// these produce the corresponding text and indent the argument for visual clarity
#let pfassume(cont) = grid(columns: 2, smallcaps("Assume:") + h(0.25em), cont)
#let pfcase(cont) = grid(columns: 2, smallcaps("Case:") + h(0.25em), cont)
#let pfsuffices(cont) = grid(columns: 2, smallcaps("Suffices:") + h(0.25em), cont)
#let pflet(cont) = grid(columns: 2, smallcaps("Let:") + h(0.25em), cont)
#let pfclaim(cont) = grid(columns: 2, smallcaps("Claim:") + h(0.25em), cont)
#let pfdef(cont) = grid(columns: 2, smallcaps("Define:") + h(0.25em), cont)

// these just produce text
#let pf = smallcaps("Proof:")
#let pfsketch = smallcaps("Proof sketch:")

#let short_numbering(steparray) = [#sym.angle.l] + str(steparray.len()) + [#sym.angle.r #steparray.at(-1)]

// step of a structured proof.
#let pfstep(
  hide_pf: false, // you can optionally hide a specific step's proof.
  hide_level: 128, // deepest proof level to show. (optional; intended only to be customized with set rules once custom elements are added to Typst)
  mixed_numbers: 4, // use short step numbers for all levels >= N. (optional; ditto)
  long_numbers: true, // use long step numbers for all levels. in practice you could also just set pfmixednumbers to be very large. (optional; ditto)
  finished: false, // finish the proof
  claim, // text/claim of step
  pf_content, // proof of step
) = {
  // increment current step number
  current_step.update(x => {
    x.push(x.pop() + 1)
    return x
  })

  locate(
    loc => {
      let current_step_array = current_step.at(loc) // current step number array

      // corresponding formatted step number
      let current_step_number = {
        if current_step_array.len() >= mixed_numbers and not long_numbers {
          short_numbering(current_step_array)
        } else {
          current_step_array.map(str).join(".")
        }
      }

      grid(
        columns: 2,
        rows: 1,
        current_step_number + "." + h(0.25em),
        grid(
          rows: 2,
          row-gutter: 0.9em,
          pfclaim(claim),
          // show this step if the proof depth is <= pfhidelevel and it hasn't been hidden manually
          if (not hide_pf and current_step_array.len() < hide_level) {
            // now that we might add substeps, add a 0 to the end of the step number array
            current_step.update(x => {
              x.push(0)
              return x
            })

            // indent the proof of the step
            [#pf #pf_content]

            // after the step is proved, remove the leftover substep index
            current_step.update(x => {
              x.pop()
              if finished { x.last() = 0 }
              return x
            })
          },
        ),
      )
    },
  )
}
