import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/dom_value.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/text_input_props.dart';

/// Shared structural base for themed text-input renderers.
///
/// Every theme renders an identical skeleton: an optional wrapper carrying a
/// label, the input (optionally nested inside a prefix/suffix container), and a
/// trailing error/helper line. The element tree, attribute wiring and the
/// input event handlers are byte-for-byte identical across themes; only the
/// style maps, the size scale, the class prefix and whether the borderless
/// inner input reflects its disabled/error state differ. Those are the abstract
/// members below.
///
/// This base lives in core and depends only on core props and interaction
/// helpers; it must never depend on a theme package.
abstract class TextInputRenderBase extends StatelessComponent {
  const TextInputRenderBase(this.props, {super.key});

  final TextInputProps props;

  /// Theme class prefix (e.g. `'arcane'`, `'neon'`, `'neubrutalism'`); used to
  /// build every emitted class such as `'$classPrefix-text-input'`.
  String get classPrefix;

  /// `gap` applied to the column wrapper.
  String get wrapperGap;

  /// Whether the borderless inner input (inside the prefix/suffix container)
  /// emits `data-disabled`/`data-error` attributes.
  bool get borderlessInputReflectsState;

  /// Size scale resolving to `(height, paddingX, paddingY, fontSize)`.
  (String, String, String, String) sizeValues(ComponentSize size);

  /// Styles for the standalone (bordered) input element.
  Map<String, String> inputStyles({
    required bool hasError,
    required bool isDisabled,
    required String height,
    required String paddingX,
    required String paddingY,
    required String fontSize,
  });

  /// Styles for the prefix/suffix container element.
  Map<String, String> containerStyles(bool hasError);

  /// Styles for the borderless input nested inside the container.
  Map<String, String> borderlessInputStyles({
    required bool isDisabled,
    required String height,
    required String paddingX,
    required String paddingY,
    required String fontSize,
  });

  /// Styles for the leading prefix span.
  Map<String, String> prefixStyles();

  /// Styles for the trailing suffix span.
  Map<String, String> suffixStyles();

  /// Per-instance decoration overrides. Default: none. A theme overrides this
  /// to translate an [ArcaneDecoration] (elevation intent, theme-specific
  /// fields) into its own CSS. Fields a theme does not implement are ignored.
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      const <String, String>{};

