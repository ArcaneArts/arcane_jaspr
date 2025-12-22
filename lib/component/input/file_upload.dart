import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// File upload style variants
enum FileUploadStyle {
  /// Default dropzone style
  dropzone,

  /// Compact button style
  button,

  /// Inline style
  inline,
}

/// File upload size variants
enum FileUploadSize {
  sm,
  md,
  lg,
}

/// Uploaded file info
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

/// File upload/dropzone component
///
/// Allows users to upload files via drag-and-drop or click to browse.
///
/// ```dart
/// ArcaneFileUpload(
///   accept: ['image/*', '.pdf'],
///   maxSize: 5 * 1024 * 1024, // 5MB
///   onFilesSelected: (files) => print(files),
/// )
/// ```
class ArcaneFileUpload extends StatefulComponent {
  /// Accepted file types (MIME types or extensions)
  final List<String> accept;

  /// Maximum file size in bytes
  final int? maxSize;

  /// Whether multiple files can be selected
  final bool multiple;

  /// Callback when files are selected
  final void Function(List<UploadedFile>)? onFilesSelected;

  /// Callback for file errors
  final void Function(String error)? onError;

  /// Style variant
  final FileUploadStyle style;

  /// Size variant
  final FileUploadSize size;

  /// Whether the input is disabled
  final bool disabled;

  /// Custom dropzone text
  final String? dropzoneText;

  /// Custom browse button text
  final String browseText;

  /// Helper text
  final String? helperText;

  /// Label text
  final String? label;

  const ArcaneFileUpload({
    this.accept = const [],
    this.maxSize,
    this.multiple = false,
    this.onFilesSelected,
    this.onError,
    this.style = FileUploadStyle.dropzone,
    this.size = FileUploadSize.md,
    this.disabled = false,
    this.dropzoneText,
    this.browseText = 'Browse files',
    this.helperText,
    this.label,
    super.key,
  });

  /// Image upload preset
  const ArcaneFileUpload.images({
    this.maxSize,
    this.multiple = true,
    this.onFilesSelected,
    this.onError,
    this.size = FileUploadSize.md,
    this.disabled = false,
    this.dropzoneText = 'Drag images here or click to browse',
    this.browseText = 'Select images',
    this.helperText,
    this.label,
    super.key,
  })  : accept = const ['image/*'],
        style = FileUploadStyle.dropzone;

  /// Document upload preset
  const ArcaneFileUpload.documents({
    this.maxSize,
    this.multiple = true,
    this.onFilesSelected,
    this.onError,
    this.size = FileUploadSize.md,
    this.disabled = false,
    this.dropzoneText = 'Drag documents here or click to browse',
    this.browseText = 'Select documents',
    this.helperText,
    this.label,
    super.key,
  })  : accept = const ['.pdf', '.doc', '.docx', '.txt'],
        style = FileUploadStyle.dropzone;

  @override
  State<ArcaneFileUpload> createState() => _ArcaneFileUploadState();
}

class _ArcaneFileUploadState extends State<ArcaneFileUpload> {
  bool _isDragOver = false;
  List<UploadedFile> _selectedFiles = [];

  String get _acceptString => component.accept.join(',');

  String get _dropzoneText {
    if (component.dropzoneText != null) return component.dropzoneText!;
    if (component.multiple) {
      return 'Drag files here or click to browse';
    }
    return 'Drag a file here or click to browse';
  }

  (String padding, String fontSize, String iconSize) get _sizeStyles =>
      switch (component.size) {
        FileUploadSize.sm => (ArcaneSpacing.md, ArcaneTypography.fontSm, '24px'),
        FileUploadSize.md => (ArcaneSpacing.lg, ArcaneTypography.fontMd, '32px'),
        FileUploadSize.lg => (ArcaneSpacing.xl, ArcaneTypography.fontLg, '48px'),
      };

  void _handleFiles(dynamic files) {
    final List<UploadedFile> uploadedFiles = [];

    // Handle FileList from input/drop
    for (var i = 0; i < (files.length as int); i++) {
      final file = files[i];
      final name = file.name as String;
      final size = file.size as int;
      final type = file.type as String;

      // Check size limit
      if (component.maxSize != null && size > component.maxSize!) {
        component.onError?.call('File "$name" exceeds maximum size');
        continue;
      }

      uploadedFiles.add(UploadedFile(name: name, size: size, type: type));
    }

    if (uploadedFiles.isNotEmpty) {
      setState(() => _selectedFiles = uploadedFiles);
      component.onFilesSelected?.call(uploadedFiles);
    }
  }

