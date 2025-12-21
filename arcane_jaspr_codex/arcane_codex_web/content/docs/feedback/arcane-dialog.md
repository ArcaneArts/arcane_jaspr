---
title: ArcaneDialog
description: Modal dialog for important content and actions
layout: docs
component: dialog
---

# ArcaneDialog

A modal dialog component for displaying important content, confirmations, or collecting user input.

## Basic Usage

```dart
ArcaneDialog.show(
  context,
  title: 'Dialog Title',
  content: ArcaneText('Dialog content goes here'),
  actions: [
    ArcaneButton.secondary(label: 'Cancel', onPressed: close),
    ArcaneButton.primary(label: 'Confirm', onPressed: confirm),
  ],
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `title` | `String?` | `null` | Dialog title |
| `content` | `Component` | required | Dialog content |
| `actions` | `List<Component>` | `[]` | Action buttons |
| `size` | `DialogSize` | `medium` | Dialog size |
| `dismissible` | `bool` | `true` | Click outside to close |
| `showCloseButton` | `bool` | `true` | Show close button |
| `styles` | `ArcaneStyleData?` | `null` | Additional styling |

## Sizes

```dart
// Small
ArcaneDialog.show(
  context,
  size: DialogSize.small,
  title: 'Small Dialog',
  content: Content(),
)

// Medium (default)
ArcaneDialog.show(
  context,
  size: DialogSize.medium,
  title: 'Medium Dialog',
  content: Content(),
)

// Large
ArcaneDialog.show(
  context,
  size: DialogSize.large,
  title: 'Large Dialog',
  content: Content(),
)

