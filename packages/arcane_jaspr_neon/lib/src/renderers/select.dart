import 'package:arcane_jaspr/core/rendering/base/select_render_base.dart';

/// Neon Select renderer.
class NeonSelect<T> extends SelectRenderBase<T> {
  const NeonSelect(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  String get surfaceIdPrefix => 'neon-select-';

  @override
  String get requiredAsteriskColor => 'var(--neon-accent)';

  @override
  String get controlBorderColor => 'var(--neon-control-border)';

  @override
  Map<String, String> triggerStyles(
    String height,
    String padding,
    String fontSize,
    String triggerColor,
    String borderColor,
  ) {
    final bool hasError = props.error != null;
    final String glowColor = hasError
        ? '0 0 0 2px color-mix(in srgb, var(--destructive) 24%, transparent)'
        : 'none';
    return <String, String>{
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'space-between',
      'width': '100%',
      'height': height,
      'padding': padding,
      'background':
          'linear-gradient(135deg, color-mix(in srgb, var(--neon-accent) 5%, transparent), color-mix(in srgb, var(--card) 86%, transparent))',
      'border': '1px solid $borderColor',
      'clip-path': 'var(--neon-control-clip)',
      'font-size': fontSize,
      'color': triggerColor,
      'cursor': props.disabled ? 'not-allowed' : 'pointer',
      'outline': 'none',
      'box-shadow': glowColor,
      'transition': 'border-color 0.18s ease, box-shadow 0.18s ease',
      if (props.disabled) 'opacity': '0.4',
    };
  }

  @override
  Map<String, String> dropdownStyles(String maxHeight) => <String, String>{
    'z-index': '50',
    'min-width': '100%',
    'max-height': maxHeight,
    'overflow-y': 'auto',
    'background': 'color-mix(in srgb, var(--card) 92%, transparent)',
    'border': '1px solid var(--neon-panel-border)',
    'clip-path': 'var(--neon-clip-sm)',
    'box-shadow': 'var(--neon-glow-md)',
  };

  @override
  Map<String, String> get searchWrapperStyles => const <String, String>{
    'padding': '0.625rem',
    'border-bottom': '1px solid var(--neon-panel-border)',
  };

  @override
  Map<String, String> get searchInputStyles => const <String, String>{
    'width': '100%',
    'padding': '0.5rem 0.75rem',
    'background': 'color-mix(in srgb, var(--card) 70%, transparent)',
    'border': '1px solid var(--neon-control-border)',
    'clip-path': 'var(--neon-clip-xs)',
    'font-size': 'var(--font-size-sm)',
    'color': 'var(--foreground)',
    'outline': 'none',
    'transition': 'border-color 0.18s ease',
  };

  @override
  Map<String, String> optionStyles(bool isSelected, bool isDisabled) =>
      <String, String>{
        'display': 'flex',
        'align-items': 'center',
        'gap': '0.75rem',
        'width': '100%',
        'padding': '0.625rem 0.875rem',
        'background': isSelected ? 'var(--neon-accent-soft)' : 'transparent',
        'border': 'none',
        'clip-path': 'var(--neon-clip-xs)',
        'font-size': 'var(--font-size-sm)',
        'color': isSelected ? 'var(--neon-accent)' : 'var(--foreground)',
        'text-align': 'left',
        'cursor': isDisabled ? 'not-allowed' : 'pointer',
        'transition': 'background 0.15s ease, color 0.15s ease',
        if (isDisabled) 'opacity': '0.4',
      };

  @override
  Map<String, String> optionCheckboxStyles(bool isSelected) => <String, String>{
    'width': '18px',
    'height': '18px',
    'clip-path': 'var(--neon-clip-xs)',
    'border': isSelected
        ? '1px solid var(--neon-accent)'
        : '1px solid var(--neon-control-border)',
    'background': isSelected ? 'var(--neon-accent)' : 'transparent',
    'display': 'flex',
    'align-items': 'center',
    'justify-content': 'center',
    'flex-shrink': '0',
    'transition': 'background 0.15s ease, border-color 0.15s ease',
  };

  @override
  String get optionCheckColor => 'var(--neon-on-accent)';

  @override
  String optionIconColor(bool isSelected) =>
      isSelected ? 'var(--neon-accent)' : 'var(--muted-foreground)';
}
