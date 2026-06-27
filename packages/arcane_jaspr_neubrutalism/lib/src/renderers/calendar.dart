import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/rendering/base/calendar_render_base.dart';

/// Neubrutalism calendar component with restrained dark styling.
class NeubrutalismCalendar extends CalendarRenderBase {
  const NeubrutalismCalendar(super.props, {super.key});

  @override
  String get classes =>
      'arcane-calendar arcane-calendar--neubrutalism neubrutalism-calendar';

  @override
  String get navButtonClasses => 'neubrutalism-calendar-nav-btn';

  @override
  String get todayButtonClasses => 'neubrutalism-calendar-today-btn';

  @override
  String get dayButtonClasses => 'neubrutalism-calendar-day';

  @override
  dom.Styles get styles => const dom.Styles(
    raw: <String, String>{
      'display': 'flex',
      'flex-direction': 'column',
      'gap': '0.5rem',
      'padding': '0.75rem',
      'background': 'var(--nb-paper, var(--card))',
      'border': 'var(--nb-border-thick, 3px) solid var(--nb-line, #000)',
      'box-shadow':
          'var(--nb-shadow-md, 5px 5px 0 0 var(--nb-shadow-color, #000))',
      'color': 'var(--nb-ink, var(--foreground))',
      'width': 'min(100%, 20rem)',
    },
  );
}
