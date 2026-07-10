import 'dart:convert';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/props/cycle_button_props.dart';
import 'package:arcane_jaspr/core/interaction/interaction.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';

/// Shared structural base for the neon/neubrutalism cycle-button renderers.
///
/// These two themes render an identical button — the cycle id derivation, the
/// `data-arcane-cycle-*` attribute payload, the click-to-advance event wiring
/// and the icon/label/indicator children all match byte-for-byte. They diverge
/// only in the class prefix, the optional `clip-path`, the per-variant style map
/// and the indicator color, which are exposed as abstract members.
///
/// The ShadCN cycle button is structurally divergent (a different attribute set,
/// a different style ordering, no rotate indicator and different sizing) and is
/// left standalone.
///
/// This base lives in core and depends only on core props and interaction
/// helpers; it must never depend on a theme package.
abstract class CycleButtonRenderBase<T> extends StatelessComponent {
  const CycleButtonRenderBase(this.props);

  final CycleButtonProps<T> props;

  /// Theme class prefix (e.g. `'neon'`, `'neubrutalism'`).
  String get classPrefix;

  /// Theme-specific clip styling (neon adds a `clip-path`; neubrutalism none).
  Map<String, String> get clipStyles;

  /// Per-variant visual styles for the button.
  Map<String, String> variantStyles(CycleButtonVariant variant);

  /// Color of the trailing rotate indicator glyph.
  String get indicatorColor;

  /// Per-instance decoration overrides. Default: none. A theme overrides this
  /// to translate an [ArcaneDecoration] (elevation intent, theme-specific
  /// fields) into its own CSS. Fields a theme does not implement are ignored.
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      const <String, String>{};

  @override
  Component build(BuildContext context) {
    final List<CycleOption<T>> options = props.options;
    final int currentIndex = options.indexWhere((o) => o.value == props.value);
    final int safeIndex = currentIndex >= 0 ? currentIndex : 0;
    final CycleOption<T> currentOption = options[safeIndex];
    final String cycleId =
        props.id ?? 'cycle-${identityHashCode(props).toRadixString(36)}';

    final List<String> values = options.map((o) => o.value.toString()).toList();
    final List<String> labels = options
        .map((o) => o.label ?? o.value.toString())
        .toList();

    final Map<String, String> sizeStyles = _cycleButtonSizeStyles(props.size);
    final ArcaneInteraction action = ArcaneInteraction.cycleNext(cycleId);

    final Map<String, String> attrs = <String, String>{
      'type': 'button',
      'data-state': 'idle',
      'data-disabled': '${props.disabled}',
      'data-variant': props.variant.name,
      'data-size': props.size.name,
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

    return dom.button(
      id: props.id,
      classes: '$classPrefix-cycle-button ${props.disabled ? 'disabled' : ''}',
      attributes: attrs,
      styles: dom.Styles(
        raw: <String, String>{
          'display': 'inline-flex',
          'align-items': 'center',
          'justify-content': 'center',
          'gap': '0.6rem',
          ...sizeStyles,
          'font-family': 'var(--font-heading)',
          'font-weight': 'var(--font-weight-semibold)',
          'letter-spacing': '0.06em',
          ...clipStyles,
          'cursor': props.disabled ? 'not-allowed' : 'pointer',
          'opacity': props.disabled ? '0.5' : '1',
          'transition':
              'background 200ms ease, border-color 200ms ease, color 200ms ease, transform 200ms ease',
          ...variantStyles(props.variant),
          ...?props.decoration?.universalStyles(),
          ...decorationStyles(props.decoration),
          ...?props.styles?.toMap(),
        },
      ),
      events: props.disabled || props.onChanged == null
          ? null
          : <String, EventCallback>{
              'click': (_) {
                final int next = (safeIndex + 1) % options.length;
                props.onChanged!(options[next].value);
              },
            },
      <Component>[
        if (currentOption.icon != null) currentOption.icon!,
        dom.span(
          classes: '$classPrefix-cycle-button-label',
          attributes: const <String, String>{'data-arcane-cycle-label': ''},
          <Component>[
            Component.text(currentOption.label ?? currentOption.value.toString()),
          ],
        ),
        dom.span(
          classes: '$classPrefix-cycle-button-indicator',
          styles: dom.Styles(
            raw: <String, String>{
              'font-size': '0.78em',
              'opacity': '0.65',
              'color': indicatorColor,
            },
          ),
          <Component>[const Component.text('\u21bb')],
        ),
      ],
    );
  }
}

/// Shared structural base for the neon/neubrutalism toggle-button renderers.
///
/// The group id derivation, the `data-arcane-group`/`aria-pressed` attribute
/// payload, the toggle event wiring and the icon/label children are identical;
/// only the class prefix and the full style map (theme-specific key sets) differ.
abstract class ToggleButtonRenderBase extends StatelessComponent {
  const ToggleButtonRenderBase(this.props);

