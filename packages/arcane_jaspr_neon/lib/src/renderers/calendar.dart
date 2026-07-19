import 'package:arcane_jaspr/core/rendering/base/calendar_render_base.dart';

/// Neon calendar renderer (neutralized skeleton).
class NeonCalendar extends CalendarRenderBase {
  const NeonCalendar(super.props, {super.key});

  @override
  String get classes => 'arcane-calendar arcane-calendar--neon';

  @override
  String get navButtonClasses => 'neon-calendar-nav-btn';

  @override
  String get todayButtonClasses => 'neon-calendar-today-btn';

  @override
  String get dayButtonClasses => 'neon-calendar-day';

  @override
  Map<String, String> get rootStyles => const <String, String>{};
}
