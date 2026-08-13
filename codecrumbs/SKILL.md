---
name: codecrumbs
description: Learn, design, or document a codebase by placing breadcrumb comments (//cc:...) in source code and optionally visualizing them with the Codecrumbs tool. Use when exploring an unfamiliar codebase, documenting architecture or execution flows in-code, building ordered step trails across files, or auditing existing codecrumb comments. Supports any language with single-line comments.
license: BSD-3-Clause
compatibility: Works convention-first with no install. Optional live visualization requires Node.js >= 8.11.1 and the codecrumbs npm package.
metadata:
  author: Monichre
  version: "1.0.0"
  source: https://github.com/CodecrumbsIO/codecrumbs
---

# Codecrumbs

Codecrumbs is a convention + tool for leaving **breadcrumb comments** in source code.
Crumbs mark important places, group into ordered **trails**, and can be rendered as a
live, interactive dependency-and-flow diagram. This skill teaches the convention so you
can author, read, and audit breadcrumbs directly; the visualization server is optional.

## Breadcrumb syntax

A breadcrumb is a single-line comment whose text starts with `cc:` or `codecrumb:`:

```
<comment-prefix>cc:[trailID#step;]title[;+linesToHighlight][;details]
```

- **Simple crumb** — `//cc:remember place` — marks a spot with a title.
- **Crumb with details** — `//cc:here is bug;well, seems like a bug in logic` —
  second segment becomes details shown on hover.
- **Trail step** — `//cc:signin#3;enable route` — `signin` is the trail ID, `#3` the
  step order. Steps of one trail are typically spread across multiple files.
- **Trail with highlight + details** — `//cc:signin#1;firebase sign in;+2;do call to firebase` —
  `+N` highlights N extra lines below the comment.
- **Group without order** — `//cc:groupname#;test` — trail ID with no step number;
  number the steps later once the order is known.

Rules: single-line comments only; the comment text (after the language's comment
prefix) must begin with `cc` or `codecrumb` followed by `:`; parameters are
`;`-separated; the `trailID#step` pair must be the first parameter when present.

## Comment prefixes by language

| Languages | Prefix | Example |
|---|---|---|
| JS, TS, Java, C#, C++, Go, Kotlin, PHP | `//` | `//cc:main function` |
| Python, Ruby, Perl | `#` | `# cc:main function` |
| Fortran | `!` | `! cc: main function` |
| OCaml | `/* */` | `/* cc:main function */` |

The trailing-text convention (`cc:`) is identical in every language — only the
comment token changes. See `references/language-support.md` for the full matrix.

## Workflows

### Learn an unfamiliar codebase
1. While reading code, drop a `//cc:` crumb at every non-obvious decision point,
   integration seam, or "how does this work" discovery.
2. When you notice a cross-file flow (auth, checkout, boot sequence), convert the
   related crumbs into a trail: shared trail ID + step numbers in execution order.
3. Run `scripts/scan-crumbs.sh <dir>` to print an index of all crumbs and trails.

### Document architecture (breadcrumb audit)
1. Run `scripts/scan-crumbs.sh <dir>` to inventory existing crumbs.
2. Report: orphan trail steps (missing siblings), duplicate step numbers in one
   trail, untitled crumbs, stale crumbs that no longer match the code below them.
3. Fix or propose fixes with minimal edits.

### Design before coding
Sketch a feature by writing only crumbs first (trail IDs + step titles in the files
that will own each step), then implement under each crumb. Remove or keep crumbs
per the project's documentation preference — always ask before mass-removing.

## Optional: live visualization

> The upstream v1 CLI is unmaintained (last release 2021; v2 is a standalone app at
> codecrumbs.io). Treat the server as optional and verify it runs before relying on it.

```
yarn global add codecrumbs          # or: npm i -g codecrumbs
codecrumbs -d src -e src/index.js   # -d source dir, -e entry point
# open http://localhost:2018
```

Key flags: `-x` exclude dirs, `-p` client port (default 2018), `-n` project name alias,
`-D` debug logs, `-C` path to config file. Multi-codebase: run one `codecrumbs`
process per repo; all instances sync into one browser view. Full reference:
`references/cli-reference.md`. Config template: `assets/codecrumbs.config.js`.

## Pitfalls

- Only single-line comments are parsed — block-comment crumbs (except OCaml-style
  single-line `/* ... */`) are invisible.
- `cc:` must be the start of the comment text; `// note: cc:x` is not a crumb.
- Step numbers are per-trail, not per-file; two crumbs in the same trail must not
  share a step number.
- Keep crumb titles short; long prose goes in the details segment.
