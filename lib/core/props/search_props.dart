import 'package:arcane_jaspr/flutter.dart';

import '../shared/shared.dart';

export '../shared/shared.dart' show ComponentSize;

/// Search result item data.
class SearchResult {
  final String title;
  final String? subtitle;
  final String? href;
  final VoidCallback? onTap;

  const SearchResult({
    required this.title,
    this.subtitle,
    this.href,
    this.onTap,
  });
}

enum SearchStyle {
  standard,
  filled,
  ghost,
}

/// Search input component properties.
class SearchProps {
  final String placeholder;
  final String? value;
  final void Function(String value)? onChanged;
  final void Function(String value)? onSubmitted;
  final bool showClear;
  final bool showIcon;
  final bool loading;
  final Widget? icon;
  final bool autofocus;
  final bool disabled;
  final ComponentSize size;
  final SearchStyle style;
  final String? id;
  final Map<String, String>? attributes;
  final List<SearchResult>? results;
  final String? resultsId;
  final bool showDropdown;
  final String? dropdownMaxHeight;
  final String? width;

  const SearchProps({
    this.placeholder = 'Search...',
    this.value,
    this.onChanged,
    this.onSubmitted,
    this.showClear = true,
    this.showIcon = true,
    this.loading = false,
    this.icon,
    this.autofocus = false,
    this.disabled = false,
    this.size = ComponentSize.md,
    this.style = SearchStyle.standard,
    this.id,
    this.attributes,
    this.results,
    this.resultsId,
    this.showDropdown = false,
    this.dropdownMaxHeight,
    this.width,
  });

  SearchProps copyWith({
    String? placeholder,
    String? value,
    void Function(String value)? onChanged,
    void Function(String value)? onSubmitted,
    bool? showClear,
    bool? showIcon,
    bool? loading,
    Widget? icon,
    bool? autofocus,
    bool? disabled,
    ComponentSize? size,
    SearchStyle? style,
    String? id,
    Map<String, String>? attributes,
    List<SearchResult>? results,
    String? resultsId,
    bool? showDropdown,
    String? dropdownMaxHeight,
    String? width,
  }) {
    return SearchProps(
      placeholder: placeholder ?? this.placeholder,
      value: value ?? this.value,
      onChanged: onChanged ?? this.onChanged,
      onSubmitted: onSubmitted ?? this.onSubmitted,
      showClear: showClear ?? this.showClear,
      showIcon: showIcon ?? this.showIcon,
      loading: loading ?? this.loading,
      icon: icon ?? this.icon,
      autofocus: autofocus ?? this.autofocus,
      disabled: disabled ?? this.disabled,
      size: size ?? this.size,
      style: style ?? this.style,
      id: id ?? this.id,
      attributes: attributes ?? this.attributes,
      results: results ?? this.results,
      resultsId: resultsId ?? this.resultsId,
      showDropdown: showDropdown ?? this.showDropdown,
      dropdownMaxHeight: dropdownMaxHeight ?? this.dropdownMaxHeight,
      width: width ?? this.width,
    );
  }
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer method for search input components.
mixin SearchRendererContract {
  /// Render a search input component.
  Widget search(SearchProps props);
}
