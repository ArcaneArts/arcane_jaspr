import 'package:arcane_jaspr/core/rendering/base/accordion_render_base.dart';

/// Neon Accordion renderer.
///
/// Uses native HTML details/summary elements for reliable expand/collapse
/// behavior that works in SSR environments without JavaScript hydration issues.
///
/// Implements the Neon design language:
/// - Clean card-based items with subtle borders
/// - Accent-colored chevron buttons
/// - Smooth CSS transitions
///
/// Supports two variants:
/// - `standard`: Basic accordion with toggle icons
/// - `faq`: FAQ-style with category badges and accent colors
class NeonAccordion extends AccordionRenderBase {
  const NeonAccordion(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  String get accentColorFallback => 'var(--neon-accent)';

  @override
  Map<String, String> detailsStyles() => const <String, String>{
    'background': 'var(--neon-panel-surface)',
    'border': '1px solid var(--neon-panel-border)',
    'clip-path': 'var(--neon-clip-md)',
    'box-shadow': 'var(--neon-shadow-sm), inset 0 1px 0 var(--neon-inset)',
    'overflow': 'hidden',
  };

  @override
  Map<String, String> categoryBadgeStyles(String accentColor) =>
      <String, String>{
        'font-family': 'var(--font-heading)',
        'font-size': '0.625rem',
        'font-weight': 'var(--font-weight-semibold)',
        'color': accentColor,
        'background': 'color-mix(in srgb, $accentColor 14%, transparent)',
        'border': '1px solid color-mix(in srgb, $accentColor 38%, transparent)',
        'clip-path': 'var(--neon-clip-xs)',
        'padding': '0.25rem 0.625rem',
        'text-transform': 'uppercase',
        'letter-spacing': '0.08em',
      };

  @override
  Map<String, String> chevronStyles(String accentColor) => <String, String>{
    'display': 'flex',
    'align-items': 'center',
    'justify-content': 'center',
    'width': '28px',
    'height': '28px',
    'clip-path': 'var(--neon-clip-xs)',
    'background': 'color-mix(in srgb, $accentColor 12%, transparent)',
    'border': '1px solid color-mix(in srgb, $accentColor 28%, transparent)',
    'color': accentColor,
    'flex-shrink': '0',
    'transition': 'transform 200ms ease, background 200ms ease',
  };

  @override
  String get contentBorderTop =>
      '1px solid color-mix(in srgb, var(--neon-panel-border) 60%, transparent)';
}
