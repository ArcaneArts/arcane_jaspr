import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/props/empty_state_props.dart';

/// Shared structural base for themed empty-state renderers.
///
/// Factors the build logic that is genuinely identical across every theme's
/// empty-state renderer — the content container, the optional icon wrapper, the
/// optional actions row (with its `action`/`secondaryAction` children) and the
/// overall child-assembly order — into one place. A concrete theme renderer
/// supplies the value-producing members (root/icon/actions CSS classes and
/// their style maps) plus two structural escape hatches where the themes
/// genuinely diverge:
///
///  * [buildBody] — the title/description section. ShadCN renders flat `div`s
///    as direct siblings, while Neon/Neubrutalism nest an `h3`/`p` pair inside
///    a text-wrapper element, so the node structure differs per theme.
///  * [buildRoot] — the final wrapping. ShadCN wraps the non-card style in a
///    bare, class-less `div` (only to host `extraStyles`), while
///    Neon/Neubrutalism always wrap it in a classed outer element, so the
///    node structure differs per theme.
///
/// This base lives in core and depends only on core props; it must never depend
/// on a theme package.
abstract class EmptyStateRenderBase extends StatelessComponent {
  const EmptyStateRenderBase(this.props, {super.key});

  final EmptyStateProps props;

  /// CSS class applied to the inner content container.
  String get contentClass;

  /// Inline styles for the inner content container.
  Map<String, String> get contentStyles;

  /// CSS class applied to the icon wrapper (used only when an icon is present).
  String get iconClass;

  /// Inline styles for the icon wrapper (used only when an icon is present).
  Map<String, String> get iconStyles;

  /// CSS class applied to the actions row (used only when an action exists).
  String get actionsClass;

  /// Inline styles for the actions row (used only when an action exists).
  Map<String, String> get actionsStyles;

  /// Builds the title/description section as the sibling nodes that sit between
  /// the optional icon and the optional actions row. Returns one or more nodes
  /// because some themes emit the title/description as flat siblings while
  /// others wrap them in a single container.
  List<Component> buildBody();

  /// Per-instance decoration overrides. Default: none. A theme overrides this
  /// to translate an [ArcaneDecoration] elevation intent into its own CSS.
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      const <String, String>{};

  /// Wraps the assembled [content] container in the theme's outer element,
  /// applying the card-vs-default decision per theme. [extraStyles] is the
  /// merged decoration/style override that must be spread into the theme's
  /// visible root element.
  Component buildRoot(Component content, Map<String, String> extraStyles);

  @override
  Component build(BuildContext context) {
    final List<Component> contentChildren = <Component>[
      if (props.icon != null)
        dom.div(
          classes: iconClass,
          styles: dom.Styles(raw: iconStyles),
          <Component>[props.icon!],
        ),
      ...buildBody(),
      if (props.action != null || props.secondaryAction != null)
        dom.div(
          classes: actionsClass,
          styles: dom.Styles(raw: actionsStyles),
          <Component>[
            if (props.action != null) props.action!,
            if (props.secondaryAction != null) props.secondaryAction!,
          ],
        ),
    ];

    final Component content = dom.div(
      classes: contentClass,
      styles: dom.Styles(raw: contentStyles),
      contentChildren,
    );

    final Map<String, String> extraStyles = <String, String>{
      ...?props.decoration?.universalStyles(),
      ...decorationStyles(props.decoration),
      ...?props.styles?.toMap(),
    };

    return buildRoot(content, extraStyles);
  }
}
