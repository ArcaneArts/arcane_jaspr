import 'package:arcane_jaspr/core/rendering/base/calendar_render_base.dart';

/// Win95 calendar renderer (neutralized skeleton).
class Win95Calendar extends CalendarRenderBase {
  const Win95Calendar(super.props, {super.key});

  @override
  String get classes => 'arcane-calendar arcane-calendar--win95';

  @override
  String get navButtonClasses => 'win95-calendar-nav-btn';

  @override
  String get todayButtonClasses => 'win95-calendar-today-btn';

  @override
  String get dayButtonClasses => 'win95-calendar-day';

  @override
  Map<String, String> get rootStyles => const <String, String>{};
}
