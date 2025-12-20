import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/arcane.dart';
import '../../util/tokens/tokens.dart';

/// Back button display mode
enum BarBackButtonMode {
  always,
  never,
  auto,
}

/// An app bar / header component.
class ArcaneBar extends StatelessComponent {
  /// Title text
  final String? titleText;

  /// Title component (overrides titleText)
  final Component? title;

  /// Subtitle text
  final String? subtitleText;

  /// Subtitle component (overrides subtitleText)
  final Component? subtitle;

  /// Leading components
  final List<Component>? leading;

  /// Trailing components
  final List<Component>? trailing;

  /// Back button mode
  final BarBackButtonMode backButton;

  /// Custom back button handler
  final void Function()? onBack;

  /// Whether the bar is transparent
  final bool transparent;

  /// Whether to center the title
  final bool centerTitle;

  /// Custom height
  final double? height;

  /// Custom padding
  final EdgeInsets? padding;

  const ArcaneBar({
    this.titleText,
    this.title,
    this.subtitleText,
    this.subtitle,
    this.leading,
    this.trailing,
    this.backButton = BarBackButtonMode.auto,
    this.onBack,
    this.transparent = false,
    this.centerTitle = false,
    this.height,
    this.padding,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final double effectiveHeight = height ?? 56.0;
    final EdgeInsets effectivePadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 16);

    // Build title section
    final Component? titleWidget = title ??
        (titleText != null
            ? span(
                classes: 'arcane-bar-title',
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontLg,
                  'font-weight': ArcaneTypography.weightSemibold,
                  'color': ArcaneColors.onSurface,
                  'white-space': 'nowrap',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                }),
                [text(titleText!)],
              )
            : null);

    final Component? subtitleWidget = subtitle ??
        (subtitleText != null
            ? span(
                classes: 'arcane-bar-subtitle',
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontXs,
                  'color': ArcaneColors.muted,
                  'white-space': 'nowrap',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                }),
                [text(subtitleText!)],
              )
            : null);

    // Show back button?
    final bool showBack = backButton == BarBackButtonMode.always ||
        (backButton == BarBackButtonMode.auto && onBack != null);

    return header(
      classes: 'arcane-bar ${transparent ? 'transparent' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.md,
        'height': '${effectiveHeight}px',
        'padding': effectivePadding.padding,
        'background-color':
            transparent ? ArcaneColors.transparent : ArcaneColors.surface,
        if (!transparent)
          'border-bottom': '1px solid ${ArcaneColors.border}',
        'flex-shrink': '0',
      }),
      [
        // Leading section
        if (showBack || (leading != null && leading!.isNotEmpty))
          div(
            classes: 'arcane-bar-leading',
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': ArcaneSpacing.sm,
            }),
            [
              if (showBack) _buildBackButton(context),
              ...?leading,
            ],
          ),

        // Title section
        div(
          classes: 'arcane-bar-content',
          styles: Styles(raw: {
            'flex': '1',
            'display': 'flex',
            'flex-direction': 'column',
            'justify-content': 'center',
            'min-width': '0',
            if (centerTitle) 'align-items': 'center',
          }),
          [
            if (titleWidget != null) titleWidget,
            if (subtitleWidget != null) subtitleWidget,
          ],
        ),

        // Trailing section
        if (trailing != null && trailing!.isNotEmpty)
          div(
            classes: 'arcane-bar-trailing',
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': ArcaneSpacing.sm,
            }),
            trailing!,
          ),
      ],
    );
  }

  Component _buildBackButton(BuildContext context) {
    return button(
      classes: 'arcane-bar-back',
      attributes: {'type': 'button', 'aria-label': 'Go back'},
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '36px',
        'height': '36px',
        'border-radius': ArcaneRadius.full,
        'background': ArcaneColors.transparent,
        'border': 'none',
        'color': ArcaneColors.onSurface,
        'cursor': 'pointer',
        'transition': ArcaneEffects.transitionFast,
      }),
      events: {
        'click': (event) {
          if (onBack != null) {
            onBack!();
          }
        },
      },
      [
        span(
          styles: const Styles(raw: {
            'font-size': ArcaneTypography.fontXl,
          }),
          [text('←')],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-bar-back:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
  ];
}

/// A simple top bar for dialogs
class ArcaneDialogBar extends StatelessComponent {
  final String? title;
  final void Function()? onClose;

  const ArcaneDialogBar({
    this.title,
    this.onClose,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-dialog-bar',
      styles: const Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'space-between',
        'padding': ArcaneSpacing.lg,
        'border-bottom': '1px solid ${ArcaneColors.border}',
      }),
      [
        if (title != null)
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontLg,
              'font-weight': ArcaneTypography.weightSemibold,
              'color': ArcaneColors.onSurface,
            }),
            [text(title!)],
          )
        else
          const div([]),
        if (onClose != null)
          button(
            attributes: {'type': 'button', 'aria-label': 'Close'},
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '32px',
              'height': '32px',
              'border-radius': ArcaneRadius.full,
              'background': ArcaneColors.transparent,
              'border': 'none',
              'color': ArcaneColors.muted,
              'cursor': 'pointer',
              'transition': ArcaneEffects.transitionFast,
              'font-size': ArcaneTypography.fontXl,
            }),
            events: {
              'click': (event) => onClose!(),
            },
            [text('×')],
          ),
      ],
    );
  }
}