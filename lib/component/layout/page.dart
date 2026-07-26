import 'package:arcane_jaspr/flutter.dart';
import 'package:arcane_jaspr/util/classes.dart';
import 'package:jaspr/dom.dart' as dom;

/// The content-width policy used by [ArcanePage].
enum ArcanePageWidth {
  /// A conventional application page.
  standard,

  /// A wider page suited to indexes, dashboards, and dense collections.
  wide,

  /// A restrained measure suited to prose and long-form content.
  reading,

  /// A broad working surface suited to editors and multi-panel tools.
  workbench,

  /// An unconstrained surface with no built-in horizontal gutter.
  full,

  /// An unconstrained surface with a small responsive media gutter.
  media,
}

/// A semantic, responsive page shell shared by Arcane Jaspr applications.
///
/// The component owns generic page structure only. Applications provide all
/// copy, actions, and body content, while themes style the stable
/// `arcane-page-*` hooks.
class ArcanePage extends StatelessWidget {
  final String? id;
  final String? eyebrow;
  final String title;
  final String? description;
  final List<Widget> actions;
  final Widget body;
  final ArcanePageWidth width;

  /// Emits a top-level `<main>` and an `<h1>` when true. Set this to false when
  /// the page is nested inside a scaffold that already owns the main landmark;
  /// the root then becomes a labeled `<section>` with an `<h2>`.
  final bool standalone;

  /// Overrides the accessible name of the page landmark.
  ///
  /// When omitted, [title] is used.
  final String? semanticLabel;
  final String classes;
  final Map<String, String> attributes;

  const ArcanePage({
    this.id,
    this.eyebrow,
    required this.title,
    this.description,
    this.actions = const <Widget>[],
    required this.body,
    this.width = ArcanePageWidth.standard,
    this.standalone = true,
    this.semanticLabel,
    this.classes = '',
    this.attributes = const <String, String>{},
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final String widthName = width.name;
    final String? titleId = id == null ? null : '$id-title';
    final Map<String, String> rootAttributes = <String, String>{
      ...attributes,
      if (semanticLabel != null)
        'aria-label': semanticLabel!
      else if (titleId != null)
        'aria-labelledby': titleId
      else
        'aria-label': title,
      'data-arcane-page': 'true',
      'data-arcane-page-width': widthName,
      'data-arcane-page-standalone': standalone.toString(),
    };
    final List<Widget> children = <Widget>[
      dom.header(classes: 'arcane-page-header', <Widget>[
        dom.div(classes: 'arcane-page-heading', <Widget>[
          if (eyebrow != null)
            dom.p(classes: 'arcane-page-eyebrow', <Widget>[
              Widget.text(eyebrow!),
            ]),
          if (standalone)
            dom.h1(id: titleId, classes: 'arcane-page-title', <Widget>[
              Widget.text(title),
            ])
          else
            dom.h2(id: titleId, classes: 'arcane-page-title', <Widget>[
              Widget.text(title),
            ]),
          if (description != null)
            dom.p(classes: 'arcane-page-description', <Widget>[
              Widget.text(description!),
            ]),
        ]),
        if (actions.isNotEmpty)
          dom.div(
            classes: 'arcane-page-actions',
            attributes: const <String, String>{
              'role': 'group',
              'aria-label': 'Page actions',
            },
            actions,
          ),
      ]),
      dom.div(classes: 'arcane-page-body', <Widget>[body]),
    ];
    final String rootClasses = cx(<String?>[
      'arcane-page',
      'arcane-page-$widthName',
      classes.trim(),
    ]);

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
