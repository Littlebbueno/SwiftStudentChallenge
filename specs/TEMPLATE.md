<!--
Copy this file to start a new spec.
Naming: specs/NNN-short-slug.md  (e.g. specs/001-localization-ui.md)
A spec is the source of truth for WHAT and WHY. Keep it updated as decisions change.
Delete these HTML comments in your real spec.
-->

# NNN — <Spec title>

| Field    | Value                                            |
| -------- | ------------------------------------------------ |
| Status   | Draft · Approved · In progress · Done · Archived |
| Owner    | <name>                                           |
| Created  | YYYY-MM-DD                                        |
| Updated  | YYYY-MM-DD                                        |
| Related  | <links to other specs / the plan / issues>       |

## Context

<!-- Why does this work exist? The problem, the trigger, and the intended outcome.
Assume the reader has the project context in AGENTS.md but not this task. -->

## Goals

<!-- Bullet list of what success looks like. Concrete and verifiable. -->

- 

## Non-goals

<!-- Explicitly out of scope, to prevent scope creep. -->

- 

## Requirements

### Functional

<!-- What the feature/change must do, from the user's or system's point of view. -->

- 

### Non-functional

<!-- Performance, accessibility, localization, energy, privacy, compatibility (iOS 18+,
TrueDepth-only features), etc. -->

- 

## Proposed approach

<!-- The recommended design. Reference existing types/files to reuse (see AGENTS.md
source map). Describe data flow and key decisions, not every line. Include
alternatives only if a trade-off matters. -->

## Affected files / components

<!-- The files you expect to add or change. For repeated patterns, describe once
and list a few representative paths. -->

- 

## Open questions

<!-- Decisions still needed from the user/maintainer. Resolve before "Approved". -->

- 

## Acceptance criteria

<!-- How we verify it's done. Be specific enough to execute. Remember: .swiftpm
builds via Xcode/xcodebuild (see AGENTS.md), and Night Mode needs a TrueDepth
device. -->

- [ ] 
- [ ] Builds clean: `xcodebuild -scheme RoadHelper -destination 'platform=iOS Simulator,name=iPhone 16 Pro' build`

## Changelog

<!-- Short dated notes as the spec evolves. -->

- YYYY-MM-DD — Created.
