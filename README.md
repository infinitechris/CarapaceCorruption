# Carapace Corruption

Carapace Corruption is a Factorio 2.0 mod prototype focused on a cyberpunk biotech defense fantasy. Rather than simply creating a hostile creature variant, the mod imagines a player-aligned bio-mechanical system: a player-owned nexus harvests biter biomass, distills it into Cyber-Slurry, and uses that biofluid as the raw material for a new generation of armored guardian units built for pest-eradication duty.

The visual identity is built around neon bio-industrial aesthetics: acid-green glow, industrial plating, and the suggestion that the player's war machine was engineered from the biology of the battlefield itself.

## Lore Direction

The player is not a victim of a spreading fungal plague. They are a biotech harvester and enforcer, drawing out Cyber-Slurry from the biomass of the biter swarm and refining it into a potent biofluid that powers their own engineered organisms for pest-eradication duty.

The nexus is a player-owned biotech engine, not a corrupted wilderness infection. It gathers, processes, and shapes living material into a disciplined swarm of defensive constructs. The player commands their own bio-fabricated brood: their war machine is made through blood, sweat, and harvested biological fluids, not through petting, taming, or direct control of wild enemies.

## Core Features

- A player-placed nexus structure at the center of the biotech conversion loop
- Cyber-Slurry as a barrel-only resource intentionally kept outside standard pipe logistics, forcing the player to manage storage, staging, and placement strategy
- A biter-biomass conversion concept in which warped enemy life becomes the raw substrate for the nexus system
- Allied sentinel units styled as cybernetic guardians, using base biter silhouette logic with a custom cyberpunk treatment
- A prototype-only defensive test loop that checks nearby hostile presence and keeps allied spawn behavior stable and observable
- Internal barrel handling and controlled slurry release as part of the nexus, creating a deliberate logistics challenge rather than a simple fluid-feed loop
- A design direction that prioritizes unit usability through layout discipline, not free-form pipe automation

## Project Structure

- `info.json` — mod metadata and dependency declarations
- `data.lua` — prototypes for fluids, items, recipes, structures, and sentinel units
- `control.lua` — prototype testing logic, allied spawn behavior, and periodic checks

## Current Status

This is a prototype-focused pass intended to validate the mod's identity, base structure behavior, and allied-unit testing flow before deeper economy or progression systems are added.

Performance remains a design priority, and the prototype will be reviewed with an eye toward long-running base behavior, stability, and any simulation costs that could affect UPS over time.

The current build is intentionally centered on:

- the `carapace-nexus` as a player-aligned biotech anchor
- allied `carapace-sentinel` units appearing on the player force
- Cyber-Slurry as a barrel-only resource that is never intended to flow through pipes, encouraging practical storage and layout planning
- safe placement and spawn spacing for a large defensive footprint
- enemy-proximity feedback as a test loop for sentinel behavior and structure response

The player does not directly command captured enemies. The prototype is built around player-owned defensive constructs emerging from the nexus rather than control over enemy units themselves.

## Testing Phase

The active test loop is intentionally narrow and clean:

- the player places the nexus as a fixed structure anchor
- allied sentinels are spawned in a controlled pattern on the player force
- Cyber-Slurry is handled as a barrel-only resource with no pipe-based flow, forcing the player to plan transport and staging around the structure
- the prototype keeps a safe inner exclusion zone around the structure to avoid overlap
- allied units are pushed outward so multiple sentinels can appear without stacking at the origin
- nearby hostile units are monitored to validate response behavior in a controlled and repeatable way

This is a prototype scenario, not a full gameplay economy. The goal is to prove the structure, sentinel behavior, and biotech identity before expanding into the broader capture-and-convert progression, while keeping an eye on any performance bottlenecks that might emerge in larger play sessions.

## Development Notes

The visual and design direction emphasizes:

- cyberpunk color palettes with acid-green biotech accents
- bio-mechanical industrial forms and engineered plating
- dystopian factory aesthetics shaped by industrial biomatter and high-tech fabrication
- a brutalist, high-tech defense identity that feels alien but still grounded in Factorio's base unit logic

## Future Direction

The next broad phase is the capture-and-convert pipeline:

- warped biter biomass is gathered and processed by the nexus
- Cyber-Slurry remains a barrel-only intermediary material that rewards deliberate storage, staging, and deployment planning
- that slurry becomes the substrate for player-made cyborg guardians and larger biotech structures
- the mod expands from a prototype defense concept into a more deliberate progression system without abandoning the current cyberpunk identity
- design refinements will continue to account for long-term stability and UPS concerns as the system grows

The intended rule remains simple: if the player wants their units to be usable, they must build around the logistics and spatial constraints of the nexus rather than treating the system like a standard pipe-fed factory loop.

## Publishing

```bash
git add .
git commit -m "Align README with biotech defense lore"
git branch -M main
git remote add origin https://github.com/infinitechris/CarapaceCorruption.git
git push -u origin main
```
