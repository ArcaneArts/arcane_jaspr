library;

import 'interaction.dart';

Map<String, String> interactionAttrs(ArcaneInteraction? action) {
  if (action == null) return const <String, String>{};
  final String encoded = encodeArcaneAction(action);
  if (encoded.isEmpty) return const <String, String>{};
  return <String, String>{'data-arcane-action': encoded};
}

Map<String, String> interactionEventAttrs({
  ArcaneInteraction? onClick,
  ArcaneInteraction? onChange,
  ArcaneInteraction? onSubmit,
  ArcaneInteraction? onDoubleClick,
  ArcaneInteraction? onContextMenu,
  ArcaneInteraction? onMouseEnter,
  ArcaneInteraction? onMouseLeave,
  ArcaneInteraction? onFocus,
  ArcaneInteraction? onBlur,
  ArcaneInteraction? onKeyDown,
  ArcaneInteraction? onLongPress,
}) {
  final Map<String, String> out = <String, String>{};
  if (onClick != null) {
    out['data-arcane-action'] = encodeArcaneAction(onClick);
  }
  if (onChange != null) {
    out['data-arcane-change'] = encodeArcaneAction(onChange);
  }
  if (onSubmit != null) {
    out['data-arcane-submit'] = encodeArcaneAction(onSubmit);
  }
  if (onDoubleClick != null) {
    out['data-arcane-dblclick'] = encodeArcaneAction(onDoubleClick);
  }
  if (onContextMenu != null) {
    out['data-arcane-contextmenu'] = encodeArcaneAction(onContextMenu);
  }
  if (onMouseEnter != null) {
    out['data-arcane-mouseenter'] = encodeArcaneAction(onMouseEnter);
  }
  if (onMouseLeave != null) {
    out['data-arcane-mouseleave'] = encodeArcaneAction(onMouseLeave);
  }
  if (onFocus != null) {
    out['data-arcane-focus'] = encodeArcaneAction(onFocus);
  }
  if (onBlur != null) {
    out['data-arcane-blur'] = encodeArcaneAction(onBlur);
  }
  if (onKeyDown != null) {
    out['data-arcane-keydown'] = encodeArcaneAction(onKeyDown);
  }
  if (onLongPress != null) {
    out['data-arcane-longpress'] = encodeArcaneAction(onLongPress);
  }
  return out;
}

Map<String, String> surfaceAttrs({
  required String surface,
  required String id,
  bool initiallyOpen = false,
  bool dismissible = true,
  bool escapeCloses = true,
  bool focusTrap = true,
  bool scrimCloses = true,
  bool restoreFocus = true,
  String? anchorId,
  String? anchorPlacement,
  String? anchorOffset,
  String? anchorAlign,
  String? animation,
  String? group,
  bool exclusive = false,
}) {
  final Map<String, String> out = <String, String>{
    'data-arcane-surface': surface,
    'data-arcane-id': id,
    'data-arcane-state': initiallyOpen ? 'open' : 'closed',
  };
  if (!dismissible) out['data-arcane-dismissible'] = 'false';
  if (!escapeCloses) out['data-arcane-escape-closes'] = 'false';
  if (!focusTrap) out['data-arcane-focus-trap'] = 'false';
  if (!scrimCloses) out['data-arcane-scrim-closes'] = 'false';
  if (!restoreFocus) out['data-arcane-restore-focus'] = 'false';
  if (anchorId != null && anchorId.isNotEmpty) {
    out['data-arcane-anchor'] = anchorId;
  }
  if (anchorPlacement != null && anchorPlacement.isNotEmpty) {
    out['data-arcane-anchor-placement'] = anchorPlacement;
  }
  if (anchorOffset != null && anchorOffset.isNotEmpty) {
    out['data-arcane-anchor-offset'] = anchorOffset;
  }
  if (anchorAlign != null && anchorAlign.isNotEmpty) {
    out['data-arcane-anchor-align'] = anchorAlign;
  }
  if (animation != null && animation.isNotEmpty) {
    out['data-arcane-animation'] = animation;
  }
  if (group != null && group.isNotEmpty) {
    out['data-arcane-surface-group'] = group;
  }
  if (exclusive) out['data-arcane-exclusive'] = 'true';
  if (!initiallyOpen) out['hidden'] = '';
  return out;
}

