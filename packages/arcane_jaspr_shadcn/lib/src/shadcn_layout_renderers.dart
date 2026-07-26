import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:arcane_jaspr/web.dart' as dom;

class ShadcnLayoutRenderers extends LayoutRenderers {
  const ShadcnLayoutRenderers();

  static bool _hasHeader(ArcaneScaffoldProps props) =>
      props.title != null || props.navigation != null || props.actions != null;

  static String _gridTemplateColumns(ArcaneScaffoldProps props) =>
      switch ((props.sidebar != null, props.secondary != null)) {
        (true, true) => 'minmax(0, auto) minmax(0, 1fr) minmax(0, auto)',
        (true, false) => 'minmax(0, auto) minmax(0, 1fr)',
        (false, true) => 'minmax(0, 1fr) minmax(0, auto)',
        (false, false) => 'minmax(0, 1fr)',
      };

  static Widget _header(ArcaneScaffoldProps props) {
    return dom.header(
      classes: 'arcane-scaffold-header',
      styles: const dom.Styles(
        raw: <String, String>{
          'height': '3.5rem',
          'display': 'flex',
          'align-items': 'center',
          'gap': '1rem',
          'border-bottom':
              '1px solid color-mix(in srgb, var(--border) 48%, transparent)',
          'background':
              'color-mix(in srgb, var(--background) 98%, transparent)',
          'padding': '0 1.25rem',
          'position': 'sticky',
          'top': '0',
          'z-index': '30',
          'backdrop-filter': 'none',
        },
      ),
      <Widget>[
        if (props.title != null)
          dom.div(
            classes: 'arcane-scaffold-title',
            styles: const dom.Styles(
              raw: <String, String>{
                'font-size': '0.9375rem',
                'font-weight': '600',
                'line-height': '1',
                'white-space': 'nowrap',
              },
            ),
            <Widget>[Text(props.title!)],
          ),
        if (props.navigation != null)
          dom.nav(
            classes: 'arcane-scaffold-navigation',
            styles: const dom.Styles(
              raw: <String, String>{
                'display': 'flex',
                'align-items': 'center',
                'gap': '0.25rem',
                'min-width': '0',
                'width': '100%',
                'flex': '1 1 auto',
              },
            ),
            <Widget>[props.navigation!],
          )
        else
          const dom.div(
            styles: dom.Styles(raw: <String, String>{'flex': '1'}),
            <Widget>[],
          ),
        if (props.actions != null)
          dom.div(
            classes: 'arcane-scaffold-actions',
            styles: const dom.Styles(
              raw: <String, String>{
                'display': 'flex',
                'align-items': 'center',
                'gap': '0.5rem',
              },
            ),
            <Widget>[props.actions!],
          ),
      ],
    );
  }

  @override
  Widget scaffold(ArcaneScaffoldProps props) {
    List<Widget> shellChildren = <Widget>[
      if (_hasHeader(props)) _header(props),
      dom.div(
        classes: 'arcane-scaffold-body',
        attributes: <String, String>{
          if (props.sidebar != null) 'data-has-sidebar': '',
          if (props.secondary != null) 'data-has-secondary': '',
        },
        styles: dom.Styles(
          raw: <String, String>{
            'display': 'grid',
            'grid-template-columns': _gridTemplateColumns(props),
            'min-height': '0',
            'flex': '1',
            'align-items': 'start',
            'overflow': 'visible',
          },
        ),
        <Widget>[
          if (props.sidebar != null)
            dom.aside(
              classes: 'arcane-scaffold-sidebar',
              styles: const dom.Styles(
                raw: <String, String>{
                  'width': '17.5rem',
                  'border-right':
                      '1px solid color-mix(in srgb, var(--border) 54%, transparent)',
                  'background':
                      'color-mix(in srgb, var(--background) 97%, var(--muted))',
                  'padding': '1rem',
                  'position': 'sticky',
                  'top': '3.5rem',
                  'align-self': 'start',
                  'height': 'max-content',
                  'max-height': 'none',
                  'min-height': '0',
                  'overflow': 'visible',
                },
              ),
              <Widget>[props.sidebar!],
            ),
          dom.main_(
            classes: 'arcane-scaffold-main',
            styles: const dom.Styles(
              raw: <String, String>{
                'min-width': '0',
                'padding': '0',
                'background': 'var(--background)',
                'overflow': 'visible',
              },
            ),
            <Widget>[props.body],
          ),
          if (props.secondary != null)
            dom.aside(
              classes: 'arcane-scaffold-secondary',
              styles: const dom.Styles(
                raw: <String, String>{
                  'width': '18rem',
                  'border-left':
                      '1px solid color-mix(in srgb, var(--border) 54%, transparent)',
                  'background':
                      'color-mix(in srgb, var(--background) 97%, var(--muted))',
                  'padding': '1rem',
                  'position': 'sticky',
                  'top': '5rem',
                  'align-self': 'start',
                  'height': 'max-content',
                  'max-height': 'none',
                  'min-height': '0',
                  'overflow': 'visible',
                },
              ),
              <Widget>[props.secondary!],
            ),
        ],
      ),
      if (props.footer != null)
        dom.footer(
          classes: 'arcane-scaffold-footer',
          styles: const dom.Styles(
            raw: <String, String>{
              'border-top':
                  '1px solid color-mix(in srgb, var(--border) 54%, transparent)',
              'padding': '0.875rem 1.25rem',
              'background': 'var(--background)',
            },
          ),
          <Widget>[props.footer!],
        ),
      if (props.floatingAction != null)
        dom.div(
          classes: 'arcane-scaffold-floating',
          styles: const dom.Styles(
            raw: <String, String>{
              'position': 'fixed',
              'right': '1.25rem',
              'bottom': '1.25rem',
              'z-index': '40',
            },
          ),
          <Widget>[props.floatingAction!],
        ),
    ];

    return dom.div(
      classes: 'arcane-scaffold shadcn-scaffold',
      styles: const dom.Styles(
        raw: <String, String>{
          'min-height': '100vh',
          'display': 'flex',
          'flex-direction': 'column',
          'background': 'var(--background)',
          'color': 'var(--foreground)',
        },
      ),
      shellChildren,
    );
  }
}
