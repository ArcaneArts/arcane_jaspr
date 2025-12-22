---
title: ArcaneFileUpload
description: File upload component with drag and drop support
layout: docs
component: file-upload
---

# ArcaneFileUpload

A file upload component with drag and drop support and visual feedback.

## Basic Usage

```dart
ArcaneFileUpload(
  onFilesSelected: (files) {
    print('Selected files: $files');
  },
)
```

## Properties

| Property | Type | Default | Description |
|----------|------|---------|-------------|
| `onFilesSelected` | `ValueChanged<List<String>>?` | `null` | File selection callback |
| `style` | `FileUploadStyle` | `dropzone` | Visual style |
| `accept` | `String?` | `null` | Accepted file types |
| `multiple` | `bool` | `false` | Allow multiple files |
| `maxSize` | `int?` | `null` | Max file size in bytes |
| `label` | `String?` | `null` | Label text |
| `hint` | `String?` | `null` | Hint text |
| `disabled` | `bool` | `false` | Disable interaction |

## Style Variants

```dart
// Dropzone (default)
ArcaneFileUpload(
  style: FileUploadStyle.dropzone,
  onFilesSelected: onFilesSelected,
)

// Button
ArcaneFileUpload(
  style: FileUploadStyle.button,
  label: 'Choose File',
  onFilesSelected: onFilesSelected,
)

// Inline
ArcaneFileUpload(
  style: FileUploadStyle.inline,
  onFilesSelected: onFilesSelected,
)
```

## Factory Constructors

```dart
// Images only
ArcaneFileUpload.images(
  onFilesSelected: onFilesSelected,
  multiple: true,
)

// Documents only
ArcaneFileUpload.documents(
  onFilesSelected: onFilesSelected,
)
```

## With File Type Restrictions

```dart
ArcaneFileUpload(
  accept: '.pdf,.doc,.docx',
  hint: 'PDF or Word documents only',
  onFilesSelected: onFilesSelected,
)
```

## Multiple Files

```dart
ArcaneFileUpload(
  multiple: true,
  hint: 'Select multiple files',
  onFilesSelected: (files) {
    print('Selected ${files.length} files');
  },
)
```

## Examples

### Profile Picture Upload

```dart
ArcaneColumn(
  gapSize: Gap.md,
  children: [
    ArcaneAvatar(initials: 'JD', size: AvatarSize.xl),
    ArcaneFileUpload.images(
      style: FileUploadStyle.button,
      label: 'Change Photo',
      onFilesSelected: (files) {
        if (files.isNotEmpty) {
          updateProfilePicture(files.first);
        }
      },
    ),
  ],
)
```

### Document Upload Form

```dart
ArcaneColumn(
  gapSize: Gap.md,
  children: [
    ArcaneText('Upload Documents', weight: FontWeight.bold),
    ArcaneFileUpload.documents(
      multiple: true,
      hint: 'Drag and drop files here or click to browse',
      onFilesSelected: onFilesSelected,
    ),
    if (selectedFiles.isNotEmpty)
      ArcaneColumn(
        gapSize: Gap.xs,
        children: [
          for (final file in selectedFiles)
            ArcaneRow(
              gapSize: Gap.sm,
              children: [
                ArcaneIcon.file(),
                ArcaneText(file),
              ],
            ),
        ],
      ),
  ],
)
```

## Related Components

- [ArcaneButton](/arcane_jaspr/docs/inputs/arcane-button) - Button component
- [ArcaneTextInput](/arcane_jaspr/docs/inputs/arcane-text-input) - Text input
