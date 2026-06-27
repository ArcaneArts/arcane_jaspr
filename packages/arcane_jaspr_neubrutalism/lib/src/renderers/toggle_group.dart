import 'package:arcane_jaspr/core/props/toggle_group_props.dart';
import 'package:arcane_jaspr/core/rendering/base/toggle_group_render_base.dart';

class NeubrutalismToggleGroup extends ToggleGroupRenderBase {
  const NeubrutalismToggleGroup(super.props, {super.key});

  @override
  String get cssClass => 'neubrutalism-toggle-group';

  @override
  String get itemBaseClass => 'neubrutalism-toggle-group-item';

  @override
  Map<String, String> get containerStyles => const <String, String>{
    'display': 'inline-flex',
    'align-items': 'center',
    'justify-content': 'center',
    'gap': '4px',
    'padding': '4px',
    'background': 'var(--nb-paper, var(--card))',
    'border': 'var(--nb-border-base, 3px) solid var(--nb-line, #000)',
    'border-radius': 'var(--nb-radius-soft, 4px)',
    'box-shadow': 'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
  };

  @override
  Map<String, String> extraRootAttrs() => <String, String>{
    'data-disabled': '${props.disabled}',
    'data-variant': props.variant.name,
    'data-size': props.size.name,
  };

  @override
  Map<String, String> extraItemAttrs(bool isSelected, bool isDisabled) =>
      <String, String>{
        'data-state': isSelected ? 'on' : 'off',
        'data-disabled': '$isDisabled',
      };

  @override
  Map<String, String> itemStyles(bool isSelected, bool isDisabled) {
    final (String height, String paddingH) = switch (props.size) {
      ToggleGroupSizeVariant.sm => ('32px', '12px'),
      ToggleGroupSizeVariant.md => ('38px', '16px'),
      ToggleGroupSizeVariant.lg => ('44px', '20px'),
    };

    final Map<String, String> variantStyles = isSelected
        ? <String, String>{
            'background': 'var(--nb-accent, var(--primary))',
            'color': 'var(--nb-on-accent, #000)',
            'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
            'box-shadow':
                'var(--nb-shadow-xs, 2px 2px 0 0 var(--nb-shadow-color, #000))',
          }
        : <String, String>{
            'background': 'transparent',
            'color': 'var(--foreground)',
            'border': 'var(--nb-border-thin, 2px) solid transparent',
            'box-shadow': 'none',
          };

    return <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'height': height,
      'min-width': height,
      'padding': '0 $paddingH',
      'font-family': 'var(--font-heading)',
      'font-size': 'var(--font-size-sm)',
      'font-weight': '800',
      'letter-spacing': '0.02em',
      'border-radius': 'var(--nb-radius-soft, 4px)',
      'cursor': isDisabled ? 'not-allowed' : 'pointer',
      'pointer-events': isDisabled ? 'none' : 'auto',
      'opacity': isDisabled ? '0.5' : '1',
      'transition':
          'transform var(--nb-transition, 120ms ease), box-shadow var(--nb-transition, 120ms ease), background-color var(--nb-transition, 120ms ease), color var(--nb-transition, 120ms ease)',
      ...variantStyles,
    };
  }
}
