import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/props/calendar_props.dart';
import 'package:arcane_jaspr/core/rendering/calendar_markup.dart';

/// Shared structural base for themed calendar renderers.
///
/// Every theme's calendar renders the identical markup produced by
/// [buildCalendarMarkup]; the only per-theme variation is the set of CSS
/// classes applied to the root/nav/today/day elements and the root inline
/// styles. This base factors the [buildCalendarMarkup] call into one place and
/// leaves those value-producing members to the concrete subclass.
///
/// This base lives in core and depends only on core props and the shared
/// calendar markup; it must never depend on a theme package.
abstract class CalendarRenderBase extends StatelessComponent {
  const CalendarRenderBase(this.props, {super.key});

  final CalendarProps props;

  /// CSS classes applied to the calendar root element.
  String get classes;

  /// Extra CSS classes appended to every navigation button.
  String get navButtonClasses;

  /// Extra CSS classes appended to the "today" button.
  String get todayButtonClasses;

  /// Extra CSS classes appended to every day button.
  String get dayButtonClasses;

  /// Inline styles for the calendar root element.
  Map<String, String> get styles;

  /// Per-instance decoration overrides. Default: none. A theme overrides this
  /// to translate an [ArcaneDecoration] (elevation intent, theme-specific
  /// fields) into its own CSS. Fields a theme does not implement are ignored.
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      const <String, String>{};

  @override
  Component build(BuildContext context) {
    final Map<String, String> merged = <String, String>{
      ...styles,
      ...?props.decoration?.universalStyles(),
      ...decorationStyles(props.decoration),
      ...?props.styles?.toMap(),
    };

    return buildCalendarMarkup(
      props,
      classes: classes,
      navButtonClasses: navButtonClasses,
      todayButtonClasses: todayButtonClasses,
      dayButtonClasses: dayButtonClasses,
      styles: dom.Styles(raw: merged),
    );
  }
}
