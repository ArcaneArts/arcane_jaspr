import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/empty_state_props.dart';
import 'package:arcane_jaspr/core/rendering/base/empty_state_render_base.dart';

/// ShadCN Empty State renderer.
///
/// Based on common empty state patterns seen in modern UI libraries.
class ShadcnEmptyState extends EmptyStateRenderBase {
  const ShadcnEmptyState(super.props, {super.key});

  (
    String iconSize,
    String titleSize,
    String descSize,
    String padding,
    String gap,
  )
  get _sizeStyles => switch (props.size) {
    EmptyStateSizeVariant.sm => ('32px', '1rem', '0.875rem', '1rem', '0.5rem'),
    EmptyStateSizeVariant.md => (
      '48px',
      '1.125rem',
      '1rem',
      '1.5rem',
      '0.75rem',
    ),
    EmptyStateSizeVariant.lg => ('64px', '1.25rem', '1.125rem', '2rem', '1rem'),
  };

  @override
  String get contentClass => 'arcane-empty-state';

  @override
  Map<String, String> get contentStyles {
    final (_, _, _, padding, gap) = _sizeStyles;
    return <String, String>{
      'display': 'flex',
      'flex-direction': 'column',
      'align-items': 'center',
      'justify-content': 'center',
      'text-align': 'center',
      'padding': padding,
      'gap': gap,
    };
  }

  @override
  String get iconClass => 'arcane-empty-state-icon';

  @override
  Map<String, String> get iconStyles {
    final (iconSize, _, _, _, _) = _sizeStyles;
    return <String, String>{
      'font-size': iconSize,
      'line-height': '1',
      'opacity': '0.6',
    };
  }

  @override
  String get actionsClass => 'arcane-empty-state-actions';

  @override
  Map<String, String> get actionsStyles => const <String, String>{
    'display': 'flex',
    'gap': 'var(--space-2)',
    'margin-top': '0.5rem',
  };

  @override
  List<Component> buildBody() {
    final (_, titleSize, descSize, _, _) = _sizeStyles;
    return <Component>[
      // Title
      dom.div(
        classes: 'arcane-empty-state-title',
        styles: dom.Styles(
          raw: <String, String>{
            'font-size': titleSize,
            'font-weight': 'var(--font-weight-semibold)',
            'color': 'var(--foreground)',
          },
        ),
        [Component.text(props.title)],
      ),

      // Description
      if (props.description != null)
        dom.div(
          classes: 'arcane-empty-state-description',
          styles: dom.Styles(
            raw: <String, String>{
              'font-size': descSize,
              'color': 'var(--muted-foreground)',
              'max-width': '360px',
            },
          ),
          [Component.text(props.description!)],
        ),
    ];
  }

  @override
  Component buildRoot(Component content, Map<String, String> extraStyles) {
    if (props.variant == EmptyStateStyleVariant.card) {
      return dom.div(
        classes: 'arcane-empty-state-card',
        attributes: const <String, String>{
          'data-arcane-surface': 'empty-state-card',
        },
        styles: dom.Styles(
          raw: <String, String>{
            'background-color': 'var(--card)',
            'border': '1px solid var(--border)',
            'border-radius': 'var(--radius-md)',
            ...extraStyles,
          },
        ),
        [content],
      );
    }

    if (extraStyles.isEmpty) return content;
    return dom.div(
      styles: dom.Styles(raw: <String, String>{...extraStyles}),
      <Component>[content],
    );
  }
}
