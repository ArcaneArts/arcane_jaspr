import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/style_layering.dart';
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

  /// Per-instance decoration overrides. Default: none. A theme overrides this
  /// to translate an [ArcaneDecoration] (elevation intent, theme-specific
  /// fields) into its own CSS. Fields a theme does not implement are ignored.
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      const <String, String>{};

  @override
  Component build(BuildContext context) {
    final List<Component> content =
        props.children ?? <Component>[props.child!];

    final Map<String, String> allStyles = layerStyles(
      <String, String>{
        ...baseStyles(props),
        ...variantStyles(props),
      },
      <Map<String, String>?>[
        props.decoration?.universalStyles(),
        decorationStyles(props.decoration),
        props.styles?.toMap(),
      ],
    );

    if (props.onTap != null) {
      return dom.button(
        type: dom.ButtonType.button,
        classes: '$cssClass clickable',
        attributes: <String, String>{
        'data-variant': props.variant.name,
        // Decorated cards opt out of themes' !important surface resets (e.g.
        // neubrutalism) so their inline decoration/styles actually render.
        if (props.decoration != null || props.styles != null)
          'data-arcane-decorated': '',
      },
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
      classes: cssClass,
      attributes: <String, String>{
        'data-variant': props.variant.name,
        // Decorated cards opt out of themes' !important surface resets (e.g.
        // neubrutalism) so their inline decoration/styles actually render.
        if (props.decoration != null || props.styles != null)
          'data-arcane-decorated': '',
      },
      styles: dom.Styles(raw: allStyles),
      content,
    );
  }
}