// Full screen
ArcaneDialog.show(
  context,
  size: DialogSize.fullScreen,
  title: 'Full Screen Dialog',
  content: Content(),
)
```

## Alert Dialog

```dart
ArcaneAlertDialog.show(
  context,
  title: 'Delete Item?',
  message: 'This action cannot be undone.',
  confirmLabel: 'Delete',
  cancelLabel: 'Cancel',
  isDestructive: true,
  onConfirm: deleteItem,
)
```

## Confirm Dialog

```dart
ArcaneConfirmDialog.show(
  context,
  title: 'Publish Post?',
  message: 'Your post will be visible to everyone.',
  confirmLabel: 'Publish',
  cancelLabel: 'Keep as Draft',
  onConfirm: publishPost,
)
```

## Text Input Dialog

```dart
ArcaneTextInputDialog.show(
  context,
  title: 'Rename File',
  label: 'File name',
  initialValue: file.name,
  confirmLabel: 'Rename',
  onConfirm: (newName) => renameFile(newName),
)
```

## Examples

### Confirmation Dialog

```dart
void showDeleteConfirmation() {
  ArcaneDialog.show(
    context,
    title: 'Delete Project?',
    content: ArcaneColumn(
      gap: Gap.md,
      children: [
        ArcaneParagraph(
          text: 'Are you sure you want to delete "${project.name}"? This will permanently remove all files and data associated with this project.',
        ),
        ArcaneAlertBanner(
          variant: AlertVariant.warning,
          message: 'This action cannot be undone.',
        ),
      ],
    ),
    actions: [
      ArcaneButton.secondary(
        label: 'Cancel',
        onPressed: () => Navigator.pop(context),
      ),
      ArcaneButton.destructive(
        label: 'Delete Project',
        onPressed: () {
          deleteProject();
          Navigator.pop(context);
        },
      ),
    ],
  );
}
```

### Form Dialog

```dart
void showEditProfileDialog() {
  ArcaneDialog.show(
    context,
    title: 'Edit Profile',
    size: DialogSize.medium,
    content: ArcaneForm(
      child: ArcaneColumn(
        gap: Gap.md,
        children: [
          ArcaneTextInput(
            label: 'Display Name',
            value: user.displayName,
          ),
          ArcaneTextArea(
            label: 'Bio',
            value: user.bio,
            maxLength: 160,
          ),
          ArcaneSelect(
            label: 'Timezone',
            options: timezones,
            value: user.timezone,
          ),
        ],
      ),
    ),
    actions: [
      ArcaneButton.secondary(
        label: 'Cancel',
        onPressed: () => Navigator.pop(context),
      ),
      ArcaneButton.primary(
        label: 'Save Changes',
        onPressed: saveProfile,
      ),
    ],
  );
}
```

### Image Preview Dialog

```dart
void showImagePreview(String imageUrl) {
  ArcaneDialog.show(
    context,
    size: DialogSize.large,
    showCloseButton: true,
    content: ArcaneColumn(
      gap: Gap.md,
      children: [
        img(
          src: imageUrl,
          styles: const ArcaneStyleData(
            maxWidth: '100%',
            borderRadius: Radius.md,
          ),
        ),
        ArcaneRow(
          mainAxisAlignment: MainAxisAlignment.center,
          gap: Gap.md,
          children: [
            ArcaneButton.secondary(
              leadingIcon: span([text('⬇️')]),
              label: 'Download',
              onPressed: () => downloadImage(imageUrl),
            ),
            ArcaneButton.secondary(
              leadingIcon: span([text('🔗')]),
              label: 'Copy Link',
              onPressed: () => copyLink(imageUrl),
            ),
          ],
        ),
      ],
    ),
  );
}
```

### Settings Dialog

```dart
void showSettingsDialog() {
  ArcaneDialog.show(
    context,
    title: 'Settings',
    size: DialogSize.medium,
    content: ArcaneColumn(
      gap: Gap.lg,
      children: [
        ArcaneDiv(
          children: [
            ArcaneHeading(text: 'Appearance', level: 3),
            ArcaneGutter(size: GutterSize.sm),
            ArcaneRow(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ArcaneText('Theme'),
                ArcaneToggleButtonGroup<String>(
                  value: theme,
                  options: [
                    ToggleOption(value: 'light', label: 'Light'),
                    ToggleOption(value: 'dark', label: 'Dark'),
                    ToggleOption(value: 'system', label: 'System'),
                  ],
                  onChanged: setTheme,
                ),
              ],
            ),
          ],
        ),
        ArcaneDivider(),
        ArcaneDiv(
          children: [
            ArcaneHeading(text: 'Notifications', level: 3),
            ArcaneGutter(size: GutterSize.sm),
            ArcaneColumn(
              gap: Gap.sm,
              children: [
                ArcaneToggleSwitch(
                  label: 'Email notifications',
                  value: emailNotifs,
                  onChanged: setEmailNotifs,
                ),
                ArcaneToggleSwitch(
                  label: 'Push notifications',
                  value: pushNotifs,
                  onChanged: setPushNotifs,
                ),
              ],
            ),
          ],
        ),
      ],
    ),
    actions: [
      ArcaneButton.primary(
        label: 'Done',
        onPressed: () => Navigator.pop(context),
      ),
    ],
  );
}
```

### Multi-Step Dialog

```dart
void showOnboardingDialog() {
  ArcaneDialog.show(
    context,
    title: 'Welcome to Arcane',
    dismissible: false,
    content: ArcaneColumn(
      gap: Gap.lg,
      children: [
        ArcaneCenter(
          child: span(
            [text('🚀')],
            styles: const ArcaneStyleData(fontSize: FontSize.xl4),
          ),
        ),
        ArcaneParagraph(
          text: steps[currentStep].description,
          styles: const ArcaneStyleData(textAlign: TextAlign.center),
        ),
        ArcaneProgressBar(
          value: (currentStep + 1) / steps.length,
        ),
      ],
    ),
    actions: [
      if (currentStep > 0)
        ArcaneButton.ghost(
          label: 'Back',
          onPressed: previousStep,
        ),
      ArcaneButton.primary(
        label: currentStep == steps.length - 1 ? 'Get Started' : 'Next',
        onPressed: currentStep == steps.length - 1 ? finish : nextStep,
      ),
    ],
  );
}
```

### Keyboard Shortcut Dialog

```dart
void showShortcutsDialog() {
  ArcaneDialog.show(
    context,
    title: 'Keyboard Shortcuts',
    size: DialogSize.medium,
    content: ArcaneColumn(
      gap: Gap.md,
      children: [
        _shortcutRow('⌘ + S', 'Save'),
        _shortcutRow('⌘ + Z', 'Undo'),
        _shortcutRow('⌘ + Shift + Z', 'Redo'),
        _shortcutRow('⌘ + K', 'Search'),
        _shortcutRow('⌘ + /', 'Toggle comment'),
        _shortcutRow('Esc', 'Close dialog'),
      ],
    ),
    actions: [
      ArcaneButton.primary(
        label: 'Got it',
        onPressed: () => Navigator.pop(context),
      ),
    ],
  );
}

Component _shortcutRow(String shortcut, String action) {
  return ArcaneRow(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      ArcaneText(action),
      ArcaneInlineCode(code: shortcut),
    ],
  );
}
```

## Related Components

- [ArcaneToast](/arcane_jaspr/docs/feedback/arcane-toast) - Temporary notifications
- [ArcaneAlertBanner](/arcane_jaspr/docs/feedback/arcane-alert-banner) - Inline alerts
- [ArcaneSheet](/arcane_jaspr/docs/feedback/arcane-sheet) - Bottom sheet
