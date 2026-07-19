import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/rendering/base/breadcrumbs_render_base.dart';

/// Neon Breadcrumbs renderer (neutralized skeleton).
class NeonBreadcrumbs extends BreadcrumbsRenderBase {
  const NeonBreadcrumbs(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  String get accentColor => 'var(--foreground)';

  @override
  Component separatorSpan(String separator) => dom.span(
    classes: 'neon-breadcrumb-separator',
    styles: const dom.Styles(
      raw: <String, String>{
        'color': 'var(--muted-foreground)',
        'user-select': 'none',
      },
    ),
    <Component>[Component.text(separator)],
  );
}
