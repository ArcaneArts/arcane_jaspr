import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/arcane.dart';
import '../../util/tools/styles.dart';

/// A component that centers its content both horizontally and vertically.
class CenterBody extends StatelessComponent {
  /// The child component
  final Component child;

  /// Maximum width of the content
  final double? maxWidth;

  /// Custom padding
  final EdgeInsets? padding;

  /// Whether to fill the entire viewport height
  final bool fillHeight;

  const CenterBody({
    required this.child,
    this.maxWidth,
    this.padding,
    this.fillHeight = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-center-body',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
        'justify-content': 'center',
        if (fillHeight) 'min-height': '100%',
        if (fillHeight) 'flex': '1',
        if (padding != null) 'padding': padding!.padding,
      }),
      [
        div(
          classes: 'arcane-center-body-content',
          styles: Styles(raw: {
            'width': '100%',
            if (maxWidth != null) 'max-width': '${maxWidth}px',
          }),
          [child],
        ),
      ],
    );
  }
}

/// A page-level centered content container
class PageBody extends StatelessComponent {
  final List<Component> children;
  final double maxWidth;
  final EdgeInsets? padding;

  const PageBody({
    required this.children,
    this.maxWidth = 1200,
    this.padding,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-page-body',
      styles: Styles(raw: {
        'width': '100%',
        'max-width': '${maxWidth}px',
        'margin': '0 auto',
        'padding': (padding ?? const EdgeInsets.all(16)).padding,
      }),
      children,
    );
  }
}

/// An empty state component for when there's no content
class EmptyState extends StatelessComponent {
  final String? title;
  final String? message;
  final Component? icon;
  final Component? action;

  const EmptyState({
    this.title,
    this.message,
    this.icon,
    this.action,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return CenterBody(
      child: div(
        classes: 'arcane-empty-state',
        styles: Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'align-items': 'center',
          'text-align': 'center',
          'padding': '48px 24px',
          'gap': '16px',
        }),
        [
          if (icon != null)
            div(
              styles: Styles(raw: {
                'color': 'var(--arcane-on-surface-variant)',
                'font-size': '3rem',
                'opacity': '0.5',
              }),
              [icon!],
            ),
          if (title != null)
            div(
              styles: Styles(raw: {
                'font-size': '1.25rem',
                'font-weight': '600',
                'color': 'var(--arcane-on-surface)',
              }),
              [text(title!)],
            ),
          if (message != null)
            div(
              styles: Styles(raw: {
                'font-size': '0.875rem',
                'color': 'var(--arcane-on-surface-variant)',
                'max-width': '400px',
              }),
              [text(message!)],
            ),
          if (action != null)
            div(
              styles: Styles(raw: {
                'margin-top': '8px',
              }),
              [action!],
            ),
        ],
      ),
    );
  }
}

/// A loading state component
class LoadingState extends StatelessComponent {
  final String? message;

  const LoadingState({
    this.message,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return CenterBody(
      child: div(
        classes: 'arcane-loading-state',
        styles: Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'align-items': 'center',
          'gap': '16px',
          'padding': '48px 24px',
        }),
        [
          // Spinner
          div(
            classes: 'arcane-loading-spinner',
            styles: Styles(raw: {
              'width': '40px',
              'height': '40px',
              'border': '3px solid var(--arcane-outline-variant)',
              'border-top-color': 'var(--arcane-primary)',
              'border-radius': '50%',
              'animation': 'arcane-spin 0.75s linear infinite',
            }),
            [],
          ),
          if (message != null)
            div(
              styles: Styles(raw: {
                'font-size': '0.875rem',
                'color': 'var(--arcane-on-surface-variant)',
              }),
              [text(message!)],
            ),
        ],
      ),
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-spin').styles(raw: {
      'from': 'transform: rotate(0deg)',
      'to': 'transform: rotate(360deg)',
    }),
  ];
}

/// An error state component
class ErrorState extends StatelessComponent {
  final String? title;
  final String? message;
  final Component? action;

  const ErrorState({
    this.title,
    this.message,
    this.action,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return CenterBody(
      child: div(
        classes: 'arcane-error-state',
        styles: Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'align-items': 'center',
          'text-align': 'center',
          'padding': '48px 24px',
          'gap': '16px',
        }),
        [
          // Error icon
          div(
            styles: Styles(raw: {
              'color': 'var(--arcane-error)',
              'font-size': '3rem',
            }),
            [text('⚠')],
          ),
          if (title != null)
            div(
              styles: Styles(raw: {
                'font-size': '1.25rem',
                'font-weight': '600',
                'color': 'var(--arcane-on-surface)',
              }),
              [text(title!)],
            ),
          if (message != null)
            div(
              styles: Styles(raw: {
                'font-size': '0.875rem',
                'color': 'var(--arcane-on-surface-variant)',
                'max-width': '400px',
              }),
              [text(message!)],
            ),
          if (action != null)
            div(
              styles: Styles(raw: {
                'margin-top': '8px',
              }),
              [action!],
            ),
        ],
      ),
    );
  }
}
