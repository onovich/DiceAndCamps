<!-- codex-project-git-workflow: initialized -->

# Codex Git Workflow

Initialization status: initialized
Project: DiceAndCamps
Repository root: `D:\WebProjects\DiceAndCamps`
Machine config: `.codex/project-git-workflow.json`
Skill: project-git-workflow

Treat this document and the machine config as the source of truth for this repository's Codex git workflow.

## Global Wrappers

Run these from the repository root:

```powershell
C:\Users\Administrator\.codex\skills\project-git-workflow\scripts\git\Status.cmd
C:\Users\Administrator\.codex\skills\project-git-workflow\scripts\git\Validate.cmd
C:\Users\Administrator\.codex\skills\project-git-workflow\scripts\git\Commit.cmd -Message "commit message" -Paths path\to\file,other\file
C:\Users\Administrator\.codex\skills\project-git-workflow\scripts\git\CommitAndPush.cmd -Message "commit message" -Paths path\to\file,other\file
C:\Users\Administrator\.codex\skills\project-git-workflow\scripts\git\Push.cmd
```

## Status

```powershell
git -c safe.directory=D:/WebProjects/DiceAndCamps status --short --branch
```

## Validation

Run these before commit or push, in order:

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\StartLocalTest.ps1 -DryRun
```

```powershell
powershell -NoProfile -ExecutionPolicy Bypass -File .\scripts\OpenOnlineTest.ps1 -DryRun
```

```powershell
powershell -NoProfile -Command "if (-not (Select-String -Path .\index.html -Pattern game-canvas -Quiet)) { exit 1 }"
```

## Staging Policy

selected files only

Inspect status before staging. Preserve unrelated user changes unless the user explicitly asks to include them.

## Commit

Use the global wrapper's built-in git commit after staging according to policy. Prefer concise conventional commit messages unless the user specifies another message.

## Push

```powershell
git -c safe.directory=D:/WebProjects/DiceAndCamps push -u origin HEAD
```

## Docs And TODO

Keep `README.md` command examples aligned with the actual scripts in the repository.

## Safety And Branch Policy

No force pushes. Destructive git commands require explicit user approval.
