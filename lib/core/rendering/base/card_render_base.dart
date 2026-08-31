import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/style_layering.dart';
import 'package:arcane_jaspr/core/props/card_props.dart';

/// Shared structural base for themed card renderers.
///
/// Factors the identical build logic shared by every theme's card renderer
/// (content resolution, the style merge, the `data-variant` attribute, and the
/// native anchor/button/div branch with its element reset styles) into one
/// place. A concrete theme renderer only supplies the root CSS class and the
/// base/variant style maps.
///
/// This base lives in core and depends only on core props; it must never
/// depend on a theme package.
abstract class CardRenderBase extends StatelessComponent {
  const CardRenderBase(this.props, {super.key});

  final CardProps props;

  /// CSS class applied to the root element (e.g. `'arcane-card'`). Interactive
  /// cards also receive `clickable`, followed by [CardProps.classes].
  String get cssClass;

  /// Base layout styles (radius, padding, sizing). Receives [props] because
  /// several keys depend on optional fields.
  Map<String, String> baseStyles(CardProps props);

  /// Variant-specific visual styles (background, border, shadow).
  Map<String, String> variantStyles(CardProps props);

  /// Per-instance decoration overrides. Default: none. A theme overrides this
  /// to translate an [ArcaneDecoration] (elevation intent, theme-specific
  /// fields) into its own CSS. Fields a theme does not implement are ignored.
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      const <String, String>{};

  @override
  Component build(BuildContext context) {
    final List<Component> content = props.children ?? <Component>[props.child!];

    final Map<String, String> allStyles = layerStyles(
      <String, String>{...baseStyles(props), ...variantStyles(props)},
      <Map<String, String>?>[
        props.decoration?.universalStyles(),
        decorationStyles(props.decoration),
        props.styles?.toMap(),
      ],
    );

    final bool isInteractive = props.href != null || props.onTap != null;
    final String customClasses = props.classes?.trim() ?? '';
    final String rootClasses = <String>[
      cssClass,
      if (isInteractive) 'clickable',
      customClasses,
    ].where((String name) => name.isNotEmpty).join(' ');
    final Map<String, String> rootAttributes = _rootAttributes();

    // href wins deterministically in release builds if a CardProps instance
    // somehow bypasses its mutual-exclusion assertion.
    if (props.href != null) {
      final String? effectiveRel = _effectiveRel;
      return dom.a(
        classes: rootClasses,
        href: props.href!,
        attributes: <String, String>{
          ...rootAttributes,
          'target': ?props.target,
          'rel': ?effectiveRel,
        },
        styles: dom.Styles(
          raw: <String, String>{
            // Match the block-level static card and remove only anchor UA
            // chrome. Theme/decoration/literal styles remain later in the map.
            'display': 'block',
            'text-decoration': 'none',
            ...allStyles,
          },
        ),
        content,
      );
    }

    if (props.onTap != null) {
      return dom.button(
        type: dom.ButtonType.button,
        classes: rootClasses,
        attributes: rootAttributes,
        styles: dom.Styles(
          raw: <String, String>{
            // Button resets are defaults that theme/decoration/styles must be
            // able to override, so they precede allStyles (which ends with the
            // literal styles: layer). Inline resets still beat UA button styles.
            'text-align': 'inherit',
            'font': 'inherit',
            ...allStyles,
          },
        ),
        events: <String, EventCallback>{'click': (_) => props.onTap?.call()},
        content,
      );
    }

    return dom.div(
      classes: rootClasses,
      attributes: rootAttributes,
      styles: dom.Styles(raw: allStyles),
      content,
    );
  }

  Map<String, String> _rootAttributes() {
    final Map<String, String> attributes = <String, String>{
      ...?props.attributes,
    };
    // These have dedicated Card API fields or are owned by its style/class
    // layering and therefore cannot be overridden through the escape hatch.
    attributes
      ..remove('class')
      ..remove('href')
      ..remove('target')
      ..remove('rel')
      ..remove('type')
      ..remove('style');

    return <String, String>{
      ...attributes,
      'data-arcane-surface': 'card',
      'data-variant': props.variant.name,
      if (props.decoration != null || props.styles != null)
        'data-arcane-decorated': '',
      if (props.ariaLabel != null) 'aria-label': props.ariaLabel!,
    };
  }

  String? get _effectiveRel {
    final List<String> tokens = (props.rel ?? '')
        .split(RegExp(r'\s+'))
        .where((String token) => token.isNotEmpty)
        .toList();

    if (props.target?.toLowerCase() == '_blank') {
      for (final String safeToken in const <String>['noopener', 'noreferrer']) {
        if (!tokens.any((String token) => token.toLowerCase() == safeToken)) {
          tokens.add(safeToken);
        }
      }
    }

    return tokens.isEmpty ? null : tokens.join(' ');
  }
}
