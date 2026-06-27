import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/card_props.dart';

/// Shared structural base for themed card renderers.
///
/// Factors the identical build logic shared by every theme's card renderer
/// (content resolution, the style merge, the `data-variant` attribute, and the
/// clickable-button-vs-div branch with its button reset styles) into one place.
/// A concrete theme renderer only supplies the root CSS class and the
/// base/variant style maps.
///
/// This base lives in core and depends only on core props; it must never
/// depend on a theme package.
abstract class CardRenderBase extends StatelessComponent {
  const CardRenderBase(this.props, {super.key});

  final CardProps props;

  /// CSS class applied to the root element (e.g. `'arcane-card'`). When the
  /// card is tappable, `' clickable'` is appended to this class.
  String get cssClass;

  /// Base layout styles (radius, padding, sizing). Receives [props] because
  /// several keys depend on optional fields.
  Map<String, String> baseStyles(CardProps props);

  /// Variant-specific visual styles (background, border, shadow).
  Map<String, String> variantStyles(CardProps props);

  @override
  Component build(BuildContext context) {
    final List<Component> content =
        props.children ?? <Component>[props.child!];

    final Map<String, String> allStyles = <String, String>{
      ...baseStyles(props),
      ...variantStyles(props),
    };

    if (props.onTap != null) {
      return dom.button(
        type: dom.ButtonType.button,
        classes: '$cssClass clickable',
        attributes: <String, String>{'data-variant': props.variant.name},
        styles: dom.Styles(
          raw: <String, String>{
            ...allStyles,
            'text-align': 'inherit',
            'font': 'inherit',
          },
        ),
        events: <String, EventCallback>{'click': (_) => props.onTap?.call()},
        content,
      );
    }

    return dom.div(
      classes: cssClass,
      attributes: <String, String>{'data-variant': props.variant.name},
      styles: dom.Styles(raw: allStyles),
      content,
    );
  }
}
