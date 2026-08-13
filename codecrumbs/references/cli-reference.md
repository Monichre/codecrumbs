# Codecrumbs CLI / config reference

> Upstream v1 CLI (npm package `codecrumbs`) is unmaintained since 2021.
> v2 is a standalone application at https://codecrumbs.io.

## Install & run

```
yarn global add codecrumbs
codecrumbs -d project-src-dir -e project-src-dir/index.js
# open http://localhost:2018
```

Precondition: Node.js >= 8.11.1.

## Flags ↔ config keys

| CLI flag | Config key (`codecrumbs.config.js`) | Description | Example |
|---|---|---|---|
| `-d` | `projectDir` | Relative path to source directory | `-d src` |
| `-e` | `entryPoint` | Entry point file (must be inside `dir`) | `-e src/app.js` |
| `-x` | `excludeDir` | Directories to exclude, comma-separated | `-x src/doc,src/thirdparty` |
| `-p` | `clientPort` | Client port (default 2018) | `-p 2019` |
| `-n` | `projectNameAlias` | Project name alias | `-n my-hello-world` |
| `-w` | `webpackConfigPath` | Path to webpack config (alias resolution) | `-w webpack.config.js` |
| `-t` | `tsConfigPath` | Path to tsconfig (TS path resolution) | `-t tsconfig.json` |
| `-i` | `ideCmd` | IDE command to open files from the UI | `-i code` |
| `-C` | — | Path to config file (default: `./codecrumbs.config.js`) | `-C config/codecrumbs.config.js` |
| `-D` | `debugModeEnabled` | Verbose debug logs | `-D` |

## Multi-codebase mode

Start one `codecrumbs` process per codebase (any locations, no monorepo required);
all running instances sync into a single diagram in the browser tab. Click a
diagram to control its UI.

## UI features

- **Codecrumbs switch** — toggle the breadcrumb tree; pick the current trail.
- **Dependencies switch** — JS/TS module dependency graph.
- **Sidebar** — code for connected nodes; JS files also get a live flowchart
  (via js2flowchart).
