import 'package:arcane_jaspr/core/props/toggle_group_props.dart';
import 'package:arcane_jaspr/core/rendering/base/toggle_group_render_base.dart';

/// ShadCN-style toggle group component
/// Reference: https://ui.shadcn.com/docs/components/toggle-group
class ShadcnToggleGroup extends ToggleGroupRenderBase {
  const ShadcnToggleGroup(super.props, {super.key});

  @override
  String get cssClass => 'arcane-toggle-group';

  @override
  String get itemBaseClass => 'arcane-toggle-group-item';

  @override
  Map<String, String> get containerStyles => const <String, String>{
    'display': 'inline-flex',
    'align-items': 'center',
    'justify-content': 'center',
    'border-radius': 'var(--radius-sm)',
    'background-color': 'transparent',
    'gap': 'var(--space-1)',
  };

  @override
  Map<String, String> extraRootAttrs() => const <String, String>{};

  @override
  Map<String, String> extraItemAttrs(bool isSelected, bool isDisabled) =>
      const <String, String>{};

  @override
  Map<String, String> itemStyles(bool isSelected, bool isDisabled) {
    final (String height, String paddingH) = switch (props.size) {
      ToggleGroupSizeVariant.sm => ('36px', '10px'),
      ToggleGroupSizeVariant.md => ('40px', '12px'),
      ToggleGroupSizeVariant.lg => ('44px', '20px'),
    };

    final Map<String, String> variantStyles = switch (props.variant) {
      ToggleGroupVariantStyle.defaultVariant => <String, String>{
        'border': 'none',
      },
      ToggleGroupVariantStyle.outline => <String, String>{
        'border': '1px solid var(--input)',
        'background-color': isSelected ? 'var(--accent)' : 'transparent',
      },
    };

    return <String, String>{
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'height': height,
      'padding': '0 $paddingH',
      'min-width': height,
      'border-radius': 'var(--radius-sm)',
      'font-size': 'var(--font-size-sm)',
      'font-weight': 'var(--font-weight-medium)',
      'background-color': isSelected ? 'var(--accent)' : 'transparent',
      'color': isSelected ? 'var(--accent-foreground)' : 'var(--foreground)',
      'transition':
          'color var(--transition), background-color var(--transition)',
      'cursor': isDisabled ? 'not-allowed' : 'pointer',
      'pointer-events': isDisabled ? 'none' : 'auto',
      'opacity': isDisabled ? '0.5' : '1',
      ...variantStyles,
    };
  }
}
