# DiceAndCamps Goal Audit

Updated: 2026-06-06

This file tracks the original 20-point goal against the current codebase so we can stop guessing and close the remaining gaps deliberately.

There is now a repeatable debug/runtime-proof harness in `index.html` plus captured scene references in `docs/runtime-proof/README.md`, so visual acceptance no longer depends on replaying a full match by hand every time.

## Status legend

- `Complete`: implemented in code with clear local evidence
- `Partial`: meaningful implementation exists, but the original target is not fully satisfied yet
- `Needs runtime proof`: code exists, but the result still needs stronger visual / in-browser verification before we can call the goal finished

## Requirement audit

1. `Complete`  
   Smaller character scale, shared-tile formations, and animated reflow are implemented in `index.html:1280`, `index.html:1302`, `index.html:1339`.

2. `Complete`  
   Build / upgrade / demolish / skip action phase exists, and max-level upgrade blocking is implemented in `index.html:4372`, `index.html:4482`, `index.html:4562`.

3. `Complete`  
   Enemy-adjacent facility events run before action phase in `index.html:2397`, `index.html:2413`, `index.html:2669`.

4. `Complete`  
   Owned-adjacent facility events run before enemy events via ordered landing flow in `index.html:1477`, `index.html:2397`, `index.html:2437`.

5. `Complete`  
   Turn-state flow is explicitly modeled and used across landing, branch choice, action phase, wizard phase, and battle in `index.html:793`, `index.html:1385`, `index.html:2397`, `index.html:4179`.

6. `Needs runtime proof`  
   Dice launch / roll / settle states, character-over-dice layering, and occluder fading exist in `index.html:800`, `index.html:2256`.  
   Code is present, but visual proof is still weaker than it should be.

7. `Complete`  
   Camera follow / dragging / returning states exist in `index.html:804`, `index.html:819`, `index.html:2192`, `index.html:4518`.

8. `Complete`  
   Monsters block empty slots, can be challenged in the action phase, and only consume the turn on failure in `index.html:3088`, `index.html:4404`.

9. `Complete`  
   Combat entry points are monster fights and facility challenges; there is no player-meets-player battle path in `index.html:3088`, `index.html:3118`.

10. `Complete`  
    Guarded enemy facilities can be challenged, wall + guard layers are modeled, and victory destroys the building in `index.html:1717`, `index.html:3118`, `index.html:3153`, `index.html:4179`.

11. `Needs runtime proof`  
    Battle transitions, map object exit, battle floor entry, staged positioning, and snapshot restore exist in `index.html:3308`, `index.html:3372`, `index.html:3445`.  
    Needs stronger in-browser confirmation for framing and smoothness.

12. `Needs runtime proof`  
    Turn-based battle commands and command UI exist in `index.html:3581`, `index.html:3669`, `index.html:4179`.  
    Mechanically present, but still needs a final feel check.

13. `Needs runtime proof`  
    Battle result animation, celebration / defeat posing, and victory flourish exist in `index.html:4013`.  
    Needs visual acceptance, not just code presence.

14. `Complete`  
    Enlarged orthogonal loop plus branches and wizard dead-end node are present in `index.html:900`, `index.html:963`.

15. `Needs runtime proof`  
    Floating road/land tiles and tile sink-bounce on landing are implemented in `index.html:1102`, `index.html:1117`, `index.html:1356`.

16. `Needs runtime proof`  
    Map intro and battle enter/exit use staggered sequencing in `index.html:1102`, `index.html:3372`, `index.html:3445`.

17. `Partial`  
    Building roster, guard recruitment / transfer, guard roles, and many owned/enemy events already exist in `index.html:750`, `index.html:2437`, `index.html:2669`, `index.html:3020`, `index.html:4471`.  
    This turn also deepened facility-specific siege identity and battle plans in `index.html:1717`, `index.html:1764`, `index.html:3851`.  
    Same-node owned facilities and stationed guards now feed temporary battle support cards into the player's deck, owned-building pass-by events now cover the building roster with next-battle prep cards and long-term deck refinement, guard composition now has explicit doctrine bonuses that feed local battle support and siege spoils, guards now also gain veterancy through training, upkeep, and battle support, veteran guards can turn that veterancy into local support, pass-by prep, richer siege spoils, and their own veteran-only support cards, veteran defenders now also toughen real building battle stats and enemy action patterns, and veterancy now reaches the map layer too: enemy veteran guards increase route pressure and can even disrupt prepared battle cards, while owned veteran guards can add pass-by fortify/heal/gold benefits that are previewed in the hover/build UI. On top of that, newly recruited guards now inherit building-specific training imprints that persist after transfer and affect route pressure, pass-by support, and battle preview stats, which makes recruitment location and later redeployment matter more. Those training imprints now also form explicit mixed-guard combos that can add extra map-event rewards, pressure patterns, and siege spoils, so building identity is starting to emerge from guard composition rather than only static facility type, and enemy facilities now actively trigger those combos both in map events and in their defender battle AI. The battle presentation layer also now reflects more of that context through taunts and result copy that respond to facility type, training combos, veterancy, and monster archetypes instead of using one generic line for every fight, while the same training combos now also feed direct same-node battle support like extra opening draws and pre-battle recovery. Siege victories now also convert enemy building identity and guard composition into immediate battle spoils plus deck refinement, player victories offer post-battle card rewards, the wizard node can also remove cards for deck-thinning, the player can inspect deck/prep/support state from a deck panel, and wild monsters now have distinct archetypes with different reward flavor and battle behavior in `index.html`.  
    This pass also upgrades route planning from simple two-building pairs to stronger three-building battlefront plans, so a junction can now mature into fuller doctrines such as offense-heavy legion staging, shield-heavy fortress sentry nets, field-rotation sustain hubs, and blockade tax-lines; those fuller plans now affect pass-by effects, opening battle setup, spoils, preferred guard roles, player build hints, and AI build priorities.  
    Siege victories now also feed the guard loop more directly: when a defended enemy building falls, the player can salvage part of that garrison into a capped reserve pool, and later recruitment can deploy matching reserve troops into owned facilities at a reduced cost instead of always minting fresh generic guards. That makes building assault, reserve management, later stationing, and node defense planning pull on the same progression thread instead of being separate systems.
    Still not at the original “fully fleshed out content layer” target.

18. `Complete`  
    Empty-guard building battles correctly fall back to wall-only fights in `index.html:1717`, `index.html:3153`.

19. `Complete`  
    Most buildings allow guards, while special defense buildings deliberately trade guard slots for heavy wall scaling in `index.html:750`, `index.html:1589`.

20. `Needs runtime proof`  
    Taunt phase, close-up camera moves, comic-style taunt layer, and typewriter text exist in `index.html:3524`, `index.html:3549`.

## What is still not truly finished

1. Strong runtime verification is still missing for the most visual goals: `6`, `11`, `12`, `13`, `15`, `16`, `20`.
   We now at least have targeted capture hooks and first-pass screenshots for `6`, `11`, `12`, `13`, and `20`, but they still need final acceptance judgment.
2. Goal `17` still needs more content depth before it matches the original ambition.
3. We still need one final requirement-by-requirement acceptance pass that proves the whole 20-point goal in the running app, not just in source code.

## Best next steps

1. Keep using the new debug scenes to extend proof coverage, especially for tile bounce / staggered map intro (`15`, `16`) and any remaining battle framing edge cases.
2. Continue deepening goal `17`, prioritizing guard/building/siege identity over unrelated polish.
3. Convert this audit into a final acceptance checklist once runtime proof exists.
