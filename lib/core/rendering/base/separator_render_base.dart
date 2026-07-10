import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/props/separator_props.dart';

/// Shared structural base for themed separator renderers.
///
/// Factors the identical build logic shared by every theme's separator renderer
/// (the variant thickness/color resolution, the labeled/vertical/simple branch
/// selection, the labeled flex scaffold with its left/right lines and centered
/// label-or-icon span, the vertical element, and the dashed/solid background
/// resolution) into one place. A concrete theme renderer only supplies the
/// value-producing members below: the class strings, the theme-specific style
/// maps, the resolved margin, and the structurally-divergent simple-horizontal
/// element.
///
/// This base lives in core and depends only on core props; it must never depend
/// on a theme package.
abstract class SeparatorRenderBase extends StatelessComponent {
  const SeparatorRenderBase(this.props, {super.key});

  final SeparatorProps props;

  /// Full class string applied to the vertical separator root element.
  String get verticalClasses;

  /// Full class string applied to the labeled (horizontal) separator root.
  String get labeledClasses;

  /// Styles applied to the vertical separator when no explicit height is set
  /// (the stretch-to-fill fallback).
  Map<String, String> get verticalStretchStyles;

  /// Inline styles for the labeled separator's flex container. [margin] is the
  /// already-resolved margin value (including units).
  Map<String, String> labeledContainerStyles(String margin);

  /// Inline styles for the centered text label span.
  Map<String, String> get labelSpanStyles;

  /// Inline styles for the centered icon span.
  Map<String, String> get iconSpanStyles;

  /// Resolved margin value including units (e.g. `'16px'` or `'1rem'`).
  String get resolveMargin;

  /// Extra style entries merged into the dashed background style after the
  /// gradient declaration. Defaults to none.
  Map<String, String> get dashedExtraStyles => const <String, String>{};

  /// Per-instance decoration overrides. Default: none. A theme overrides this
  /// to translate an [ArcaneDecoration] (elevation intent, theme-specific
  /// fields) into its own CSS. Fields a theme does not implement are ignored.
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      const <String, String>{};

  /// Builds the simple (unlabeled) horizontal separator. This branch diverges
  /// structurally between themes (e.g. `<hr>` versus `<div>`, differing style
  /// maps), so each theme supplies its own element while reusing
  /// [horizontalAttrs] and [backgroundStyle].
  Component buildSimpleHorizontal(String thickness, String color, String margin);

  /// Attributes shared by every horizontal separator element.
  Map<String, String> horizontalAttrs() => <String, String>{
    'role': props.decorative ? 'none' : 'separator',
    if (!props.decorative) 'aria-orientation': 'horizontal',
  };

  /// Background style for a separator line of the given [color]. Honors the
  /// dashed flag and the separator orientation.
  Map<String, String> backgroundStyle(String color) {
    if (props.dashed) {
      final bool isVertical =
          props.orientation == SeparatorOrientation.vertical;
      return <String, String>{
        'background': isVertical
            ? 'repeating-linear-gradient(to bottom, $color 0, $color 4px, transparent 4px, transparent 8px)'
            : 'repeating-linear-gradient(to right, $color 0, $color 4px, transparent 4px, transparent 8px)',
        ...dashedExtraStyles,
      };
    }
    return <String, String>{'background-color': color};
  }

  @override
  Component build(BuildContext context) {
    final bool isHorizontal =
        props.orientation == SeparatorOrientation.horizontal;

    final (String thickness, String variantColor) = switch (props.variant) {
      SeparatorVariant.standard => ('1px', 'var(--border)'),
      SeparatorVariant.subtle => ('1px', 'var(--muted)'),
      SeparatorVariant.bold => ('2px', 'var(--border)'),
    };

    final String effectiveColor = props.color ?? variantColor;
    final String margin = resolveMargin;

    // Handle labeled/icon horizontal separator.
    if ((props.label != null || props.icon != null) && isHorizontal) {
      return _buildLabeled(thickness, effectiveColor, margin);
    }

    // Vertical separator.
    if (!isHorizontal) {
      return _buildVertical(thickness, effectiveColor, margin);
    }

    // Simple horizontal separator (structurally theme-specific).
    return buildSimpleHorizontal(thickness, effectiveColor, margin);
  }

  Component _buildVertical(String thickness, String color, String margin) {
    return dom.div(
      classes: verticalClasses,
      attributes: <String, String>{
        'role': props.decorative ? 'none' : 'separator',
        if (!props.decorative) 'aria-orientation': 'vertical',
      },
      styles: dom.Styles(
        raw: <String, String>{
          'width': thickness,
          'margin': '0 $margin',
          ...backgroundStyle(color),
          if (props.height != null)
            'height': '${props.height}px'
          else
            ...verticalStretchStyles,
          ...?props.decoration?.universalStyles(),
          ...decorationStyles(props.decoration),
          ...?props.styles?.toMap(),
        },
      ),
      const <Component>[],
    );
  }

  Component _buildLabeled(String thickness, String color, String margin) {
    return dom.div(
      classes: labeledClasses,
      attributes: <String, String>{
        'role': props.decorative ? 'none' : 'separator',
      },
      styles: dom.Styles(
        raw: <String, String>{
          ...labeledContainerStyles(margin),
          ...?props.decoration?.universalStyles(),
          ...decorationStyles(props.decoration),
          ...?props.styles?.toMap(),
        },
      ),
      <Component>[
        // Left line.
        dom.div(
          styles: dom.Styles(
            raw: <String, String>{
              'flex': '1',
              'height': thickness,
              ...backgroundStyle(color),
            },
          ),
          const <Component>[],
        ),

        // Label or icon.
        if (props.label != null)
          dom.span(
            styles: dom.Styles(raw: labelSpanStyles),
            <Component>[Component.text(props.label!)],
          )
        else if (props.icon != null)
          dom.span(
            styles: dom.Styles(raw: iconSpanStyles),
            <Component>[props.icon!],
          ),

        // Right line.
        dom.div(
          styles: dom.Styles(
            raw: <String, String>{
              'flex': '1',
              'height': thickness,
              ...backgroundStyle(color),
            },
          ),
          const <Component>[],
        ),
      ],
    );
  }
}