Map<String, String> groupAttrs({
  required String groupId,
  String mode = 'single',
  String? value,
  bool? required,
  bool? disabled,
  String? minSelections,
  String? maxSelections,
  String? changeAction,
}) {
  final Map<String, String> out = <String, String>{
    'data-arcane-group': groupId,
    'data-arcane-group-mode': mode,
  };
  if (value != null && value.isNotEmpty) {
    out['data-arcane-group-value'] = value;
  }
  if (required == true) out['data-arcane-group-required'] = 'true';
  if (disabled == true) out['data-arcane-group-disabled'] = 'true';
  if (minSelections != null) {
    out['data-arcane-group-min'] = minSelections;
  }
  if (maxSelections != null) {
    out['data-arcane-group-max'] = maxSelections;
  }
  if (changeAction != null && changeAction.isNotEmpty) {
    out['data-arcane-group-change'] = changeAction;
  }
  return out;
}

Map<String, String> groupItemAttrs({
  required String groupId,
  required String value,
  bool selected = false,
  bool disabled = false,
}) {
  final Map<String, String> out = <String, String>{
    'data-arcane-group': groupId,
    'data-arcane-value': value,
    'data-arcane-state': selected ? 'selected' : 'unselected',
  };
  if (disabled) out['data-arcane-disabled'] = 'true';
  return out;
}

Map<String, String> tabsAttrs({
  required String groupId,
  required String activeTab,
  String orientation = 'horizontal',
}) {
  return <String, String>{
    'data-arcane-tabs-group': groupId,
    'data-arcane-tabs-active': activeTab,
    'data-arcane-tabs-orientation': orientation,
  };
}

Map<String, String> tabTriggerAttrs({
  required String groupId,
  required String tabId,
  bool active = false,
  bool disabled = false,
}) {
  final Map<String, String> out = <String, String>{
    'data-arcane-tabs-group': groupId,
    'data-arcane-tab': tabId,
    'data-arcane-state': active ? 'active' : 'inactive',
    'role': 'tab',
    'aria-selected': active ? 'true' : 'false',
    'tabindex': active ? '0' : '-1',
  };
  if (disabled) out['data-arcane-disabled'] = 'true';
  return out;
}

Map<String, String> tabPanelAttrs({
  required String groupId,
  required String tabId,
  bool active = false,
}) {
  final Map<String, String> out = <String, String>{
    'data-arcane-tabs-group': groupId,
    'data-arcane-tab-panel': tabId,
    'data-arcane-state': active ? 'active' : 'inactive',
    'role': 'tabpanel',
  };
  if (!active) out['hidden'] = '';
  return out;
}

Map<String, String> panelAttrs({
  required String groupId,
  required String panelId,
  bool expanded = false,
  bool exclusive = false,
}) {
  final Map<String, String> out = <String, String>{
    'data-arcane-panel-group': groupId,
    'data-arcane-panel': panelId,
    'data-arcane-state': expanded ? 'expanded' : 'collapsed',
    'aria-expanded': expanded ? 'true' : 'false',
  };
  if (exclusive) out['data-arcane-panel-exclusive'] = 'true';
  return out;
}

Map<String, String> panelContentAttrs({
  required String groupId,
  required String panelId,
  bool expanded = false,
}) {
  final Map<String, String> out = <String, String>{
    'data-arcane-panel-group': groupId,
    'data-arcane-panel-content': panelId,
    'data-arcane-state': expanded ? 'expanded' : 'collapsed',
  };
  if (!expanded) out['hidden'] = '';
  return out;
}

Map<String, String> stepperAttrs({
  required String groupId,
  required int activeStep,
  required int stepCount,
  bool linear = true,
}) {
  return <String, String>{
    'data-arcane-stepper': groupId,
    'data-arcane-step-active': activeStep.toString(),
    'data-arcane-step-count': stepCount.toString(),
    if (linear) 'data-arcane-step-linear': 'true',
  };
}

Map<String, String> stepAttrs({
  required String groupId,
  required int index,
  bool active = false,
  bool completed = false,
}) {
  return <String, String>{
    'data-arcane-stepper': groupId,
    'data-arcane-step': index.toString(),
    'data-arcane-state': active
        ? 'active'
        : (completed ? 'completed' : 'pending'),
  };
}

