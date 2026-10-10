# Homework

_Deadline: Has to be defended before exam_

TLDR: Build your own shell in Rust.
If you wish to use any other dependency than what is white-listed here, ask Tavo.
Generally crates with similar functionality are allowed, but ask first just to be sure.

## Deadline 1: week 10
_No external creates are allowed_
- REPL set up
- Builtin commands: `cd`, `ls`, `exit`

## Deadline 2: week 11
_No external creates are allowed_
- Run external commands
- Expand `~` to `$HOME`, `.` to current dir and `*` to everything that matches

## Deadline 3: week 12
_External dependencies allowed: `rustyline`_
- Add history and command completion
- Add syntax highlighting
- Add `stdout` and `stderr` piping to file

## Deadline 4: week 14
_External dependencies allowed: `rustyline`_
- Make chaining commands possible
- Add `alias` command

# Deadline 5: week 15
_External dependencies allowed: `rustyline, pest`_
- Add variables
- Add proper parsing

# Deadline 6: before exam
_External dependencies allowed: `rustyline, pest`_
- Add background processes