  @override
  Component build(BuildContext context) {
    final bool hasError = props.error != null;
    final bool hasWrapper =
        props.label != null ||
        props.error != null ||
        props.helperText != null ||
        props.prefix != null ||
        props.suffix != null;

    final (String height, String paddingX, String paddingY, String fontSize) =
        sizeValues(props.size);
    final Map<String, String> baseContainerStyles = containerStyles(hasError);
    final bool containerOwnsPerimeter =
        baseContainerStyles.containsKey('border') ||
        baseContainerStyles.containsKey('box-shadow');

    final dom.InputType inputType = switch (props.type) {
      TextInputType.text => dom.InputType.text,
      TextInputType.email => dom.InputType.email,
      TextInputType.password => dom.InputType.password,
      TextInputType.number => dom.InputType.number,
      TextInputType.tel => dom.InputType.tel,
      TextInputType.url => dom.InputType.url,
      TextInputType.search => dom.InputType.search,
    };

    final Map<String, String> runtimeAttrs = textInputAttrs(
      onChange: props.onChangeAction,
      onSubmit: props.onSubmitAction,
      formId: props.formId,
      fieldName: props.fieldName,
    );

    final Component inputElement = dom.input(
      type: inputType,
      id: props.id,
      name: props.name,
      classes: '$classPrefix-text-input',
      attributes: <String, String>{
        if (props.placeholder != null) 'placeholder': props.placeholder!,
        if (props.value != null) 'value': props.value!,
        if (props.disabled) 'disabled': 'true',
        if (props.required) 'required': 'true',
        if (props.readOnly) 'readonly': 'true',
        'data-disabled': '${props.disabled}',
        'data-error': '$hasError',
        ...runtimeAttrs,
        ...?props.attributes,
      },
      styles: dom.Styles(
        raw: <String, String>{
          ...inputStyles(
            hasError: hasError,
            isDisabled: props.disabled,
            height: height,
            paddingX: paddingX,
            paddingY: paddingY,
            fontSize: fontSize,
          ),
          ...?props.decoration?.universalStyles(),
          ...decorationStyles(props.decoration),
          ...?props.styles?.toMap(),
        },
      ),
      events: _inputEvents(),
    );

    if (!hasWrapper) {
      return dom.div(
        styles: dom.Styles(
          raw: <String, String>{if (props.fullWidth) 'width': '100%'},
        ),
        <Component>[inputElement],
      );
    }

    return dom.div(
      classes: '$classPrefix-text-input-wrapper',
      attributes: <String, String>{
        'data-disabled': '${props.disabled}',
        'data-error': '$hasError',
      },
      styles: dom.Styles(
        raw: <String, String>{
          'display': 'flex',
          'flex-direction': 'column',
          'gap': wrapperGap,
          if (props.fullWidth) 'width': '100%',
        },
      ),
      <Component>[
        if (props.label != null)
          Component.element(
            tag: 'label',
            attributes: props.id != null
                ? <String, String>{'for': props.id!}
                : null,
            styles: const dom.Styles(
              raw: <String, String>{
                'font-size': 'var(--font-size-sm)',
                'font-weight': 'var(--font-weight-medium)',
                'line-height': '1',
                'color': 'var(--foreground)',
              },
            ),
            children: <Component>[
              Component.text(props.label!),
              if (props.required)
                const dom.span(
                  styles: dom.Styles(
                    raw: <String, String>{
                      'color': 'var(--destructive)',
                      'margin-left': '0.25rem',
                    },
                  ),
                  <Component>[Component.text('*')],
                ),
            ],
          ),
        if (props.prefix != null || props.suffix != null)
          dom.div(
            classes: '$classPrefix-text-input-container',
            attributes: <String, String>{
              'data-disabled': '${props.disabled}',
              'data-error': '$hasError',
              if (containerOwnsPerimeter) 'data-arcane-field-shell': 'true',
            },
            styles: dom.Styles(
              raw: <String, String>{
                ...baseContainerStyles,
                ...?props.decoration?.universalStyles(),
                ...decorationStyles(props.decoration),
                ...?props.styles?.toMap(),
              },
            ),
            <Component>[
              if (props.prefix != null)
                dom.span(
                  classes: '$classPrefix-text-input-prefix',
                  styles: dom.Styles(raw: prefixStyles()),
                  <Component>[props.prefix!],
                ),
              dom.input(
                type: inputType,
                id: props.id,
                name: props.name,
                classes: '$classPrefix-text-input',
                attributes: <String, String>{
                  if (containerOwnsPerimeter)
                    'data-arcane-field-control': 'true',
                  if (containerOwnsPerimeter) 'data-arcane-field-inner': 'true',
                  if (props.placeholder != null)
                    'placeholder': props.placeholder!,
                  if (props.value != null) 'value': props.value!,
                  if (props.disabled) 'disabled': 'true',
                  if (props.required) 'required': 'true',
                  if (props.readOnly) 'readonly': 'true',
                  if (borderlessInputReflectsState)
                    'data-disabled': '${props.disabled}',
                  if (borderlessInputReflectsState) 'data-error': '$hasError',
                  ...runtimeAttrs,
                  ...?props.attributes,
                },
                styles: dom.Styles(
                  raw: borderlessInputStyles(
                    isDisabled: props.disabled,
                    height: height,
                    paddingX: paddingX,
                    paddingY: paddingY,
                    fontSize: fontSize,
                  ),
                ),
                events: _inputEvents(),
              ),
              if (props.suffix != null)
                dom.span(
                  classes: '$classPrefix-text-input-suffix',
                  styles: dom.Styles(raw: suffixStyles()),
                  <Component>[props.suffix!],
                ),
            ],
          )
        else
          inputElement,
        if (props.error != null)
          dom.span(
            classes: '$classPrefix-text-input-error',
            styles: const dom.Styles(
              raw: <String, String>{
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--destructive)',
              },
            ),
            <Component>[Component.text(props.error!)],
          )
        else if (props.helperText != null)
          dom.span(
            classes: '$classPrefix-text-input-helper',
            styles: const dom.Styles(
              raw: <String, String>{
                'font-size': 'var(--font-size-sm)',
                'color': 'var(--muted-foreground)',
              },
            ),
            <Component>[Component.text(props.helperText!)],
          ),
      ],
    );
  }

  /// Input event wiring shared by every theme (identical across all of them).
  Map<String, EventCallback> _inputEvents() {
    return <String, EventCallback>{
      if (props.onChanged != null)
        'input': (event) {
          props.onChanged!(domInputValue(event.target));
        },
      if (props.onFocus != null) 'focus': (event) => props.onFocus!(),
      if (props.onBlur != null) 'blur': (event) => props.onBlur!(),
      if (props.onSubmit != null)
        'keydown': (event) {
          if (domEventKey(event) == 'Enter') {
            props.onSubmit!(domInputValue(event.target));
          }
        },
    };
  }
}
