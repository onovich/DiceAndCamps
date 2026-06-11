# Dice & Camps TODO

Updated: 2026-06-11

This list keeps the remaining work separate from the implementation history in `docs/implementation-roadmap.md`.

## P0: Release And Smoke Proof

- Keep GitHub Pages deploy output aligned with runtime assets. `index.html` now imports local `vendor/` modules, so the deploy workflow must ship `vendor/` with the static site.
- Run a local browser smoke before gameplay pushes: load the page, confirm the map renders, and watch for module/runtime errors.
- After each push to `main`, verify the Pages build and online preview once the GitHub Actions run finishes.

## P1: Runtime Acceptance

- Finish visual acceptance for goal `6`: dice launch, settle face, render layer, and occluder fade/restore.
- Finish visual acceptance for goals `11`, `12`, and `13`: battle entry/restoration, command loop readability, and result presentation.
- Add runtime proof for goals `15` and `16`: floating tile bounce plus staggered map appear/disappear.
- Finish visual acceptance for goal `20`: taunt camera framing, comic boxes, and typewriter pacing.
- Refresh `docs/runtime-proof/` captures after the action-choice and battle-hand changes stabilize.

## P2: Gameplay Depth And Balance

- Continue goal `17`: deepen facility, guard, siege, reserve, and route-planning identity before treating the content layer as complete.
- Balance the current economy pass, especially cheaper facilities, guard recruitment cost, monster gold rewards, and battle hand size.
- Check that the new action-choice menu makes build/manage/challenge intent obvious without hiding valid adjacent targets.
- Exercise battle card retention across multiple rounds: opening draw, per-turn draw, discard behavior, empty-hand flee fallback, and support-card counters.
- Extend AI smoke scenarios so AI build management, guard deployment, and challenge choices still progress without blocking.

## P3: Maintainability

- Split the large `index.html` into modules once the current gameplay pass stabilizes: data/config, rendering, input, UI, turn flow, and battle logic.
- Move hardcoded facility, monster, guard, card, reward, and map values into structured config.
- Replace callback-heavy animation timing with a clearer async animation queue.
- Keep the local `vendor/` dependency approach documented until the project moves to a package-managed build.

## Parking Lot

- Add GLTFLoader and an asset pipeline when formal art replacement starts.
- Replace procedural placeholder geometry with style-matched production assets while preserving the orthographic NPR look.
- Revisit README/design encoding and bilingual copy polish when documentation work becomes the focus.
