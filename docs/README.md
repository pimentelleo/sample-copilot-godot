# Documentation

This directory contains all the documentation for the Warhammer 40K Boltgun Godot project.

## 📚 Available Documentation

### Android Development
- **[ANDROID_BUILD.md](ANDROID_BUILD.md)** - Complete guide for building Android APK
  - Prerequisites and setup
  - Step-by-step build instructions
  - Troubleshooting common issues
  - Performance optimization
  - Play Store distribution guide

### Mobile Controls
- **[MOBILE_CONTROLS.md](MOBILE_CONTROLS.md)** - Mobile touch controls documentation
  - Control layout and usage
  - Customization options
  - Adding new buttons
  - Testing and debugging
  - Platform detection

### Technical Documentation
- **[MOBILE_UPDATE_SUMMARY.md](MOBILE_UPDATE_SUMMARY.md)** - Technical details of mobile implementation
  - Complete list of changes
  - File structure modifications
  - Platform detection details
  - Performance considerations
  - Known limitations

## 🚀 Quick Links

### For Players
- Main README: [../README.md](../README.md)
- Quick Android Start: [../QUICKSTART_ANDROID.md](../QUICKSTART_ANDROID.md)

### For Developers
- Contributing Guide: [../CONTRIBUTING.md](../CONTRIBUTING.md)
- Changelog: [../CHANGELOG.md](../CHANGELOG.md)
- License: [../LICENSE](../LICENSE)

## 📱 Mobile Quick Reference

### Building for Android
```bash
# From project root
./build-android.sh install-debug
```

### Key Files
- `export_presets.cfg` - Export configuration
- `project.godot` - Project settings
- `scenes/ui/mobile_controls.tscn` - Touch controls UI
- `scripts/ui/mobile_controls.gd` - Touch controls logic

### Platform Detection
```gdscript
if OS.has_feature("mobile") or OS.has_feature("web"):
    # Mobile-specific code
```

## 🎯 Control Schemes

### Desktop
- WASD - Movement
- Mouse - Camera
- Space - Jump
- Shift - Sprint/Dash
- Mouse1 - Shoot
- R - Reload

### Mobile
- Virtual Joystick (left) - Movement
- Touch Drag (right half) - Camera
- Fire Button - Shoot
- Jump Button - Jump
- Reload Button - Reload
- Dash Button - Sprint/Dash

## 🔧 Configuration Files

### Project Settings (`project.godot`)
```ini
[display]
window/handheld/orientation=1  # Landscape

[rendering]
renderer/rendering_method="mobile"
renderer/rendering_method.mobile="gl_compatibility"

[input_devices]
pointing/emulate_touch_from_mouse=true
```

### Export Preset (`export_presets.cfg`)
- Platform: Android
- Min SDK: 21 (Android 5.0)
- Target SDK: 33 (Android 13)
- Architecture: arm64-v8a

## 📊 Project Statistics

### Code Files
- 13 GDScript files (.gd)
- 11 Scene files (.tscn)
- ~2500 lines of code

### Documentation
- 4 Markdown guides
- 1 Quick start guide
- 1 Contributing guide
- 1 Changelog

### Supported Platforms
- Windows ✅
- Linux ✅
- macOS ✅
- Android ✅
- iOS ⚠️ (possible but untested)
- Web ⚠️ (possible but untested)

## 🛠️ Development Tools

### Required
- Godot 4.3+
- Text editor or IDE
- Git

### For Android
- Android Studio
- Android SDK (API 21-33)
- Android NDK (23.2+)
- Java JDK 11+

### Recommended
- VS Code with GDScript extension
- Android Device for testing
- ADB tools

## 📞 Support & Resources

### Official Godot Resources
- [Godot Documentation](https://docs.godotengine.org/)
- [Godot Android Export](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html)
- [Godot Community](https://godotengine.org/community)

### Learning Resources
- [GDScript Basics](https://docs.godotengine.org/en/stable/tutorials/scripting/gdscript/gdscript_basics.html)
- [Mobile Game Development](https://docs.godotengine.org/en/stable/tutorials/platform/mobile.html)
- [3D FPS Tutorial](https://docs.godotengine.org/en/stable/tutorials/3d/index.html)

### Community
- [Godot Forums](https://forum.godotengine.org/)
- [r/godot](https://reddit.com/r/godot)
- [Godot Discord](https://discord.gg/godotengine)

## 🤝 Contributing

See [CONTRIBUTING.md](../CONTRIBUTING.md) for:
- Code style guidelines
- Development workflow
- Pull request process
- Testing requirements

## 📄 License

This project is licensed under the MIT License - see [LICENSE](../LICENSE) file.

**Note**: Warhammer 40,000 is a registered trademark of Games Workshop. This is a fan project not affiliated with Games Workshop.

---

**Last Updated**: 2026-02-09
**Version**: 0.2.0 (Mobile Update)
