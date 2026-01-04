import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';
import 'sheet_types.dart';

export 'sheet_types.dart';

/// A modal sheet that slides in from screen edges.
///
/// Sheets are used for forms, filters, action menus, and other
/// content that requires user attention without navigating away.
///
/// ```dart
/// ArcaneSheet(
///   isOpen: showSheet,
///   onClose: () => setState(() => showSheet = false),
///   position: SheetPosition.bottom,
///   child: SheetContent(),
/// )
/// ```
class ArcaneSheet extends StatelessComponent {
  /// Whether the sheet is open
  final bool isOpen;

  /// Callback when sheet should close
  final VoidCallback? onClose;

  /// Sheet position (which edge it slides from)
  final SheetPosition position;

  /// Sheet size
  final SheetSize size;

  /// Sheet content
  final Component child;

  /// Optional title
  final String? title;

  /// Optional description below title
  final String? description;

  /// Optional header widget (overrides title/description)
  final Component? header;

  /// Optional footer content
  final Component? footer;

  /// Whether to show backdrop overlay
  final bool showBackdrop;

  /// Whether clicking backdrop closes sheet
  final bool closeOnBackdropClick;

  /// Whether to show close button
  final bool showCloseButton;

  /// Whether to show drag handle (for bottom/top sheets)
  final bool showDragHandle;

  /// Custom max width (for bottom sheets that shouldn't span full width)
  final String? maxWidth;

  const ArcaneSheet({
    required this.isOpen,
    required this.child,
    this.onClose,
    this.position = SheetPosition.bottom,
    this.size = SheetSize.auto,
    this.title,
    this.description,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = true,
    this.showDragHandle = true,
    this.maxWidth,
    super.key,
  });

  /// Bottom sheet constructor
  const ArcaneSheet.bottom({
    required this.isOpen,
    required this.child,
    this.onClose,
    this.size = SheetSize.auto,
    this.title,
    this.description,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = false,
    this.showDragHandle = true,
    this.maxWidth,
    super.key,
  }) : position = SheetPosition.bottom;

  /// Top sheet constructor
  const ArcaneSheet.top({
    required this.isOpen,
    required this.child,
    this.onClose,
    this.size = SheetSize.auto,
    this.title,
    this.description,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = true,
    this.showDragHandle = false,
    this.maxWidth,
    super.key,
  }) : position = SheetPosition.top;

  /// Side sheet (end/right) constructor
  const ArcaneSheet.end({
    required this.isOpen,
    required this.child,
    this.onClose,
    this.size = SheetSize.md,
    this.title,
    this.description,
    this.header,
    this.footer,
    this.showBackdrop = true,
    this.closeOnBackdropClick = true,
    this.showCloseButton = true,
    this.showDragHandle = false,
    this.maxWidth,
    super.key,
  }) : position = SheetPosition.end;

  bool get _isVertical =>
      position == SheetPosition.bottom || position == SheetPosition.top;

  String? get _sizeValue {
    if (size == SheetSize.auto) return null;
    if (_isVertical) {
      return switch (size) {
        SheetSize.auto => null,
        SheetSize.sm => '30vh',
        SheetSize.md => '50vh',
        SheetSize.lg => '70vh',
        SheetSize.xl => '90vh',
        SheetSize.full => '100vh',
      };
    } else {
      return switch (size) {
        SheetSize.auto => null,
        SheetSize.sm => '280px',
        SheetSize.md => '400px',
        SheetSize.lg => '540px',
        SheetSize.xl => '720px',
        SheetSize.full => '100vw',
      };
    }
  }

