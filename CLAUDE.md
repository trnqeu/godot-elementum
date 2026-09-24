# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## What this repository is

A hands-on Godot course for teaching an absolute-beginner 12-year-old to program in GDScript, built lesson by lesson into a small 2D game called **Elementum**. It is not a production codebase — it's teaching material plus the game project the lessons build up. See `README.md` for the full lesson index and collaboration workflow (a parent on Linux and the learner on Windows, sharing one Git repo, no WSL).

## Commands

There is no build step, package manager, or test suite — this is a Godot Engine 4.x project driven entirely through the editor:

- Open the project: launch Godot 4.x → Import → select `game/project.godot`.
- Run the whole game: **F5** in the editor (runs `run/main_scene`, currently `game/scenes/main.tscn`).
- Run just the scene currently open in the editor: **F6** — this is the normal way to test an individual lesson's scene (e.g. `game/scenes/player/player.tscn`) in isolation.
- No linter/formatter is configured; follow the existing GDScript style (tabs for indentation, `snake_case`, static typing with `:=`/type hints where the existing files use it).

Everyone must use the **same Godot 4.x minor version** (currently 4.7.x, see `README.md`) — `game/project.godot`'s `config/features` records the version last used to write it.

For any Godot API, node or editor-menu question, use the project skill `.claude/skills/godot-4-7/SKILL.md` (4.7 facts and doc URLs) rather than memory — 4.7 is newer than Claude's training data. If the `godot` MCP server is available, use it to validate scenes/scripts.

## Architecture

Two top-level trees with different audiences:

- `lessons/` — the course itself, one Markdown file per lesson (`00-...md`, `01-...md`, ...). Every lesson follows the fixed 6-section structure defined in `lessons/_template-lezione.md`: Obiettivo, Concetti nuovi, Passi hands-on, Checkpoint, Sfida finale (facoltativa), Salva il tuo progresso. New lessons should be authored by copying that template, not freehand. Lessons are written progressively (only as far as the learner has actually reached), not all upfront.
- `game/` — the actual Godot project referenced by the lessons:
  - `scenes/player/`, `scenes/enemies/`, `scenes/rooms/`, `scenes/spells/`, `scenes/ui/` — one scene = one responsibility; no god-object scenes.
  - `scripts/utils/dado.gd` — `class_name Dado`, static helper for D&D-style dice rolls (`Dado.tira_dado(facce)`, `Dado.colpisce(bonus, difesa)`), introduced starting the "dice/first enemy" lesson.
  - `scripts/resources/` — custom `Resource` subclasses (e.g. a future `Spell` resource for the card-style spell system).
  - `scripts/autoload/` — intentionally does not exist yet; see constraint below.
  - `assets/sprites/` — placeholder art is `game/icon.svg`; `assets/sprites/README.md` points to CC0 Kenney.nl packs as the intended real art source.

## Design constraints specific to this course (don't relax without discussing with the user)

These are deliberate pedagogical simplifications, not missing features — code changes to `game/` should respect them unless the user explicitly asks to move past a given lesson's stage:

- **No Autoload/singleton before the "save progress" lesson.** Global mutable state introduced early is "black magic" to a first-time programmer; until then, state lives on nodes and is passed via direct signals/references between the few scenes involved.
- **No real deck-building.** Spells are a fixed, small loadout (1-4 slots unlocked lesson by lesson) shown as cards with mana cost/cooldown in the HUD — not a shuffled draw/discard deck. This is intentional; don't build actual deck mechanics unless asked.
- **Real-time combat, not turn-based.** Exploration and combat both run live (`CharacterBody2D` + `move_and_slide()`); hits are resolved instantly via a d20 roll under the hood (`Dado`), not through a turn queue/menu.
- **Elemental reactions are minimal by design.** Core pair reactions (Water+Electro = Folgorazione, Water+Ice = Congelamento) are the required set; Fire+Ice and Fire+Water are optional "stretch" reactions, not required baseline features.
- **All lesson prose and in-code comments are in Italian**, written for a 12-year-old with zero programming background — keep new comments short, concrete, and explain *why*, matching the existing tone in `game/scenes/player/player.gd` and `game/scripts/utils/dado.gd`.
- **Custom Input Map actions are deliberately deferred.** Lesson 1 uses Godot's built-in `ui_left`/`ui_right`/`ui_up`/`ui_down` actions on purpose (zero-config, guaranteed to work) rather than hand-authoring custom actions in `project.godot`; introduce custom actions (e.g. Italian-named ones like `muovi_sinistra`) only in a lesson designed to teach the Input Map UI directly.
- Every gameplay balance value (speed, damage, HP, mana cost) should be exposed via `@export` so the learner can tune it from the Inspector without touching code.

## Git workflow

Everyone commits directly to `main` — no feature branches for the learner (avoids introducing merge/branch concepts that add nothing pedagogically here). End-of-lesson checkpoints are marked with a **tag**, not a branch: `git tag lezione-NN` after the commit for that lesson. See `lessons/_template-lezione.md`'s "Salva il tuo progresso" section for the exact commands expected at the end of every lesson.
