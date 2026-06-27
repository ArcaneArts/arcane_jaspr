import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/rendering/base/separator_render_base.dart';

/// ShadCN Separator renderer.
///
/// Unified separator component combining features from both Divider and Separator.
/// Supports variants, dashed lines, labels, icons, and custom colors.
///
/// Reference: https://ui.shadcn.com/docs/components/separator
class ShadcnSeparator extends SeparatorRenderBase {
  const ShadcnSeparator(super.props, {super.key});

  @override
  String get resolveMargin => '${props.margin ?? 16}px';

  @override
  String get verticalClasses => 'arcane-separator arcane-separator-vertical';

  @override
  String get labeledClasses => 'arcane-separator arcane-separator-labeled';

  @override
  Map<String, String> get verticalStretchStyles => const <String, String>{
    'align-self': 'stretch',
    'min-height': '20px',
  };

  @override
  Map<String, String> labeledContainerStyles(String margin) => <String, String>{
    'display': 'flex',
    'align-items': 'center',
    'gap': 'var(--space-4)',
    'margin': '$margin 0',
  };

  @override
  Map<String, String> get labelSpanStyles => const <String, String>{
    'font-size': 'var(--font-size-sm)',
    'color': 'var(--muted-foreground)',
    'white-space': 'nowrap',
  };

  @override
  Map<String, String> get iconSpanStyles => const <String, String>{
    'color': 'var(--muted-foreground)',
  };

  @override
  Component buildSimpleHorizontal(
    String thickness,
    String color,
    String margin,
  ) {
    return dom.hr(
      classes: 'arcane-separator',
      attributes: horizontalAttrs(),
      styles: dom.Styles(
        raw: <String, String>{
          'margin': '$margin 0',
          'border': 'none',
          'height': thickness,
          ...backgroundStyle(color),
        },
      ),
    );
  }
}
