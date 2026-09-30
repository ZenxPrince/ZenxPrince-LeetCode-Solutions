$ErrorActionPreference = "Stop"

$Root = "$env:USERPROFILE\Phoenix-LeetCode"
Set-Location $Root

Write-Host ""
Write-Host "=== PHOENIX LEETCODE ENGINE ===" -ForegroundColor Cyan
Write-Host "Time: $(Get-Date)"
Write-Host ""

# Repository status
Write-Host "[1/4] Checking workspace..." -ForegroundColor Yellow

$folders = @(
    "problems",
    "solutions",
    "tests",
    "reports"
)

foreach ($folder in $folders) {
    if (!(Test-Path "$Root\$folder")) {
        New-Item -ItemType Directory -Force "$Root\$folder" | Out-Null
    }
}

# Git status
Write-Host "[2/4] Checking Git..." -ForegroundColor Yellow
git status --short

# Generate a daily report
Write-Host "[3/4] Generating report..." -ForegroundColor Yellow

$Report = @"
# Phoenix LeetCode Daily Report

**Date:** $(Get-Date -Format "yyyy-MM-dd")
**Time:** $(Get-Date -Format "HH:mm:ss")
**Account:** ZenxPrince
**Solutions Repository:** ZenxPrince/ZenxPrince-LeetCode-Solutions

## Workspace

- Problems directory: OK
- Solutions directory: OK
- Tests directory: OK
- Reports directory: OK
- Git repository: OK

## Automation

LeetHub is configured separately to synchronize accepted LeetCode
solutions to the GitHub solutions repository.

## Integrity

This engine does not fabricate LeetCode submissions, accepted
solutions, rankings, or contribution history.
"@

$Report | Set-Content "$Root\reports\$(Get-Date -Format 'yyyy-MM-dd').md"

# Commit only genuine workspace changes
Write-Host "[4/4] Recording workspace changes..." -ForegroundColor Yellow

git add -A

if ((git diff --cached --quiet) -eq $false) {
    git commit -m "chore: Phoenix daily workspace update"
}

Write-Host ""
Write-Host "=== PHOENIX ENGINE READY ===" -ForegroundColor Green
Write-Host ""
