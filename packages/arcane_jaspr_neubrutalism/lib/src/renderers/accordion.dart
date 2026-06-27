import 'package:arcane_jaspr/core/rendering/base/accordion_render_base.dart';

/// Neubrutalism Accordion renderer.
///
/// Uses native HTML details/summary elements for reliable expand/collapse
/// behavior that works in SSR environments without JavaScript hydration issues.
///
/// Implements the Neubrutalism design language:
/// - Clean card-based items with subtle borders
/// - Accent-colored chevron buttons
/// - Smooth CSS transitions
///
/// Supports two variants:
/// - `standard`: Basic accordion with toggle icons
/// - `faq`: FAQ-style with category badges and accent colors
class NeubrutalismAccordion extends AccordionRenderBase {
  const NeubrutalismAccordion(super.props, {super.key});

  @override
  String get classPrefix => 'neubrutalism';

  @override
  String get accentColorFallback => 'var(--nb-accent, var(--primary))';

  @override
  Map<String, String> detailsStyles() => const <String, String>{
    'background': 'var(--nb-paper, var(--card))',
    'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
    'box-shadow': 'var(--nb-shadow-sm, 3px 3px 0 0 var(--nb-shadow-color, #000))',
    'overflow': 'hidden',
  };

  @override
  Map<String, String> categoryBadgeStyles(String accentColor) =>
      <String, String>{
        'font-family': 'var(--font-heading)',
        'font-size': '0.625rem',
        'font-weight': 'var(--font-weight-semibold)',
        'color': accentColor,
        'background': 'var(--nb-paper-soft, var(--card))',
        'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
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
    'background': 'var(--nb-paper-soft, var(--card))',
    'border': 'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
    'color': accentColor,
    'flex-shrink': '0',
    'transition': 'transform 200ms ease, background 200ms ease',
  };

  @override
  String get contentBorderTop =>
      'var(--nb-border-thin, 2px) solid var(--nb-line, #000)';
}
