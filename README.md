# Carapace Corruption

Carapace Corruption is a Factorio 2.0 mod prototype built around a player-owned biotech defense loop. The concept blends industrial infrastructure, cyberpunk styling, and a biomatter conversion system: the player builds a nexus, harvests the mass of enemy swarms, turns it into Cyber-Slurry, and transforms that raw biological feed into allied sentinel guardians.

The mod’s public-facing identity is a player-aligned war machine: a bio-industrial fortress that uses the enemy’s own biomass against them, while keeping the overall design focused on controlled logistics, safe spacing, and clean structure placement.

## Design Goals

- Create a distinct biotech defense fantasy without turning the mod into a full enemy-control gimmick
- Keep the player at the center of the system through a nexus-driven conversion loop
- Use Cyber-Slurry as a deliberately constrained resource, with barrel handling creating a more tactical storage and staging problem
- Build allied sentinel units that feel like engineered defenders, not wild creatures or tamable enemies
- Maintain a prototype-first approach that is stable, readable, and easy to expand later

## Core Systems

- Nexus-based structure logic for the player’s biotech extraction and conversion network
- Cyber-Slurry as a barrel-only intermediary resource intended to avoid standard fluid automation patterns
- Biomass conversion concepts that transform battlefield threat into usable bio-material
- Allied sentinel units designed around a biter-derived silhouette with a cybernetic, industrial treatment
- Defensive spawn behavior that is easy to observe and tune in early testing stages
- Controlled enemy proximity checks used to validate defensive response behavior during prototype iteration

## Current Status

This is a prototype-focused pass intended to validate the mod’s identity, structure logic, sentinel behavior, and resource flow before deeper economy and progression systems are added.

The present direction stays intentionally simple:

- the nexus is the player’s biotech anchor
- allied sentinels are spawned on the player force in a controlled pattern
- Cyber-Slurry is treated as a barrel-handling resource instead of a standard pipe-fed fluid loop
- defensive spacing and placement rules are kept tight to support stable behavior in play sessions
- nearby hostiles remain available as a test signal for sentinel responsiveness during early iteration

## Visual Direction

The visual language centers on:

- acid-green biotech glows and industrial plating
- hard-edged war-machine forms with a bio-mechanical feel
- dystopian factory aesthetics shaped by biomass-derived materials
- a defensive, enemy-turned-asset identity that reads as engineered and purposeful rather than random corruption

## Project Structure

- info.json — mod metadata and project details
- data.lua — definitions for items, recipes, structures, and prototype data
- control.lua — runtime logic for sentinel testing, spawn behavior, and structure checks
- graphics/ — art and visual assets
- art/ — curated reference and tooling repository for design work

## Repository

Project homepage: https://github.com/infinitechris/CarapaceCorruption

## Notes

This mod remains in an early prototype phase. The goal is to build a readable, stable foundation for the nexus, sentinel defense loop, and Cyber-Slurry logistics before expanding into wider progression, economy, or combat systems.
