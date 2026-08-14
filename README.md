# Carapace Corruption

Carapace Corruption is a compact Factorio 2.0 mod concept centered on a cyberpunk bio-mechanical aesthetic. It introduces Cyber-Slurry, an incubator-style production machine, and a corrupted biter unit with a neon green, infected look.

This project is designed as a clean foundation for future expansion, with a strong sci-fi identity and a lightweight prototype structure that can grow into a larger mod ecosystem.

## Features

- Custom fluid: Cyber-Slurry
- Incubator Pen prototype as a simple electric production machine
- Corrupted biter unit using base-style animations with a custom tint
- Minimal control script with entity hooks and a throttled periodic tick loop

## Project Structure

- `info.json` — mod metadata and dependencies
- `data.lua` — prototype definitions for fluids, recipes, items, entities, and units
- `control.lua` — basic event logic and periodic checks

## Current Status

This is an initial scaffold and prototype pass. The goal is to establish the visual and mechanical identity of the mod before expanding into additional content and gameplay systems.

## Development Notes

The visual direction emphasizes:

- cyberpunk color palettes
- neon green corruption effects
- bio-mechanical industrial forms
- dystopian factory aesthetics from a contaminated future

## Publishing

```bash
git add .
git commit -m "Initial Carapace Corruption mod scaffold"
git branch -M main
git remote add origin https://github.com/infinitechris/CarapaceCorruption.git
git push -u origin main
```
