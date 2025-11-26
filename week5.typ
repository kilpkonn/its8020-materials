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

  Nov 27, 2025
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

#new-section[`async/await`]

#slide[
  = Non-blocking interfaces
  Synchronous interfaces yield result as soon as they are done.

  Asynchronous interfaces yield progress that something is being done, or the result, once they are done.
]

#slide[
  = Non-blocking interfaces

  In Rust, the state of `async` function maps to
  ```rs
  enum Poll<T> {
    Ready(T),
    Pending // Come back later, we are not done
  }
  ```
]

#slide[
  = Polling

  `Poll` usually ends up in the return type of functions that start with `poll_` and signals that we attempt an operation without blocking.

  These methods take `&mut self` (or really pinned version) as they need to internally keep track of where they left off.

  ```rs
  // Rust like pseudocode
  loop {
    match my_future.poll() {
      Ready(res) => println!("Got {res}"),
      Pending => continue,
    }
  }
  ```
]

#slide[
  = Standardized polling
  ```rs
  // Simplified version of future trait
  trait Future {
    type Output;
    fn poll(&mut self) -> Poll<Self::Output>
  }
  ```
  Types that implement `Future` are called futures

  #note[
    In general, you should not poll future that has returned `Poll::Ready`.
    If done so, future is allowed to panic.
  ]
]

#slide[
  = Standardized polling
  Pooling manually is inconvenient and luckily is rarely seen in Rust.

  Instead you use `.await` that polls the underlying future and either continues if ready propagates up the pending variant if "pending".

  #note[
    This is special case of #link("https://dev-doc.rust-lang.org/beta/unstable-book/language-features/generators.html")[generators].
  ]
]

#slide[
  = `Pin` and `Unpin`

  Unluckily what we described won't work for futures that take references to local variables.
  
  If you pause a function, you also need to keep track of all local variables, however it is not clear what happens when we move the generator.
  It is a self-referential data structure.

  And since we return the generator, we definitely move it.
]

#slide[
  = `Pin` and `Unpin`

  `Pin` says we have something pinned to specific memory location.
  With that we can safely take references and store them as the data is guaranteed not to be moved.

  To indicate that something is pinning agnostic, we have `Unpin` trait.
  It indicates that the type does not rely nor exposes pinning guarantees.

  #note[
    Pinning is very confusing topic so we won't dive any deeper than the surface level.
    There are many good blog posts on how it would be simpler if the language was built slightly differently.
  ]
]

#slide[
  = Going to sleep
  Note that our current polling interface ends up in 100% CPU load.

  To deal with that, we can go to sleep instead poll again and have something signal when to wake up.
  For that Rust has `Waker`, passed in as an extra parameter to `poll`.

  #note[
    What exactly happens when `Waker::wake()` is called is executor dependent, but in general it tells the executor that the future can make progress again.
  ]
]

#slide[
  = `Waker`
  You might have figured that `wake` does not really wake anything as to call that you need to be already running.

  Instead it signals, that poll should be called again, as there is more work to do.

  #note[
    Executor can also poll when no wake is called, but having knowledge of which futures to call first helps optimize the polling.
  ]
]

#slide[
  _When does the execution of `async` function start?_
  ```rs
  let a = read_async();
  a.await
  ```
  _What happens if future is dropped?_
]