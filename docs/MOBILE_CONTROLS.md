# Mobile Controls Guide

## Overview

This game includes full touch controls for mobile devices. The controls automatically appear on mobile platforms and are hidden on desktop.

## Control Layout

### Left Side - Movement Joystick
- **Virtual joystick** for character movement
- Drag within the circle to move in any direction
- Returns to center when released
- Shows visual feedback with the inner circle

### Right Side - Action Buttons

#### Fire Button (Bottom Right)
- Large button for primary weapon fire
- Hold to keep firing (for automatic weapons)
- Located where your right thumb naturally rests

#### Jump Button (Top Right)
- Jump/hover action
- Single tap to jump

#### Reload Button (Top Center)
- Reload current weapon
- Shows when weapon needs reloading

#### Dash Button (Top Left)
- Quick dash/sprint action
- Use to dodge enemy attacks

### Look Controls
- **Touch and drag** on the right half of the screen (outside buttons) to look around
- Works similar to FPS mobile games
- Adjustable sensitivity

## Customization

### Adjusting Sensitivity

Edit the look sensitivity in `scripts/ui/mobile_controls.gd`:
```gdscript
var look_sensitivity: float = 0.002  # Increase for faster look, decrease for slower
```

### Adjusting Joystick

Edit joystick parameters in `scripts/ui/virtual_joystick.gd`:
```gdscript
@export var dead_zone: float = 10.0      # Minimum distance before registering input
@export var max_distance: float = 80.0   # Maximum joystick movement
```

### Button Layout

To change button positions, edit `scenes/ui/mobile_controls.tscn` in the Godot editor.

## Adding New Buttons

1. Create a new instance of `TouchButton` scene
2. Set the `action_name` to match your input action
3. Set the `button_text` to display on the button
4. Position it in the `mobile_controls.tscn` scene

Example:
```gdscript
action_name = "melee"
button_text = "MELEE"
```

## Testing on Desktop

The project includes touch emulation for testing on desktop:
- `pointing/emulate_touch_from_mouse=true` in project.godot
- Mobile controls are hidden by default on desktop
- Set `visible = true` in mobile_controls.gd to test layout

## Platform Detection

The game detects mobile platforms automatically:
```gdscript
OS.has_feature("mobile") or OS.has_feature("web")
```

This affects:
- Control scheme (keyboard/mouse vs touch)
- UI scaling
- Performance settings

## Performance Tips

For better performance on mobile:
1. Keep button count reasonable (4-6 max)
2. Use simple ColorRect instead of heavy textures for buttons
3. Minimize transparency overlays
4. Canvas layer set to high value (100) to render on top

## Compatibility

Touch controls work on:
- Android 5.0+ (API 21+)
- iOS (via Godot export)
- HTML5/Web (with touch devices)
- Any platform with touch screen support

## Known Issues

- On some devices, multi-touch might have slight delay
- Look sensitivity may need adjustment per device
- Some Android devices may need "disable battery optimization" for best performance

## Future Improvements

Potential additions:
- [ ] Customizable button layout
- [ ] Adjustable button sizes
- [ ] Different control schemes (fixed joystick, floating joystick)
- [ ] Gyroscope support for aiming
- [ ] Haptic feedback
- [ ] Save/load control preferences
