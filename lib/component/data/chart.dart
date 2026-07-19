import 'package:arcane_jaspr/flutter.dart';

import '../../core/theme_provider.dart';

class ArcaneChartPoint {
  final String label;
  final num value;

  const ArcaneChartPoint({required this.label, required this.value});
}

class ArcaneChart extends StatelessWidget {
  final List<ArcaneChartPoint> points;
  final String? title;
  final String? description;
  final String color;

  const ArcaneChart({
    required this.points,
    this.title,
    this.description,
    this.color = 'var(--primary)',
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final List<ChartPointProps> mappedPoints = points
        .map(
          (ArcaneChartPoint point) =>
              ChartPointProps(label: point.label, value: point.value),
        )
        .toList();

    return context.renderers.chart(
      ChartProps(
        points: mappedPoints,
        title: title,
        description: description,
        color: color,
      ),
    );
  }
}
