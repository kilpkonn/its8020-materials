# Homework

_Deadlines: Has to be presented once during practice and final version submitted 3 days before exam to moodle_

You present current state of work.
Submission to moodle is final version.

Grade:
- Code not "presented/shown" in any practice = 0 points
- Otherwise grade comes from automatic test suite (Will add at least some tests here after testing hw).

## Task
TLDR: Build your own shell in Rust.
If you wish to use any other dependency than what is white-listed here, ask Tavo.
Generally crates with similar functionality are allowed, but ask first just to be sure.

### Deadline 1: week 10
_No external creates are allowed_
- REPL set up
- Builtin commands: `cd`, `ls`, `exit`

### Deadline 2: week 11
_No external creates are allowed_
- Run external commands (with basic args)
- Expand `~` to `$HOME`, `.` to current dir and `*` to everything that matches

### Deadline 3: week 12
_External dependencies allowed: `rustyline`_
- Add history and command completion
- Add syntax highlighting
- Add `stdout` and `stderr` piping to file

### Deadline 5: week 13
_External dependencies allowed: `rustyline`_
- Make chaining commands possible
- Add `alias` & `pwd` commands

### Deadline 4: week 14
_External dependencies allowed: `rustyline`_
- Add 10 integration tests for current functionality (`cd`, `ls`, `pwd` & `alias`, piping and expansion)
  - Tests have to use compiled binary i.e. it must be possible to swap out the binary under test
  - Tests can be written in `rust`, `bash`/`zsh`/`nu`, `just`, `python` or any other suitable language - be ready to defend your choice
  - For tests, all external dependencies are allowed, but be ready to justify the need

### Deadline 6: week 15
_External dependencies allowed: `rustyline, pest`_
- Add variables
- Add proper parsing

### Deadline 7: final submission
_External dependencies allowed: `rustyline, pest`_
- Add background processes
