---
title: ArcaneThemeToggle
description: Toggle button for switching between light and dark themes
layout: docs
component: theme-toggle
---

# ArcaneThemeToggle

A specialized toggle component for switching between light and dark theme modes.

## Basic Usage

```dart
ArcaneThemeToggle(
  isDark: isDarkMode,
  onToggle: (isDark) {
    setState(() => isDarkMode = isDark);
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `isDark` | `bool` | `false` | Current theme mode |
| `onToggle` | `ValueChanged<bool>?` | `null` | Mode change handler |
| `size` | `ThemeToggleSize` | `medium` | Toggle size |
| `showLabel` | `bool` | `false` | Show text label |
| `styles` | `ArcaneStyleData?` | `null` | Custom styling |

## Simple Version

For a simpler toggle that syncs with system theme:

```dart
ArcaneThemeToggleSimple()
```

## Sizes

```dart
// Small
ArcaneThemeToggle(
  isDark: isDark,
  size: ThemeToggleSize.small,
  onToggle: (v) => setState(() => isDark = v),
)

// Medium (default)
ArcaneThemeToggle(
  isDark: isDark,
  size: ThemeToggleSize.medium,
  onToggle: (v) => setState(() => isDark = v),
)

// Large
ArcaneThemeToggle(
  isDark: isDark,
  size: ThemeToggleSize.large,
  onToggle: (v) => setState(() => isDark = v),
)
```

## With Label

```dart
ArcaneThemeToggle(
  isDark: isDarkMode,
  showLabel: true,
  onToggle: (v) => setState(() => isDarkMode = v),
)
```

## Examples

### Header with Theme Toggle

```dart
ArcaneBar(
  leading: [
    ArcaneText('Logo'),
  ],
  trailing: [
    ArcaneButton.ghost(label: 'Docs', onPressed: () {}),
    ArcaneButton.ghost(label: 'Pricing', onPressed: () {}),
    ArcaneThemeToggle(
      isDark: isDarkMode,
      onToggle: (isDark) {
        setState(() => isDarkMode = isDark);
        updateTheme(isDark);
      },
    ),
  ],
)
```

### Settings Page

```dart
ArcaneDiv(
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
        ArcaneText('Theme'),
        ArcaneDiv(
          styles: const ArcaneStyleData(
            fontSize: FontSize.sm,
            textColor: TextColor.muted,
          ),
          children: [ArcaneText('Switch between light and dark mode')],
        ),
      ],
    ),
    ArcaneThemeToggle(
      isDark: isDarkMode,
      onToggle: (isDark) {
        setState(() => isDarkMode = isDark);
        savePreference('theme', isDark ? 'dark' : 'light');
      },
    ),
  ],
)
```

### Dropdown Menu with Theme

```dart
ArcaneDropdownMenu(
  children: [
    ArcaneDropdownItem(
      label: 'Profile',
      onPressed: () => goToProfile(),
    ),
    ArcaneDropdownItem(
      label: 'Settings',
      onPressed: () => goToSettings(),
    ),
    ArcaneDivider(),
    ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.flex,
        justifyContent: JustifyContent.spaceBetween,
        alignItems: AlignItems.center,
        padding: PaddingPreset.smMd,
      ),
      children: [
        ArcaneText('Dark mode'),
        ArcaneThemeToggle(
          isDark: isDarkMode,
          size: ThemeToggleSize.small,
          onToggle: (v) => toggleTheme(v),
        ),
      ],
    ),
    ArcaneDivider(),
    ArcaneDropdownItem(
      label: 'Sign out',
      onPressed: () => signOut(),
    ),
  ],
)
```

### Footer Theme Toggle

```dart
ArcaneFooter(
  children: [
    ArcaneDiv(
      styles: const ArcaneStyleData(
        display: Display.flex,
        justifyContent: JustifyContent.spaceBetween,
        alignItems: AlignItems.center,
      ),
      children: [
        ArcaneText('© 2024 Company'),
        ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.flex,
            alignItems: AlignItems.center,
            gap: Gap.sm,
          ),
          children: [
            ArcaneText('Theme:'),
            ArcaneThemeToggle(
              isDark: isDarkMode,
              size: ThemeToggleSize.small,
              onToggle: toggleTheme,
            ),
          ],
        ),
      ],
    ),
  ],
)
```

### Persisting Theme Preference

```dart
class ThemeProvider extends StatefulComponent {
  bool _isDark = false;

  @override
  void initState() {
    super.initState();
    _loadTheme();
  }

  void _loadTheme() async {
    final saved = await storage.get('theme');
    setState(() => _isDark = saved == 'dark');
  }

  void _toggleTheme(bool isDark) async {
    setState(() => _isDark = isDark);
    await storage.set('theme', isDark ? 'dark' : 'light');
  }

  @override
  Iterable<Component> build(BuildContext context) sync* {
    yield ArcaneApp(
      theme: ArcaneTheme.supabase(
        themeMode: _isDark ? ThemeMode.dark : ThemeMode.light,
      ),
      child: YourApp(
        themeToggle: ArcaneThemeToggle(
          isDark: _isDark,
          onToggle: _toggleTheme,
        ),
      ),
    );
  }
}
```

## Related Components

- [ArcaneToggleSwitch](/arcane_jaspr/docs/inputs/arcane-toggle-switch) - Generic toggle switch
- [ArcaneCycleButton](/arcane_jaspr/docs/inputs/arcane-cycle-button) - Cycle through options