  @override
  Component build(BuildContext context) {
    final (padding, fontSize, iconSize) = _sizeStyles;

    return div(
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': ArcaneSpacing.sm,
      }),
      [
        // Label
        if (component.label != null)
          label(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'font-weight': ArcaneTypography.weightMedium,
              'color': ArcaneColors.onSurface,
            }),
            [text(component.label!)],
          ),

        // Dropzone or button
        if (component.style == FileUploadStyle.dropzone)
          _buildDropzone(padding, fontSize, iconSize)
        else if (component.style == FileUploadStyle.button)
          _buildButton(fontSize)
        else
          _buildInline(fontSize),

        // Selected files list
        if (_selectedFiles.isNotEmpty)
          div(
            styles: const Styles(raw: {
              'display': 'flex',
              'flex-direction': 'column',
              'gap': ArcaneSpacing.xs,
            }),
            [
              for (final file in _selectedFiles)
                div(
                  styles: const Styles(raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'space-between',
                    'padding': ArcaneSpacing.sm,
                    'background': ArcaneColors.surfaceVariant,
                    'border-radius': ArcaneRadius.sm,
                    'font-size': ArcaneTypography.fontSm,
                  }),
                  [
                    span(
                      styles: const Styles(raw: {
                        'color': ArcaneColors.onSurface,
                        'overflow': 'hidden',
                        'text-overflow': 'ellipsis',
                        'white-space': 'nowrap',
                      }),
                      [text(file.name)],
                    ),
                    span(
                      styles: const Styles(raw: {
                        'color': ArcaneColors.muted,
                        'flex-shrink': '0',
                        'margin-left': ArcaneSpacing.sm,
                      }),
                      [text(file.formattedSize)],
                    ),
                  ],
                ),
            ],
          ),

        // Helper text
        if (component.helperText != null)
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontXs,
              'color': ArcaneColors.muted,
            }),
            [text(component.helperText!)],
          ),
      ],
    );
  }

  Component _buildDropzone(String padding, String fontSize, String iconSize) {
    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        'gap': ArcaneSpacing.md,
        'padding': padding,
        'border': _isDragOver
            ? '2px dashed ${ArcaneColors.accent}'
            : '2px dashed ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.lg,
        'background': _isDragOver
            ? 'rgba(var(--arcane-accent-rgb), 0.05)'
            : 'transparent',
        'cursor': component.disabled ? 'not-allowed' : 'pointer',
        'opacity': component.disabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
        'text-align': 'center',
      }),
      events: {
        'click': (_) {
          if (!component.disabled) {
            _triggerFileInput();
          }
        },
        'dragover': (e) {
          e.preventDefault();
          if (!component.disabled) {
            setState(() => _isDragOver = true);
          }
        },
        'dragleave': (_) {
          setState(() => _isDragOver = false);
        },
        'drop': (e) {
          e.preventDefault();
          setState(() => _isDragOver = false);
          if (!component.disabled) {
            final files = (e as dynamic).dataTransfer?.files;
            if (files != null) {
              _handleFiles(files);
            }
          }
        },
      },
      [
        // Upload icon
        div(
          styles: Styles(raw: {
            'font-size': iconSize,
            'color': _isDragOver ? ArcaneColors.accent : ArcaneColors.muted,
          }),
          [text('📁')],
        ),

        // Text
        div(
          styles: Styles(raw: {
            'font-size': fontSize,
            'color': ArcaneColors.onSurface,
          }),
          [text(_dropzoneText)],
        ),

        // Browse button
        span(
          styles: const Styles(raw: {
            'color': ArcaneColors.accent,
            'font-weight': ArcaneTypography.weightMedium,
            'text-decoration': 'underline',
          }),
          [text(component.browseText)],
        ),

        // Hidden file input
        _buildHiddenInput(),
      ],
    );
  }

  Component _buildButton(String fontSize) {
    return div(
      styles: const Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.sm,
      }),
      [
        button(
          type: ButtonType.button,
          attributes: component.disabled ? {'disabled': 'true'} : null,
          styles: Styles(raw: {
            'display': 'inline-flex',
            'align-items': 'center',
            'gap': ArcaneSpacing.xs,
            'padding': '10px 20px',
            'font-size': fontSize,
            'font-weight': ArcaneTypography.weightMedium,
            'background': ArcaneColors.surfaceVariant,
            'border': '1px solid ${ArcaneColors.border}',
            'border-radius': ArcaneRadius.md,
            'color': ArcaneColors.onSurface,
            'cursor': component.disabled ? 'not-allowed' : 'pointer',
            'opacity': component.disabled ? '0.5' : '1',
            'transition': ArcaneEffects.transitionFast,
          }),
          events: {
            'click': (_) {
              if (!component.disabled) {
                _triggerFileInput();
              }
            },
          },
          [
            text('📎'),
            text(component.browseText),
          ],
        ),
        _buildHiddenInput(),
      ],
    );
  }

  Component _buildInline(String fontSize) {
    return div(
      styles: const Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.xs,
      }),
      [
        a(
          href: '#',
          styles: Styles(raw: {
            'font-size': fontSize,
            'color': ArcaneColors.accent,
            'text-decoration': 'underline',
            'cursor': component.disabled ? 'not-allowed' : 'pointer',
            'opacity': component.disabled ? '0.5' : '1',
          }),
          events: {
            'click': (e) {
              e.preventDefault();
              if (!component.disabled) {
                _triggerFileInput();
              }
            },
          },
          [text(component.browseText)],
        ),
        _buildHiddenInput(),
      ],
    );
  }

  Component _buildHiddenInput() {
    return input(
      id: 'file-input',
      type: InputType.file,
      attributes: {
        if (_acceptString.isNotEmpty) 'accept': _acceptString,
        if (component.multiple) 'multiple': 'true',
      },
      styles: const Styles(raw: {
        'position': 'absolute',
        'width': '1px',
        'height': '1px',
        'padding': '0',
        'margin': '-1px',
        'overflow': 'hidden',
        'clip': 'rect(0, 0, 0, 0)',
        'white-space': 'nowrap',
        'border': '0',
      }),
      events: {
        'change': (e) {
          final files = (e.target as dynamic)?.files;
          if (files != null) {
            _handleFiles(files);
          }
        },
      },
    );
  }

  void _triggerFileInput() {
    // Trigger click on hidden file input via JavaScript
    // This would need JS interop in practice
  }
}
