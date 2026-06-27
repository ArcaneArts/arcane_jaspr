import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/empty_state_props.dart';
import 'package:arcane_jaspr/core/rendering/base/empty_state_render_base.dart';

/// Neon Empty State renderer.
///
/// Implements the Neon design language:
/// - Larger spacing
/// - Card variant with subtle border
/// - Accent-colored icon
class NeonEmptyState extends EmptyStateRenderBase {
  const NeonEmptyState(super.props, {super.key});

  // Neon sizes
  (String iconSize, String titleSize, String descSize, String gap)
  get _sizeStyles => switch (props.size) {
    EmptyStateSizeVariant.sm => ('48px', '1rem', '0.8125rem', '0.75rem'),
    EmptyStateSizeVariant.md => (
      '64px',
      '1.25rem',
      '0.875rem',
      '1rem',
    ), // Neon: larger
    EmptyStateSizeVariant.lg => ('80px', '1.5rem', '1rem', '1.25rem'),
  };

  @override
  String get contentClass => 'neon-empty-state-content';

  @override
  Map<String, String> get contentStyles {
    final (_, _, _, gap) = _sizeStyles;
    return <String, String>{
      'display': 'flex',
      'flex-direction': props.style == EmptyStateStyleVariant.compact
          ? 'row'
          : 'column',
      'align-items': 'center',
      'text-align': props.style == EmptyStateStyleVariant.compact
          ? 'left'
          : 'center',
      'gap': gap,
      if (props.style == EmptyStateStyleVariant.compact) 'text-align': 'left',
    };
  }

  @override
  String get iconClass => 'neon-empty-state-icon';

  @override
  Map<String, String> get iconStyles {
    final (iconSize, _, _, _) = _sizeStyles;
    return <String, String>{
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'center',
      'width': iconSize,
      'height': iconSize,
      'color': 'var(--neon-accent)',
      'flex-shrink': '0',
      'filter':
          'drop-shadow(0 0 18px color-mix(in srgb, var(--neon-accent) 32%, transparent))',
    };
  }

  @override
  String get actionsClass => 'neon-empty-state-actions';

  @override
  Map<String, String> get actionsStyles => <String, String>{
    'display': 'flex',
    'gap': '0.75rem', // Neon: more gap
    'margin-top': props.style == EmptyStateStyleVariant.compact
        ? '0'
        : '0.5rem',
    if (props.style == EmptyStateStyleVariant.compact) 'margin-left': 'auto',
  };

  @override
  List<Component> buildBody() {
    final (_, titleSize, descSize, _) = _sizeStyles;
    return <Component>[
      // Text content
      dom.div(
        classes: 'neon-empty-state-text',
        styles: const dom.Styles(
          raw: <String, String>{
            'display': 'flex',
            'flex-direction': 'column',
            'gap': 'var(--space-2)',
          },
        ),
        [
          // Title
          dom.h3(
            classes: 'neon-empty-state-title',
            styles: dom.Styles(
              raw: <String, String>{
                'font-family': 'var(--font-heading)',
                'font-size': titleSize,
                'font-weight': 'var(--font-weight-semibold)',
                'letter-spacing': '0.04em',
                'color': 'var(--foreground)',
                'margin': '0',
              },
            ),
            [Component.text(props.title)],
          ),

          // Description
          if (props.description != null)
            dom.p(
              classes: 'neon-empty-state-description',
              styles: dom.Styles(
                raw: <String, String>{
                  'font-size': descSize,
                  'color': 'var(--muted-foreground)',
                  'margin': '0',
                  'max-width': '400px',
                  'line-height': '1.5',
                },
              ),
              [Component.text(props.description!)],
            ),
        ],
      ),
    ];
  }

  @override
  Component buildRoot(Component content) {
    // Wrap in card if variant is card
    if (props.style == EmptyStateStyleVariant.card) {
      return dom.div(
        classes: 'neon-empty-state neon-empty-state-card',
        styles: const dom.Styles(
          raw: <String, String>{
            'padding': '2.5rem',
            'background': 'var(--neon-panel-surface)',
            'border': '1px solid var(--neon-panel-border)',
            'clip-path': 'var(--neon-clip-md)',
            'box-shadow':
                'var(--neon-shadow-md), inset 0 1px 0 var(--neon-inset)',
          },
        ),
        [content],
      );
    }

    return dom.div(
      classes: 'neon-empty-state',
      styles: dom.Styles(
        raw: <String, String>{
          'padding': props.style == EmptyStateStyleVariant.compact
              ? '1rem'
              : '2rem', // Neon: more padding
        },
      ),
      [content],
    );
  }
}
