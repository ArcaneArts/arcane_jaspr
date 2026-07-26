import 'package:arcane_jaspr/flutter.dart';
import 'package:jaspr/dom.dart' as dom;

/// A recovery link rendered by [ArcaneNotFoundPage].
class ArcaneNotFoundAction {
  final String label;
  final String href;
  final bool primary;
  final String? ariaLabel;

  const ArcaneNotFoundAction({
    required this.label,
    required this.href,
    this.primary = false,
    this.ariaLabel,
  });
}

/// A theme-aware 404 surface with semantic recovery navigation.
///
/// The component deliberately owns only generic not-found content. Themes can
/// present the stable `arcane-not-found-*` structure as a conventional card,
/// a full-screen system error, or another native surface. Applications retain
/// control over brand copy, diagnostics, and recovery destinations.
class ArcaneNotFoundPage extends StatelessWidget {
  final String? id;
  final String applicationName;
  final String code;
  final String title;
  final String description;
  final String? requestedPath;
  final String? diagnosticCode;
  final List<ArcaneNotFoundAction> actions;

  /// Emits a top-level `<main>` and viewport-filling layout when true. Set to
  /// false when placing the surface inside a scaffold that already owns its
  /// main landmark; the root then becomes a labeled `<section>`.
  final bool standalone;
  final String classes;
  final Map<String, String> attributes;

  const ArcaneNotFoundPage({
    this.id,
    this.applicationName = 'Application',
    this.code = '404',
    this.title = 'Page not found',
    this.description =
        'The page you requested does not exist or is no longer available.',
    this.requestedPath,
    this.diagnosticCode,
    this.actions = const <ArcaneNotFoundAction>[
      ArcaneNotFoundAction(label: 'Return home', href: '/', primary: true),
    ],
    this.standalone = true,
    this.classes = '',
    this.attributes = const <String, String>{},
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String rootClasses = _joinClasses(<String>[
      'arcane-not-found',
      classes,
    ]);
    final Map<String, String> rootAttributes = <String, String>{
      ...attributes,
      'aria-label': title,
      'data-arcane-not-found': 'true',
      'data-arcane-not-found-standalone': standalone.toString(),
    };
    final List<Widget> children = <Widget>[
      dom.div(classes: 'arcane-not-found-surface', <Widget>[
        dom.div(classes: 'arcane-not-found-banner', <Widget>[
          dom.span(classes: 'arcane-not-found-application', <Widget>[
            Widget.text(applicationName),
          ]),
          dom.span(classes: 'arcane-not-found-code', <Widget>[
            Widget.text(code),
          ]),
        ]),
        dom.div(classes: 'arcane-not-found-content', <Widget>[
          if (standalone)
            dom.h1(classes: 'arcane-not-found-title', <Widget>[
              Widget.text(title),
            ])
          else
            dom.h2(classes: 'arcane-not-found-title', <Widget>[
              Widget.text(title),
            ]),
          dom.p(classes: 'arcane-not-found-description', <Widget>[
            Widget.text(description),
          ]),
          if (requestedPath != null)
            dom.p(classes: 'arcane-not-found-path', <Widget>[
              const dom.span(classes: 'arcane-not-found-path-label', <Widget>[
                Widget.text('Requested path:'),
              ]),
              dom.code(classes: 'arcane-not-found-path-value', <Widget>[
                Widget.text(requestedPath!),
              ]),
            ]),
          if (actions.isNotEmpty)
            dom.nav(
              classes: 'arcane-not-found-actions',
              attributes: const <String, String>{
                'aria-label': 'Recovery options',
              },
              <Widget>[
                for (final ArcaneNotFoundAction action in actions)
                  dom.a(
                    href: action.href,
                    classes: _joinClasses(<String>[
                      'arcane-not-found-action',
                      if (action.primary) 'arcane-not-found-action-primary',
                    ]),
                    attributes: <String, String>{
                      if (action.ariaLabel != null)
                        'aria-label': action.ariaLabel!,
                    },
                    <Widget>[Widget.text(action.label)],
                  ),
              ],
            ),
          if (diagnosticCode != null)
            dom.p(classes: 'arcane-not-found-diagnostic', <Widget>[
              Widget.text(diagnosticCode!),
            ]),
        ]),
      ]),
    ];

    if (standalone) {
      return dom.main_(
        id: id,
        classes: rootClasses,
        attributes: rootAttributes,
        children,
      );
    }
    return dom.section(
      id: id,
      classes: rootClasses,
      attributes: rootAttributes,
      children,
    );
  }
}

String _joinClasses(List<String> names) => names
    .map((String name) => name.trim())
    .where((String name) => name.isNotEmpty)
    .join(' ');
