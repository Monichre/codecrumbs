# Codecrumbs skill — brainstorm notes

Date: 2026-08-13
Context: design session on how the `codecrumbs/` agent skill actually works and
where it should go next.

## How the skill works today

Three layers, loaded progressively by the agent:

1. **Trigger** — the agent sees only the `description` at startup ("explore an
   unfamiliar TS/Python codebase, document flows in-code, build ordered step
   trails, audit codecrumb comments"). Queries like "map this codebase for me",
   "walk me through the auth flow", or "leave breadcrumbs while you explore"
   fire the skill.
2. **Instructions** — the agent loads the SKILL.md body: the grammar
   (`cc:[trailID#step;]title[;+lines][;details]`), the two comment prefixes
   (TS `//`, Python `#`), the three workflows, and pitfalls.
3. **On demand** — only if needed: `scripts/scan-crumbs.sh` (inventory),
   `references/` (grammar / CLI depth), `assets/codecrumbs.config.js` (server).

**Core design bet:** the convention is the product, not the tool. Crumbs are
plain comments in real files, so the agent can author, read, and reason about
trails with zero installs. The visualization server is a bonus layer most
sessions never need.

## The core loop

```
read file → drop crumb at seam → notice cross-file flow → number into trail
   → run scan-crumbs.sh → index of trails → (optional) codecrumbs server diagram
```

Concretely, a TS session might produce:

```ts
// auth/api.ts
//cc:signin#1;firebase sign in;+2;send creds to firebase
export async function signIn(email, password) { ... }

// auth/store.ts
//cc:signin#2;persist session
export const authStore = ... { ... }

// routes/guard.ts
//cc:signin#3;protect routes
```

The `signin` trail is grep-able, survives across sessions, and any future agent
(or human) that loads the skill can reconstruct the flow from
`scan-crumbs.sh` output alone — even if the codecrumbs tool never runs.

## Open questions

### 1. Crumbs as permanent artifacts vs. scratch notes

Leaving `//cc:` comments in someone's source is an invasive act. Is the skill's
job to *leave knowledge behind* (persistent, like lightweight ADRs scattered at
decision points), or to *scaffold exploration* (crumbs are temporary, removed
after the agent reports)?

The skill currently says "always ask before mass-removing" but is silent on
*adding*. Options:

- always ask before leaving crumbs in the user's code, or
- default to "crumbs only in files the agent is already touching".

### 2. Who owns trail naming?

There's no registry — two agents exploring independently could both name a
trail `signin`. Possible conventions:

- prefix with a module: `cc:auth/signin#1`, or
- rule: check `scan-crumbs.sh` first for existing trail IDs before creating one.

### 3. Agent-native visualization

The v1 CLI is unmaintained; v2 is a SaaS. But an agent can do what the old tool
did, itself: grep crumbs → emit a Mermaid diagram or a markdown trail report —
no server required. Should the skill grow a "render trails as a diagram"
workflow? That would make it fully self-contained.

### 4. Design-before-coding as the headline workflow

Writing trail steps *first* as a spec — `cc:checkout#1` in the cart file,
`#2` in the payment file — then implementing under each crumb is a genuinely
agent-shaped pattern: the crumbs become a machine-readable implementation
checklist with cross-file ordering. Candidate for the headline workflow.

### 5. Lifecycle stewardship

Crumbs rot (code moves, steps go stale). The audit workflow catches it — but
who runs it, and when? A "run scan, flag stale crumbs" reflex on every session
that loads the skill?

## Instinct ranking

**3 and 4** make the skill feel alive rather than archival — the agent becomes
the visualizer and the spec-writer, not just a comment-typist.
