# Semi-Formalizing Ordered Sets, Lattices, and Frames

Generating a dataset of informal, semi-formal, and formalized mathematics, based on the propositions, lemmas, theorems, and exercises found in mathematical texts. 

At present, all proofs are taken from Davey-Priestly's Introduction to Lattices and Order. 

## Getting Started (Setup for Contributors)

This repo is generated with the help of the [Lean-LSP-MCP](https://github.com/oOo0oOo/lean-lsp-mcp/tree/main) server. Please follow the following instructions to install the MCP and its related tools locally:

### 1. Dependencies

Install `uv` (required):
```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

Install `ripgrep` (optional but recommended) ):
```bash
brew install ripgrep
```
(See [repo](https://github.com/BurntSushi/ripgrep?tab=readme-ov-file#installation) for non-macOS installation commands)

### 2. First-time setup

Run `lake build` before opening Cursor to ensure the Lean LSP starts

### 3. Lean-LSP-MCP and Lean4-Skills

The `Lean-LSP-MCP` configuration is included locally in this repo at `.cursor/mcp.json`.

#### Using `Lean4-skills`

This project is set up so that users may use lean4-skills if desired. 

Some local set up is required for first time users of this tool (the following instructions are for Cursor users. Please see the repo's directions to set up with other hosts):

1. Shallow-clone the `lean4-skills` repository (anywhere in filesystem)

    ```bash
    git clone --depth 1 https://github.com/cameronfreer/lean4-skills.git
    ```

2. Set the three variables required by the hosts to use this tool:

    ```
    export LEAN4_PLUGIN_ROOT=/path/to/lean4-skills/plugins/lean4
    export LEAN4_SCRIPTS=$LEAN4_PLUGIN_ROOT/lib/scripts
    export LEAN4_REFS=$LEAN4_PLUGIN_ROOT/skills/lean4/references
    ```

(Note: I set mine in `~/.zshrc` to ensure I could use the `lean4-skills` tool in multiple repositories).

See `Lean4-skills`'s [repo](https://github.com/cameronfreer/lean4-skills/tree/main) for documentation and command options.

## Overview/Description

## Informal Proofs

Proofs written in the informal "mathematical" language (i.e. natural language with mathematical symbols). Informal proofs rely heavily on intuition, "common sense", and implicit assumptions.

...

The informal proofs can be found in the `InformalProofs` directory.


## Semi-formal Proofs

...

## Formal Proofs

...

The formal(ized) proofs can be found in the `FormalProofs/` directory. 

Each file in `FormalProofs/` corresponds to a chapter in the Davey-Priestley book. Theorems/lemmas/propositions are named in correspondence with the book. 

Formalized statements from chapter exercises were also included when appropriate.

At present, most of the proofs contain only the formalized proof statement, closed with the `sorry` tactic. Most completed proofs were done with the help of the Cursor agent and the given tools (`lean-lsp-mcp`, `lean4-skills`, `ripgrep`).

