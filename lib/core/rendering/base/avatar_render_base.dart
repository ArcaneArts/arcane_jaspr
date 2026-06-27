import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/avatar_props.dart';

/// Shared structural base for themed avatar renderers.
///
/// Factors the consistent build skeleton shared by every theme's avatar
/// renderer (the root container element, its inline styles, the optional tap
/// handler, and the body-then-optional-status child assembly) into one place.
/// A concrete theme renderer supplies the root/status CSS classes and inline
/// style maps as value members.
///
/// The avatar body diverges structurally between themes: ShadCN renders the
/// image/initials fallback flat inside the root, while Neon and Neubrutalism
/// wrap that content in an inner element. That divergent sub-tree is therefore
/// produced by the abstract [buildBody] escape hatch rather than a value map.
///
/// This base lives in core and depends only on core props; it must never
/// depend on a theme package.
abstract class AvatarRenderBase extends StatelessComponent {
  const AvatarRenderBase(this.props, {super.key});

  final AvatarProps props;

  /// CSS class applied to the root container element.
  String get rootClass;

  /// CSS class applied to the status indicator element.
  String get statusClass;

  /// Inline styles for the root container element.
  Map<String, String> rootStyles(AvatarProps props);

  /// Inline styles for the status indicator element.
  Map<String, String> statusStyles(AvatarProps props);

  /// Builds the avatar body (image or initials fallback). This sub-tree differs
  /// structurally per theme, so it is produced here rather than value-mapped.
  Component buildBody(AvatarProps props);

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: rootClass,
      styles: dom.Styles(raw: rootStyles(props)),
      events: props.onTap == null
          ? null
          : <String, EventCallback>{'click': (_) => props.onTap!()},
      <Component>[
        buildBody(props),
        if (props.showStatus)
          dom.div(
            classes: statusClass,
            styles: dom.Styles(raw: statusStyles(props)),
            const <Component>[],
          ),
      ],
    );
  }
}
