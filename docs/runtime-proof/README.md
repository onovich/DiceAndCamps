# Runtime Proof Scenes

Updated: 2026-06-05

This folder stores repeatable runtime-proof captures driven by `index.html` query params.

## Query scenes

- `?debug=1&scene=map`
- `?debug=1&scene=dice&hold=dice-settle`
- `?debug=1&scene=battle-facility&hold=taunt`
- `?debug=1&scene=battle-facility&hold=commands`
- `?debug=1&scene=result-victory&hold=result`

## Captured files

- `map-overview.png`: enlarged orthogonal loop overview
- `dice-settle.png`: dice launch / settle framing
- `battle-taunt.png`: taunt comic boxes and battle staging
- `battle-commands.png`: battle command UI and battlefield framing
- `result-victory.png`: victory result banner plus confetti

## Notes

- The new debug panel lets us jump to these scenes in-browser without replaying a whole run.
- The `hold` query param intentionally pauses a scene on a specific phase so headless capture can stop on stable frames.
- This is stronger runtime evidence for goals `6`, `11`, `12`, `13`, and `20`, but it does not replace final human feel-checks for animation smoothness.
