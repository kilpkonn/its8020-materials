#import "lib.typ": *

#show: project.with()

#slide[
  #set page(header: none, footer: none, margin: 3em)

 
  #text(size: 1.3em)[
    *Memory management: ownership, lifetimes*
  ]

  ITS8020

  #metropolis.divider
  
  #set text(size: .8em, weight: "light")
  Tavo Annus

  Jan 16, 2025
]

#new-section[Ownership]

#slide[
 Ownership#footnote[From: https://doc.rust-lang.org/book/ch04-00-understanding-ownership.html] is Rust’s most unique feature and has deep implications for the rest of the language. It enables Rust to make memory safety guarantees without needing a garbage collector, so it’s important to understand how ownership works.
]

#slide[
  = Context

  All programs have to manage memory somehow during runtime:
  - Some use garbage collectors that allocate and free memory
  - Same require programmer to explicitly allocate and free memory
  - Rust uses third approach: ownership - a set of memory related rules that the compiler checks and refuses to compile if anything is violated
]

#slide[
  = Ownership Rules
  From the Rust book#footnote[https://doc.rust-lang.org/book/ch04-01-what-is-ownership.html]:
  1. Each value in Rust has an owner.
  2. There can only be one owner at a time.
  3. When the owner goes out of scope, the value will be dropped.
]

#slide[
  = Variable scope
  ```rs
  let a = "foo";
  {
    let b = "bar";
    println!("{a}, {b}"); // Both in scope
  }
  println!("{a}, no b"); // `b` not in scope
  ```
]

#slide[
  = Variable scope
  
  ```rs
  {
    let s1 = "foo"; // Allocated on stack
    let s2 = String::from("foo"); // Allocated on heap
  }
  // Neither `s1` nor `s2` is in scope
  ```
]

#slide[
  = Memory allocation

  ```rs
  {
    let s = String::from("foo"); // Allocate memory (heap)
    // ...
  } // Give memory back to allocator
  ```

  This is also known as Resource Acquisition Is Initialization (RAII) in C++
  
  #note[
    `String::new()`, `Vec::new()` and similar do not allocate.
  ]

]

#slide[
  = `Drop` trait
  ```rs
  // Definition
  pub trait Drop {
    fn drop(&mut self);
  }

  // Usage
  {
    let s = true;
    drop(s); // Manually drop `s`
  } // Otherwise `s` is implicitly dropped here
  ```
]

#slide[
  = Move semantics
  In other words, transferring ownership
  ```rs
  let s1 = String::from("foo");
  let s2 = s1; // Ownership is transferred to `s2`
  ```
]

#slide[
  = Move semantics: types that are `Copy`
  ```rs
  let s1: i32 = 123;
  let s2 = s1; // `s1` contents are copied to s2, both are valid
  ```
  Common for primitive types

]

#slide[
  = Move semantics

  This is also known as affine type system.
  
  See https://en.wikipedia.org/wiki/Substructural_type_system#Affine_type_systems

]

#new-section[References and borrowing]

#slide[
  = References

  Instead of owning data you can reference it.

  ```rs
  let x = true;
  let y = &x; // `y` references `x`
  ```
  #note[
    References can be both mutable (`&mut`) and immutable (`&`) similarly to normal data.
  ]
]

#slide[
  = Borrowing
  Creating a reference is also known as "borrowing" as instead of owning value, you borrow it.

  The reference is valid as long as the borrowed value is valid.

  There can be multiple (immutable) references to single value.
]

#slide[
  = Mutable references
  Mutable references work as normal references, but allow mutating the underlying data.

  Mutable references have one big restriction: if you have a mutable reference to a value, you can have no other references to that value.

  #note[
    Mutable references are also called as "exclusive references"
  ]
]

#slide[
  = Lifetimes
  All references in Rust have lifetimes associated with them.

  ```rs
  fn identity(x: &str) -> &str {
    x
  }
  // Desugared into
  fn identity<'a>(x: &'a str) -> &'a str {
    x
  }
  ```
]

#note[
  The process of figuring out the lifetimes automatically is called #box["lifetime elision"]
]

#slide[
  = `'static` lifetime

  There is a special lifetime name `'static` that specifies that the reference has to be valid through the entire execution of the program.

  _Can you name "group(s)" of items that have alway static lifetimes?_
]

#slide[
  = Subtyping and Variance

  Variance#footnote[https://doc.rust-lang.org/reference/subtyping.html] is a property that generic types have with respect to their arguments. A generic type’s variance in a parameter is how the subtyping of the parameter affects the subtyping of the type.
]

#slide[
  = Subtyping and Variance
  - `F<T>` is #text(blue)[covariant] over `T` if `T` being a subtype of `U` implies that `F<T>` is a subtype of `F<U>` (subtyping “passes through”)
  - `F<T>` is #text(blue)[contravariant] over `T` if `T` being a subtype of `U` implies that `F<U>` is a subtype of `F<T>`
  - `F<T>` is #text(blue)[invariant] over `T` otherwise (no subtyping relation can be derived)

]