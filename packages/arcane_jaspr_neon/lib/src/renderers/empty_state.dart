import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/rendering/base/empty_state_render_base.dart';

/// Neon Empty State renderer.
class NeonEmptyState extends EmptyStateRenderBase {
  const NeonEmptyState(super.props, {super.key});

  @override
  String get contentClass => 'neon-empty-state-content';

  @override
  Map<String, String> get contentStyles => const <String, String>{};

  @override
  String get iconClass => 'neon-empty-state-icon';

  @override
  Map<String, String> get iconStyles => const <String, String>{};

  @override
  String get actionsClass => 'neon-empty-state-actions';

  @override
  Map<String, String> get actionsStyles => const <String, String>{};

  @override
  List<Component> buildBody() => <Component>[
    dom.h3(
      classes: 'neon-empty-state-title',
      <Component>[Component.text(props.title)],
    ),
    if (props.description != null)
      dom.p(
        classes: 'neon-empty-state-description',
        <Component>[Component.text(props.description!)],
      ),
  ];

  @override
  Component buildRoot(Component content, Map<String, String> extraStyles) =>
      dom.div(
        classes: 'neon-empty-state',
        styles: dom.Styles(raw: <String, String>{...extraStyles}),
        <Component>[content],
      );
}
