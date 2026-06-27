import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/rendering/base/calendar_render_base.dart';

/// Neon calendar component with restrained dark styling.
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
  dom.Styles get styles => const dom.Styles(
    raw: <String, String>{
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '0.5rem',
      'padding': '0.75rem',
      'background-color': 'var(--surface, #0b0d12)',
      'border': '1px solid var(--border, rgba(80, 200, 255, 0.18))',
      'border-radius': '0.75rem',
      'box-shadow':
          '0 0 30px rgba(80, 200, 255, 0.08), 0 0 0 1px rgba(80, 200, 255, 0.04)',
      'color': 'var(--foreground, #e0e6f0)',
      'width': 'min(100%, 20rem)',
    },
  );
}
