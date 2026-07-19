import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/rendering/base/breadcrumbs_render_base.dart';

/// Neubrutalism Breadcrumbs renderer.
///
/// Implements the Neubrutalism design language:
/// - Larger size options
/// - Accent-colored links
/// - More spacing between items
class NeubrutalismBreadcrumbs extends BreadcrumbsRenderBase {
  const NeubrutalismBreadcrumbs(super.props, {super.key});

  @override
  String get themePrefix => 'neubrutalism';

  @override
  String get accentColor => 'var(--nb-accent, var(--primary))';

  @override
  Component separatorSpan(String separator) => dom.span(
    classes: 'neubrutalism-breadcrumb-separator neubrutalism-breadcrumbs-separator',
    styles: const dom.Styles(
      raw: <String, String>{
        'color': 'var(--foreground)',
        'opacity': '0.6',
        'font-weight': '900',
        'user-select': 'none',
      },
    ),
    <Component>[Component.text(separator)],
  );
}
