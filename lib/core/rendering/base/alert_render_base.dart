import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/props/alert_props.dart';

/// Shared structural base for themed alert renderers.
///
/// Factors the identical build logic shared by every theme's alert renderer
/// (the root container, the optional icon block, the content block with its
/// title/description/child/action children, and the optional dismiss button)
/// into one place. A concrete theme renderer only supplies the value-producing
/// members below: the per-element CSS classes, the style maps, the default
/// icon, the dismiss glyph and the action spacing.
///
/// The overall element tree is byte-identical across all three themes; only the
/// CSS class strings and style values differ, so this base uses value-map
/// abstractions (like the button and card bases) rather than structural
/// sub-builders.
///
/// This base lives in core and depends only on core props; it must never
/// depend on a theme package.
abstract class AlertRenderBase extends StatelessComponent {
  const AlertRenderBase(this.props, {super.key});

  final AlertProps props;

  /// CSS class applied to the root element (e.g. `'arcane-alert'`).
  String get rootClass;

  /// Attributes applied to the root element (`role` plus any data markers).
  Map<String, String> get rootAttributes;

  /// Root styles that follow the shared layout block and precede the
  /// style-variant container styles (spacing plus any theme-specific layout
  /// such as clipping).
  Map<String, String> get rootLayoutStyles;

  /// Style-variant container styles (background, border, shadow) for the root.
  Map<String, String> get containerStyles;

  /// CSS class applied to the icon wrapper.
  String get iconClass;

  /// Inline styles for the icon wrapper.
  Map<String, String> get iconStyles;

  /// The default icon used when [AlertProps.icon] is null.
  Component get defaultIcon;

  /// CSS class applied to the content wrapper.
  String get contentClass;

  /// CSS class applied to the title element.
  String get titleClass;

  /// Inline styles for the title element.
  Map<String, String> get titleStyles;

  /// CSS class applied to the description element.
  String get descriptionClass;

  /// Inline styles for the description element.
  Map<String, String> get descriptionStyles;

  /// `margin-top` value applied to the action wrapper.
  String get actionMarginTop;

  /// CSS class applied to the dismiss button.
  String get dismissClass;

  /// Inline styles for the dismiss button.
  Map<String, String> get dismissStyles;

  /// The glyph/icon rendered inside the dismiss button.
  Component get dismissChild;

  /// Per-instance decoration overrides. Default: none. Themes translate an
  /// ArcaneDecoration into their own CSS; unimplemented fields are ignored.
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      const <String, String>{};

  @override
  Component build(BuildContext context) {
    return dom.div(
      classes: rootClass,
      attributes: rootAttributes,
      styles: dom.Styles(
        raw: <String, String>{
          'position': 'relative',
          'width': '100%',
          'display': 'flex',
          'align-items': 'flex-start',
          ...rootLayoutStyles,
          ...containerStyles,
          ...?props.decoration?.universalStyles(),
          ...decorationStyles(props.decoration),
          ...?props.styles?.toMap(),
        },
      ),
      <Component>[
        // Icon
        if (props.showIcon)
          dom.div(
            classes: iconClass,
            styles: dom.Styles(raw: iconStyles),
            <Component>[props.icon ?? defaultIcon],
          ),

        // Content
        dom.div(
          classes: contentClass,
          styles: const dom.Styles(
            raw: <String, String>{'flex': '1', 'min-width': '0'},
          ),
          <Component>[
            // Title
            if (props.title != null)
              dom.div(
                classes: titleClass,
                styles: dom.Styles(raw: titleStyles),
                <Component>[Component.text(props.title!)],
              ),
            // Description
            if (props.message != null)
              dom.div(
                classes: descriptionClass,
                styles: dom.Styles(raw: descriptionStyles),
                <Component>[Component.text(props.message!)],
              ),
            if (props.child != null) props.child!,
            if (props.action != null)
              dom.div(
                styles: dom.Styles(
                  raw: <String, String>{'margin-top': actionMarginTop},
                ),
                <Component>[props.action!],
              ),
          ],
        ),

        // Dismiss button
        if (props.dismissible)
          dom.button(
            type: dom.ButtonType.button,
            classes: dismissClass,
            attributes: const <String, String>{'aria-label': 'Dismiss'},
            styles: dom.Styles(raw: dismissStyles),
            events: <String, EventCallback>{
              'click': (_) => props.onDismiss?.call(),
            },
            <Component>[dismissChild],
          ),
      ],
    );
  }
}
