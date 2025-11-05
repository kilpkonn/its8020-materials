#import "lib.typ": *

#show: project.with()

#slide[
  #set page(header: none, footer: none, margin: 3em)

 
  #text(size: 1.3em)[
    *Rust basics*
  ]

  ITS8020

  #metropolis.divider
  
  #set text(size: .8em, weight: "light")
  Tavo Annus

  Oct 30, 2025
]

#new-section[Background]

#slide[
  = Main events

  In 2006, Graydon Hoare created Rust as a side project at Mozilla Research.

  In 2009, Mozilla Research started officially sponsoring the project.

  In 2015 (9th Jan), Rust 1.0 was released.

  In 2020, Mozilla dropped sponsorship.

  In 2021, Rust Foundation was created.
]

#slide[
  = Pre 1.0 era

  Compiler was written/bootstrapped in \~38k lines of OCaml.

  Originally garbage collected.

  Some removed features:
  - Explicit OOP via `obj` keyword
  - Typestate system to track states of values
  - Pure functions
]

#new-section[Common programming concepts]

#slide[
  = Variables
  ```rs
  let a = 1; // Immutable, inferred type
  let b: f64 = 1.0; // Immutable, explicit type
  let mut c = true; // Mutable, inferred type
  let c = "some str"; // Shadows `c`, aka new variable
  ```
]

#slide[
  = Data types: primitives
  Fixed width numbers
  ```rs
  i8, i16, i32, i64, i128, u8, ..., u128, f32, f64
  ```
  Architecture dependent
  ```rs
  isize, usize
  ```
  Other
  ```rs
  bool, char
  ```
]

#slide[
  = Data types: tuples
  ```rs
  let m_tuple = (1, "foo", true);
  println!("({}, {}, {})", m_tuple.0, m_tuple.1, m_tuple.2);
  
  let (a, b, c) = m_tuple; // Destructuring
  ```
]

#slide[
  = Data types: arrays
  ```rs
  let a = [1, 2, 3, 4, 5];
  let a: [i32; 5] = [1, 2, 3, 4, 5]; // Note the type
  let a = [3; 5]; // Same as `[3, 3, 3, 3, 3]`

  let b = a[0];
  let c = a[5]; // Panics as out of bounds
  ```
]

#slide[
  = Data types: structs
  ```rs
  struct Foo {
    a: bool,
    b: u64,
  }
  ```
  _What is the size of this struct?_
]

#slide[
  = Data types: enums
  ```rs
  enum Foo {
    A,
    B(u8),
    C {
      x: bool,
      y: f32,
    }
  }
  ```
  Enums in Rust are also known as "Sum types" in functional programming
]

#slide[
  = Functions
  ```rs
  fn main() {
    println!("Hello, world!");
  }

  fn foo(x: bool) { todo!() }

  fn wrap(x: i32) -> Option<bool> { Some(x) }
  
  // Same as above, but more verbose
  fn bad(x: i32) -> Option<bool> { return Some(x)}
  ```
]

#slide[
  = Control flow: `if/else`

  ```rs
  if x > 0 {
    println!("Yay");
  } else if x < 0 {
    println!("Nay");
  } else {
    println!("Ohh");
  }

  let v = if y { "y is true" } else { "y is false" };
  println!("{v}");
  ```
]

#slide[
  = Control flow: loops
  ```rs
  while condition {
    todo!();
  }
  
  loop {
    println!("Looping forever...");
    break; // Or break the loop to stop (can return value)
  }

  for v in [1, 2, 3] {
    println!("Element: {v}");
  }
  ```
]

#slide[
  = Control flow: pattern matching
  ```rs
  // From std:
  enum Option<T> { None, Some(T) }

  // Pattern matching
  let v = Some(123);
  match v {
    Some(it) => println!("Got {v}"),
    None => println!("No value"),
  }
  ```
]

#slide[
  = Iterators
  ```rs
  fn sum_of_positive_squares(numbers: &[i32]) -> i32 {
    numbers.iter()
      .filter(|i| i > 0)
      .map(|i| i * i)
      .sum()
  }
  ```
]

#slide[
  = Interfaces
  ```rs
  trait Area {
    fn area(&self) -> f32;
  }

  struct Circle(f32);
  
  impl Area for Circle {
    fn area(&self) -> f32 {
      std::f32::consts::PI * self.0.pow(2)
    }  
  }
  ```
]

#slide[
  = Interfaces
  ```rs
  fn calc_paint_needed<T: Area>(v: T) -> f32 {
    v.area() * 0.5
  }

  fn calc_paint_needed<T>(v: T) -> f32 where T:Area {
    v.area() * 0.5
  }

  fn calc_paint_needed(v: impl Area) -> f32 {
    v.area() * 0.5
  }
  ```
]

#slide[
  = Next week

  Cargo, compilation, sharing code
]