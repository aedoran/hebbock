# 📜 Wiki Guidelines

> Master rules for this vault. **Read this first.** If a new note doesn't fit, update these guidelines — don't work around them.
>
> Design goal: a flat, predictable, **markdown-first** structure that both a human (in Obsidian) and an agent (me) can navigate by `grep`, `find`, and `read` without ambiguity.
>
> **Core model: one world, many continents, many campaigns.** The world is **Hebbock** — the Hargate region is its heart, and the **Zazi continent** (Gulf of Daafia) is another known continent of the same world (ruled 2026-08-20). Multiple parties run multiple campaigns across it. World truth lives in the continent tier (`hebbock/` for the world heart, `zazi/` for the Zazi continent); each campaign's journey lives in `campaigns/<slug>/`.

## Table of Contents
1. [Purpose](#1-purpose)
2. [The Map (folder layout)](#2-the-map)
3. [File Naming (slugs)](#3-file-naming)
4. [Frontmatter](#4-frontmatter)
5. [Tags](#5-tags)
6. [Links](#6-links)
7. [Canonical Names & Aliases](#7-canonical-names--aliases)
8. [World vs. Campaign: the split](#8-world-vs-campaign-the-split)
9. [Page Templates](#9-page-templates)
10. [The Churn (ingestion workflow)](#10-the-churn)
11. [Quality Rules](#11-quality-rules)
12. [Open Questions](#12-open-questions)

---

## 1. Purpose

This vault documents the world of **Hebbock** and every campaign played in it: its people, places, factions, items, creatures, and deep lore — plus the journey of each campaign: its party, its characters, its arcs, and its session history.

Everything is cross-linked so that any page can be reached in a few hops, and so the agent can always find an entity by searching for any of its known names.

It also holds generic `projects/`, `calendar/`, and `reference/` notes that aren't Hebbock-specific.

---

## 2. The Map

```
wiki/
├─ 00-Index.md            # front door — links to everything
├─ 01-Guidelines.md       # THIS FILE — the rules
├─ _names.md              # 🧾 canonical names → slug → aliases (source of truth)
├─ _questions.md          # ❓ open questions needing a ruling
├─ .obsidian-wiki-config.json
├─ inbox/                 # raw drops; I triage into the sections below
├─ hebbock/               # 🌍 THE WORLD — persistent, campaign-independent canon
│   ├─ README.md
│   ├─ locations/         # regions, cities, dungeons, landmarks (hierarchical)
│   ├─ factions/          # guilds, temples, houses, powers, cults
│   ├─ items/             # world-famous items, artifacts, relics
│   ├─ creatures/         # beasts & monsters of the realm
│   ├─ npcs/              # world NPCs — exist regardless of any campaign
│   └─ worldbuilding/     # history, gods, magic, cosmology, politics; the Hebbock entry page
├─ campaigns/             # 🎲 ONE SUBFOLDER PER CAMPAIGN
│   ├─ README.md          # the campaign registry (table of all campaigns)
│   └─ <campaign-slug>/
│       ├─ README.md      # the campaign page: premise, party, status, timeline
│       ├─ party.md       # the party: roster, how they met, current state
│       ├─ characters/    # PCs of this campaign (one page each)
│       ├─ npcs/          # NPCs introduced/used only in this campaign
│       ├─ locations/     # locations only relevant to this campaign
│       ├─ items/         # campaign loot & notable items
│       ├─ arcs/          # the campaign's plot arcs
│       ├─ songs/         # bardic works / creative works (one per piece)
│       └─ sessions/      # one page per session
├─ projects/              # non-campaign active work
├─ calendar/              # dated notes & events
└─ reference/             # durable facts, integrations, how-tos
```

**Rules of thumb**
- One page per entity. No god-pages. If a page grows huge, split it.
- `hebbock/` is self-contained world canon; `campaigns/<slug>/` is self-contained campaign record.
- Underscore-prefixed files at the root (`_names.md`, `_questions.md`) are **registry/working** files, not entities.
- If something is genuinely cross-cutting, link it; don't duplicate it (see [Section 8](#8-world-vs-campaign-the-split)).

---

## 3. File Naming

**Default: filenames are `kebab-case` slugs derived from the canonical name.** This keeps them shell-safe, grep-friendly, and unambiguous for the agent.

Slug rules:
- Lowercase, words joined by `-`.
- Strip punctuation (apostrophes, slashes, etc.). Keep the letters.
- Keep it short but unique. "Kingdom of Aethra" → `kingdom-of-aethra`. "Vaelor the Bold" → `vaelor-the-bold`.
- The human display name lives in frontmatter `title`/`aliases` and is always the **display text** in links.

**Campaign folders** use the campaign's slug: `campaigns/the-veiled-road/`, `campaigns/ashes-of-the-east/`.

**Why not just use the name as the filename?** Some names have characters that break the filesystem or shell, and "Vaelor" vs "Vailor" would create two files that look identical. Slugs + the `_names.md` registry solve both problems and stay greppable: `grep -ri "vaelor" wiki/` finds the page no matter how it's spelled or in which tier it lives.

**Exception:** if you, aedoran, strongly prefer the human name as the filename, say so and I'll switch to `Name As Written.md` and keep the alias registry. It's your vault.

---

## 4. Frontmatter

Every page starts with YAML frontmatter. These fields are **required** on every entity page:

```yaml
---
title: "Canonical Display Name"     # the one true name
slug: canonical-slug                # matches the filename
type: npc                           # see type list below
aliases: []                         # alternate / variant spellings
tags: [npc]                         # see tag list
created: 2026-08-20
updated: 2026-08-20
status: draft                       # draft | canonical | disputed
---
```

**`type` values:**
- World tier: `world` · `location` · `faction` · `item` · `creature` · `npc` · `worldbuilding`
- Campaign tier: `campaign` · `party` · `pc` · `arc` · `session` · `song` (bardic / creative works within a campaign)

**`status` meaning**
- `draft` — I wrote it from the notes; details may be unconfirmed.
- `canonical` — reviewed by you; treat as the source of truth.
- `disputed` — sources conflict; a question is open in `_questions.md`.

Type-specific fields are allowed **after** the required ones. Examples:

```yaml
# pc / npc
race: ""
class: ""        # pc only
level: 0
alignment: ""
player: ""       # pc only (who plays them)
affiliations: [] # links to faction slugs

# location
parent: ""       # link to the containing region
kind: region     # region | city | dungeon | landmark | ...

# faction
goals: []
leader: ""       # link to an npc slug
rivalries: []    # links to faction slugs

# campaign
world: hebbock   # which world
party: ""        # link to the party page
status_campaign: active   # active | ongoing | concluded | abandoned
```

Keep frontmatter terse. Long-form details belong in the body.

---

## 5. Tags

Use a small, closed vocabulary. Add new ones in `_names.md`/here before using them.

**World tier:** `#hebbock` `#location` `#faction` `#item` `#creature` `#npc` `#worldbuilding` `#region` `#city` `#dungeon` `#temple` `#guild`

**Campaign tier:** `#campaign` `#party` `#pc` `#arc` `#session` `#major-quest` `#side-quest`

**State / role:** `#ally` `#enemy` `#neutral` `#alive` `#deceased` `#active`

**Campaign cross-tag:** world entities that appear in a campaign get tagged with the campaign slug, e.g. `#veiled-road` — this lets `grep` answer "what world entities does campaign X touch?"

Frontmatter `tags` and inline `#tags` in the body should agree.

---

## 6. Links

- Use Obsidian wiki-links: `[[slug|Display Name]]`. The display text is always the human name, even though the target is a slug.
  - Within a folder, use the shortest path that resolves: `[[factions/guild-of-the-veiled-hand|Guild of the Veiled Hand]]`.
  - Across tiers, always qualify with the tier: `[[hebbock/locations/aethra|Aethra]]`, `[[campaigns/the-veiled-road/party|The Veiled Road Party]]`.
- **Cross-link aggressively.** Every page should link to the entities it involves: an NPC links to their factions and home; a faction lists its members; a dungeon sits in its region; a session links to every person/place it touches; a campaign links to its party, its world, and the world entities it touches.
- No dangling links. If I link to a page that doesn't exist yet, I create a stub (or note it in `_questions.md`).
- Bidirectional: if A links to B, B should mention A (at least in a Relationships / Members / Appearances section).

---

## 7. Canonical Names & Aliases

`_names.md` (at the wiki root) is the **single source of truth** for every entity name, its slug, and its known variants — across both tiers. Format:

| Canonical Name | Slug | Aliases | Type | Page |
|---|---|---|---|---|
| Hebbock | `hebbock` | | world | [[hebbock/worldbuilding/hebbock\|Hebbock]] |
| Vaelor the Bold | `vaelor-the-bold` | Vailor, The Bold | pc | [[campaigns/<slug>/characters/vaelor-the-bold\|Vaelor the Bold]] |

**Workflow:** whenever I meet a name, I check `_names.md`.
- Found → use the canonical name & slug.
- Not found → draft it, and if there's **any** variant spelling or ambiguity, I add an open question and confirm with you before marking it canonical.

This is how "Vaelor" vs "Vailor" never haunts the vault again.

---

## 8. World vs. Campaign: the split

This is the heart of the structure. **Hebbock is the stage; campaigns are the plays staged on it.**

**What lives in `hebbock/` (world canon)**
- Places, factions, items, creatures, NPCs that exist **in the world itself**, independent of any campaign.
- The deep lore: history, gods, magic, cosmology, politics.
- **Changes to the world** caused by a campaign (a city falls, a king dies, a faction rises) are recorded *here*, dated, and linked to the session/arc that caused them. The world page is the record of what is true *now*.

**What lives in `campaigns/<slug>/` (the campaign record)**
- The campaign's premise, its party, its PCs, its sessions, its arcs — the story as it unfolded.
- Campaign-only entities: a one-arc NPC, a dungeon only this party ever visited, loot this party owns.
- The campaign's **timeline**: session → what happened → what world changes it caused (with links into `hebbock/`).

**The golden rule: one page per entity.**
- A world NPC or faction that appears in a campaign gets **one** page in `hebbock/`, linked from the campaign. Never duplicated per campaign.
- A PC belongs to exactly one campaign and lives there.
- When you're unsure which tier a page belongs in: "does it exist if this campaign never happened?" Yes → `hebbock/`. No → `campaigns/<slug>/`.
- If a world entity is *primarily* relevant to one campaign, still file it in `hebbock/` and tag it with the campaign slug.

---

## 9. Page Templates

### Person — PC (lives in `campaigns/<slug>/characters/`)
```markdown
---
title: ""
slug: ""
type: pc
aliases: []
tags: [pc, <campaign-slug>]
created:
updated:
status: draft
---
# Title

> One-line summary.

## Overview
Who they are, their role in the party, their vibe.

## Details
- Race / Class / Level:
- Alignment:
- Player:

## Appearance
## Personality

## Relationships
- [[npcs/slug|Name]] — relationship

## Affiliations
- [[hebbock/factions/faction-slug|Faction]] — role / rank

## Campaign
- Part of [[party|The Party]] (since session X)

## Appearances
- [[sessions/session-01|Session 1]] — what happened
```

### Person — NPC (world NPC in `hebbock/npcs/`; campaign-only NPC in `campaigns/<slug>/npcs/`)
```markdown
---
title: ""
slug: ""
type: npc
aliases: []
tags: [npc]
created:
updated:
status: draft
---
# Title

> One-line summary.

## Overview
Who they are, their role, their vibe.

## Details
- Race / Class / Level:
- Alignment:

## Appearance
## Personality

## Relationships
- [[npcs/slug|Name]] — relationship

## Affiliations
- [[factions/faction-slug|Faction]] — role / rank

## Where They Are
- [[locations/slug|Location]] — current home / base

## Appearances
- [[campaigns/<slug>/sessions/session-01|Session 1]] — what happened
```

### Location (in `hebbock/locations/` unless campaign-only)
```markdown
---
title: ""
slug: ""
type: location
aliases: []
tags: [location]
parent: ""
created:
updated:
status: draft
kind: region
---
# Title

> One-line summary.

## Geography
## Notable Features
## Inhabitants & Powers
- [[npcs/slug|Name]] — role here

## Connected Places
- [[locations/region-slug|Region]] (parent)
- [[locations/dungeon-slug|Dungeon]] (child)

## Current State
_What is true now — including campaign-caused changes, dated._
```

### Faction / Organization (in `hebbock/factions/` unless campaign-only)
```markdown
---
title: ""
slug: ""
type: faction
aliases: []
tags: [faction]
goals: []
leader: ""
rivalries: []
created:
updated:
status: draft
---
# Title

> One-line summary.

## Purpose & Goals
## Leadership
- [[npcs/slug|Name]] — role / rank

## Members
| Name | Role | Notes |
|---|---|---|
| [[npcs/slug\|Name]] | | |

## Structure & Ranks
## Allies & Rivalries
- [[factions/other-slug|Faction]] — relationship

## Headquarters
- [[locations/hq-slug|Location]]

## History
## Involvement in Campaigns
- [[campaigns/<slug>/README|Campaign]] — how they're involved
```

### Item (world item in `hebbock/items/`; campaign loot in `campaigns/<slug>/items/`)
```markdown
---
title: ""
slug: ""
type: item
aliases: []
tags: [item]
created:
updated:
status: draft
owner: ""
---
# Title
> One-line summary.

## Description
## Properties
## Provenance
## Current Owner
- [[characters/slug|Name]] / [[npcs/slug|Name]]
```

### Creature (in `hebbock/creatures/`)
```markdown
---
title: ""
slug: ""
type: creature
aliases: []
tags: [creature]
created:
updated:
status: draft
---
# Title
> One-line summary.

## Biology / Nature
## Habitat
## Behavior
## Threat
## Notable Encounters
```

### Campaign (in `campaigns/<slug>/README.md`)
```markdown
---
title: "Campaign Name"
slug: <campaign-slug>
type: campaign
aliases: []
tags: [campaign]
world: hebbock
party: ""
created:
updated:
status: draft
status_campaign: active
---
# Campaign Name

> One-line premise.

## Premise
The hook, the stakes, the tone.

## The Party
- [[party|Party page]] — full roster
- [[characters/slug|Name]] (player)

## Key World Entities
- [[hebbock/factions/slug|Faction]]
- [[hebbock/locations/slug|Location]]

## Timeline
| Session | What Happened | World Changes |
|---|---|---|
| [[sessions/session-01|S1]] | | |

## Status
active / ongoing / concluded / abandoned
```

### Party (in `campaigns/<slug>/party.md`)
```markdown
---
title: "Party Name"
slug: <campaign-slug>-party
type: party
aliases: []
tags: [party, <campaign-slug>]
created:
updated:
status: draft
campaign: ""
---
# Party Name

> One-line summary of the group.

## Roster
| Name | Player | Role in Party | Page |
|---|---|---|---|
| | | | [[characters/slug\|Name]] |

## How They Met
## Dynamic
## Current State
## Campaign
- [[README|Campaign page]]
```

### Arc (in `campaigns/<slug>/arcs/`)
```markdown
---
title: ""
slug: ""
type: arc
aliases: []
tags: [arc, <campaign-slug>]
created:
updated:
status: draft
---
# Title
> One-line summary.

## Premise
## Key World Entities
- [[hebbock/factions/slug|Faction]]
- [[hebbock/locations/slug|Location]]
## Key People
- [[hebbock/npcs/slug|Name]]
- [[characters/slug|Name]]
## Beats
- [[sessions/session-01|Session 1]] — beat
## Status
ongoing | resolved | foreshadowed
```

### Session (in `campaigns/<slug>/sessions/`)
```markdown
---
title: "Session 1"
slug: session-01
type: session
aliases: []
tags: [session, <campaign-slug>]
date:
created:
updated:
status: draft
arc: ""
---
# Session 1
## Recap
## Key Events
- 
## People
- [[characters/slug|Name]] —
- [[hebbock/npcs/slug|Name]] —
## Places
- [[hebbock/locations/slug|Location]]
## World Changes
- [[hebbock/locations/slug|Location]] — what changed
## Open Threads
- 
```

### Worldbuilding (in `hebbock/worldbuilding/`)
```markdown
---
title: ""
slug: ""
type: worldbuilding
aliases: []
tags: [worldbuilding]
created:
updated:
status: draft
---
# Title
> One-line summary.

## Details
## Related
- [[locations/slug|...]]
```

### Song / bardic work (in `campaigns/<slug>/songs/`)
```markdown
---
title: ""
slug: ""
type: song
aliases: []
tags: [song, <campaign-slug>]
created:
updated:
status: draft
campaign: ""
---
# Title
> One-line summary of the piece.

## Provenance
Who composed it (the bard / a character), when, and why.

## The Words
The full lyrics / text.

## About
- [[characters/slug|...]] — who it's about
- [[hebbock/...|...]] — world entities it touches

## Where It Appears
- [[sessions/session-xx|...]] — when it was sung, if in-play
```

---

## 10. The Churn (ingestion workflow)

This is how I turn your raw notes into the wiki. When you drop notes in `inbox/` (or paste them), I do the following:

1. **Read** the raw notes carefully.
2. **Extract entities** — places, factions, items, creatures, NPCs, PCs, parties, sessions, arcs, and the world lore they touch.
3. **Sort each into its tier** using the golden rule: "does it exist if this campaign never happened?" → `hebbock/` or `campaigns/<slug>/`.
4. **Draft a page** per entity from the templates above, in the right folder, with frontmatter.
5. **Build / refresh `_names.md`** and flag **every** name that has variant spellings.
6. **Model the organizations** — for each faction, capture goals, leadership, ranks, membership, and rivalries; note anything unclear.
7. **Collect open questions** into `_questions.md`, grouped as:
   - **Naming** — variant/ambiguous spellings. "Which is the true name?"
   - **Organizations** — membership, rank, allegiances. "Is Lord X still in the guild, or did he left?"
   - **Contradictions** — details that conflict across notes (dates, places, relationships).
   - **Gaps** — missing info. "Who leads the temple? Which campaign does this party belong to?"
8. **Ask you** those questions (batched, not one-by-one) **before** finalizing.
9. **Apply your answers** — update pages, resolve conflicts, set `status: canonical` on confirmed pages, and cross-link everything.
10. **Update** `00-Index.md`, `_names.md`, and the `campaigns/` registry.
11. **Report** a short summary: what I created, what's canonical, what questions remain.

I never mark a page `canonical` until you've confirmed it. Drafts are clearly labeled.

---

## 11. Quality Rules

- **No orphaned pages.** Every page links to and is linked from at least one other.
- **No duplicates.** One canonical page per entity; variants are aliases, not new pages. World entities are never duplicated into campaigns.
- **No dangling links.** Link to a stub or a logged question, never to nothing.
- **Frontmatter is always present** and valid.
- **Contradictions are surfaced, not hidden.** If sources disagree, set `status: disputed` and log it.
- **The world reflects the present.** Campaign-caused changes to the world are dated and linked to the session that caused them.
- **Keep it greppable.** Plain words, consistent kebab-case slugs, no special characters in filenames.
- **Update `updated:`** whenever a page changes meaningfully.
- **One thing per page.** Split god-pages.

---

## 12. Open Questions

`_questions.md` (at the wiki root) is the running list of everything I need you to clarify. I add entries as I churn; I check them off as you answer. It's grouped by category (Naming / Organizations / Contradictions / Gaps) so you can answer in batches.

When a question is resolved, I fold the answer into the relevant page(s) and `_names.md`.

---

_These guidelines are a living document. As the campaigns of Hebbock grow, I'll refine them with your sign-off._ 🎶
