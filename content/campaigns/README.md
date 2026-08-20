# 🎲 Campaigns

> One subfolder **per campaign**. Each holds that campaign's own records: its party, its characters, its sessions, its arcs — the story as it unfolded.
>
> World truth lives in the continent tier of the campaign's continent ([[hebbock/README|hebbock/]] for the world heart, [[zazi/README|zazi/]] for the Zazi continent — same world, ruled 2026-08-20). Campaign folders hold the *journey*; the tier holds the *world the journey happened in*.

## Structure

```
campaigns/
├─ README.md            # this file — the campaign registry (table below)
├─ <campaign-slug>/
│   ├─ README.md        # campaign page: premise, party roster, status, timeline
│   ├─ party.md         # the party: who's in it, how they met, current state
│   ├─ characters/      # PCs of this campaign (one page each)
│   ├─ npcs/            # NPCs introduced/used only in this campaign
│   ├─ locations/       # locations only relevant to this campaign
│   ├─ items/           # campaign loot & notable items (world-famous items link to hebbock)
│   ├─ arcs/            # the campaign's plot arcs
│   └─ sessions/        # one page per session
```

## The Registry

| Campaign | Continent | Slug | Party | Status | Page |
|---|---|---|---|---|---|
| Quiet Door | [[hebbock/worldbuilding/hebbock\|Hebbock (world heart)]] | `quiet-door` | [[quiet-door/party\|The Party]] | active | [[quiet-door/README\|Quiet Door]] |
| The Avengers | [[zazi/worldbuilding/zazi\|Zazi continent]] | `team-c` | [[team-c/party\|The Party]] | active | [[team-c/README\|The Avengers]] |

- **Slug** — kebab-case, folder name.
- **Continent** — the continent tier the campaign is played in (one world, two known continent tiers).
- **Party** — link to the party page.
- **Status** — active · ongoing · concluded · abandoned.

## Conventions
- A **PC belongs to one campaign** — lives in `campaigns/<slug>/characters/`.
- A world NPC or faction that appears in a campaign gets **one** page (in its world tier, `hebbock/` or `zazi/`), linked from the campaign; never duplicated per campaign.
- Every session page links to the party, the places visited, and the arcs advanced.
- Every page gets a row in [[_names|_names.md]] and cross-links both ways.
- Campaign READMEs include a **timeline** (session → what happened → world changes).

_When a new campaign starts, I create `campaigns/<slug>/` from this template and add it to the registry._ 🎶
