# 🎲 Campaigns

> One subfolder **per campaign** played in the world of Hebbock. Each holds that campaign's own records: its party, its characters, its sessions, its arcs — the story as it unfolded.
>
> World truth lives in [[hebbock/README|hebbock/]]. Campaign folders hold the *journey*; hebbock holds the *world the journey happened in*.

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

| Campaign | Slug | Party | Status | Page |
|---|---|---|---|---|
| _none yet_ | | | | |

- **Slug** — kebab-case, folder name.
- **Party** — link to the party page.
- **Status** — active · ongoing · concluded · abandoned.

## Conventions
- A **PC belongs to one campaign** — lives in `campaigns/<slug>/characters/`.
- A world NPC or faction that appears in a campaign gets **one** page (in `hebbock/`), linked from the campaign; never duplicated per campaign.
- Every session page links to the party, the places visited, and the arcs advanced.
- Every page gets a row in [[_names|_names.md]] and cross-links both ways.
- Campaign READMEs include a **timeline** (session → what happened → world changes).

_When a new campaign starts, I create `campaigns/<slug>/` from this template and add it to the registry._ 🎶
