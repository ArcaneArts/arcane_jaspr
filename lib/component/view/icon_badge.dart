import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/dom.dart' as dom;

import '../../util/style_types/arcane_style_data.dart';
import '../../util/style_types/colors.dart';

/// A small icon inside a tinted, rounded container — the ubiquitous
/// "colored icon circle/square" idiom as a first-class component.
///
/// The container is tinted with [accentColor] at [tintOpacity] and the icon
/// takes the solid [accentColor]. [accentColor] is any CSS color string
/// (a hex, a `var(--x)` token, or an `ArcaneColor.*.css` value).
class IconBadge extends StatelessWidget {
  final Widget icon;

  /// Accent color as a CSS color string. Defaults to the theme primary.
  final String accentColor;

  /// Square size of the badge, in pixels.
  final double size;

  /// Corner radius in pixels. When null (the default) the badge is a full circle.
  final double? radius;

  /// How strongly the container background is tinted with [accentColor] (0..1).
  final double tintOpacity;

  /// Literal, theme-permeable style override (always applied, wins over the base).
  final ArcaneStyleData? styles;

  const IconBadge({
    required this.icon,
    this.accentColor = 'var(--primary)',
    this.size = 40,
    this.radius,
    this.tintOpacity = 0.12,
    this.styles,
    super.key,
  });

  /// A square-cornered badge (defaults to an 8px radius).
  const IconBadge.square({
    required this.icon,
    this.accentColor = 'var(--primary)',
    this.size = 40,
    this.radius = 8,
    this.tintOpacity = 0.12,
    this.styles,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return dom.div(
      classes: 'arcane-icon-badge',
      styles: dom.Styles(
        raw: <String, String>{
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'flex-shrink': '0',
          'width': '${size}px',
          'height': '${size}px',
          'border-radius': radius == null ? '9999px' : '${radius}px',
          'background-color': accentColor.opacity(tintOpacity),
          'color': accentColor,
          // Literal styles: override wins.
          ...?styles?.toMap(),
        },
      ),
      <Widget>[icon],
    );
  }
}
