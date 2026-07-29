import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/rendering/base/style_layering.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/theme_provider.dart';

/// Shared structural base for themed button renderers.
///
/// Factors the identical build logic shared by every theme's button renderer
/// (children assembly, loading/disabled handling, the href-vs-button branch,
/// interaction wiring and the loading spinner) into one place. A concrete
/// theme renderer only supplies the value-producing members below: the root
/// CSS class, the arrow-indicator transition, and the base/variant/size style
/// maps.
///
/// This base lives in core and depends only on core props and interaction
/// helpers; it must never depend on a theme package.
abstract class ButtonRenderBase extends StatelessComponent {
  const ButtonRenderBase(this.props, {super.key});

  final ButtonProps props;

  /// CSS class applied to the root element (e.g. `'arcane-button'`).
  String get cssClass;

  /// `transition` value applied to the trailing arrow indicator span.
  String get arrowTransition;

  /// Base layout styles for the control; receives the resolved disabled flag.
  Map<String, String> baseStyles(bool isDisabled);

  /// Variant-specific visual styles (colors, borders, shadows).
  Map<String, String> variantStyles(ButtonVariant variant);

  /// Size-specific dimension styles.
  Map<String, String> sizeStyles(ButtonSize size);

  /// Per-instance decoration overrides. Default: none. A theme overrides this
  /// to translate an [ArcaneDecoration] (elevation intent, theme-specific
  /// fields) into its own CSS. Fields a theme does not implement are ignored.
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      const <String, String>{};

  @override
  Component build(BuildContext context) {
    final bool isDisabled = props.disabled || props.loading;

    final Map<String, String> allStyles = layerStyles(
      <String, String>{
        ...baseStyles(isDisabled),
        ...variantStyles(props.variant),
        ...sizeStyles(props.size),
        if (props.fullWidth) 'width': '100%',
      },
      <Map<String, String>?>[
        props.decoration?.universalStyles(),
        decorationStyles(props.decoration),
        props.styles?.toMap(),
      ],
    );

    final List<Component> children = <Component>[];

    if (props.loading) {
      children.add(
        context.renderers.loadingSpinner(
          const LoadingSpinnerProps(size: '1rem', color: 'currentColor'),
        ),
      );
    } else if (props.icon != null) {
      children.add(props.icon!);
    }

    if (props.label != null) {
      children.add(Component.text(props.label!));
    }

    if (props.child != null) {
      children.add(props.child!);
    }

    if (props.trailing != null && !props.loading) {
      children.add(props.trailing!);
    }

    if (props.showArrow && !props.loading) {
      children.add(
        dom.span(
          styles: dom.Styles(
            raw: <String, String>{
              'margin-left': '0.25rem',
              'transition': arrowTransition,
            },
          ),
          <Component>[ArcaneIcon.arrowRight(size: IconSize.sm)],
        ),
      );
    }

    final Map<String, String> baseAttributes = <String, String>{
      'data-state': props.loading ? 'loading' : 'idle',
      'data-disabled': '$isDisabled',
      'data-variant': props.variant.name,
      'data-size': props.size.name,
      ...?props.attributes,
    };
    final Map<String, String> actionAttrs = interactionAttrs(props.action);

    if (props.href != null) {
      return dom.a(
        id: props.id,
        classes: cssClass,
        href: props.href!,
        attributes: <String, String>{
          if (isDisabled) 'aria-disabled': 'true',
          ...baseAttributes,
          ...actionAttrs,
        },
        styles: dom.Styles(
          raw: <String, String>{'text-decoration': 'none', ...allStyles},
        ),
        events: <String, EventCallback>{
          if (props.onPressed != null)
            'click': (event) {
              if (!isDisabled) {
                props.onPressed!();
              }
            },
        },
        children,
      );
    }

    return dom.button(
      id: props.id,
      classes: cssClass,
      attributes: <String, String>{
        if (isDisabled) 'disabled': 'true',
        ...baseAttributes,
        'type': props.type.value,
        ...actionAttrs,
      },
      styles: dom.Styles(raw: allStyles),
      events: <String, EventCallback>{
        'click': (event) {
          if (!isDisabled && props.onPressed != null) {
            props.onPressed!();
          }
        },
      },
      children,
    );
  }
}
