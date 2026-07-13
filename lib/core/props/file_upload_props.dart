import 'package:jaspr/jaspr.dart';
import 'package:web/web.dart' as web;

import '../shared/shared.dart';

export '../shared/shared.dart' show ComponentSize;

enum FileUploadStyle {
  dropzone,
  button,
  inline,
}

/// Uploaded file data.
class UploadedFile {
  final String name;
  final int size;
  final String type;

  const UploadedFile({
    required this.name,
    required this.size,
    required this.type,
  });

  String get formattedSize {
    if (size < 1024) return '$size B';
    if (size < 1024 * 1024) return '${(size / 1024).toStringAsFixed(1)} KB';
    return '${(size / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

/// File upload component properties.
class FileUploadProps {
  final FileUploadStyle style;
  final ComponentSize size;
  final bool isDragOver;
  final List<UploadedFile> selectedFiles;
  final bool disabled;
  final String? label;
  final String dropzoneText;
  final String browseText;
  final String? helperText;
  final String acceptString;
  final bool multiple;
  final void Function()? onClick;
  final void Function(web.Event event)? onDragOver;
  final void Function(web.Event event)? onDragLeave;
  final void Function(web.Event event)? onDrop;
  final void Function(web.Event event)? onInputChange;

  const FileUploadProps({
    required this.style,
    required this.size,
    required this.isDragOver,
    required this.selectedFiles,
    required this.disabled,
    required this.dropzoneText,
    required this.browseText,
    required this.acceptString,
    required this.multiple,
    this.label,
    this.helperText,
    this.onClick,
    this.onDragOver,
    this.onDragLeave,
    this.onDrop,
    this.onInputChange,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for file upload components.
mixin FileUploadRendererContract {
  /// Render a file upload component.
  Component fileUpload(FileUploadProps props);
}
