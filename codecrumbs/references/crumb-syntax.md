# Breadcrumb parameter grammar

Canonical form (single line, after the language comment prefix):

```
cc:[trailID#step;]title[;+linesToHighlight][;details]
```

The long alias `codecrumb:` works everywhere `cc:` does.

## Parsing rules (from the upstream parser)

1. Split comment text on `:` — everything after the first `:` is the parameter string.
2. Split parameters on `;`.
3. If the first segment contains `#`, it is `trailID#step`: text before `#` is the
   trail (flow) ID, the number after is the step order. Otherwise the crumb is a
   simple (trail-less) breadcrumb.
4. Next `;` segment is the crumb **title**.
5. If the following segment starts with `+`, it is the number of extra lines to
   highlight below the comment (`+2` = highlight 2 lines).
6. Remaining segment is **details** (free text, shown on hover in the UI).

## Examples

| Comment | Meaning |
|---|---|
| `//cc:remember place` | Simple crumb titled "remember place" |
| `//cc:here is bug;well, seems like a bug in logic` | Crumb with details |
| `//cc:signin#3;enable route` | Step 3 of trail `signin`, titled "enable route" |
| `//cc:signin#1;firebase sign in;+2;do call to firebase with credentials` | Trail step with 2-line highlight and details |
| `//cc:groupname#;test` | Trail membership without a step number (order later) |

## Edge cases

- Empty step (`trail#`) is valid — groups crumbs into a trail without ordering.
- Step `0` is valid (`trail#0`).
- Anything malformed (missing title, bad step number) still renders as a crumb with
  whatever parameters parsed successfully; keep crumbs well-formed anyway.
- One crumb per line; multi-crumb lines are not supported.