Map<String, String> paginationAttrs({
  required String groupId,
  required int activePage,
  required int pageCount,
}) {
  return <String, String>{
    'data-arcane-pagination': groupId,
    'data-arcane-page-active': activePage.toString(),
    'data-arcane-page-count': pageCount.toString(),
  };
}

Map<String, String> carouselAttrs({
  required String groupId,
  required int activeIndex,
  required int slideCount,
  bool loop = false,
  String? autoplayMs,
}) {
  final Map<String, String> out = <String, String>{
    'data-arcane-carousel': groupId,
    'data-arcane-carousel-active': activeIndex.toString(),
    'data-arcane-carousel-count': slideCount.toString(),
  };
  if (loop) out['data-arcane-carousel-loop'] = 'true';
  if (autoplayMs != null) {
    out['data-arcane-carousel-autoplay'] = autoplayMs;
  }
  return out;
}

Map<String, String> carouselSlideAttrs({
  required String groupId,
  required int index,
  bool active = false,
}) {
  return <String, String>{
    'data-arcane-carousel': groupId,
    'data-arcane-carousel-slide': index.toString(),
    'data-arcane-state': active ? 'active' : 'inactive',
  };
}

Map<String, String> sliderAttrs({
  required String sliderId,
  required double min,
  required double max,
  double? value,
  double? lo,
  double? hi,
  double? step,
  bool range = false,
  bool disabled = false,
  String? changeAction,
}) {
  final Map<String, String> out = <String, String>{
    'data-arcane-slider': sliderId,
    'data-arcane-slider-min': _trimNumber(min),
    'data-arcane-slider-max': _trimNumber(max),
  };
  if (range) {
    out['data-arcane-slider-range'] = 'true';
    out['data-arcane-slider-lo'] = _trimNumber(lo ?? min);
    out['data-arcane-slider-hi'] = _trimNumber(hi ?? max);
  } else {
    out['data-arcane-slider-value'] = _trimNumber(value ?? min);
  }
  if (step != null && step > 0) {
    out['data-arcane-slider-step'] = _trimNumber(step);
  }
  if (disabled) out['data-arcane-disabled'] = 'true';
  if (changeAction != null && changeAction.isNotEmpty) {
    out['data-arcane-slider-change'] = changeAction;
  }
  return out;
}

String _trimNumber(double n) {
  if (n == n.truncateToDouble()) return n.toInt().toString();
  return n.toString();
}

Map<String, String> formAttrs({
  required String formId,
  String? endpoint,
  String? method,
  bool resetOnSubmit = false,
}) {
  final Map<String, String> out = <String, String>{
    'data-arcane-form': formId,
  };
  if (endpoint != null && endpoint.isNotEmpty) {
    out['data-arcane-form-endpoint'] = endpoint;
  }
  if (method != null && method.isNotEmpty) {
    out['data-arcane-form-method'] = method;
  }
  if (resetOnSubmit) {
    out['data-arcane-form-reset-on-submit'] = 'true';
  }
  return out;
}

Map<String, String> fieldAttrs({
  required String formId,
  required String name,
  String? value,
  bool required = false,
  bool disabled = false,
  String? type,
  String? validate,
}) {
  final Map<String, String> out = <String, String>{
    'data-arcane-form': formId,
    'data-arcane-field': name,
    'data-arcane-field-value': ?value,
  };
  if (required) out['data-arcane-field-required'] = 'true';
  if (disabled) out['data-arcane-field-disabled'] = 'true';
  if (type != null && type.isNotEmpty) {
    out['data-arcane-field-type'] = type;
  }
  if (validate != null && validate.isNotEmpty) {
    out['data-arcane-field-validate'] = validate;
  }
  return out;
}

Map<String, String> anchorAttrs(String anchorId) =>
    <String, String>{'data-arcane-anchor-id': anchorId};

Map<String, String> dismissAttrs() =>
    <String, String>{'data-arcane-action': 'surface.dismiss'};

