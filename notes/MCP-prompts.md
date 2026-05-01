# MCP Prompts

Prompts for using the Lean-LSP-MCP server and it's related tools (lean4-skills and ripgrep).

Many of these prompts are taken/adapted from examples in lean4-skills.

## Finding open goals in a Lean file:

Prompt:
```
List all the `sorry`s in @<file>, then add each as a single item in the TODO list
```

Generates a TODO list of all `sorry`s in given file(s), in order of appearance. TODO stays in Cursor context memory.

## Closing open goals in Lean file:

Prompt:
```
Fill in Sorry #01. DO NOT MOVE ON TO OTHER SORRY's BEFORE THIS ONE IS FILLED
```