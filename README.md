# ComputerCraft Scripts

This repository is a collection of scripts designed for use in Minecraft's ComputerCraft Mod, organized into modular groups for easier syncing and management.

## Structure

- `sync.lua`: The main entry point for downloading and organizing scripts.
- `lib/`: Contains reusable, general-purpose utilities (e.g., `movementutilities`). These scripts can be loaded by other modules.
- `modules/`: Contains self-contained feature groups (e.g., `patroller`). These modules can depend on scripts in `lib/`.

## Usage

Scripts can be run directly within the ComputerCraft mod environment. To use a module, ensure all its dependencies in `lib/` are present, and then run the module's entry point (e.g., `modules/patroller/startup.lua`).

## Documentation
For concrete details and official documentation regarding ComputerCraft, please refer to the official ComputerCraft Mod documentation and community resources, specifically: https://computercraft.info/ and https://tweaked.cc

## Contents
- `sync.lua`: Script for downloading and organizing all modules and utilities.
- `lib/movementutilities/`: Core movement and fuel checking utilities.
- `modules/patroller/`: Scripts implementing the
For concrete details and official documentation regarding ComputerCraft, please refer to the official ComputerCraft Mod documentation and community resources, specifically: https://computercraft.info/ and https://tweaked.cc

## Contents
- `sync.lua`: Script for downloading and organizing all modules and utilities.
- `lib/movementutilities/`: Core movement and fuel checking utilities.
- `modules/patroller/`: Scripts implementing the patrol routine.