#import "@preview/polylux:0.4.0": *
#import "@preview/metropolis-polylux:0.1.0" as metropolis
#import metropolis: new-section, focus

#show: metropolis.setup

// Make the paper dimensions fit for a presentation and the text larger
#set page(paper: "presentation-16-9")
#set text(size: 25pt)

#set text(font: "Inria Sans")

#show link: it => {
  set text(blue)
  if type(it.dest) != str {
    it
  }
  else {
    underline(it)
  }
}

#slide[
  #set page(header: none, footer: none, margin: 3em)

 
  #text(size: 1.3em)[
    *Tooling, compilation*
  ]

  ITS8020

  #metropolis.divider
  
  #set text(size: .8em, weight: "light")
  Tavo Annus

  Jan 16, 2025
]

#new-section[Tooling]

#slide[
  = Compiler: `rustc`

  The "one and only" Rust compiler

  Similar to C/C++ compilers (say `gcc` or `clang`)

  Does the compilation part (gives back object files)
  Usually not invoked directly

  Compilation steps: #link("https://blog.rust-lang.org/2016/09/08/incremental/")
  
  See how `cargo` calls `rustc` with `cargo build --verbose`
]

#slide[
  = Compiler: `rustc`

  `rustc` supports multiple codegen backends:
   - LLVM is default (and only stable)
   - GCC (for more supported archidectures)
   - Cranelift (for faster compilation)
]

#slide[
  = Linker
  Usually system linker is used aka same as for C/C++

  You can use other linkers (for example for embedded)

  Usually everything is statically linked (dynamically in C)
  
]

#slide[
  = Package manager: `cargo`

  Similar to `pip`, `gradle`, `maven`, etc.

  Helps managing dependencies and setting up complex builds.

  Packages in Rust are called `crates`.
  
  The official repository for `crates` is #link("https://crates.io/")

  Crate is also the single/smallest compilation unit.

  _What is the smallest compilation unit in C/C++?_
]

#slide[
  = Formatter: `rustfmt`

  Official code formatter for Rust

  Loosely inspired by Go: 
  "Gofmt's style is no one's favorite, yet gofmt is everyone's favorite."
]

#slide[
  = Linter: `clippy`

  Official code linter for Rust

  More opinionated than `rustc` that also does a bit of linting.

  Supports multiple levels/groups of lints, see #link("https://rust-lang.github.io/rust-clippy/")

]

#new-section[Compilation]

#slide[
  = General model
  Same as for C:
  1. Lex & parse source to get Abstract syntax tree (AST)
  2. Perform optimizations in intermediate representations (IR)
  3. Write machine readable instructions to object files
  4. Link object files together to executable
]

#slide[
  = Generics

  _How to translate generic functions/data to object files?_

  #uncover(2)[
  ```rs
  fn sum<T: Add>(a: T, b: T) -> T {
    a + b
  }
  ```]
]

#slide[
  = Monomorphization

  Generate code for each variant of the function

  _How to deal with conflicting symbols?_

  #uncover(2)[
    Just mangle them by adding "random" parts to it

    ```
    foo::example_function
    ->
    _RNvCskwGfYPst2Cb_3foo16example_function
    ```
  ]
]

#slide[
  = Dynamic dispatch

  Build a `vtable` which tells which function to call

  Very close to what most OOP languages do (C++, Java, C\#, ...)

  ```rs
  trait Animal { /* ... */ }
  let cat = Cat::new();
  let dog = Dog::new();
  let animals: Vec<&dyn Animal> = vec![&cat, &dog];
  ```

  See `dyn` compatibility #link("https://doc.rust-lang.org/reference/items/traits.html#dyn-compatibility")
]

#slide[
  = Static vs dynamic dispatch
  _Which is faster? why?_

  _Which has smaller binary size? why?_

  _Which takes longer to compile? why?_

  _Who should decide: library author or consumer?_
]

#new-section[Pointers]

#slide[
  = Reference vs pointer
  Pointer just points somewhere - no guarantees.

  Reference references data - no `NULL` etc.

  You can think of references as pointer with extra guarantees
]

#slide[
  = Fat pointers
  Fat pointer = pointer + metadata

  `x: &dyn Foo => {pointer to x} + {pointer to vtable of Foo}`
  
  `x: &[bool] => {pointer to x} + {size of array}`

  _What is in `struct String { .. }`?_
]

#slide[
  = Pointer arithmetic
  There is no pointer arithmetic in Rust.

  But you can convert to `u64`/`u32` and back or use `unsafe` helper methods.

  However, de-referencing a pointer needs `unsafe` so you should avoid it by default and use only when you know what you are doing.
]
