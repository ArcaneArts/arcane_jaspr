import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

export '../../core/props/spec_row_props.dart';

/// A specification row displaying a label-value pair.
///
/// Commonly used in pricing cards for displaying specifications
/// like RAM, storage, CPU, etc.
class ArcaneSpecRow extends StatelessWidget {
  final String label;
  final String value;
  final bool highlight;
  final String? labelColor;
  final String? valueColor;
  final String? fontSize;

  const ArcaneSpecRow({
    required this.label,
    required this.value,
    this.highlight = false,
    this.labelColor,
    this.valueColor,
    this.fontSize,
    super.key,
  });

  /// Creates a highlighted spec row (value uses primary color).
  const ArcaneSpecRow.highlight({
    required this.label,
    required this.value,
    this.labelColor,
    this.valueColor,
    this.fontSize,
    super.key,
  }) : highlight = true;

  @override
  Widget build(BuildContext context) {
    return context.renderers.specRow(SpecRowProps(
      label: label,
      value: value,
      highlight: highlight,
      labelColor: labelColor,
      valueColor: valueColor,
      fontSize: fontSize,
    ));
  }
}
