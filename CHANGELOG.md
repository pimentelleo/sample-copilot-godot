# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

### Added
- Full mobile device support with touch controls
- Virtual joystick for movement on mobile
- Touch buttons for all game actions (Fire, Jump, Reload, Dash)
- Touch and drag camera control for mobile
- Automatic platform detection (desktop vs mobile)
- Mobile-optimized UI scaling
- Android export configuration and preset
- Complete Android build documentation
- Mobile controls user guide
- GL Compatibility rendering for better device support
- Touch input emulation for desktop testing
- Landscape orientation support for mobile
- Immersive fullscreen mode on Android

### Changed
- Player controller now supports both keyboard/mouse and touch input
- HUD dynamically adjusts text size for mobile devices
- Display settings optimized for mobile aspect ratios
- Input system refactored to work across platforms
- Test level now includes mobile controls

### Documentation
- Added ANDROID_BUILD.md with complete build instructions
- Added MOBILE_CONTROLS.md with control documentation
- Added MOBILE_UPDATE_SUMMARY.md with technical details
- Updated README.md with mobile information and controls
- Added .gitattributes for better Git file handling

## [0.1.0] - 2026-02-09

### Added - Initial Release
- First-person shooter player controller with movement, jumping, and dashing
- Mouse look camera system
- Health and armor system for player
- Weapon system with base Weapon class
- Boltgun weapon implementation
- Ammunition and reload system
- Enemy AI with state machine (Idle, Patrol, Chase, Attack)
- Enemy navigation using NavigationAgent3D
- Enemy damage and death system
- HUD showing health, armor, weapon, and ammo
- Crosshair for aiming
- Main menu with Start, Options, and Quit
- Pickup system for health, armor, and ammo
- Projectile system for weapons
- Game manager for score and progression tracking
- Test level with player, enemies, and basic environment
- Complete project structure and organization
- Comprehensive README with features and instructions
- CONTRIBUTING.md with development guidelines
- MIT License with Warhammer 40K disclaimer

### Technical
- Godot 4.3 project configuration
- Input action mapping for keyboard/mouse/controller
- Physics layers configuration
- Custom gravity settings
- MSAA antialiasing
- ProceduralSky environment
- Basic mesh-based geometry
- Git configuration with .gitignore

### Assets
- Godot default icon
- Basic geometric shapes for prototyping
- Placeholder meshes for player, enemies, weapons

---

## Version History

### Version Naming Scheme
- **Major.Minor.Patch** (Semantic Versioning)
- Major: Breaking changes or major new features
- Minor: New features, backward compatible
- Patch: Bug fixes and small improvements

### Future Versions (Planned)
- **0.2.0**: Sound and music system
- **0.3.0**: Additional weapons and enemies
- **0.4.0**: Visual effects and polish
- **0.5.0**: Campaign/level system
- **1.0.0**: First stable release

---

## Notes

### Mobile Support
The mobile update (current unreleased version) adds comprehensive touch control support and Android build capability. The game now works seamlessly on both desktop and mobile platforms with appropriate controls for each.

### Compatibility
- Desktop: Windows, Linux, macOS
- Mobile: Android 5.0+ (API 21+)
- Rendering: OpenGL 3.3 (Desktop), OpenGL ES 3.0 (Mobile)

### Known Issues
- iOS export not tested (requires Mac)
- Web export not tested
- Some multi-touch edge cases on certain Android devices
- No haptic feedback yet
- Gyroscope not implemented

### Roadmap
See README.md for complete TODO list and planned features.
