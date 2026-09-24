---
name: godot-4-7
description: Godot 4.7 reference for this course project. Use whenever writing or reviewing GDScript, .tscn scenes, project.godot, or lesson text that names Godot nodes, editor menus or APIs. Covers 4.6→4.7 changes, deprecated nodes, and the exact API facts the lessons rely on, plus where to verify anything else.
---

# Godot 4.7 reference (Elementum course)

The learner runs **Godot 4.7.2**. 4.7 is newer than Claude's training data, so do not answer engine questions from memory: check this file, then the official docs. Docs root: `https://docs.godotengine.org/en/stable/` (confirmed to be the 4.7 docs when this file was written).

## How to verify anything not listed here

- Class reference URL pattern: `https://docs.godotengine.org/en/stable/classes/class_<lowercase classname>.html` (e.g. `class_characterbody2d.html`). Fetch it with WebFetch before using a method, signal or property you are not sure about.
- Breaking changes between versions: `https://docs.godotengine.org/en/stable/tutorials/migrating/upgrading_to_godot_4.7.html` (re-fetch when a new 4.x is released, then update this file).
- Release highlights: `https://godotengine.org/releases/4.7/`.
- If the `godot` MCP server tools are available in the session, use them to validate scenes/scripts instead of assuming they load.
- If something could not be tested in the editor, say so to the user.

## 4.6 → 4.7 changes worth knowing

Breaking or behavioral (from the official upgrade guide):
- `Object.is_class()` now takes a `StringName`.
- `RichTextLabel.add_image()/update_image()`: width/height are `float`; `width_in_percent`/`height_in_percent` replaced by `width_unit`/`height_unit`; `ImageUpdateMask.UPDATE_WIDTH_IN_PERCENT` renamed `UPDATE_WIDTH_UNIT`.
- GDScript: assigning to a packed-array element no longer triggers the property setter for the whole array; overriding a method with an inherited typed return now requires an explicit `return`.
- `AudioStreamPlayer` default `area_mask` is now disabled (was layer 1).
- Input: mouse/keyboard `device` IDs are now `InputEvent.DEVICE_ID_MOUSE` / `DEVICE_ID_KEYBOARD` (were `0`).
- Line antialiasing feather removed from 2D lines (adjust widths manually).
- Project defaults changed: stretch mode `disabled` → `canvas_items`, stretch aspect `keep` → `expand`. This is why a fresh `project.godot` no longer lists the viewport size/stretch keys.

New in 4.7 that a beginner may notice: 2D Scene Paint Mode in the editor, new Asset Store (replaces Asset Library), `VirtualJoystick` node, copy/paste of Inspector property groups, `PopupMenu` search bar, `Tween.tween_await()`, one-way collision direction on `CollisionShape2D`.

## API facts the course relies on (verified against the 4.7 docs)

- **CharacterBody2D**: `move_and_slide() -> bool`, uses the physics step's delta automatically (do not multiply `velocity` by delta), call it in `_physics_process()`. `motion_mode`: `MOTION_MODE_GROUNDED = 0` (platformers), `MOTION_MODE_FLOATING = 1` (top-down: constant speed while sliding, all collisions count as walls). The course's top-down player uses `motion_mode = 1` in `player.tscn`.
- **Bodies**: `StaticBody2D` (solid, never moves), `CharacterBody2D` (moved by code), `RigidBody2D` (simulated), `Area2D` (detects overlaps, no solid collision). Solid/detecting bodies need a child `CollisionShape2D` with a `shape`.
- **Area2D signals**: `body_entered`, `body_exited`, `area_entered`, `area_exited` (plus `*_shape_*` variants); require `monitoring = true` (default). Overlap lists update once per physics step, so prefer signals.
- **Collision layers**: `collision_layer` = layers the object is in; `collision_mask` = layers it scans. Named in Project Settings → Layer Names → 2D Physics. Code: `set_collision_layer_value(n, bool)`, `set_collision_mask_value(n, bool)`.
- **TileMap is deprecated → use `TileMapLayer`** (one layer per node; use several nodes for several layers). Key API: `tile_set`, `set_cell()`, `get_cell_source_id()`, `local_to_map()`, `map_to_local()`, `get_used_cells()`, `collision_enabled`. Never teach `TileMap` in lessons.
- **Input**: `Input.get_axis(neg, pos)` = strength(pos) − strength(neg); `Input.get_vector(neg_x, pos_x, neg_y, pos_y, deadzone)` returns a length-limited vector; `is_action_pressed()`, `is_action_just_pressed()`, `get_action_strength()`. The built-in `ui_left/right/up/down` actions exist by default (arrow keys); the course uses them until the lesson that teaches custom Input Map actions.
- **GDScript syntax**: `:=` infers type; typed collections `Array[int]`, `Dictionary[String, int]` (typed dictionaries are supported); `signal name(args)`, emit with `name.emit(...)`, connect with `obj.name.connect(callable)`; `@export`, `@onready`; `class_name` + `extends`; `static func`; `match`; lambdas `func(x): ...`; `await signal_or_coroutine`.
- **Style (official guide)**: tabs for indentation; `snake_case` files/functions/variables; `PascalCase` classes; `CONSTANT_CASE` constants and enum members; signals in past tense (`door_opened`); double-quoted strings; lines under 100 chars; two blank lines between functions; script order: signals/enums/constants → exported vars → regular vars → `@onready` → `_init/_ready` → virtual callbacks → public methods → private methods (`_leading_underscore`).

## Not verified yet (check before writing lesson text that depends on it)

- The exact English label and location of the editor option that shows collision shapes while the game runs (Lesson 2 says Debug → Visible Collision Shapes; the debug-menu docs page was not reachable).
- Any editor UI wording introduced or changed in 4.7 (menus, panel names). The learner's editor language may also be Italian.
- The docs page `tutorials/physics/using_character_body_2d.html` was summarized as suggesting `MOTION_MODE_GROUNDED` for top-down, which contradicts the class reference (which recommends floating for top-down). Treat the class reference as authoritative and re-read the page directly if this matters.
