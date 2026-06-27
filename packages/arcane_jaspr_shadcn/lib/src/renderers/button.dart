import 'package:arcane_jaspr/core/props/button_props.dart';
import 'package:arcane_jaspr/core/rendering/base/button_render_base.dart';

/// ShadCN Button renderer.
///
/// Outputs the exact HTML structure and CSS classes from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/button
class ShadcnButton extends ButtonRenderBase {
  const ShadcnButton(super.props, {super.key});

  @override
  String get cssClass => 'arcane-button';

  @override
  String get arrowTransition => 'transform var(--transition)';

  // ShadCN base classes (from cva buttonVariants).
  @override
  Map<String, String> baseStyles(bool isDisabled) => <String, String>{
    'display': 'inline-flex',
    'align-items': 'center',
    'justify-content': 'center',
    'gap': 'var(--space-2)',
    'white-space': 'nowrap',
    'border-radius': 'var(--radius)',
    'font-size': 'var(--font-size-sm)',
    'font-weight': 'var(--font-weight-medium)',
    'line-height': '1.25rem',
    'transition':
        'color var(--transition), background-color var(--transition), border-color var(--transition), box-shadow var(--transition)',
    'outline': 'none',
    'cursor': isDisabled ? 'not-allowed' : 'pointer',
    'pointer-events': isDisabled ? 'none' : 'auto',
    'opacity': isDisabled ? '0.5' : '1',
    'user-select': 'none',
    '-webkit-user-select': 'none',
  };

  @override
  Map<String, String> variantStyles(ButtonVariant variant) => switch (variant) {
    ButtonVariant.primary => <String, String>{
      'background-color': 'var(--primary)',
      'color': 'var(--primary-foreground)',
      'border': 'none',
    },
    ButtonVariant.destructive => <String, String>{
      'background-color': 'var(--destructive)',
      'color': 'var(--destructive-foreground)',
      'border': 'none',
    },
    ButtonVariant.outline => <String, String>{
      'background-color': 'var(--background)',
      'color': 'var(--foreground)',
      'border': '1px solid var(--input)',
    },
    ButtonVariant.secondary => <String, String>{
      'background-color': 'var(--secondary)',
      'color': 'var(--secondary-foreground)',
      'border': 'none',
    },
    ButtonVariant.ghost => <String, String>{
      'background-color': 'transparent',
      'color': 'var(--foreground)',
      'border': 'none',
    },
    ButtonVariant.link => <String, String>{
      'background-color': 'transparent',
      'color': 'var(--primary)',
      'border': 'none',
      'text-underline-offset': '4px',
      'padding': '0',
      'height': 'auto',
    },
    ButtonVariant.success => <String, String>{
      'background-color': 'var(--success, #22c55e)',
      'color': 'var(--success-foreground, #ffffff)',
      'border': 'none',
    },
    ButtonVariant.warning => <String, String>{
      'background-color': 'var(--warning, #f59e0b)',
      'color': 'var(--warning-foreground, #000000)',
      'border': 'none',
    },
    ButtonVariant.info => <String, String>{
      'background-color': 'var(--info, #3b82f6)',
      'color': 'var(--info-foreground, #ffffff)',
      'border': 'none',
    },
    ButtonVariant.accent => <String, String>{
      'background-color': 'var(--accent)',
      'color': 'var(--accent-foreground)',
      'border': 'none',
    },
  };

  @override
  Map<String, String> sizeStyles(ButtonSize size) => switch (size) {
    ButtonSize.sm => <String, String>{
      'height': '2.25rem',
      'padding': '0 0.75rem',
    },
    ButtonSize.md => <String, String>{
      'height': '2.5rem',
      'padding': '0.5rem 1rem',
    },
    ButtonSize.lg => <String, String>{'height': '2.75rem', 'padding': '0 2rem'},
    ButtonSize.iconSm => <String, String>{
      'height': '2.25rem',
      'width': '2.25rem',
      'padding': '0',
    },
    ButtonSize.iconMd => <String, String>{
      'height': '2.5rem',
      'width': '2.5rem',
      'padding': '0',
    },
    ButtonSize.iconLg => <String, String>{
      'height': '2.75rem',
      'width': '2.75rem',
      'padding': '0',
    },
  };
}
