---
title: ArcaneToggleSwitch
description: Toggle switch for on/off states
layout: docs
component: toggle-switch
---

# ArcaneToggleSwitch

A styled toggle switch component for binary on/off states. More visually prominent than a checkbox for settings.

## Basic Usage

```dart
ArcaneToggleSwitch(
  value: isEnabled,
  onChanged: (value) {
    setState(() => isEnabled = value);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `value` | `bool` | `false` | Current toggle state |
| `onChanged` | `ValueChanged<bool>?` | `null` | State change handler |
| `label` | `String?` | `null` | Label text |
| `labelPosition` | `LabelPosition` | `right` | Label placement |
| `isDisabled` | `bool` | `false` | Disable interaction |
| `size` | `SwitchSize` | `medium` | Switch size |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## With Label

```dart
ArcaneToggleSwitch(
  label: 'Dark Mode',
  value: isDarkMode,
  onChanged: (value) => setState(() => isDarkMode = value),
)
```

## Label Position

```dart
// Label on right (default)
ArcaneToggleSwitch(
  label: 'Enable notifications',
  labelPosition: LabelPosition.right,
  value: notifications,
  onChanged: (v) => setState(() => notifications = v),
)

// Label on left
ArcaneToggleSwitch(
  label: 'Enable notifications',
  labelPosition: LabelPosition.left,
  value: notifications,
  onChanged: (v) => setState(() => notifications = v),
)
```

## Sizes

```dart
// Small
ArcaneToggleSwitch(
  size: SwitchSize.small,
  value: isOn,
  onChanged: (v) => setState(() => isOn = v),
)

// Medium (default)
ArcaneToggleSwitch(
  size: SwitchSize.medium,
  value: isOn,
  onChanged: (v) => setState(() => isOn = v),
)

// Large
ArcaneToggleSwitch(
  size: SwitchSize.large,
  value: isOn,
  onChanged: (v) => setState(() => isOn = v),
)
```

## Disabled State

```dart
ArcaneToggleSwitch(
  label: 'Premium Feature',
  value: false,
  isDisabled: true,
)
```

## Examples

### Settings List

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.lg,
  ),
  children: [
    _buildSettingRow(
      'Push Notifications',
      'Receive alerts on your device',
      pushNotifications,
      (v) => setState(() => pushNotifications = v),
    ),
    _buildSettingRow(
      'Email Notifications',
      'Get updates via email',
      emailNotifications,
      (v) => setState(() => emailNotifications = v),
    ),
    _buildSettingRow(
      'Auto-Save',
      'Automatically save changes',
      autoSave,
      (v) => setState(() => autoSave = v),
    ),
  ],
)

Widget _buildSettingRow(
  String title,
  String subtitle,
  bool value,
  ValueChanged<bool> onChanged,
) {
  return ArcaneDiv(
    styles: const ArcaneStyleData(
      display: Display.flex,
      justifyContent: JustifyContent.spaceBetween,
      alignItems: AlignItems.center,
      padding: PaddingPreset.md,
      background: Background.surface,
      borderRadius: Radius.lg,
    ),
    children: [
      ArcaneDiv(
        children: [
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontWeight: FontWeight.w500,
            ),
            children: [ArcaneText(title)],
          ),
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontSize: FontSize.sm,
              textColor: TextColor.muted,
            ),
            children: [ArcaneText(subtitle)],
          ),
        ],
      ),
      ArcaneToggleSwitch(
        value: value,
        onChanged: onChanged,
      ),
    ],
  );
}
```

### Feature Flags

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.md,
  ),
  children: [
    for (final feature in features)
      ArcaneDiv(
        styles: const ArcaneStyleData(
          display: Display.flex,
          justifyContent: JustifyContent.spaceBetween,
          alignItems: AlignItems.center,
          padding: PaddingPreset.sm,
          borderBottom: BorderPreset.subtle,
        ),
        children: [
          ArcaneText(feature.name),
          ArcaneToggleSwitch(
            value: feature.isEnabled,
            onChanged: (v) => toggleFeature(feature.id, v),
          ),
        ],
      ),
  ],
)
```

### Quick Actions

```dart
ArcaneDiv(
  styles: const ArcaneStyleData(
    display: Display.flex,
    gap: Gap.xl,
    padding: PaddingPreset.lg,
    background: Background.card,
    borderRadius: Radius.lg,
  ),
  children: [
    ArcaneToggleSwitch(
      label: 'WiFi',
      value: wifiEnabled,
      onChanged: (v) => setState(() => wifiEnabled = v),
    ),
    ArcaneToggleSwitch(
      label: 'Bluetooth',
      value: bluetoothEnabled,
      onChanged: (v) => setState(() => bluetoothEnabled = v),
    ),
    ArcaneToggleSwitch(
      label: 'Airplane',
      value: airplaneMode,
      onChanged: (v) => setState(() => airplaneMode = v),
    ),
  ],
)
```

## Related Components

- [ArcaneCheckbox](/arcane_jaspr/docs/inputs/arcane-checkbox) - Checkbox for boolean states
- [ArcaneThemeToggle](/arcane_jaspr/docs/inputs/arcane-theme-toggle) - Theme mode toggle
- [ArcaneToggleButton](/arcane_jaspr/docs/inputs/arcane-toggle-button) - Toggle button
