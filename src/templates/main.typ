// standalone layout without configuring any other packages.
#import "./layout.typ": simple
// imports various packages, setup essential show rules etc.
#import "./preamble.typ"

// Define shorthands for symbols. Not including definition of thms.
#import "./shorthands.typ"
// Thms definition and show-rules with zkgraph enabled.
#import "./thm_typzk.typ"
// Thms definition and show-rules without zkgraph. Mutually exclusive with "thm_typzk.typ"
#import "./thm_vanilla.typ"
// Proof setup
#import "./pf3.typ"
