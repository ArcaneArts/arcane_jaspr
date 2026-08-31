import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/empty_state_props.dart';
import 'package:arcane_jaspr/core/rendering/base/empty_state_render_base.dart';

/// Win95 Empty State renderer.
class Win95EmptyState extends EmptyStateRenderBase {
  const Win95EmptyState(super.props, {super.key});

  @override
  String get contentClass => 'win95-empty-state-content';

  @override
  Map<String, String> get contentStyles => const <String, String>{};

  @override
  String get iconClass => 'win95-empty-state-icon';

  @override
  Map<String, String> get iconStyles => const <String, String>{};

  @override
  String get actionsClass => 'win95-empty-state-actions';

  @override
  Map<String, String> get actionsStyles => const <String, String>{};

  @override
  List<Component> buildBody() => <Component>[
    dom.h3(classes: 'win95-empty-state-title', <Component>[
      Component.text(props.title),
    ]),
    if (props.description != null)
      dom.p(classes: 'win95-empty-state-description', <Component>[
        Component.text(props.description!),
      ]),
  ];

  @override
  Component buildRoot(Component content, Map<String, String> extraStyles) =>
      dom.div(
        classes: 'win95-empty-state',
        attributes: <String, String>{
          if (props.variant == EmptyStateStyleVariant.card)
            'data-arcane-surface': 'empty-state-card',
        },
        styles: dom.Styles(raw: <String, String>{...extraStyles}),
        <Component>[content],
      );
}
