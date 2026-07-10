import 'package:arcane_jaspr/core/rendering/base/calendar_render_base.dart';

/// ShadCN-style calendar component
/// Reference: https://ui.shadcn.com/docs/components/calendar
class ShadcnCalendar extends CalendarRenderBase {
  const ShadcnCalendar(super.props, {super.key});

  @override
  String get classes => 'arcane-calendar';

  @override
  String get navButtonClasses => '';

  @override
  String get todayButtonClasses => '';

  @override
  String get dayButtonClasses => '';

  @override
  Map<String, String> get styles => const <String, String>{
    'display': 'flex',
    'flex-direction': 'column',
    'gap': 'var(--space-2)',
    'padding': '12px',
    'background-color': 'var(--card)',
    'border': '1px solid var(--border)',
    'border-radius': 'var(--radius-md)',
    'width': 'min(100%, 20rem)',
  };
}