  Map<String, String> get _positionStyles {
    final sizeVal = _sizeValue;
    return switch (position) {
      SheetPosition.bottom => {
          'bottom': '0',
          'left': '0',
          'right': '0',
          if (sizeVal != null) 'height': sizeVal,
          'max-height': '90vh',
          'transform': isOpen ? 'translateY(0)' : 'translateY(100%)',
        },
      SheetPosition.top => {
          'top': '0',
          'left': '0',
          'right': '0',
          if (sizeVal != null) 'height': sizeVal,
          'max-height': '90vh',
          'transform': isOpen ? 'translateY(0)' : 'translateY(-100%)',
        },
      SheetPosition.end => {
          'top': '0',
          'right': '0',
          'bottom': '0',
          if (sizeVal != null) 'width': sizeVal else 'width': '400px',
          'max-width': '100vw',
          'transform': isOpen ? 'translateX(0)' : 'translateX(100%)',
        },
      SheetPosition.start => {
          'top': '0',
          'left': '0',
          'bottom': '0',
          if (sizeVal != null) 'width': sizeVal else 'width': '400px',
          'max-width': '100vw',
          'transform': isOpen ? 'translateX(0)' : 'translateX(-100%)',
        },
    };
  }

  String get _borderRadius => switch (position) {
        SheetPosition.bottom =>
          '${ArcaneRadius.xl} ${ArcaneRadius.xl} 0 0',
        SheetPosition.top =>
          '0 0 ${ArcaneRadius.xl} ${ArcaneRadius.xl}',
        SheetPosition.end =>
          '${ArcaneRadius.xl} 0 0 ${ArcaneRadius.xl}',
        SheetPosition.start =>
          '0 ${ArcaneRadius.xl} ${ArcaneRadius.xl} 0',
      };

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-sheet ${isOpen ? 'open' : 'closed'}',
      attributes: {
        'data-sheet': 'true',
        'data-position': position.name,
      },
      styles: Styles(raw: {
        'position': 'fixed',
        'top': '0',
        'left': '0',
        'right': '0',
        'bottom': '0',
        'z-index': '1100',
        'pointer-events': isOpen ? 'auto' : 'none',
      }),
      [
        // Backdrop
        if (showBackdrop)
          div(
            classes: 'arcane-sheet-backdrop',
            styles: Styles(raw: {
              'position': 'absolute',
              'top': '0',
              'left': '0',
              'right': '0',
              'bottom': '0',
              'background': ArcaneColors.overlay,
              'opacity': isOpen ? '1' : '0',
              'transition': 'opacity 0.3s ease',
            }),
            events:
                closeOnBackdropClick ? {'click': (_) => onClose?.call()} : null,
            [],
          ),

        // Sheet container (for centering bottom sheets if needed)
        div(
          classes: 'arcane-sheet-container',
          styles: Styles(raw: {
            'position': 'absolute',
            if (position == SheetPosition.bottom) ...{
              'bottom': '0',
              'left': '50%',
              'transform': isOpen
                  ? 'translateX(-50%) translateY(0)'
                  : 'translateX(-50%) translateY(100%)',
              'width': maxWidth ?? '100%',
              'max-width': maxWidth ?? '100%',
            } else
              ..._positionStyles,
            'transition': 'transform 0.3s cubic-bezier(0.32, 0.72, 0, 1)',
          }),
          [
            // Sheet panel
            div(
              classes: 'arcane-sheet-panel',
              styles: Styles(raw: {
                'background': ArcaneColors.surface,
                'box-shadow': ArcaneEffects.shadowXl,
                'display': 'flex',
                'flex-direction': 'column',
                'border-radius': size == SheetSize.full ? '0' : _borderRadius,
                'border': '1px solid ${ArcaneColors.border}',
                if (position == SheetPosition.bottom && size == SheetSize.auto)
                  'max-height': '85vh',
              }),
              [
                // Drag handle (for bottom/top sheets)
                if (showDragHandle && _isVertical)
                  const div(
                    classes: 'arcane-sheet-drag-handle',
                    styles: Styles(raw: {
                      'display': 'flex',
                      'justify-content': 'center',
                      'padding': '${ArcaneSpacing.sm} 0',
                    }),
                    [
                      div(
                        styles: Styles(raw: {
                          'width': '36px',
                          'height': '4px',
                          'background': ArcaneColors.muted,
                          'border-radius': ArcaneRadius.full,
                          'opacity': '0.4',
                        }),
                        [],
                      ),
                    ],
                  ),

                // Header
                if (header != null || title != null || showCloseButton)
                  div(
                    classes: 'arcane-sheet-header',
                    styles: const Styles(raw: {
                      'display': 'flex',
                      'align-items': 'flex-start',
                      'justify-content': 'space-between',
                      'gap': ArcaneSpacing.md,
                      'padding': ArcaneSpacing.lg,
                      'padding-top':
                          ArcaneSpacing.md, // Less if drag handle shown
                    }),
                    [
                      if (header != null)
                        div(
                          styles: const Styles(raw: {'flex': '1'}),
                          [header!],
                        )
                      else if (title != null)
                        div(
                          styles: const Styles(raw: {
                            'flex': '1',
                            'display': 'flex',
                            'flex-direction': 'column',
                            'gap': ArcaneSpacing.xs,
                          }),
                          [
                            span(
                              styles: const Styles(raw: {
                                'font-size': ArcaneTypography.fontLg,
                                'font-weight': ArcaneTypography.weightSemibold,
                                'color': ArcaneColors.onSurface,
                              }),
                              [Component.text(title!)],
                            ),
                            if (description != null)
                              span(
                                styles: const Styles(raw: {
                                  'font-size': ArcaneTypography.fontSm,
                                  'color': ArcaneColors.muted,
                                }),
                                [Component.text(description!)],
                              ),
                          ],
                        ),
                      if (showCloseButton)
                        button(
                          type: ButtonType.button,
                          classes: 'arcane-sheet-close',
                          attributes: {'aria-label': 'Close sheet'},
                          styles: const Styles(raw: {
                            'width': '32px',
                            'height': '32px',
                            'display': 'flex',
                            'align-items': 'center',
                            'justify-content': 'center',
                            'padding': '0',
                            'border': 'none',
                            'background': 'transparent',
                            'color': ArcaneColors.muted,
                            'cursor': 'pointer',
                            'border-radius': ArcaneRadius.sm,
                            'font-size': ArcaneTypography.fontXl,
                            'transition': ArcaneEffects.transitionFast,
                            'flex-shrink': '0',
                          }),
                          events: {'click': (_) => onClose?.call()},
                          [text('×')],
                        ),
                    ],
                  ),

                // Content
                div(
                  classes: 'arcane-sheet-content',
                  styles: const Styles(raw: {
                    'flex': '1',
                    'overflow': 'auto',
                    'padding': '0 ${ArcaneSpacing.lg} ${ArcaneSpacing.lg}',
                  }),
                  [child],
                ),

                // Footer
                if (footer != null)
                  div(
                    classes: 'arcane-sheet-footer',
                    styles: const Styles(raw: {
                      'padding': ArcaneSpacing.lg,
                      'border-top': '1px solid ${ArcaneColors.border}',
                      'flex-shrink': '0',
                    }),
                    [footer!],
                  ),
              ],
            ),
          ],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('.arcane-sheet-close:hover').styles(raw: {
      'color': ArcaneColors.onSurface,
      'background': ArcaneColors.surfaceVariant,
    }),
  ];
}

/// Action sheet with a list of actions (mobile-style).
///
/// ```dart
/// ArcaneActionSheet(
///   isOpen: showActions,
///   onClose: () => setState(() => showActions = false),
///   actions: [
///     ActionSheetItem(
///       label: 'Share',
///       icon: '📤',
///       onTap: () => handleShare(),
///     ),
///     ActionSheetItem(
///       label: 'Delete',
///       icon: '🗑️',
///       destructive: true,
///       onTap: () => handleDelete(),
///     ),
///   ],
/// )
/// ```
class ArcaneActionSheet extends StatelessComponent {
  /// Whether the action sheet is open
  final bool isOpen;

