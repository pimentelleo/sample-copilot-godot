#!/bin/bash

# Godot Android Build Script
# This script helps build the Android APK from command line

# Configuration
PROJECT_PATH="."
GODOT_EXECUTABLE="godot"  # Change if godot is not in PATH
EXPORT_NAME="Android"
OUTPUT_DIR="./builds/android"
APP_NAME="wh40k-boltgun"

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Functions
print_info() {
    echo -e "${GREEN}[INFO]${NC} $1"
}

print_warn() {
    echo -e "${YELLOW}[WARN]${NC} $1"
}

print_error() {
    echo -e "${RED}[ERROR]${NC} $1"
}

check_godot() {
    if ! command -v $GODOT_EXECUTABLE &> /dev/null; then
        print_error "Godot executable not found in PATH"
        print_info "Please install Godot or set GODOT_EXECUTABLE variable"
        exit 1
    fi
    print_info "Found Godot: $(which $GODOT_EXECUTABLE)"
}

check_android_sdk() {
    if [ -z "$ANDROID_HOME" ] && [ -z "$ANDROID_SDK_ROOT" ]; then
        print_warn "ANDROID_HOME or ANDROID_SDK_ROOT not set"
        print_warn "Make sure Android SDK is configured in Godot Editor Settings"
    else
        print_info "Android SDK found: ${ANDROID_HOME:-$ANDROID_SDK_ROOT}"
    fi
}

create_output_dir() {
    mkdir -p "$OUTPUT_DIR"
    print_info "Output directory: $OUTPUT_DIR"
}

build_debug() {
    print_info "Building DEBUG APK..."
    create_output_dir
    $GODOT_EXECUTABLE --headless --export-debug "$EXPORT_NAME" "$OUTPUT_DIR/${APP_NAME}-debug.apk"
    
    if [ $? -eq 0 ]; then
        print_info "✓ Debug build successful!"
        print_info "APK location: $OUTPUT_DIR/${APP_NAME}-debug.apk"
    else
        print_error "✗ Debug build failed!"
        exit 1
    fi
}

build_release() {
    print_info "Building RELEASE APK..."
    create_output_dir
    $GODOT_EXECUTABLE --headless --export-release "$EXPORT_NAME" "$OUTPUT_DIR/${APP_NAME}.apk"
    
    if [ $? -eq 0 ]; then
        print_info "✓ Release build successful!"
        print_info "APK location: $OUTPUT_DIR/${APP_NAME}.apk"
    else
        print_error "✗ Release build failed!"
        exit 1
    fi
}

install_apk() {
    local apk_file="$1"
    
    if [ ! -f "$apk_file" ]; then
        print_error "APK file not found: $apk_file"
        exit 1
    fi
    
    print_info "Installing APK to device..."
    
    # Check if device is connected
    if ! adb devices | grep -q "device$"; then
        print_error "No Android device connected"
        print_info "Connect your device and enable USB debugging"
        exit 1
    fi
    
    adb install -r "$apk_file"
    
    if [ $? -eq 0 ]; then
        print_info "✓ APK installed successfully!"
    else
        print_error "✗ Installation failed!"
        exit 1
    fi
}

show_logs() {
    print_info "Showing device logs (press Ctrl+C to stop)..."
    adb logcat | grep -i "godot\|wh40k"
}

show_help() {
    echo "Usage: $0 [COMMAND]"
    echo ""
    echo "Commands:"
    echo "  debug           Build debug APK"
    echo "  release         Build release APK"
    echo "  install-debug   Build and install debug APK"
    echo "  install-release Build and install release APK"
    echo "  logs            Show device logs"
    echo "  clean           Clean build directory"
    echo "  help            Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 debug              # Build debug APK"
    echo "  $0 release            # Build release APK"
    echo "  $0 install-debug      # Build and install debug"
    echo "  $0 logs               # View device logs"
}

clean_builds() {
    print_info "Cleaning build directory..."
    rm -rf "$OUTPUT_DIR"
    print_info "✓ Build directory cleaned"
}

# Main script
print_info "Godot Android Build Script"
print_info "==========================="

check_godot
check_android_sdk

case "${1:-help}" in
    debug)
        build_debug
        ;;
    release)
        build_release
        ;;
    install-debug)
        build_debug
        install_apk "$OUTPUT_DIR/${APP_NAME}-debug.apk"
        ;;
    install-release)
        build_release
        install_apk "$OUTPUT_DIR/${APP_NAME}.apk"
        ;;
    install)
        if [ -f "$OUTPUT_DIR/${APP_NAME}-debug.apk" ]; then
            install_apk "$OUTPUT_DIR/${APP_NAME}-debug.apk"
        elif [ -f "$OUTPUT_DIR/${APP_NAME}.apk" ]; then
            install_apk "$OUTPUT_DIR/${APP_NAME}.apk"
        else
            print_error "No APK found to install. Build first!"
            exit 1
        fi
        ;;
    logs)
        show_logs
        ;;
    clean)
        clean_builds
        ;;
    help|--help|-h)
        show_help
        ;;
    *)
        print_error "Unknown command: $1"
        show_help
        exit 1
        ;;
esac
