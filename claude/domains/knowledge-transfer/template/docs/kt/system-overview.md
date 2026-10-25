<!-- kt:cited -->
# System Overview

What a new developer needs in order to find their way around the code and make a safe change. Every bullet, step and table row cites a source.

## What the system does

<!-- Three to five bullets: who uses it and for what. -->

## Components

| Component | What it does | Where in the code | Source |
|---|---|---|---|

## External systems

| System | What we send or receive | How (API, file, database) | Source |
|---|---|---|---|

## Environments

| Environment | Where it runs | How to get access | Source |
|---|---|---|---|

## Build, test and run locally

<!-- Numbered steps with exact commands. -->

## Deploy

<!-- Numbered steps for each environment, from build to checking it worked. -->

## Where to start when changing the code

<!-- Bullets: the main entry points, where the business logic lives, traps to avoid. -->

## Example

```
- Orders are imported every night from the ERP by the `NightlyImport` job. [src: Jobs/NightlyImport.cs:18]
1. Run `dotnet test` from the solution folder. [src: Build/README.md]
```
