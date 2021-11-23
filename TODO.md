# TODO

- Ensure that each element is only nestable under specific types of elements (e.g. `use_case` can go under `specification` only and `fact` can go under `scenario` only)
- Support setting up common `scenario`, `use case` or `specification` preconditions by adding code directly under their block or inside a `before`/`after` block
- Support printing more than one line for `fact {}` (right now it assumes one line only, no multi-line support for printing)
- Support scaffolding initial specification directory and lib_specification.rb for a project (or any initial file name passed as argument to scaffolding command); Also, automatically amend `Rakefile` to add `rake verify` task and potentially configure as default.
- Look into the idea of auto-parsing the two compared objects from the fact statement in order to print values upon failed verificaiton
