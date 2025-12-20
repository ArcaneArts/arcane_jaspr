import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/arcane.dart';
import '../../util/tokens/tokens.dart';

/// A component that centers its content both horizontally and vertically.
class ArcaneCenterBody extends StatelessComponent {
  /// The child component
  final Component child;

  /// Maximum width of the content
  final double? maxWidth;

  /// Custom padding
  final EdgeInsets? padding;

  /// Whether to fill the entire viewport height
  final bool fillHeight;

  const ArcaneCenterBody({
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
class ArcanePageBody extends StatelessComponent {
  final List<Component> children;
  final double maxWidth;
  final EdgeInsets? padding;

  const ArcanePageBody({
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
class ArcaneEmptyState extends StatelessComponent {
  final String? title;
  final String? message;
  final Component? icon;
  final Component? action;

  const ArcaneEmptyState({
    this.title,
    this.message,
    this.icon,
    this.action,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneCenterBody(
      child: div(
        classes: 'arcane-empty-state',
        styles: const Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'align-items': 'center',
          'text-align': 'center',
          'padding': '${ArcaneSpacing.massive} ${ArcaneSpacing.xl}',
          'gap': ArcaneSpacing.lg,
        }),
        [
          if (icon != null)
            div(
              styles: const Styles(raw: {
                'color': ArcaneColors.muted,
                'font-size': ArcaneTypography.font4xl,
                'opacity': '0.5',
              }),
              [icon!],
            ),
          if (title != null)
            div(
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.fontXl,
                'font-weight': ArcaneTypography.weightSemibold,
                'color': ArcaneColors.onSurface,
              }),
              [text(title!)],
            ),
          if (message != null)
            div(
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.fontSm,
                'color': ArcaneColors.muted,
                'max-width': '400px',
              }),
              [text(message!)],
            ),
          if (action != null)
            div(
              styles: const Styles(raw: {
                'margin-top': ArcaneSpacing.sm,
              }),
              [action!],
            ),
        ],
      ),
    );
  }
}

/// A loading state component
class ArcaneLoadingState extends StatelessComponent {
  final String? message;

  const ArcaneLoadingState({
    this.message,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneCenterBody(
      child: div(
        classes: 'arcane-loading-state',
        styles: const Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'align-items': 'center',
          'gap': ArcaneSpacing.lg,
          'padding': '${ArcaneSpacing.massive} ${ArcaneSpacing.xl}',
        }),
        [
          // Spinner
          const div(
            classes: 'arcane-loading-spinner',
            styles: Styles(raw: {
              'width': '40px',
              'height': '40px',
              'border': '3px solid ${ArcaneColors.border}',
              'border-top-color': ArcaneColors.accent,
              'border-radius': ArcaneRadius.full,
              'animation': 'arcane-spin 0.75s linear infinite',
            }),
            [],
          ),
          if (message != null)
            div(
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.fontSm,
                'color': ArcaneColors.muted,
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
class ArcaneErrorState extends StatelessComponent {
  final String? title;
  final String? message;
  final Component? action;

  const ArcaneErrorState({
    this.title,
    this.message,
    this.action,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneCenterBody(
      child: div(
        classes: 'arcane-error-state',
        styles: const Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'align-items': 'center',
          'text-align': 'center',
          'padding': '${ArcaneSpacing.massive} ${ArcaneSpacing.xl}',
          'gap': ArcaneSpacing.lg,
        }),
        [
          // Error icon
          div(
            styles: const Styles(raw: {
              'color': ArcaneColors.error,
              'font-size': ArcaneTypography.font4xl,
            }),
            [text('⚠')],
          ),
          if (title != null)
            div(
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.fontXl,
                'font-weight': ArcaneTypography.weightSemibold,
                'color': ArcaneColors.onSurface,
              }),
              [text(title!)],
            ),
          if (message != null)
            div(
              styles: const Styles(raw: {
                'font-size': ArcaneTypography.fontSm,
                'color': ArcaneColors.muted,
                'max-width': '400px',
              }),
              [text(message!)],
            ),
          if (action != null)
            div(
              styles: const Styles(raw: {
                'margin-top': ArcaneSpacing.sm,
              }),
              [action!],
            ),
        ],
      ),
    );
  }
}