import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/style_layering.dart';
import 'package:arcane_jaspr/core/props/breadcrumbs_props.dart';

/// Shared structural base for the Neon-family breadcrumb renderers.
///
/// The Neon and Neubrutalism breadcrumbs share an identical structure (a `nav`
/// holding items and separators directly, with the SVG home icon, the
/// link/button/current item branches and the size table). They differ only in
/// the CSS class prefix, the accent color of the current item, and the
/// separator span. This base factors the shared logic, leaving those values to
/// the concrete renderer.
///
/// The ShadCN breadcrumb uses a different DOM (an `ol`/`li` list) and therefore
/// does not extend this base.
///
/// This base lives in core and depends only on core props; it must never
/// depend on a theme package.
abstract class BreadcrumbsRenderBase extends StatelessComponent {
  const BreadcrumbsRenderBase(this.props, {super.key});

  final BreadcrumbsProps props;

  /// CSS class prefix (e.g. `'neon'`, `'neubrutalism'`).
  String get themePrefix;

  /// Color applied to the current (last) item.
  String get accentColor;

  /// Builds the separator span for the resolved [separator] glyph.
  Component separatorSpan(String separator);

  /// Per-instance decoration overrides. Default: none. Themes translate an
  /// ArcaneDecoration into their own CSS; unimplemented fields are ignored.
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      const <String, String>{};

  @override
  Component build(BuildContext context) {
    final (String fontSize, String gap) = switch (props.size) {
      BreadcrumbSizeVariant.sm => ('0.75rem', '0.5rem'),
      BreadcrumbSizeVariant.md => ('0.875rem', '0.625rem'),
      BreadcrumbSizeVariant.lg => ('1rem', '0.75rem'),
    };

    return dom.nav(
      classes: '$themePrefix-breadcrumbs',
      attributes: <String, String>{'aria-label': 'Breadcrumb'},
      styles: dom.Styles(
        raw: layerStyles(
          <String, String>{
            'display': 'flex',
            'align-items': 'center',
            'gap': gap,
            'font-size': fontSize,
          },
          <Map<String, String>?>[
            props.decoration?.universalStyles(),
            decorationStyles(props.decoration),
            props.styles?.toMap(),
          ],
        ),
      ),
      <Component>[
        for (int i = 0; i < props.items.length; i++) ...<Component>[
          _buildItem(props.items[i], i, i == props.items.length - 1),
          if (i < props.items.length - 1) _buildSeparator(),
        ],
      ],
    );
  }

  Component _buildItem(BreadcrumbItemProps item, int index, bool isLast) {
    final bool isClickable = item.href != null || props.onItemClick != null;

    final List<Component> children = <Component>[
      if (index == 0 && props.showHomeIcon)
        const Component.element(
          tag: 'svg',
          attributes: <String, String>{
            'width': '14',
            'height': '14',
            'viewBox': '0 0 24 24',
            'fill': 'none',
            'stroke': 'currentColor',
            'stroke-width': '2',
            'stroke-linecap': 'round',
            'stroke-linejoin': 'round',
            'aria-hidden': 'true',
          },
          styles: dom.Styles(raw: <String, String>{'margin-right': '0.4rem'}),
          children: <Component>[
            Component.element(
              tag: 'path',
              attributes: <String, String>{'d': 'M3 12l9-9 9 9'},
              children: <Component>[],
            ),
            Component.element(
              tag: 'path',
              attributes: <String, String>{'d': 'M5 10v10h14V10'},
              children: <Component>[],
            ),
          ],
        )
      else if (item.icon != null) ...<Component>[
        item.icon!,
        const dom.span(styles: dom.Styles(raw: <String, String>{'width': '0.375rem'}), <Component>[]),
      ],
      Component.text(item.label),
    ];

    if (item.href != null && !isLast) {
      return dom.a(
        href: item.href!,
        classes: '$themePrefix-breadcrumb-link',
        styles: const dom.Styles(
          raw: <String, String>{
            'display': 'inline-flex',
            'align-items': 'center',
            'color': 'var(--muted-foreground)',
            'text-decoration': 'none',
            'transition': 'color 200ms ease',
          },
        ),
        children,
      );
    }

    if (props.onItemClick != null && !isLast) {
      return dom.button(
        classes: '$themePrefix-breadcrumb-button',
        styles: const dom.Styles(
          raw: <String, String>{
            'display': 'inline-flex',
            'align-items': 'center',
            'background': 'transparent',
            'border': 'none',
            'padding': '0',
            'color': 'var(--muted-foreground)',
            'cursor': 'pointer',
            'font': 'inherit',
            'transition': 'color 200ms ease',
          },
        ),
        events: <String, EventCallback>{
          'click': (_) => props.onItemClick!(item, index),
        },
        children,
      );
    }

    return dom.span(
      classes: '$themePrefix-breadcrumb-current',
      styles: dom.Styles(
        raw: <String, String>{
          'display': 'inline-flex',
          'align-items': 'center',
          'color': isLast ? accentColor : 'var(--muted-foreground)',
          'font-weight': isLast ? 'var(--font-weight-semibold)' : '400',
          if (!isClickable && !isLast) 'cursor': 'default',
        },
      ),
      children,
    );
  }

  Component _buildSeparator() {
    if (props.customSeparator != null) {
      return props.customSeparator!;
    }

    final String separator = switch (props.separator) {
      BreadcrumbSeparatorStyle.slash => '/',
      BreadcrumbSeparatorStyle.chevron => '›',
      BreadcrumbSeparatorStyle.arrow => '→',
      BreadcrumbSeparatorStyle.dot => '•',
    };

    return separatorSpan(separator);
  }
}
