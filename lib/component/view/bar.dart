import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/appearance/theme.dart';
import '../../util/arcane.dart';
import '../../util/tools/styles.dart';

/// Back button display mode
enum BarBackButtonMode {
  always,
  never,
  auto,
}

/// An app bar / header component.
class Bar extends StatelessComponent {
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

  const Bar({
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
    final theme = ArcaneTheme.of(context);
    final effectiveHeight = height ?? 56.0;
    final effectivePadding =
        padding ?? const EdgeInsets.symmetric(horizontal: 16);

    // Build title section
    final titleWidget = title ??
        (titleText != null
            ? span(
                classes: 'arcane-bar-title',
                styles: Styles(raw: {
                  'font-size': '1.125rem',
                  'font-weight': '600',
                  'color': 'var(--arcane-on-surface)',
                  'white-space': 'nowrap',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                }),
                [text(titleText!)],
              )
            : null);

    final subtitleWidget = subtitle ??
        (subtitleText != null
            ? span(
                classes: 'arcane-bar-subtitle',
                styles: Styles(raw: {
                  'font-size': '0.75rem',
                  'color': 'var(--arcane-on-surface-variant)',
                  'white-space': 'nowrap',
                  'overflow': 'hidden',
                  'text-overflow': 'ellipsis',
                }),
                [text(subtitleText!)],
              )
            : null);

    // Show back button?
    final showBack = backButton == BarBackButtonMode.always ||
        (backButton == BarBackButtonMode.auto && onBack != null);

    return header(
      classes: 'arcane-bar ${transparent ? 'transparent' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': '12px',
        'height': '${effectiveHeight}px',
        'padding': effectivePadding.padding,
        'background-color':
            transparent ? 'transparent' : 'var(--arcane-surface)',
        if (!transparent)
          'border-bottom': '1px solid var(--arcane-outline-variant)',
        'flex-shrink': '0',
      }),
      [
        // Leading section
        if (showBack || (leading != null && leading!.isNotEmpty))
          div(
            classes: 'arcane-bar-leading',
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '8px',
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
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'gap': '8px',
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
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': '36px',
        'height': '36px',
        'border-radius': '50%',
        'background': 'transparent',
        'color': 'var(--arcane-on-surface)',
        'cursor': 'pointer',
        'transition': 'background-color 150ms ease',
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
          styles: Styles(raw: {
            'font-size': '1.25rem',
          }),
          [text('←')],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-bar-back:hover').styles(raw: {
      'background-color': 'var(--arcane-surface-variant)',
    }),
  ];
}

/// A simple top bar for dialogs
class DialogBar extends StatelessComponent {
  final String? title;
  final void Function()? onClose;

  const DialogBar({
    this.title,
    this.onClose,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-dialog-bar',
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'space-between',
        'padding': '16px',
        'border-bottom': '1px solid var(--arcane-outline-variant)',
      }),
      [
        if (title != null)
          span(
            styles: Styles(raw: {
              'font-size': '1.125rem',
              'font-weight': '600',
              'color': 'var(--arcane-on-surface)',
            }),
            [text(title!)],
          )
        else
          div([]),
        if (onClose != null)
          button(
            attributes: {'type': 'button', 'aria-label': 'Close'},
            styles: Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '32px',
              'height': '32px',
              'border-radius': '50%',
              'background': 'transparent',
              'color': 'var(--arcane-on-surface-variant)',
              'cursor': 'pointer',
              'transition': 'all 150ms ease',
              'font-size': '1.25rem',
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
