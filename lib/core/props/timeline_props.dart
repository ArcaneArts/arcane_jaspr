import 'package:arcane_jaspr/flutter.dart';

import '../shared/shared.dart';

export '../shared/shared.dart' show ComponentSize;

enum TimelineLayout {
  vertical,
  horizontal,
  alternating,
}

enum TimelineStatus {
  default_,
  complete,
  current,
  pending,
  error,
}

/// Timeline item data.
class TimelineItemData {
  final String title;
  final String? subtitle;
  final String? description;
  final String? date;
  final Widget? icon;
  final TimelineStatus status;
  final Widget? content;

  const TimelineItemData({
    required this.title,
    this.subtitle,
    this.description,
    this.date,
    this.icon,
    this.status = TimelineStatus.default_,
    this.content,
  });
}

/// Timeline component properties.
class TimelineProps {
  final List<TimelineItemData> items;
  final TimelineLayout layout;
  final ComponentSize size;
  final bool showConnectors;

  const TimelineProps({
    required this.items,
    this.layout = TimelineLayout.vertical,
    this.size = ComponentSize.md,
    this.showConnectors = true,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for timeline components.
mixin TimelineRendererContract {
  Widget timeline(TimelineProps props);
}