  /// Callback when sheet should close
  final VoidCallback? onClose;

  /// Title text
  final String? title;

  /// Description text
  final String? message;

  /// List of actions
  final List<ActionSheetItem> actions;

  /// Whether to show cancel button
  final bool showCancel;

  /// Custom cancel label
  final String cancelLabel;

  const ArcaneActionSheet({
    required this.isOpen,
    required this.actions,
    this.onClose,
    this.title,
    this.message,
    this.showCancel = true,
    this.cancelLabel = 'Cancel',
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneSheet.bottom(
      isOpen: isOpen,
      onClose: onClose,
      showCloseButton: false,
      showDragHandle: true,
      child: div(
        styles: const Styles(raw: {
          'display': 'flex',
          'flex-direction': 'column',
          'gap': ArcaneSpacing.xs,
        }),
        [
          // Title and message
          if (title != null || message != null)
            div(
              styles: const Styles(raw: {
                'text-align': 'center',
                'padding-bottom': ArcaneSpacing.md,
                'margin-bottom': ArcaneSpacing.sm,
                'border-bottom': '1px solid ${ArcaneColors.border}',
              }),
              [
                if (title != null)
                  div(
                    styles: const Styles(raw: {
                      'font-size': ArcaneTypography.fontMd,
                      'font-weight': ArcaneTypography.weightSemibold,
                      'color': ArcaneColors.onSurface,
                      'margin-bottom': ArcaneSpacing.xs,
                    }),
                    [Component.text(title!)],
                  ),
                if (message != null)
                  div(
                    styles: const Styles(raw: {
                      'font-size': ArcaneTypography.fontSm,
                      'color': ArcaneColors.muted,
                    }),
                    [Component.text(message!)],
                  ),
              ],
            ),

          // Actions
          for (final action in actions) _buildActionItem(action),

          // Cancel button
          if (showCancel) ...[
            const div(
              styles: Styles(raw: {
                'height': ArcaneSpacing.sm,
              }),
              [],
            ),
            button(
              type: ButtonType.button,
              styles: const Styles(raw: {
                'width': '100%',
                'padding': ArcaneSpacing.md,
                'border': 'none',
                'background': ArcaneColors.surfaceVariant,
                'color': ArcaneColors.onSurface,
                'font-size': ArcaneTypography.fontMd,
                'font-weight': ArcaneTypography.weightMedium,
                'border-radius': ArcaneRadius.lg,
                'cursor': 'pointer',
                'transition': ArcaneEffects.transitionFast,
              }),
              events: {'click': (_) => onClose?.call()},
              [Component.text(cancelLabel)],
            ),
          ],
        ],
      ),
    );
  }

  Component _buildActionItem(ActionSheetItem action) {
    return button(
      type: ButtonType.button,
      classes: 'arcane-action-sheet-item ${action.destructive ? 'destructive' : ''}',
      styles: Styles(raw: {
        'width': '100%',
        'display': 'flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.md,
        'padding': ArcaneSpacing.md,
        'border': 'none',
        'background': 'transparent',
        'color':
            action.destructive ? ArcaneColors.error : ArcaneColors.onSurface,
        'font-size': ArcaneTypography.fontMd,
        'border-radius': ArcaneRadius.md,
        'cursor': action.disabled ? 'not-allowed' : 'pointer',
        'opacity': action.disabled ? '0.5' : '1',
        'transition': ArcaneEffects.transitionFast,
      }),
      events: action.disabled
          ? null
          : {
              'click': (_) {
                action.onTap?.call();
                if (action.closeOnTap) onClose?.call();
              },
            },
      [
        if (action.icon != null)
          span(
            styles: const Styles(raw: {
              'font-size': ArcaneTypography.fontLg,
            }),
            [Component.text(action.icon!)],
          ),
        span(
          styles: const Styles(raw: {
            'flex': '1',
            'text-align': 'left',
          }),
          [Component.text(action.label)],
        ),
        if (action.trailing != null) action.trailing!,
      ],
    );
  }

  @css
  static final List<StyleRule> actionSheetStyles = [
    css('.arcane-action-sheet-item:hover:not(:disabled)').styles(raw: {
      'background': ArcaneColors.surfaceVariant,
    }),
  ];
}

/// An action item for [ArcaneActionSheet].
class ActionSheetItem {
  /// Label text
  final String label;

  /// Optional icon (emoji or icon code)
  final String? icon;

  /// Whether this is a destructive action
  final bool destructive;

  /// Whether the action is disabled
  final bool disabled;

  /// Callback when tapped
  final VoidCallback? onTap;

  /// Whether to close sheet on tap
  final bool closeOnTap;

  /// Optional trailing widget
  final Component? trailing;

  const ActionSheetItem({
    required this.label,
    this.icon,
    this.destructive = false,
    this.disabled = false,
    this.onTap,
    this.closeOnTap = true,
    this.trailing,
  });
}