Map<String, String> calendarAttrs({
  required String calendarId,
  required int year,
  required int month,
  String mode = 'single',
  DateTime? selected,
  DateTime? rangeStart,
  DateTime? rangeEnd,
  DateTime? minDate,
  DateTime? maxDate,
  bool showWeekNumbers = false,
  bool showToday = true,
  int firstDayOfWeek = 0,
}) {
  final Map<String, String> out = <String, String>{
    'data-arcane-calendar': '',
    'data-arcane-id': calendarId,
    'data-arcane-mode': mode,
    'data-arcane-year': year.toString(),
    'data-arcane-month': month.toString(),
    'data-arcane-first-day': firstDayOfWeek.toString(),
  };
  if (showWeekNumbers) out['data-arcane-show-week-numbers'] = 'true';
  if (!showToday) out['data-arcane-show-today'] = 'false';
  if (selected != null) out['data-arcane-selected'] = _isoDate(selected);
  if (rangeStart != null) out['data-arcane-range-start'] = _isoDate(rangeStart);
  if (rangeEnd != null) out['data-arcane-range-end'] = _isoDate(rangeEnd);
  if (minDate != null) out['data-arcane-min'] = _isoDate(minDate);
  if (maxDate != null) out['data-arcane-max'] = _isoDate(maxDate);
  return out;
}

String _isoDate(DateTime d) {
  final String y = d.year.toString().padLeft(4, '0');
  final String m = d.month.toString().padLeft(2, '0');
  final String day = d.day.toString().padLeft(2, '0');
  return '$y-$m-$day';
}

Map<String, String> calendarTriggerAttrs(String calendarId) =>
    <String, String>{'data-arcane-calendar-trigger': calendarId};

Map<String, String> calendarPickerAttrs(String calendarId) =>
    <String, String>{'data-arcane-calendar-anchor': calendarId};

Map<String, String> timePickerAttrs({
  required String pickerId,
  bool use24Hour = false,
  bool clearable = true,
  String? placeholder,
  String? value,
}) {
  final Map<String, String> out = <String, String>{
    'data-arcane-time-picker': pickerId,
    'data-arcane-time-24h': use24Hour ? 'true' : 'false',
    'data-arcane-time-clearable': clearable ? 'true' : 'false',
  };
  if (placeholder != null && placeholder.isNotEmpty) {
    out['data-arcane-time-placeholder'] = placeholder;
  }
  if (value != null && value.isNotEmpty) {
    out['data-arcane-time-value'] = value;
  }
  return out;
}

Map<String, String> timePickerDisplayAttrs() =>
    const <String, String>{'data-arcane-time-display': ''};

Map<String, String> timePickerClearAttrs() =>
    const <String, String>{'data-arcane-time-clear': ''};

Map<String, String> textInputAttrs({
  ArcaneInteraction? onChange,
  ArcaneInteraction? onSubmit,
  String? formId,
  String? fieldName,
  String? fieldType,
  String? fieldValidate,
  bool required = false,
  bool disabled = false,
}) {
  final Map<String, String> out = <String, String>{};
  if (onChange != null) {
    out['data-arcane-input'] = encodeArcaneAction(onChange);
    out['data-arcane-change'] = encodeArcaneAction(onChange);
  }
  if (onSubmit != null) {
    out['data-arcane-submit'] = encodeArcaneAction(onSubmit);
  }
  if (formId != null && formId.isNotEmpty &&
      fieldName != null && fieldName.isNotEmpty) {
    out['data-arcane-form'] = formId;
    out['data-arcane-field'] = fieldName;
    if (required) out['data-arcane-field-required'] = 'true';
    if (disabled) out['data-arcane-field-disabled'] = 'true';
    if (fieldType != null && fieldType.isNotEmpty) {
      out['data-arcane-field-type'] = fieldType;
    }
    if (fieldValidate != null && fieldValidate.isNotEmpty) {
      out['data-arcane-field-validate'] = fieldValidate;
    }
  }
  return out;
}

Map<String, String> mergeAttrs(List<Map<String, String>> attrs) {
  final Map<String, String> out = <String, String>{};
  for (final Map<String, String> map in attrs) {
    for (final MapEntry<String, String> entry in map.entries) {
      if (entry.key == 'class' && out.containsKey('class')) {
        out['class'] = '${out['class']} ${entry.value}';
      } else {
        out[entry.key] = entry.value;
      }
    }
  }
  return out;
}