  final ToggleButtonProps props;

  /// Theme class prefix (e.g. `'neon'`, `'neubrutalism'`).
  String get classPrefix;

  /// Full inline style map for the toggle; receives the shared [sizeStyles].
  Map<String, String> toggleStyles(Map<String, String> sizeStyles);

  /// Per-instance decoration overrides. Default: none. A theme overrides this
  /// to translate an [ArcaneDecoration] (elevation intent, theme-specific
  /// fields) into its own CSS. Fields a theme does not implement are ignored.
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      const <String, String>{};

  @override
  Component build(BuildContext context) {
    final String groupId =
        props.id ?? 'toggle-${identityHashCode(props).toRadixString(36)}';
    final ArcaneInteraction action = ArcaneInteraction.toggleValue(
      groupId,
      'on',
    );
    final Map<String, String> sizeStyles = _cycleButtonSizeStyles(props.size);

    final Map<String, String> attrs = <String, String>{
      'type': 'button',
      'aria-pressed': '${props.value}',
      'data-state': props.value ? 'on' : 'off',
      'data-disabled': '${props.disabled}',
      'data-arcane-group': groupId,
      'data-arcane-group-mode': 'multi',
      'data-arcane-value': 'on',
      if (props.value) 'data-arcane-selected': 'true',
      if (props.disabled) 'disabled': 'true',
      if (props.disabled) 'data-arcane-disabled': 'true',
      ...interactionAttrs(action),
      ...?props.attributes,
    };

    return dom.button(
      id: props.id,
      classes:
          '$classPrefix-toggle-button ${props.value ? 'active' : ''} ${props.disabled ? 'disabled' : ''}',
      attributes: attrs,
      styles: dom.Styles(
        raw: <String, String>{
          ...toggleStyles(sizeStyles),
          ...?props.decoration?.universalStyles(),
          ...decorationStyles(props.decoration),
          ...?props.styles?.toMap(),
        },
      ),
      events: props.disabled || props.onChanged == null
          ? null
          : <String, EventCallback>{
              'click': (_) => props.onChanged!(!props.value),
            },
      <Component>[
        if (props.icon != null) props.icon!,
        if (props.label != null) Component.text(props.label!),
      ],
    );
  }
}

/// Size styles shared by the neon/neubrutalism cycle and toggle buttons.
Map<String, String> _cycleButtonSizeStyles(CycleButtonSize size) =>
    switch (size) {
      CycleButtonSize.small => const <String, String>{
        'height': '2.25rem',
        'padding': '0 0.9rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.medium => const <String, String>{
        'height': '2.6rem',
        'padding': '0 1.1rem',
        'font-size': 'var(--font-size-sm)',
      },
      CycleButtonSize.large => const <String, String>{
        'height': '3rem',
        'padding': '0 1.4rem',
        'font-size': 'var(--font-size-base)',
      },
      CycleButtonSize.icon => const <String, String>{
        'height': '2.6rem',
        'width': '2.6rem',
        'padding': '0',
      },
      CycleButtonSize.iconSmall => const <String, String>{
        'height': '2.25rem',
        'width': '2.25rem',
        'padding': '0',
      },
      CycleButtonSize.iconLarge => const <String, String>{
        'height': '3rem',
        'width': '3rem',
        'padding': '0',
      },
    };
