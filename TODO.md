# TODO

- Handle weird failure on NoMethodError
- Detect if you are the last line of a `scenario` when performing a verification comparison and print compared objects upon failure
- Ensure that each element is only nestable under specific types of elements (e.g. `use_case` can go under `specification` only and `fact` can go under `scenario` only)
- Support setting up common `scenario`, `use case` or `specification` preconditions by adding code directly under their block or inside a `before`/`after` block
- Support printing more than one line for `fact {}` (right now it assumes one line only, no multi-line support for printing)
- Support scaffolding initial specification directory and lib_specification.rb for a project (or any initial file name passed as argument to scaffolding command); Also, automatically amend `Rakefile` to add `rake verify` task and potentially configure as default.
- Support usage of `pd` without getting caught up by failure printout logic
- Support nesting a `specification` under another `specification` (without repeating verification multiple times)
