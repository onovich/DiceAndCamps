# Dice & Camps Implementation Roadmap

This roadmap tracks the requested gameplay goals without dropping scope. Work should land in small tested increments; each increment must keep the static prototype runnable.

## Requirement Map

1. Multi-character road-node occupancy: smaller character models, centered solo stance, evenly distributed shared stance, and lively tweened reflow.
2. Player post-move action phase: build on empty land, upgrade owned buildings, demolish owned buildings, challenge enemy guarded buildings, fight adjacent monsters, or do nothing. Every action except demolition and successful combat consumes the current action. Max-level buildings cannot be upgraded.
3. Enemy building event phase: when arriving near enemy buildings, resolve all enemy building events before player choices.
4. Owned building event phase: when arriving near owned buildings, resolve owned building events before enemy events.
5. Turn/action state machine: explicit phase transitions to prevent mixed movement, event, build, battle, and end-turn flows.
6. Dice state machine and presentation: launch dice from the current character's node, scale/perspective-like emphasis while airborne, settle showing the final face, render above characters/buildings, and temporarily fade occluding buildings.
7. Camera state machine: separate follow, drag, and return-to-follow states so releasing drag smoothly recenters without shake.
8. Adjacent monster choices: monsters can occupy adjacent land; players may fight them during the action phase. Victory does not consume the action; defeat does.
9. Character collision rule: meeting another character does not start combat.
10. Enemy guarded building challenge: players can challenge guarded enemy buildings; victory destroys the building without consuming the action, defeat consumes it. Unguarded buildings still fight as defensive walls.
11. Battle scene transition: move map tiles out of view in staggered order, show a stylized battle floor, move combatants into JRPG-style positions, and restore all recorded map/camera positions afterward.
12. Turn-based JRPG combat: attack, skill, defend, flee choices with camera-enhanced presentation.
13. Battle result presentation: bold victory/defeat UI, cheering and discouraged character animations, and celebratory particles for winners.
14. Larger map: loop layout with branches.
14a. Orthogonal map constraint: all road nodes must align on a grid and connect only forward/back/left/right, with no diagonal or staggered adjacency.
14b. Branch choice: when a moving player reaches a fork before spending all dice steps, pause movement and let the player choose a direction.
14c. Shared adjacent land: L-corner road nodes may share the same adjacent land tile instead of creating overlapping duplicate land.
14d. Future special dead ends: only rare optional NPC nodes, such as a wizard trade node, may be dead ends. This can later connect to a minimal Slay-the-Spire-inspired deck-building combat layer.
15. Floating map tiles: road/land tiles hover; landing characters depress the road tile and it springs back.
16. Staggered map appear/disappear: map tiles should transition with offset timing.
17. Building content expansion: prioritize guard recruitment/assignment and combat impact; design additional owned/enemy building functions for later batches.
18. Wall-only battles: attacking an unguarded enemy building enters battle against the wall.
19. Guard assignment rules: most buildings can house guards; special buildings may skip guards but should upgrade defense quickly.
20. Pre-battle taunt phase: camera close-ups and comic dialogue boxes with typewriter text before combat.

## Dependency Order

1. Foundation state machines: turn phase, action phase, dice phase, camera mode, and battle phase enums.
2. Spatial presentation: smaller characters, shared-node stance layout, tile landing bounce, camera drag return, dice launch/settle layer.
3. Action phase rewrite: owned event queue, enemy event queue, then explicit player action choices.
4. Building model upgrade: level caps, demolition, defense stats, guard slots, wall-only enemy data.
5. Monster and challenge entry points: adjacent monster battle and enemy building challenge.
6. Battle scene shell: map exit/return, battle floor, participant placement, camera recording/restoration.
7. Battle rules and UI: JRPG commands, taunts, attacks, skills, defend/flee, result animations.
8. Map expansion and content pass: larger loop, branches, more building events, richer guard recruitment.

## Increment Plan

### Increment 1: Flow And Spatial Foundations

- Add explicit state machine helpers for turn, dice, camera, and action phases.
- Shrink character models and implement shared road-node stance reflow.
- Add camera drag/follow/return modes.
- Replace global animation clearing with scoped slot highlight tweens.
- Improve dice launch and settlement enough to respect the new dice phase.

### Increment 2: Post-Move Action Phase

- Resolve owned building events, then enemy building events, then enter action choices.
- Add build, upgrade, demolish, and pass actions.
- Enforce max building level.
- Track whether the current action has been consumed.

### Increment 3: Combat Entry Points

- Add adjacent monsters and enemy building challenge selection.
- Ensure character-to-character meetings do not trigger combat.
- Add wall-only enemy fallback for unguarded enemy buildings.

