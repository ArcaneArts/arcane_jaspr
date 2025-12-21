import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight,
        FontStyle,
        StyleRule,
        Display,
        Position,
        Overflow,
        Cursor,
        Visibility,
        TextDecoration,
        TextTransform,
        FontFamily,
        WhiteSpace,
        Radius,
        Transition,
        PointerEvents,
        ZIndex,
        events;

import '../../util/arcane.dart';
import '../../util/style_types/index.dart';
import '../view/icon.dart';
import '../html/div.dart';
import '../html/arcane_link.dart';
import '../typography/text.dart';

/// A search result item for [ArcaneSearchBar]
class ArcaneSearchResult {
  /// Display title
  final String title;

  /// Optional subtitle/category
  final String? subtitle;

  /// URL to navigate to when clicked
  final String? href;

  /// Callback when clicked (alternative to href)
  final VoidCallback? onTap;

  const ArcaneSearchResult({
    required this.title,
    this.subtitle,
    this.href,
    this.onTap,
  });
}

/// A complete search bar component with icon, input, and dropdown results.
///
/// Uses CSS variables for theming (--arcane-surface, --arcane-outline, etc).
///
/// For static sites, use [id] to allow JavaScript to hook into the search.
/// For dynamic sites, use [results] to provide search results programmatically.
///
/// Example (static site with JS):
/// ```dart
/// ArcaneSearchBar(
///   id: 'docs-search',
///   placeholder: 'Search docs...',
///   resultsId: 'search-results',
/// )
/// ```
///
/// Example (dynamic):
/// ```dart
/// ArcaneSearchBar(
///   placeholder: 'Search...',
///   onSearch: (query) => performSearch(query),
///   results: searchResults,
/// )
/// ```
class ArcaneSearchBar extends StatefulComponent {
  /// Optional ID for the search input (for JS hooks)
  final String? id;

  /// Optional ID for the results container (for JS hooks)
  final String? resultsId;

  /// Placeholder text
  final String placeholder;

  /// Custom width
  final String width;

  /// Icon size
  final IconSize iconSize;

  /// Whether to show the dropdown results container
  final bool showDropdown;

  /// Maximum height of dropdown
  final String dropdownMaxHeight;

  /// Search results to display
  final List<ArcaneSearchResult>? results;

  /// Callback when search value changes
  final void Function(String value)? onSearch;

  /// Callback when search is submitted
  final void Function(String value)? onSubmitted;

  /// Additional styling
  final ArcaneStyleData? styles;

  const ArcaneSearchBar({
    this.id,
    this.resultsId,
    this.placeholder = 'Search...',
    this.width = '240px',
    this.iconSize = IconSize.md,
    this.showDropdown = true,
    this.dropdownMaxHeight = '300px',
    this.results,
    this.onSearch,
    this.onSubmitted,
    this.styles,
    super.key,
  });

  @override
  State<ArcaneSearchBar> createState() => _ArcaneSearchBarState();
}

class _ArcaneSearchBarState extends State<ArcaneSearchBar> {
  String _value = '';

  void _handleInput(String value) {
    setState(() {
      _value = value;
    });
    component.onSearch?.call(value);
  }

  @override
  Component build(BuildContext context) {
    final baseStyles = const ArcaneStyleData(
      position: Position.relative,
    ).merge(component.styles);

    return ArcaneDiv(
      styles: baseStyles.copyWith(widthCustom: component.width),
      children: [
        // Search input wrapper
        ArcaneDiv(
          styles: const ArcaneStyleData(
            position: Position.relative,
            width: Size.full,
          ),
          children: [
            // The actual input - uses CSS variables for theming
            input(
              id: component.id,
              type: InputType.text,
              attributes: {
                'placeholder': component.placeholder,
                'value': _value,
                'autocomplete': 'off',
              },
              styles: const Styles(raw: {
                'width': '100%',
                'padding': '8px 12px 8px 36px',
                'font-size': '14px',
                'border-radius': '8px',
                'border': '1px solid var(--arcane-outline)',
                'background': 'var(--arcane-surface)',
                'color': 'var(--arcane-on-surface)',
                'outline': 'none',
                'transition': 'border-color 0.2s, box-shadow 0.2s',
              }),
              events: {
                'input': (event) {
                  final target = event.target;
                  if (target != null) {
                    _handleInput((target as dynamic).value ?? '');
                  }
                },
                if (component.onSubmitted != null)
                  'keydown': (event) {
                    if ((event as dynamic).key == 'Enter') {
                      final target = event.target;
                      if (target != null) {
                        component.onSubmitted!((target as dynamic).value ?? '');
                      }
                    }
                  },
              },
            ),

            // Search icon - positioned absolutely
            ArcaneDiv(
              styles: const ArcaneStyleData(
                position: Position.absolute,
                left: '12px',
                top: '50%',
                transformCustom: 'translateY(-50%)',
                pointerEvents: PointerEvents.none,
                raw: {
                  'color': 'var(--arcane-on-surface-variant)',
                },
              ),
              children: [
                ArcaneIcon.search(size: component.iconSize),
              ],
            ),
          ],
        ),

        // Results dropdown - uses CSS variables for theming
        if (component.showDropdown)
          div(
            id: component.resultsId,
            styles: Styles(raw: {
              'position': 'absolute',
              'top': '100%',
              'left': '0',
              'right': '0',
              'z-index': '1000',
              'margin-top': '4px',
              'background': 'var(--arcane-surface)',
              'border': '1px solid var(--arcane-outline)',
              'border-radius': '8px',
              'box-shadow': '0 4px 12px rgba(0,0,0,0.15)',
              'overflow-y': 'auto',
              'max-height': component.dropdownMaxHeight,
              // Hidden by default - shown via JS or state
              'display': component.results != null && component.results!.isNotEmpty
                  ? 'block'
                  : 'none',
            }),
            component.results != null
                ? component.results!.map(_buildResultItem).toList()
                : [],
          ),
      ],
    );
  }

  Component _buildResultItem(ArcaneSearchResult result) {
    final content = ArcaneDiv(
      styles: const ArcaneStyleData(
        padding: PaddingPreset.sm,
        cursor: Cursor.pointer,
        transition: Transition.allFast,
        raw: {
          'border-bottom': '1px solid var(--arcane-outline-variant)',
        },
      ),
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(
            fontWeight: FontWeight.w500,
            raw: {
              'color': 'var(--arcane-on-surface)',
            },
          ),
          children: [ArcaneText(result.title)],
        ),
        if (result.subtitle != null)
          ArcaneDiv(
            styles: const ArcaneStyleData(
              fontSize: FontSize.xs,
              raw: {
                'color': 'var(--arcane-on-surface-variant)',
              },
            ),
            children: [ArcaneText(result.subtitle!)],
          ),
      ],
    );

    if (result.href != null) {
      return ArcaneLink(
        href: result.href!,
        styles: const ArcaneStyleData(
          textDecoration: TextDecoration.none,
        ),
        child: content,
      );
    }

    return content;
  }
}
