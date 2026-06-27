import 'package:arcane_jaspr/core/props/kbd_props.dart';
import 'package:arcane_jaspr/core/rendering/base/kbd_render_base.dart';

/// ShadCN-styled keyboard shortcut display component
class ShadcnKbd extends KbdRenderBase {
  const ShadcnKbd(super.props, {super.key});

  @override
  String? get kbdClasses => null;

  @override
  String get keysWrapperGap => 'var(--space-1)';

  (String padding, String fontSize, String minWidth) get _sizeStyles =>
      switch (props.size) {
        ComponentSize.sm => ('2px 5px', '0.75rem', '20px'),
        ComponentSize.md => ('4px 8px', '0.875rem', '24px'),
        ComponentSize.lg => ('6px 12px', '1rem', '32px'),
      };

  @override
  Map<String, String> get styleMap {
    final (padding, fontSize, minWidth) = _sizeStyles;

    final baseStyles = {
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'min-width': minWidth,
      'padding': padding,
      'font-size': fontSize,
      'font-family':
          'var(--font-mono, ui-monospace, SFMono-Regular, "SF Mono", Menlo, Consolas, monospace)',
      'font-weight': 'var(--font-weight-medium)',
      'line-height': '1',
      'white-space': 'nowrap',
      'user-select': 'none',
    };

    return switch (props.style) {
      KbdStyle.raised => {
        ...baseStyles,
        'background':
            'linear-gradient(180deg, var(--muted) 0%, var(--card) 100%)',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--arcane-radius-xs, 0.25rem)',
        'box-shadow':
            '0 2px 0 var(--border), inset 0 1px 0 rgba(var(--foreground-rgb), 0.1)',
        'color': 'var(--foreground)',
      },
      KbdStyle.flat => {
        ...baseStyles,
        'background': 'var(--muted)',
        'border': 'none',
        'border-radius': 'var(--arcane-radius-xs, 0.25rem)',
        'color': 'var(--foreground)',
      },
      KbdStyle.outline => {
        ...baseStyles,
        'background': 'transparent',
        'border': '1px solid var(--border)',
        'border-radius': 'var(--arcane-radius-xs, 0.25rem)',
        'color': 'var(--muted-foreground)',
      },
    };
  }
}
