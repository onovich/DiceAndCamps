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

## Validation Gates

- Static launchers dry-run successfully.
- `index.html` still contains the game canvas and initializes without syntax errors.
- Manual smoke: open the local page, roll a turn, verify same-node stance reflow, drag camera and release, and reach post-move interaction.
- Git workflow validation passes before each commit/push.
