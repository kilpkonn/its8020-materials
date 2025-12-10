#import "lib.typ": *

#show: project.with()

#slide[
  #set page(header: none, footer: none, margin: 3em)

 
  #text(size: 1.3em)[
    *Design and architecture*
  ]

  ITS8020

  #metropolis.divider
  
  #set text(size: .8em, weight: "light")
  Tavo Annus

  Dec 11, 2025
]

#slide[
  See https://www.tedinski.com/ for good articles on SW design and architecture
]

#slide[
  The best approach we have for doing software development is iterative improvement.

  _But what should we prioritize to fix sooner rather than later?_
]

#slide[
  = System boundaries
  A system boundary is a publicly exposed interface that third-party developers are going to use.

  #note[
    Third-party here does not have to reflect truly external party, but it can be other team / developer.
    The important part is that getting them to change something is HARD.
  ]
]

#slide[
  = System boundaries
  System boundaries are more important than rest of the program as braking changes are more costly there.

  As a rule of thumb, system boundaries take the form of versioned artifact of some kind.

  #note[
      We version it as we know, we will have to change it and likely brake it at some point.
  ]
]

#slide[
  = Are system boundaries found or created?
  Sometimes system boundaries are found when external users start using your program.

  In other cases, they are created, advertised and then users start using it.
]

#slide[
  = Why create system boundary?

  The main reason for creating system boundaries is that it is the ONLY approach to truly re-using code.

  #note[
    Boundaries are not free, as they need maintaining, changes are hard to do and so on...
  ]
]

#slide[
  = Dependencies

  Dependencies of a system are also part of the interface of that system.

  And they are usually hard to change, so most likely part of system boundary.

  #note[
    Not depending on a system means systems are decoupled
  ]
]

#slide[
  = Rules are different at the system boundaries

  _Should you follow DRY at system boundary?_

  _Should the interface be powerful, generic or something in between?_

  _Prefer functions or data?_
]

#slide[
  For every complex problem there is an answer that is clear, simple, and wrong.
]

#slide[
  = Powerful <=> useful

  There is a natural tradeoff between powerful and useful - you cannot make abstraction more powerful without making it less useful.

  #note[
    You can do the opposite tho: make it less powerful without making it more useful.
    That is called poor software design.
  ]
]

#slide[
  = Design duality: Functions vs data interfaces
  - If you only expose functions (and actually some data) you can freely modify the data without braking anything.
  - If you only expose data (and actually some functions) you can freely modify functions without braking anything.

  _Which is most commonly preferred / suggested?_
]

#slide[
  = Why you should only test at system boundaries?
  - These are the only interfaces that we care about
  - You should not test for what happens, but for what should happen
  - If you didn't brake API, but the test starts failing, you are testing it wrong
]

#slide[
  = Documenting functions
  - What inputs?
  - What outputs?
  - Can anything else happen? (panic, modify state)
  - Does something else relate to it?

  #note[
    You should usually prefer types to text.
  ]
]

#slide[
  = Kinds of documentation
  - Reference
  - Example
  - Guide
  #note[
    There are multiple other ways to categorize documentation.
  ]
]

#slide[
  = Hot takes on OOP
  OOP is so popular because it forces us to categorize things:
  It is something we have been taught to do throughout entire life.

  This doesn't mean we are good at it nor does it mean it is necessary to do.

  It just gives low hanging fruits to pick, so we feel progress.
]

#slide[
  = Hot takes on OOP

  How many times have you performed a successful refactor in OOP?
  - Something that wasn't trivial anyway
  - Something that took less time than expected
  - Something that would have taken longer in other language
]

#slide[
  = Everything is a people problem
  When working in a team, every problem (unless solved) is people problem.

  We can spend months arguing about SW architecture and solve the issue by changing people working on it.

  Since we can only know the truth when looking back at things, every technical argument at its core is: "I like this, you like that".
]