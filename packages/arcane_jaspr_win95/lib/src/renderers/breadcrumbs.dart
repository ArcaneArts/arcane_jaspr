import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/rendering/base/breadcrumbs_render_base.dart';

/// Win95 Breadcrumbs renderer (neutralized skeleton).
class Win95Breadcrumbs extends BreadcrumbsRenderBase {
  const Win95Breadcrumbs(super.props, {super.key});

  @override
  String get themePrefix => 'win95';

  @override
  String get accentColor => 'var(--foreground)';

  @override
  Component separatorSpan(String separator) => dom.span(
    classes: 'win95-breadcrumb-separator',
    styles: const dom.Styles(
      raw: <String, String>{
        'color': 'var(--muted-foreground)',
        'user-select': 'none',
      },
    ),
    <Component>[Component.text(separator)],
  );
}
