# CLAUDE.md

This project uses **Spec-Driven Development**. Before doing any work, read the
project memory and the relevant spec.

## Project memory

@AGENTS.md

## Specs

- All feature/refactor work is described by a spec in [`specs/`](specs/).
- New specs are created from [`specs/TEMPLATE.md`](specs/TEMPLATE.md).
- A spec is the source of truth for *what* and *why*. Read the spec before
  writing code, and keep it updated as decisions change.

## Working agreement

1. Read `AGENTS.md` for context, conventions, and current state.
2. Find or create the spec for the task in `specs/`.
3. Implement against the spec; update the spec's **Status** as you progress.
4. Verify per the spec's **Acceptance criteria** (see build/verify in `AGENTS.md`).
