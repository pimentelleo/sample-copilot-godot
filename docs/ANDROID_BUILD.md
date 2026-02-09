# Android Build Instructions for Godot 4

## Prerequisites

Before you can build for Android, you need to:

### 1. Install Android Studio
Download and install Android Studio from: https://developer.android.com/studio

### 2. Install Android SDK
Open Android Studio and install:
- Android SDK Platform 33 (Android 13)
- Android SDK Build-Tools
- Android SDK Command-line Tools
- Android SDK Platform-Tools
- NDK (Side by side) version 23.2.8568313 or newer

### 3. Install Godot Android Build Template

In Godot Editor:
1. Go to **Editor > Manage Export Templates**
2. Download and install the Android export template for Godot 4.3
3. Or download manually from: https://godotengine.org/download

### 4. Configure Android Settings in Godot

1. Open **Editor > Editor Settings**
2. Navigate to **Export > Android**
3. Set the following paths:
   - **Android SDK Path**: Usually `~/Android/Sdk` on Linux/Mac or `C:\Users\[Username]\AppData\Local\Android\Sdk` on Windows
   - **Debug Keystore**: Generate or use existing debug keystore
   - **Debug Keystore User**: Usually "androiddebugkey"
   - **Debug Keystore Password**: Usually "android"

### 5. Generate Debug Keystore (if needed)

If you don't have a debug keystore, generate one:

```bash
keytool -keyalg RSA -genkeypair -alias androiddebugkey -keypass android \
  -keystore debug.keystore -storepass android -dname "CN=Android Debug,O=Android,C=US" \
  -validity 9999 -deststoretype pkcs12
```

## Building the APK

### Method 1: Using Godot Editor

1. Open the project in Godot 4
2. Go to **Project > Export**
3. Click **Add...** and select **Android**
4. Configure the export preset:
   - **Name**: Android
   - **Runnable**: ✓ (checked)
   - **Export Path**: Choose where to save the APK
   - **Min SDK**: 21 (Android 5.0)
   - **Target SDK**: 33 (Android 13)
   - **Architectures**: 
     - arm64-v8a: ✓ (64-bit ARM - recommended)
     - armeabi-v7a: ✗ (32-bit ARM - optional for older devices)
5. Click **Export Project**
6. Choose **Export PCK/ZIP** or **Export APK**

### Method 2: One-Click Deploy

1. Connect your Android device via USB
2. Enable **Developer Options** and **USB Debugging** on your device
3. In Godot, click the **Remote Debug** button (phone icon)
4. Select your device
5. Click **Play** to build and run on device

### Method 3: Command Line Export

```bash
godot --export-release "Android" ./builds/android/wh40k-boltgun.apk
```

Or for debug build:
```bash
godot --export-debug "Android" ./builds/android/wh40k-boltgun-debug.apk
```

## Testing on Device

### Enable Developer Options:
1. Go to **Settings > About Phone**
2. Tap **Build Number** 7 times
3. Go back to **Settings > Developer Options**
4. Enable **USB Debugging**

### Install APK:
```bash
adb install path/to/wh40k-boltgun.apk
```

Or drag and drop the APK file to your device and install manually.

## Troubleshooting

### "No Android SDK found"
- Make sure Android SDK is installed
- Check that the path is correct in Godot settings
- Restart Godot after setting the path

### "Build failed: NDK not found"
- Install NDK in Android Studio (SDK Manager > SDK Tools > NDK)
- Version 23.2.8568313 or newer is required

### "Keystore not found or invalid"
- Generate a new debug keystore using the keytool command above
- Make sure the keystore path is correct in export settings

### App crashes on startup
- Check that you're building for the correct architecture (arm64-v8a)
- Make sure you have the correct Android export template
- Check device logs: `adb logcat | grep godot`

### Touch controls not working
- Make sure mobile_controls scene is in the level
- Check that the scene is in the "mobile_controls" group
- Verify that touch input emulation is enabled in project settings

## Performance Optimization

For better performance on mobile:

1. **Graphics Settings** (already configured in project.godot):
   - Using mobile rendering method
   - GL Compatibility mode enabled
   - MSAA 3D set to 2x

2. **Resolution Scaling**:
   - Consider using 3D scale: 0.75 for lower-end devices
   - Can be set in project settings or runtime

3. **Reduce Draw Calls**:
   - Use instanced rendering for repeated objects
   - Combine meshes where possible
   - Use texture atlases

4. **Lighting**:
   - Limit number of dynamic lights
   - Use baked lighting where possible
   - Consider disabling shadows on lower-end devices

## Distribution

### For Google Play Store:

You'll need a **release keystore** (not debug):

```bash
keytool -keyalg RSA -genkeypair -alias release-key -keypass YOUR_PASSWORD \
  -keystore release.keystore -storepass YOUR_PASSWORD \
  -dname "CN=Your Name,O=Your Company,C=US" -validity 10000 -deststoretype pkcs12
```

Then in export settings:
- Set **Keystore**: path to release.keystore
- Set **Keystore User**: release-key
- Set **Keystore Password**: YOUR_PASSWORD
- Enable **Use Custom Build** if using plugins

### Requirements for Play Store:
- Target API level 33 (Android 13) or higher
- 64-bit support (arm64-v8a) required
- Privacy policy if collecting user data
- Content rating
- App icon (512x512 PNG)
- Screenshots
- Description

## File Size Optimization

To reduce APK size:
1. Only include necessary architectures (arm64-v8a usually enough)
2. Use texture compression (ETC2)
3. Remove unused assets
4. Use PCK export for smaller incremental updates

## Current Configuration

This project is configured with:
- **Min SDK**: 21 (Android 5.0 Lollipop)
- **Target SDK**: 33 (Android 13)
- **Architecture**: arm64-v8a (64-bit)
- **Rendering**: Mobile/GL Compatibility
- **Orientation**: Landscape
- **Full-screen**: Immersive mode enabled

## Additional Resources

- [Godot Android Export Documentation](https://docs.godotengine.org/en/stable/tutorials/export/exporting_for_android.html)
- [Android Developer Guide](https://developer.android.com/guide)
- [Godot Mobile Optimization](https://docs.godotengine.org/en/stable/tutorials/performance/index.html)