### Increment 4: Battle Scene And JRPG Loop

- Add battle transition, battle floor, participant placement, and restoration.
- Implement command UI and basic attack/skill/defend/flee loop.
- Add taunt dialogue and result celebration/defeat presentation.

### Increment 5: Map And Content Expansion

- Expand loop map with branches.
- Add staggered map appear/disappear.
- Add guard recruitment/assignment and more building event designs.
- Added healing camps and training camps as owned building events.
- Added automatic AI battle commands so passive AI encounters cannot block on human input.
- Added pre-battle camera close-ups for the taunt/typewriter sequence.
- Added command-level camera focus changes for attack, skill, defend, flee, and counterattacks.
- Added enemy passive events for income, healing, training, and guarded non-guard buildings.
- Added faster defense scaling for facilities that cannot host guards.
- Strengthened dice render layering so characters cannot depth-occlude the roll result.
- Added battle snapshot, exit, and restore handling for noncombat characters.
- Rebuilt the route graph as an orthogonal main loop with reconnecting branches.
- Added shared adjacent land tiles for L-corner roads to avoid duplicate/overlapping land.
- Added player branch-choice UI during movement when dice steps remain.
- Added an optional wizard dead-end node with gold/HP-for-card trades.
- Added a minimal deck-combat foundation: starter decks, shuffle/draw/discard, and card actions in battle.
- Added continuous idle floating for road and land tiles with pause/resume around bounce, action highlights, and battle transitions.
- Added battle deck HUD counters and card kind labels for the deck-combat UI.
- Added explicit branch-choice and wizard-event states to keep new map/NPC flows out of generic moving/event states.
- Upgraded wizard trades from random rewards to paid three-card deck-building choices.
- Enlarged the board by adding more 2-unit grid road tiles to the main loop, not by increasing road spacing.
- Added slim road connectors so the loop and branch direction read as continuous routes instead of isolated floating tiles.
- Reduced land-tile density and tile size so buildable spaces no longer fill every gap between roads.
- Replaced the branch-choice DOM menu with in-world road-tile arrows that appear only after the player reaches a fork mid-move.
- Added pointer hover feedback for road tiles, land tiles, and branch-choice arrows.
- Added hover information panels for player/enemy characters, owned/enemy facilities, and wild monsters.
- Added an explicit battle phase state machine for battle entry, taunts, attacker/enemy turns, results, and restoration.
- Added clearer JRPG combat feedback: defense shields, hit sparks, and enemy counterattack lunges.
- Added a battle status HUD with both combatants' HP bars, round count, and current battle phase.
- Added shared building battle previews for hover panels, enemy challenge menus, and wall/guard combat stats.
- Added AI building management so opponents recruit guards and upgrade owned facilities before building new ones.
- Added snapshot-based dice occluder fading so nearby buildings and guard markers fade during dice rolls and restore exactly afterward.
- Refined shared road-node stances with smaller character bodies, colored stance pads, and bouncy reflow animations.
- Strengthened pre-battle taunts with jagged comic panels, speaker labels, and monster/facility-specific lines.
- Expanded the garrison layer with typed guards, owned guard-post training events, action-phase guard transfers, richer facility hover info, and AI guard reassignments.
- Split facility battles into wall-first and guard-follow-up phases so enemy defenders actually hide behind fortifications before being forced into the open.
- Added barracks and wall-workshop facilities so guard training, reinforcements, and fortification growth have clearer building identities for both player and AI turns.
- Made guard archetypes mechanically matter in siege fights with shield-based wall mitigation, scout-style evasion, and clearer role readouts in enemy challenge previews.
- Reworked the battle command surface into explicit Attack, Skill, Defend, and Flee choices, while keeping deck-drawn cards as a secondary skill layer.
- Gave enemy turns more JRPG identity with phase-aware actions like emergency wall repairs, guard rally turns, and role-driven counter moves instead of a single flat retaliation pattern.
- Upgraded battle results into a comic-style payoff panel with winner-focus camera beats, stronger cheer/slump contrast, and more expressive victory or defeat copy.
- Expanded the orthogonal main loop again by adding more road tiles and reconnecting longer inner branches, keeping the board larger without increasing grid spacing.
- Turned guard recruitment into an explicit role choice so players can deliberately buy shield, spear, or scout defenders instead of receiving a fixed auto-cycle.

## Validation Gates

- Static launchers dry-run successfully.
- `index.html` still contains the game canvas and initializes without syntax errors.
- Manual smoke: open the local page, roll a turn, verify same-node stance reflow, drag camera and release, and reach post-move interaction.
- Git workflow validation passes before each commit/push.
