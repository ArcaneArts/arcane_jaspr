import 'package:arcane_jaspr/flutter.dart';

enum TagInputStyleVariant {
  outline,
  filled,
  ghost,
}

/// Tag input component properties.
class TagInputProps {
  final List<String> tags;
  final void Function(List<String>)? onTagsChanged;
  final String placeholder;
  final TagInputStyleVariant style;
  final int? maxTags;
  final bool allowDuplicates;
  final bool disabled;
  final String? label;
  final String? helperText;
  final String? errorText;
  final String inputValue;
  final bool isFocused;
  final void Function(String)? onInputChange;
  final void Function(String)? onKeyDown;
  final void Function(int)? onRemoveTag;
  final void Function(bool)? onFocusChange;
  final Widget Function(String tag, VoidCallback onRemove)? tagBuilder;

  const TagInputProps({
    required this.tags,
    this.onTagsChanged,
    this.placeholder = 'Add tag...',
    this.style = TagInputStyleVariant.outline,
    this.maxTags,
    this.allowDuplicates = false,
    this.disabled = false,
    this.label,
    this.helperText,
    this.errorText,
    this.inputValue = '',
    this.isFocused = false,
    this.onInputChange,
    this.onKeyDown,
    this.onRemoveTag,
    this.onFocusChange,
    this.tagBuilder,
  });

  TagInputProps copyWith({
    List<String>? tags,
    void Function(List<String>)? onTagsChanged,
    String? placeholder,
    TagInputStyleVariant? style,
    int? maxTags,
    bool? allowDuplicates,
    bool? disabled,
    String? label,
    String? helperText,
    String? errorText,
    String? inputValue,
    bool? isFocused,
    void Function(String)? onInputChange,
    void Function(String)? onKeyDown,
    void Function(int)? onRemoveTag,
    void Function(bool)? onFocusChange,
    Widget Function(String tag, VoidCallback onRemove)? tagBuilder,
  }) {
    return TagInputProps(
      tags: tags ?? this.tags,
      onTagsChanged: onTagsChanged ?? this.onTagsChanged,
      placeholder: placeholder ?? this.placeholder,
      style: style ?? this.style,
      maxTags: maxTags ?? this.maxTags,
      allowDuplicates: allowDuplicates ?? this.allowDuplicates,
      disabled: disabled ?? this.disabled,
      label: label ?? this.label,
      helperText: helperText ?? this.helperText,
      errorText: errorText ?? this.errorText,
      inputValue: inputValue ?? this.inputValue,
      isFocused: isFocused ?? this.isFocused,
      onInputChange: onInputChange ?? this.onInputChange,
      onKeyDown: onKeyDown ?? this.onKeyDown,
      onRemoveTag: onRemoveTag ?? this.onRemoveTag,
      onFocusChange: onFocusChange ?? this.onFocusChange,
      tagBuilder: tagBuilder ?? this.tagBuilder,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for tag input components.
mixin TagInputRendererContract {
  /// Render a tag input component.
  Widget tagInput(TagInputProps props);
}
