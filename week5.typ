#import "lib.typ": *

#show: project.with()

#slide[
  #set page(header: none, footer: none, margin: 3em)

 
  #text(size: 1.3em)[
    *Foreign function interface*
  ]

  ITS8020

  #metropolis.divider
  
  #set text(size: .8em, weight: "light")
  Tavo Annus

  Nov 27, 2025
]

#slide[
  See: https://slightknack.github.io/rust-abi-wiki/intro/intro.html
]

#slide[
  = What is ABI
  ABIs describe two main facilities:

  - How data is laid out in memory
  - How functions are called.

  #note[
    The C ABI is "the oldest" ABI, dating back to C.
    The C ABI can be used from Rust through the use of `extern "C"`.
  ]
]

#slide[
  = What does it mean for an ABI to be stable?

  A stable ABI means that a compiler will consistently produce the same ABI for an executable across versions.

  #note[
    Rust has no stable ABI nor is it planning to add one.
  ]
]

#slide[
  = Why is a stable ABI a good thing?

  Stable ABI enables dynamic linking, incremental compilation over different compiler versions, hot reloading and more...
  
]

#slide[
  = Why is a stable ABI a bad thing?

  It doesn't let you change it therefore you cannot improve it.
]

#slide[
  = How to use stable ABI in Rust
  You reuse C ABI.
]

#slide[
  = Data types
  ```rs
  #[repr(C)]
  struct Foo {
    a: bool,
    b: u64,
  }
  ```
  #note[
    `repr(packed)` and `repr(align(n))` are modifiers on `repr(C)`.
  ]
  See https://doc.rust-lang.org/nomicon/other-reprs.html
]

#slide[
  = Functions
  ```rs
  // Explicitly "C"
  extern "C" fn foo(arg: bool) -> u32 { todo!() }
  // Implicitly "C"
  extern fn bar(arg: bool) -> u32 { todo!() }
  ```

  _Can we call them from C?_
]

#slide[
  = Functions

  ```rs
  // Turn off name mangling
  #[unsafe(no_mangle)]
  extern foo(arg: bool) -> u32 { todo!() }
  ```
]

#slide[
  = Linking against C
  ```rs
  extern "C" {
    // Use same name as Rust
    fn foo(arg: bool) -> u32;
    
    // Explicitly specify name
    #[link(name = "bar_in_c")]
    fn bar() -> f32;
  }
  ```
]

#slide[
  = Specifying files to link against
  ```rs
  // build.rs
  fn main() {
    // Tell which lib to link
    println!("cargo:rustc-link-lib=libmysharedlib");
    // Tell where to search
    println!("cargo:rustc-link-search=/opt/lib/abc");
  }
  ```
]

#slide[
  = Useful tools
  - #link("https://github.com/rust-lang/rust-bindgen")[`rust-bindgen`]
  - #link("https://github.com/mozilla/cbindgen")[`cbindgen`]
  - #link("https://github.com/rust-lang/cc-rs")[`cc-rs`]
  - #link("https://github.com/PyO3/pyo3")[`PyO3`]
  - #link("https://github.com/mlua-rs/mlua")[`mlua`]
]

#new-section[`unsafe`]

#slide[
  = `unsafe` superpowers

  1. Dereference a raw pointer
  2. Call an unsafe function or method
  3. Access or modify a mutable static variable
  4. Implement an unsafe trait
  5. Access fields of unions


  See https://doc.rust-lang.org/book/ch20-01-unsafe-rust.html
]

#slide[
  ```rs
  extern "C" {
    fn puts(s: *const i8);
  }

  fn main() {
    let msg = b"Hello from Rust!\0".as_ptr() as *const i8;
    unsafe {
        puts(msg);
    }
  }
  ```
]

#slide[
  Best practice is to wrap all C function calls in safe Rust functions to guarantee safety

  #note[
    Note that the function has to be safe to call from anywhere, not just from your current implementation.
    This includes multi-threaded code!
  ]
]

#slide[

]