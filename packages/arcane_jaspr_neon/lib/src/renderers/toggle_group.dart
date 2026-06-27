import 'package:arcane_jaspr/core/props/toggle_group_props.dart';
import 'package:arcane_jaspr/core/rendering/base/toggle_group_render_base.dart';

/// Neon toggle group renderer with restrained dark surfaces.
class NeonToggleGroup extends ToggleGroupRenderBase {
  const NeonToggleGroup(super.props, {super.key});

  @override
  String get cssClass => 'neon-toggle-group';

  @override
  String get itemBaseClass => 'neon-toggle-group-item';

  @override
  Map<String, String> get containerStyles => const <String, String>{
    'display': 'inline-flex',
    'align-items': 'center',
    'justify-content': 'center',
    'gap': '4px',
    'padding': '4px',
    'clip-path': 'var(--neon-clip-sm)',
    'background': 'var(--neon-panel-tint)',
    'border': '1px solid var(--neon-panel-border)',
    'box-shadow': 'inset 0 1px 0 var(--neon-inset)',
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
      ToggleGroupSizeVariant.sm => ('36px', '12px'),
      ToggleGroupSizeVariant.md => ('42px', '16px'),
      ToggleGroupSizeVariant.lg => ('48px', '20px'),
    };

    final Map<String, String> variantStyles = switch (props.variant) {
      ToggleGroupVariantStyle.defaultVariant => <String, String>{
        'border':
            '1px solid ${isSelected ? 'var(--neon-control-border-strong)' : 'transparent'}',
        'background': isSelected
            ? 'color-mix(in srgb, var(--neon-accent) 18%, var(--neon-surface-2))'
            : 'transparent',
        'box-shadow': isSelected
            ? '0 0 16px color-mix(in srgb, var(--neon-accent) 22%, transparent)'
            : 'none',
      },
      ToggleGroupVariantStyle.outline => <String, String>{
        'border': isSelected
            ? '1px solid var(--neon-control-border-strong)'
            : '1px solid var(--neon-control-border)',
        'background': isSelected
            ? 'color-mix(in srgb, var(--neon-accent) 14%, var(--neon-surface-1))'
            : 'var(--neon-surface-1)',
        'box-shadow': isSelected
            ? '0 0 16px color-mix(in srgb, var(--neon-accent) 22%, transparent)'
            : 'none',
      },
    };

    return <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'height': height,
      'min-width': height,
      'padding': '0 $paddingH',
      'clip-path': 'var(--neon-clip-xs)',
      'font-family': 'var(--font-heading)',
      'font-size': 'var(--font-size-sm)',
      'font-weight': 'var(--font-weight-semibold)',
      'letter-spacing': '0.04em',
      'color': isSelected ? 'var(--neon-accent)' : 'var(--foreground)',
      'cursor': isDisabled ? 'not-allowed' : 'pointer',
      'pointer-events': isDisabled ? 'none' : 'auto',
      'opacity': isDisabled ? '0.5' : '1',
      'transition':
          'background 200ms ease, border-color 200ms ease, color 200ms ease, box-shadow 200ms ease',
      ...variantStyles,
    };
  }
}
