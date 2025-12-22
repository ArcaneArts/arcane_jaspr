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
        events;

import '../../util/style_types/arcane_style_data.dart';

/// A side content component for tangential or supplementary content.
///
/// This wraps the HTML `<aside>` element. Use it for sidebars,
/// pull quotes, or content that is separate from the main flow.
///
/// Example:
/// ```dart
/// ArcaneSideContent(
///   styles: ArcaneStyleData(
///     width: WidthPreset.sidebar,
///     padding: PaddingPreset.md,
///   ),
///   children: [
///     ArcaneText('Related Links'),
///     ArcaneBulletList(children: [...]),
///   ],
/// )
/// ```
class ArcaneSideContent extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final String? classes;
  final String? id;

  const ArcaneSideContent({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return aside(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

// Legacy alias for backwards compatibility
typedef ArcaneAside = ArcaneSideContent;
