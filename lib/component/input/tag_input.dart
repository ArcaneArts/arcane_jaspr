import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/tokens/tokens.dart';

/// Tag input style variants
enum TagInputStyle {
  /// Default style with border
  outline,

  /// Filled background style
  filled,

  /// Ghost/minimal style
  ghost,
}

/// Tag/chip input component
///
/// Allows users to add and remove tags by typing.
///
/// ```dart
/// ArcaneTagInput(
///   tags: ['Flutter', 'Dart', 'Jaspr'],
///   onTagsChanged: (tags) => print(tags),
///   placeholder: 'Add a tag...',
/// )
/// ```
class ArcaneTagInput extends StatefulComponent {
  /// Current list of tags
  final List<String> tags;

  /// Callback when tags change
  final void Function(List<String>)? onTagsChanged;

  /// Placeholder text
  final String placeholder;

  /// Style variant
  final TagInputStyle style;

  /// Maximum number of tags allowed (null = unlimited)
  final int? maxTags;

  /// Whether duplicate tags are allowed
  final bool allowDuplicates;

  /// Whether the input is disabled
  final bool disabled;

  /// Label text
  final String? label;

  /// Helper text
  final String? helperText;

  /// Error message
  final String? errorText;

  /// Custom tag builder
  final Component Function(String tag, VoidCallback onRemove)? tagBuilder;

  const ArcaneTagInput({
    required this.tags,
    this.onTagsChanged,
    this.placeholder = 'Add tag...',
    this.style = TagInputStyle.outline,
    this.maxTags,
    this.allowDuplicates = false,
    this.disabled = false,
    this.label,
    this.helperText,
    this.errorText,
    this.tagBuilder,
    super.key,
  });

  @override
  State<ArcaneTagInput> createState() => _ArcaneTagInputState();
}

class _ArcaneTagInputState extends State<ArcaneTagInput> {
  String _inputValue = '';
  bool _isFocused = false;

  void _addTag(String tag) {
    final trimmed = tag.trim();
    if (trimmed.isEmpty) return;
    if (!component.allowDuplicates && component.tags.contains(trimmed)) return;
    if (component.maxTags != null && component.tags.length >= component.maxTags!) return;

    final newTags = [...component.tags, trimmed];
    component.onTagsChanged?.call(newTags);
    _inputValue = '';
  }

  void _removeTag(int index) {
    final newTags = [...component.tags]..removeAt(index);
    component.onTagsChanged?.call(newTags);
  }

  void _handleKeyDown(String key) {
    if (key == 'Enter' || key == ',') {
      _addTag(_inputValue);
    } else if (key == 'Backspace' && _inputValue.isEmpty && component.tags.isNotEmpty) {
      _removeTag(component.tags.length - 1);
    }
  }

  @override
  Component build(BuildContext context) {
    final hasError = component.errorText != null;

    final containerStyles = switch (component.style) {
      TagInputStyle.outline => {
          'background': ArcaneColors.input,
          'border': hasError
              ? '1px solid ${ArcaneColors.error}'
              : _isFocused
                  ? '1px solid ${ArcaneColors.accent}'
                  : '1px solid ${ArcaneColors.border}',
        },
      TagInputStyle.filled => {
          'background': ArcaneColors.surfaceVariant,
          'border': hasError
              ? '1px solid ${ArcaneColors.error}'
              : _isFocused
                  ? '1px solid ${ArcaneColors.accent}'
                  : '1px solid transparent',
        },
      TagInputStyle.ghost => {
          'background': 'transparent',
          'border': hasError
              ? '1px solid ${ArcaneColors.error}'
              : _isFocused
                  ? '1px solid ${ArcaneColors.accent}'
                  : '1px solid transparent',
        },
    };

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

        // Input container
        div(
          styles: Styles(raw: {
            'display': 'flex',
            'flex-wrap': 'wrap',
            'align-items': 'center',
            'gap': ArcaneSpacing.xs,
            'padding': ArcaneSpacing.sm,
            'border-radius': ArcaneRadius.md,
            'min-height': '44px',
            'transition': ArcaneEffects.transitionFast,
            'cursor': component.disabled ? 'not-allowed' : 'text',
            'opacity': component.disabled ? '0.5' : '1',
            ...containerStyles,
          }),
          [
            // Tags
            for (var i = 0; i < component.tags.length; i++)
              component.tagBuilder?.call(
                    component.tags[i],
                    () => _removeTag(i),
                  ) ??
                  _buildDefaultTag(component.tags[i], i),

            // Input field
            if (!component.disabled &&
                (component.maxTags == null ||
                    component.tags.length < component.maxTags!))
              input(
                type: InputType.text,
                attributes: {
                  'placeholder': component.tags.isEmpty ? component.placeholder : '',
                  'value': _inputValue,
                },
                styles: const Styles(raw: {
                  'flex': '1',
                  'min-width': '80px',
                  'border': 'none',
                  'background': 'transparent',
                  'outline': 'none',
                  'font-size': ArcaneTypography.fontSm,
                  'color': ArcaneColors.onSurface,
                  'padding': '4px',
                }),
                events: {
                  'focus': (_) => setState(() => _isFocused = true),
                  'blur': (_) => setState(() => _isFocused = false),
                  'input': (event) {
                    final target = event.target;
                    if (target != null) {
                      setState(() => _inputValue = (target as dynamic).value ?? '');
                    }
                  },
                  'keydown': (event) {
                    final key = (event as dynamic).key;
                    if (key == 'Enter') {
                      event.preventDefault();
                      _handleKeyDown('Enter');
                    } else if (key == 'Backspace') {
                      _handleKeyDown('Backspace');
                    } else if (key == ',') {
                      event.preventDefault();
                      _handleKeyDown(',');
                    }
                  },
                },
              ),
          ],
        ),

        // Helper/Error text
        if (component.helperText != null || hasError)
          span(
            styles: Styles(raw: {
              'font-size': ArcaneTypography.fontXs,
              'color': hasError ? ArcaneColors.error : ArcaneColors.muted,
            }),
            [text(hasError ? component.errorText! : component.helperText!)],
          ),
      ],
    );
  }

  Component _buildDefaultTag(String tag, int index) {
    return span(
      styles: const Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.xs,
        'padding': '4px 8px',
        'background': ArcaneColors.accent,
        'color': ArcaneColors.accentForeground,
        'border-radius': ArcaneRadius.full,
        'font-size': ArcaneTypography.fontXs,
        'font-weight': ArcaneTypography.weightMedium,
      }),
      [
        text(tag),
        if (!component.disabled)
          button(
            type: ButtonType.button,
            styles: const Styles(raw: {
              'display': 'inline-flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '16px',
              'height': '16px',
              'padding': '0',
              'border': 'none',
              'background': ArcaneColors.onSurfaceAlpha20,
              'border-radius': ArcaneRadius.full,
              'color': 'inherit',
              'cursor': 'pointer',
              'font-size': '12px',
              'line-height': '1',
            }),
            events: {
              'click': (_) => _removeTag(index),
            },
            [text('×')],
          ),
      ],
    );
  }
}
