# Android Quick Start Guide

## 🚀 TL;DR - Quick Build

```bash
# Make script executable (first time only)
chmod +x build-android.sh

# Build and install debug APK to connected device
./build-android.sh install-debug

# View logs
./build-android.sh logs
```

## 📋 Prerequisites Checklist

- [ ] Godot 4.3+ installed
- [ ] Android Studio installed
- [ ] Android SDK installed (API 21-33)
- [ ] Android NDK installed (23.2+)
- [ ] USB debugging enabled on device
- [ ] Device connected via USB

## ⚡ Quick Commands

### Build APK
```bash
# Debug build
./build-android.sh debug

# Release build
./build-android.sh release
```

### Install to Device
```bash
# Build and install debug
./build-android.sh install-debug

# Install existing APK
adb install -r builds/android/wh40k-boltgun-debug.apk
```

### Device Commands
```bash
# List connected devices
adb devices

# View logs
adb logcat | grep godot

# Uninstall app
adb uninstall com.pimentelleo.wh40kboltgun

# Take screenshot
adb shell screencap /sdcard/screenshot.png
adb pull /sdcard/screenshot.png
```

## 🔧 First Time Setup

### 1. Install Android SDK
Download Android Studio from: https://developer.android.com/studio

In SDK Manager, install:
- Android SDK Platform 33
- Android SDK Build-Tools
- Android SDK Command-line Tools
- Android SDK Platform-Tools
- NDK (Side by side) 23.2+

### 2. Configure Godot
1. Open Godot Editor
2. Go to `Editor > Editor Settings`
3. Navigate to `Export > Android`
4. Set Android SDK Path:
   - Linux/Mac: `~/Android/Sdk`
   - Windows: `C:\Users\[Username]\AppData\Local\Android\Sdk`

### 3. Install Export Templates
1. In Godot: `Editor > Manage Export Templates`
2. Download templates for Godot 4.3
3. Or run: `godot --headless --download-templates`

### 4. Enable USB Debugging
On your Android device:
1. Go to `Settings > About Phone`
2. Tap `Build Number` 7 times
3. Go back to `Settings > Developer Options`
4. Enable `USB Debugging`

## 📱 Testing

### Test on Device (One-Click)
1. Connect device via USB
2. In Godot, click Remote Debug button (phone icon)
3. Select your device
4. Press Play (F5)

### Manual Install
```bash
# Install APK
adb install builds/android/wh40k-boltgun-debug.apk

# Launch app
adb shell am start -n com.pimentelleo.wh40kboltgun/.GodotApp

# View logs
adb logcat -c  # Clear logs first
adb logcat | grep godot
```

## 🐛 Troubleshooting

### "Godot not found"
```bash
# Add godot to PATH or use full path
export PATH=$PATH:/path/to/godot

# Or edit build-android.sh:
GODOT_EXECUTABLE="/full/path/to/godot"
```

### "No Android device found"
```bash
# Check connection
adb devices

# Restart adb if needed
adb kill-server
adb start-server

# Check USB debugging is enabled on device
```

### "Build failed"
```bash
# Check Godot can see Android SDK
godot --editor --quit  # Opens and closes editor to check config

# Verify export preset exists
cat export_presets.cfg | grep Android

# Rebuild from Godot Editor (easier to see errors)
```

### App crashes on launch
```bash
# View crash logs
adb logcat | grep -E "FATAL|AndroidRuntime|godot"

# Common issues:
# - Wrong architecture (use arm64-v8a)
# - Missing permissions
# - Incompatible Android version
```

## 🎮 Controls on Mobile

- **Left joystick**: Movement
- **Right screen drag**: Look around
- **Fire button** (bottom right): Shoot
- **Jump button** (top right): Jump
- **Reload button** (top center): Reload
- **Dash button** (top left): Dash/Sprint

## 📊 Performance Tips

### Optimize for Low-End Devices
In project.godot, you can adjust:
```ini
# Reduce rendering load
[rendering]
anti_aliasing/quality/msaa_3d=0  # Disable MSAA
textures/canvas_textures/default_texture_filter=0

# Limit frame rate
[physics]
common/fps_max=30  # Add this line
```

### Check Device Performance
```bash
# Monitor FPS
adb shell dumpsys gfxinfo com.pimentelleo.wh40kboltgun

# Monitor memory
adb shell dumpsys meminfo com.pimentelleo.wh40kboltgun

# Battery usage
adb shell dumpsys batterystats com.pimentelleo.wh40kboltgun
```

## 📦 File Sizes

Expected APK sizes:
- Debug build: ~25-35 MB
- Release build: ~15-25 MB
- Installed size: ~50-70 MB

To reduce size:
- Remove unused assets
- Use texture compression
- Only include arm64-v8a architecture

## 🌐 Distribution

### Google Play Store
Requirements:
- Target SDK 33+ (already configured)
- 64-bit support (arm64-v8a) ✓
- Release keystore (not debug)
- Privacy policy
- Screenshots
- App description

### Direct Distribution (APK)
Can share APK file directly:
- Enable "Unknown Sources" on device
- Download APK to device
- Open and install
- Or use: `adb install your-app.apk`

## 📝 Build Checklist

Before building:
- [ ] Tested on desktop
- [ ] All scripts error-free
- [ ] Assets optimized
- [ ] Version code incremented
- [ ] Proper package name set
- [ ] Icon created (if custom)

Debug build:
- [ ] Built successfully
- [ ] Installed on device
- [ ] App launches
- [ ] Controls work
- [ ] No crashes in typical gameplay

Release build:
- [ ] Signed with release keystore
- [ ] Tested on multiple devices
- [ ] Performance acceptable
- [ ] All features working
- [ ] Ready for distribution

## 🆘 Need Help?

1. Check full documentation: `docs/ANDROID_BUILD.md`
2. Mobile controls guide: `docs/MOBILE_CONTROLS.md`
3. Godot Android docs: https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html
4. Stack Overflow: Search "godot 4 android"

## 💡 Pro Tips

1. **Keep USB debugging enabled** for faster testing
2. **Use debug builds** during development (faster)
3. **Test on real device** early and often
4. **Monitor logs** while testing: `./build-android.sh logs`
5. **Use wireless debugging** for convenience (Android 11+)
6. **Create release keystore early** and keep it safe
7. **Test different screen sizes** if possible
8. **Check battery usage** - optimize if high

---

**Happy Building! 🎮📱**
