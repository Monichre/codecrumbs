# Language support

This skill targets **TypeScript** and **Python**. Codecrumbs parses single-line
comments; the `cc:` convention is language-agnostic — only the comment token
changes.

| Language | Comment token | Example |
|---|---|---|
| TypeScript | `//` | `//cc:main function` |
| Python | `#` | `# cc:main function` |

Notes:

- Whitespace between the comment token and `cc:` is fine (`// cc:` and `# cc:` both work).
- The default upstream parser matches `//` comments; Python registers its own
  `#` comment regex. When authoring crumbs by convention (no server), any
  single-line comment form your agent can grep for is sufficient.
- Dependency-graph visualization upstream only supports JavaScript and TypeScript;
  flowchart view is JavaScript-only. Crumbs and trails work in both TS and Python.
