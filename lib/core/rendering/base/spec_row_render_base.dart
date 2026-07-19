import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/spec_row_props.dart';

/// Shared structural base for themed spec-row renderers.
///
/// Every theme's spec row is a label/value pair with an identical
/// space-between layout; only the CSS class prefix, the highlight color and the
/// value font-weight differ. This base factors the shared markup and color
/// resolution, leaving the concrete renderer to supply those few values.
///
/// This base lives in core and depends only on core props; it must never
/// depend on a theme package.
abstract class SpecRowRenderBase extends StatelessComponent {
  const SpecRowRenderBase(this.props, {super.key});

  final SpecRowProps props;

  /// CSS class prefix; classes are derived as `'$cssPrefix-spec-row'`,
  /// `'$cssPrefix-spec-row-label'` and `'$cssPrefix-spec-row-value'`.
  String get cssPrefix;

  /// Value color used when [SpecRowProps.highlight] is set and no explicit
  /// value color is provided.
  String get highlightColor;

  /// Font weight applied to the value span.
  String get valueFontWeight;

  @override
  Component build(BuildContext context) {
    final String fontSize = props.fontSize ?? 'var(--font-size-sm)';
    final String labelColor = props.labelColor ?? 'var(--muted-foreground)';
    final String valueColor =
        props.valueColor ??
        (props.highlight ? highlightColor : 'var(--foreground)');

    return dom.div(
      classes: '$cssPrefix-spec-row',
      styles: const dom.Styles(
        raw: <String, String>{
          'display': 'flex',
          'justify-content': 'space-between',
          'align-items': 'center',
        },
      ),
      <Component>[
        dom.span(
          classes: '$cssPrefix-spec-row-label',
          styles: dom.Styles(
            raw: <String, String>{'font-size': fontSize, 'color': labelColor},
          ),
          <Component>[Component.text(props.label)],
        ),
        dom.span(
          classes: '$cssPrefix-spec-row-value',
          styles: dom.Styles(
            raw: <String, String>{
              'font-size': fontSize,
              'font-weight': valueFontWeight,
              'color': valueColor,
            },
          ),
          <Component>[Component.text(props.value)],
        ),
      ],
    );
  }
}
