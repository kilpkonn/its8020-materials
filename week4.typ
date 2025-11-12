#import "lib.typ": *

#show: project.with()

#slide[
  #set page(header: none, footer: none, margin: 3em)

 
  #text(size: 1.3em)[
    *Parallelism, threads, channels*
  ]

  ITS8020

  #metropolis.divider
  
  #set text(size: .8em, weight: "light")
  Tavo Annus

  Nov 20, 2025
]

#slide[
   = Subprocesses

   ```rs
   use std::process::Command;

   let output = Command::new("echo")
       .arg("Hello world")
       .output()
       .expect("Failed to execute command");
   ```

   See #link("https://doc.rust-lang.org/std/process/index.html")
]

#slide[
  = Threads

  ```rs
  use std::thread;

  thread::spawn(move || {
      // some work here
  });
  ```

  See #link("https://doc.rust-lang.org/std/thread/index.html")
]

#slide[
  = Scoped threads

  - Allows borrowing non-`'static` data
  - Automatically joins all threads on on "going out of scope"
  
  See #link("https://doc.rust-lang.org/stable/std/thread/fn.scope.html")
]

#slide[
  = `Send` and `Sync` traits
  
    - A type is `Send` if it is safe to send it to another thread.
    - A type is `Sync` if it is safe to share between threads (`T` is `Sync` if and only if `&T` is `Send`).

    #note[
      You can `unsafe impl Send` for your own types.
      Be super careful though as the correctness of the execution is on you then!
    ]
]

#slide[
  = `Mutex` and `RwLock`

  ```rs
  let m = Mutex::new(0);
  let mut data = m.lock().unwrap();

  let rw = RwLock::new(0);
  let r = rw.read().unwrap();
  drop(r)
  let mut w = rw.write().unwrap();
  ```
]

#slide[
  = `Mutex` and `RwLock`

  - `RwLock` allows multiple readers
  - `RwLock` has more bounds on data (`T` has to be `Sync` for `RwLock<T>` to be `Sync`)
  - Potential writer starvation for `RwLock`
]

#slide[
  = Atomics

  - Similar to C++ model of atomics
  - See fetch ordering here: https://doc.rust-lang.org/std/sync/atomic/enum.Ordering.html

  More on atomics: #link("https://doc.rust-lang.org/std/sync/atomic/")
]

#slide[
  = Channels

  #link("https://en.wikipedia.org/wiki/Channel_(programming)")
]

#slide[
  = Channels in rust

  ```rs
  use std::sync::mpsc::channel;

  let (tx, rx) = channel::<i32>();
  // Send message
  tx.send(123).unwrap();
  // Receive message
  rx.recv().unwrap(); 
  ```
]

#slide[
  = Channels in rust
  - _What to do if the queue starts growing?_
  - _What if thread panics/exits after poping the value, but not acting?_
  - _Can you cause deadlocks?_

  See `tokio` channels: #link("https://tokio.rs/tokio/tutorial/channels")
]