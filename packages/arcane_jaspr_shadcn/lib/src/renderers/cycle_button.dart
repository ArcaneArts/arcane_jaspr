import 'dart:convert';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import 'package:arcane_jaspr/core/props/cycle_button_props.dart';
import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';

/// ShadCN Cycle Button renderer.
class ShadcnCycleButton<T> extends StatelessComponent {
  final CycleButtonProps<T> props;

  const ShadcnCycleButton(this.props);

  @override
  Component build(BuildContext context) {
    final List<CycleOption<T>> options = props.options;
    final int currentIndex = options.indexWhere((o) => o.value == props.value);
    final int safeIndex = currentIndex >= 0 ? currentIndex : 0;
    final CycleOption<T> currentOption = options[safeIndex];
    final String cycleId = props.id ?? 'cycle-${identityHashCode(props).toRadixString(36)}';

    final List<String> values = options.map((o) => o.value.toString()).toList();
    final List<String> labels = options.map((o) => o.label ?? o.value.toString()).toList();

    // Get size-specific styles
    final Map<String, String> sizeStyles = switch (props.size) {
      CycleButtonSize.small => {
        'height': '2rem',
        'padding': '0 0.75rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.medium => {
        'height': '2.5rem',
        'padding': '0 1rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.large => {
        'height': '2.75rem',
        'padding': '0 2rem',
        'font-size': 'var(--font-size-base)',
      },
      CycleButtonSize.icon => {
        'height': '2.5rem',
        'width': '2.5rem',
        'padding': '0',
      },
      CycleButtonSize.iconSmall => {
        'height': '2rem',
        'width': '2rem',
        'padding': '0',
      },
      CycleButtonSize.iconLarge => {
        'height': '2.75rem',
        'width': '2.75rem',
        'padding': '0',
      },
    };

    // Get variant-specific styles
    final Map<String, String> variantStyles = switch (props.variant) {
      CycleButtonVariant.outline => {
        'background-color': 'transparent',
        'color': 'var(--foreground)',
        'border': '1px solid var(--border)',
      },
      CycleButtonVariant.primary => {
        'background-color': 'var(--primary)',
        'color': 'var(--primary-foreground)',
        'border': 'none',
      },
      CycleButtonVariant.secondary => {
        'background-color': 'var(--secondary)',
        'color': 'var(--secondary-foreground)',
        'border': 'none',
      },
      CycleButtonVariant.ghost => {
        'background-color': 'transparent',
        'color': 'var(--foreground)',
        'border': 'none',
      },
      CycleButtonVariant.destructive => {
        'background-color': 'var(--destructive)',
        'color': 'var(--destructive-foreground)',
        'border': 'none',
      },
    };

    final ArcaneInteraction action = ArcaneInteraction.cycleNext(cycleId);

    final Map<String, String> attrs = <String, String>{
      'type': 'button',
      'data-arcane-cycle': cycleId,
      'data-arcane-cycle-active': safeIndex.toString(),
      'data-arcane-cycle-values': jsonEncode(values),
      'data-arcane-cycle-labels': jsonEncode(labels),
      'data-arcane-value': values[safeIndex],
      if (props.disabled) 'disabled': 'true',
      if (props.disabled) 'data-arcane-disabled': 'true',
      ...interactionAttrs(action),
      ...?props.attributes,
    };

    return button(
      id: props.id,
      classes: 'arcane-cycle-button ${props.disabled ? 'disabled' : ''}',
      attributes: attrs,
      styles: Styles(
        raw: <String, String>{
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': 'var(--space-2)',
          ...sizeStyles,
          'font-weight': 'var(--font-weight-medium)',
          'border-radius': 'var(--radius-sm)',
          ...variantStyles,
          'cursor': props.disabled ? 'not-allowed' : 'pointer',
          'opacity': props.disabled ? '0.5' : '1',
          'transition': 'all var(--transition)',
          'white-space': 'nowrap',
          ...?props.decoration?.universalStyles(),
          ...?props.styles?.toMap(),
        },
      ),
      events: props.onChanged == null
          ? null
          : <String, EventCallback>{
              'click': (event) {
                if (props.disabled) return;
                final int next = (safeIndex + 1) % options.length;
                props.onChanged!(options[next].value);
              },
            },
      <Component>[
        if (currentOption.icon != null) currentOption.icon!,
        span(
          classes: 'arcane-cycle-button-label',
          attributes: const <String, String>{'data-arcane-cycle-label': ''},
          [Component.text(currentOption.label ?? currentOption.value.toString())],
        ),
      ],
    );
  }
}

/// ShadCN Toggle Button renderer.
class ShadcnToggleButton extends StatelessComponent {
  final ToggleButtonProps props;

  const ShadcnToggleButton(this.props);

  @override
  Component build(BuildContext context) {
    final String groupId = props.id ?? 'toggle-${identityHashCode(props).toRadixString(36)}';
    final ArcaneInteraction action = ArcaneInteraction.toggleValue(groupId, 'on');

    // Get size-specific styles
    final Map<String, String> sizeStyles = switch (props.size) {
      CycleButtonSize.small => {
        'height': '2rem',
        'padding': '0 0.75rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.medium => {
        'height': '2.5rem',
        'padding': '0 1rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.large => {
        'height': '2.75rem',
        'padding': '0 2rem',
        'font-size': 'var(--font-size-base)',
      },
      CycleButtonSize.icon => {
        'height': '2.5rem',
        'width': '2.5rem',
        'padding': '0',
      },
      CycleButtonSize.iconSmall => {
        'height': '2rem',
        'width': '2rem',
        'padding': '0',
      },
      CycleButtonSize.iconLarge => {
        'height': '2.75rem',
        'width': '2.75rem',
        'padding': '0',
      },
    };

    final Map<String, String> attrs = <String, String>{
      'type': 'button',
      'aria-pressed': '${props.value}',
      'data-arcane-group': groupId,
      'data-arcane-group-mode': 'multi',
      'data-arcane-value': 'on',
      'data-arcane-state': props.value ? 'on' : 'off',
      if (props.value) 'data-arcane-selected': 'true',
      if (props.disabled) 'disabled': 'true',
      if (props.disabled) 'data-arcane-disabled': 'true',
      ...interactionAttrs(action),
      ...?props.attributes,
    };

    return button(
      id: props.id,
      classes:
          'arcane-toggle-button ${props.value ? 'active' : ''} ${props.disabled ? 'disabled' : ''}',
      attributes: attrs,
      styles: Styles(
        raw: <String, String>{
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': 'var(--space-2)',
          ...sizeStyles,
          'font-weight': 'var(--font-weight-medium)',
          'border-radius': 'var(--radius-sm)',
          // Active: primary background, inactive: muted background with border
          'background-color': props.value ? 'var(--primary)' : 'var(--muted)',
          'color': props.value ? 'var(--primary-foreground)' : 'var(--foreground)',
          'border': props.value ? 'none' : '1px solid var(--border)',
          'cursor': props.disabled ? 'not-allowed' : 'pointer',
          'opacity': props.disabled ? '0.5' : '1',
          'transition': 'all var(--transition)',
          ...?props.decoration?.universalStyles(),
          ...?props.styles?.toMap(),
        },
      ),
      events: props.onChanged == null
          ? null
          : <String, EventCallback>{
              'click': (event) {
                if (!props.disabled) {
                  props.onChanged!(!props.value);
                }
              },
            },
      <Component>[
        if (props.icon != null) props.icon!,
        if (props.label != null) Component.text(props.label!),
      ],
    );
  }
}
