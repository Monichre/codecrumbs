# Multi-language support

Codecrumbs parses single-line comments; the `cc:` convention is language-agnostic.
Only the comment token changes per language.

| Language | Comment token | Example |
|---|---|---|
| JavaScript / TypeScript | `//` | `//cc:main function` |
| Java | `//` | `//cc: main function` |
| C# | `//` | `//cc:main function` |
| C++ | `//` | `//cc:main function` |
| Go | `//` | `// cc:main function` |
| Haskell | `--` | `-- cc:main function` |
| Kotlin | `//` | `//cc:main function` |
| Lua | `--` | `-- cc:main function` |
| PHP | `//` | `//cc:main function` |
| Python | `#` | `# cc:main function` |
| Ruby | `#` | `# cc:main function` |
| Perl | `#` | `# cc: main function.` |
| Fortran | `!` | `! cc: main function` |
| OCaml | `/* ... */` (single line) | `/* cc:main function */` |

Notes:

- Whitespace between the comment token and `cc:` is fine (`// cc:` works).
- The default parser matches `//` comments; other languages register their own
  comment regex upstream. When authoring crumbs by convention (no server), any
  single-line comment form your agent can grep for is sufficient.
- Languages not listed can still carry crumbs by convention — pick the language's
  single-line comment token and keep the `cc:` body identical.
- Dependency-graph visualization upstream only supports JavaScript and TypeScript;
  flowchart view is JavaScript-only. Crumbs and trails work everywhere.
