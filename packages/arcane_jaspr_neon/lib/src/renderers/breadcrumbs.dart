import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/rendering/base/breadcrumbs_render_base.dart';

/// Neon Breadcrumbs renderer.
///
/// Implements the Neon design language:
/// - Larger size options
/// - Accent-colored links
/// - More spacing between items
class NeonBreadcrumbs extends BreadcrumbsRenderBase {
  const NeonBreadcrumbs(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  String get accentColor => 'var(--neon-accent)';

  @override
  Component separatorSpan(String separator) => dom.span(
    classes: 'neon-breadcrumb-separator',
    styles: const dom.Styles(
      raw: <String, String>{
        'color':
            'color-mix(in srgb, var(--neon-accent) 38%, var(--muted-foreground))',
        'opacity': '0.7',
        'user-select': 'none',
      },
    ),
    <Component>[Component.text(separator)],
  );
}
