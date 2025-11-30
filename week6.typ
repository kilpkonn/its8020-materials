#import "lib.typ": *

#show: project.with()

#slide[
  #set page(header: none, footer: none, margin: 3em)

 
  #text(size: 1.3em)[
    *Windowing systems: Xorg and Wayland*
  ]

  ITS8020

  #metropolis.divider
  
  #set text(size: .8em, weight: "light")
  Tavo Annus

  Dec 4, 2025
]

#slide[
  Windowing systems are not only about drawing stuff,
  they also handle inputs/outputs and do lots of other stuff.
]

#new-section[
  Xorg
]

#slide[
  = Xorg
  X.Org is a non-profit corporation chartered to research, develop, support, organize, administrate, standardize, promote, and defend a free and open accelerated graphics stack.

  The most well known project is the X Window System and it's implementation the X.Org Server.
  #note[
    Xorg, X11, X server etc. are often used to refer to same thing.
  ]
]

#slide[
  Good guide for X11: https://www.x.org/wiki/guide/concepts/#index1h2
]

#slide[
  = X Window System
  - Client - Server model
  - Clients tell what to draw, inputs, etc.
  - Server communicates with kernel to draw, or forwards events
  - Most commonly Unix sockets are used for IPC
  - Other options are available as extensions
  #note[
    Client and server can be confusing as server may be on you laptop (drawing graphics) while the client may be "on server" telling what to draw.
  ]
]

#slide[
  #figure(
    image("fig/x-architecture.webp")
  )
]

#new-section[
  Wayland
]

#slide[
  Wayland is a communication protocol that specifies the communication between a display server and its clients, as well as a C library implementation of that protocol.

  #note[
    The C library is only for protocol (messages)
  ]
]

#slide[
  = Wayland
  - Throws away Xserver component - now compositor is the server
  - Rendering is done in the app (render to buffer and tell the compositor to use that)

  #note[
    DRI2 under X: direct rendering achieves the same rendering for X
  ]
]

#slide[
  #figure(
    image("fig/wayland-architecture.webp")
  )
]

#slide[
  Good guide to wayland https://wayland.freedesktop.org/
]

#slide[
  #figure(
    image("fig/wayland-lies.webp")
  )
]

#slide[
  = Mess with GPU drivers
  Two competing protocols:
  - GBM for Mesa (Intel/AMD)
  - EGL for Nvidia
]
