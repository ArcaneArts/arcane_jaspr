import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/rendering/base/separator_render_base.dart';

/// Neon Separator renderer.
///
/// Unified separator component combining features from both Divider and Separator.
/// Implements the Neon design language:
/// - Subtle border color for OLED screens
/// - Optional label/icon with accent styling
/// - Dashed line support
/// - Variant-based thickness
class NeonSeparator extends SeparatorRenderBase {
  const NeonSeparator(super.props, {super.key});

  @override
  String get resolveMargin =>
      props.margin != null ? '${props.margin}px' : '1rem';

  @override
  String get verticalClasses => 'neon-separator neon-separator-vertical';

  @override
  String get labeledClasses => 'neon-separator neon-separator-with-label';

  @override
  Map<String, String> get verticalStretchStyles => const <String, String>{
    'height': '100%',
    'min-height': '20px',
  };

  @override
  Map<String, String> get dashedExtraStyles => const <String, String>{
    'background-color': 'transparent',
  };

  @override
  Map<String, String> labeledContainerStyles(String margin) => <String, String>{
    'display': 'flex',
    'align-items': 'center',
    'width': '100%',
    'margin': '$margin 0',
    'gap': 'var(--arcane-space-4)',
  };

  @override
  Map<String, String> get labelSpanStyles => const <String, String>{
    'font-family': 'var(--font-heading)',
    'font-size': 'var(--arcane-font-size-xs)',
    'font-weight': 'var(--arcane-font-weight-medium)',
    'text-transform': 'uppercase',
    'letter-spacing': '0.08em',
    'color': 'var(--muted-foreground)',
    'flex-shrink': '0',
  };

  @override
  Map<String, String> get iconSpanStyles => const <String, String>{
    'color': 'var(--muted-foreground)',
    'flex-shrink': '0',
  };

  @override
  Component buildSimpleHorizontal(
    String thickness,
    String color,
    String margin,
  ) {
    return dom.div(
      classes: 'neon-separator',
      attributes: horizontalAttrs(),
      styles: dom.Styles(
        raw: <String, String>{
          'width': '100%',
          'height': thickness,
          'margin': '$margin 0',
          ...backgroundStyle(color),
        },
      ),
      const <Component>[],
    );
  }
}
