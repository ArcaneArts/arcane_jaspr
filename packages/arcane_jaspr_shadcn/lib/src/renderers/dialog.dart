import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/dialog_props.dart';

class ShadcnDialog extends StatelessComponent {
  final DialogProps props;

  const ShadcnDialog(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final String surfaceId = props.id ?? _autoId();
    final Map<String, String> surfAttrs = surfaceAttrs(
      surface: 'dialog',
      id: surfaceId,
      initiallyOpen: props.isOpen,
      dismissible: props.barrierDismissible,
      escapeCloses: props.escapeCloses,
      focusTrap: props.focusTrap,
      scrimCloses: props.barrierDismissible,
      restoreFocus: props.restoreFocus,
    );

    return dom.div(
      classes: 'arcane-dialog-overlay',
      attributes: <String, String>{...surfAttrs, 'data-arcane-scrim': ''},
      styles: const dom.Styles(
        raw: <String, String>{
          'position': 'fixed',
          'inset': '0',
          'z-index': '50',
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'padding': '24px',
          'background-color': 'rgba(0, 0, 0, 0.8)',
          'animation': 'arcane-fade-in var(--transition-slow)',
        },
      ),
      events: <String, EventCallback>{
        if (props.onClose != null && props.barrierDismissible)
          'click': (event) {
            if (event.target == event.currentTarget) {
              props.onClose!();
            }
          },
      },
      <Component>[
        dom.div(
          classes: 'arcane-dialog',
          attributes: <String, String>{
            'role': 'dialog',
            'aria-modal': 'true',
            if (props.title != null)
              'aria-labelledby': 'dialog-title-$surfaceId',
            'data-arcane-autofocus': '',
          },
          styles: dom.Styles(
            raw: <String, String>{
              'position': 'relative',
              'background-color': 'var(--background)',
              'color': 'var(--foreground)',
              'border-radius': 'var(--radius-md)',
              'border': '1px solid var(--border)',
              'box-shadow': 'var(--shadow-lg)',
              'max-width': '${props.maxWidth}px',
              'width': '100%',
              'max-height': 'calc(100vh - 48px)',
              'display': 'flex',
              'flex-direction': 'column',
              'overflow': 'hidden',
              'animation': 'arcane-scale-in var(--transition-slow)',
              ...?props.decoration?.universalStyles(),
              ...?props.styles?.toMap(),
            },
          ),
          events: <String, EventCallback>{
            'click': (event) => event.stopPropagation(),
          },
          <Component>[
            if (props.title != null || props.showCloseButton)
              dom.div(
                classes: 'arcane-dialog-header',
                styles: const dom.Styles(
                  raw: <String, String>{
                    'display': 'flex',
                    'align-items': 'flex-start',
                    'justify-content': 'space-between',
                    'padding': '24px',
                    'padding-bottom': '0',
                    'flex-shrink': '0',
                  },
                ),
                <Component>[
                  if (props.title != null)
                    dom.span(
                      id: 'dialog-title-$surfaceId',
                      styles: const dom.Styles(
                        raw: <String, String>{
                          'font-size': 'var(--font-size-lg)',
                          'font-weight': 'var(--font-weight-semibold)',
                          'line-height': '1',
                          'letter-spacing': '-0.025em',
                          'color': 'var(--foreground)',
                        },
                      ),
                      <Component>[Component.text(props.title!)],
                    )
                  else
                    const dom.div(<Component>[]),
                  if (props.showCloseButton)
                    dom.button(
                      classes: 'arcane-dialog-close',
                      attributes: <String, String>{
                        'type': 'button',
                        'aria-label': 'Close dialog',
                        ...dismissAttrs(),
                      },
                      styles: const dom.Styles(
                        raw: <String, String>{
                          'position': 'absolute',
                          'right': '16px',
                          'top': '16px',
                          'display': 'inline-flex',
                          'align-items': 'center',
                          'justify-content': 'center',
                          'width': '24px',
                          'height': '24px',
                          'border-radius': 'var(--radius-xs)',
                          'background': 'transparent',
                          'border': 'none',
                          'opacity': '0.7',
                          'color': 'var(--foreground)',
                          'cursor': 'pointer',
                          'transition': 'opacity var(--transition)',
                          'font-size': 'var(--font-size-base)',
                          'padding': '0',
                        },
                      ),
                      events: <String, EventCallback>{
                        if (props.onClose != null)
                          'click': (event) => props.onClose!(),
                      },
                      <Component>[ArcaneIcon.x(size: IconSize.sm)],
                    ),
                ],
              ),
            dom.div(
              classes: 'arcane-dialog-body',
              styles: const dom.Styles(
                raw: <String, String>{
                  'padding': '24px',
                  'overflow-y': 'auto',
                  'flex': '1',
                },
              ),
              props.content,
            ),
            if (props.actions != null && props.actions!.isNotEmpty)
              dom.div(
                classes: 'arcane-dialog-footer',
                styles: const dom.Styles(
                  raw: <String, String>{
                    'display': 'flex',
                    'flex-direction': 'row',
                    'justify-content': 'flex-end',
                    'gap': 'var(--space-2)',
                    'padding': '0 24px 24px 24px',
                    'flex-shrink': '0',
                  },
                ),
                props.actions!,
              ),
          ],
        ),
      ],
    );
  }

  static int _autoCounter = 0;
  static String _autoId() {
    _autoCounter++;
    return 'arcane-dialog-$_autoCounter';
  }
}

class ShadcnSheet extends StatelessComponent {
  final SheetProps props;

  const ShadcnSheet(this.props, {super.key});

  bool get _isVertical =>
      props.position == SheetPosition.bottom ||
      props.position == SheetPosition.top;

  String? get _sizeValue {
    if (props.size == SheetSizeVariant.auto) return null;
    if (_isVertical) {
      return switch (props.size) {
        SheetSizeVariant.auto => null,
        SheetSizeVariant.sm => '30vh',
        SheetSizeVariant.md => '50vh',
        SheetSizeVariant.lg => '70vh',
        SheetSizeVariant.xl => '90vh',
        SheetSizeVariant.full => '100vh',
      };
    } else {
      return switch (props.size) {
        SheetSizeVariant.auto => null,
        SheetSizeVariant.sm => '280px',
        SheetSizeVariant.md => '400px',
        SheetSizeVariant.lg => '540px',
        SheetSizeVariant.xl => '720px',
        SheetSizeVariant.full => '100vw',
      };
    }
  }

  String get _borderRadius => switch (props.position) {
    SheetPosition.bottom => 'var(--radius-md) var(--radius-md) 0 0',
    SheetPosition.top => '0 0 var(--radius-md) var(--radius-md)',
    SheetPosition.right => 'var(--radius-md) 0 0 var(--radius-md)',
    SheetPosition.left => '0 var(--radius-md) var(--radius-md) 0',
  };

  @override
  Component build(BuildContext context) {
    final String surfaceId = props.id ?? _autoId();
    final String? sizeVal = _sizeValue;

    final Map<String, String> sheetStyles = <String, String>{
      'position': 'fixed',
      'z-index': '50',
      'background-color': 'var(--background)',
      'color': 'var(--foreground)',
      'box-shadow': 'var(--shadow-lg)',
      'display': 'flex',
      'flex-direction': 'column',
      'overflow': 'hidden',
      'transition': 'transform 300ms cubic-bezier(0.32, 0.72, 0, 1)',
      'border-radius': props.size == SheetSizeVariant.full
          ? '0'
          : _borderRadius,
      'border': '1px solid var(--border)',
    };

    switch (props.position) {
      case SheetPosition.right:
        sheetStyles.addAll(<String, String>{
          'top': '0',
          'right': '0',
          'bottom': '0',
          'height': '100%',
          'width': sizeVal ?? '400px',
          'max-width': '100vw',
          'animation': 'arcane-slide-left var(--transition-slower)',
        });
        break;
      case SheetPosition.left:
        sheetStyles.addAll(<String, String>{
          'top': '0',
          'left': '0',
          'bottom': '0',
          'height': '100%',
          'width': sizeVal ?? '400px',
          'max-width': '100vw',
          'animation': 'arcane-slide-right var(--transition-slower)',
        });
        break;
      case SheetPosition.bottom:
        sheetStyles.addAll(<String, String>{
          'left': props.maxWidth != null ? '50%' : '0',
          'right': props.maxWidth != null ? 'auto' : '0',
          'bottom': '0',
          if (props.maxWidth != null) 'transform': 'translateX(-50%)',
          'height': ?sizeVal,
          'max-height': '90vh',
          'width': props.maxWidth ?? '100%',
          'animation': 'arcane-slide-up var(--transition-slower)',
        });
        break;
      case SheetPosition.top:
        sheetStyles.addAll(<String, String>{
          'left': '0',
          'right': '0',
          'top': '0',
          'height': ?sizeVal,
          'max-height': '90vh',
          'animation': 'arcane-slide-down var(--transition-slower)',
        });
        break;
    }

    sheetStyles.addAll(<String, String>{
      ...?props.decoration?.universalStyles(),
      ...?props.styles?.toMap(),
    });

    final Map<String, String> surfAttrs = surfaceAttrs(
      surface: 'sheet',
      id: surfaceId,
      initiallyOpen: props.isOpen,
      dismissible: props.closeOnBackdropClick,
      escapeCloses: props.escapeCloses,
      focusTrap: props.focusTrap,
      scrimCloses: props.closeOnBackdropClick,
      restoreFocus: props.restoreFocus,
    );

    return dom.div(
      classes: 'arcane-sheet',
      attributes: <String, String>{
        ...surfAttrs,
        'data-position': props.position.name,
      },
      styles: const dom.Styles(
        raw: <String, String>{
          'position': 'fixed',
          'inset': '0',
          'z-index': '1100',
          'pointer-events': 'auto',
        },
      ),
      <Component>[
        if (props.showBackdrop)
          dom.div(
            classes: 'arcane-sheet-backdrop',
            attributes: <String, String>{'data-arcane-scrim': ''},
            styles: const dom.Styles(
              raw: <String, String>{
                'position': 'absolute',
                'inset': '0',
                'background-color': 'rgba(0, 0, 0, 0.8)',
                'animation': 'arcane-fade-in var(--transition-slow)',
              },
            ),
            events: <String, EventCallback>{
              if (props.closeOnBackdropClick && props.onClose != null)
                'click': (_) => props.onClose!(),
            },
            <Component>[],
          ),
        dom.div(
          classes: 'arcane-sheet-panel arcane-sheet-${props.position.name}',
          attributes: const <String, String>{
            'role': 'dialog',
            'aria-modal': 'true',
            'data-arcane-autofocus': '',
          },
          styles: dom.Styles(raw: sheetStyles),
          events: <String, EventCallback>{
            'click': (event) => event.stopPropagation(),
          },
          <Component>[
            if (props.showDragHandle && _isVertical)
              const dom.div(
                classes: 'arcane-sheet-drag-handle',
                styles: dom.Styles(
                  raw: <String, String>{
                    'display': 'flex',
                    'justify-content': 'center',
                    'padding': '8px 0',
                  },
                ),
                <Component>[
                  dom.div(
                    styles: dom.Styles(
                      raw: <String, String>{
                        'width': '36px',
                        'height': '4px',
                        'background': 'var(--muted-foreground)',
                        'border-radius': 'var(--radius-xs)',
                        'opacity': '0.4',
                      },
                    ),
                    <Component>[],
                  ),
                ],
              ),
            if (props.header != null ||
                props.title != null ||
                props.showCloseButton)
              dom.div(
                classes: 'arcane-sheet-header',
                styles: const dom.Styles(
                  raw: <String, String>{
                    'display': 'flex',
                    'align-items': 'flex-start',
                    'justify-content': 'space-between',
                    'gap': '16px',
                    'padding': '24px',
                    'padding-top': '12px',
                    'flex-shrink': '0',
                  },
                ),
                <Component>[
                  if (props.header != null)
                    dom.div(
                      styles: const dom.Styles(
                        raw: <String, String>{'flex': '1'},
                      ),
                      <Component>[props.header!],
                    )
                  else if (props.title != null)
                    dom.div(
                      styles: const dom.Styles(
                        raw: <String, String>{
                          'flex': '1',
                          'display': 'flex',
                          'flex-direction': 'column',
                          'gap': 'var(--space-1)',
                        },
                      ),
                      <Component>[
                        dom.span(
                          styles: const dom.Styles(
                            raw: <String, String>{
                              'font-size': 'var(--font-size-lg)',
                              'font-weight': 'var(--font-weight-semibold)',
                              'color': 'var(--foreground)',
                            },
                          ),
                          <Component>[Component.text(props.title!)],
                        ),
                        if (props.description != null)
                          dom.span(
                            styles: const dom.Styles(
                              raw: <String, String>{
                                'font-size': 'var(--font-size-sm)',
                                'color': 'var(--muted-foreground)',
                              },
                            ),
                            <Component>[Component.text(props.description!)],
                          ),
                      ],
                    )
                  else
                    const dom.div(<Component>[]),
                  if (props.showCloseButton)
                    dom.button(
                      classes: 'arcane-sheet-close',
                      attributes: <String, String>{
                        'type': 'button',
                        'aria-label': 'Close sheet',
                        ...dismissAttrs(),
                      },
                      styles: const dom.Styles(
                        raw: <String, String>{
                          'width': '32px',
                          'height': '32px',
                          'display': 'flex',
                          'align-items': 'center',
                          'justify-content': 'center',
                          'padding': '0',
                          'border': 'none',
                          'background': 'transparent',
                          'color': 'var(--muted-foreground)',
                          'cursor': 'pointer',
                          'border-radius': 'var(--radius-sm)',
                          'font-size': 'var(--font-size-xl)',
                          'transition':
                              'color var(--transition), background var(--transition)',
                          'flex-shrink': '0',
                        },
                      ),
                      events: <String, EventCallback>{
                        if (props.onClose != null)
                          'click': (_) => props.onClose!(),
                      },
                      <Component>[ArcaneIcon.x(size: IconSize.sm)],
                    ),
                ],
              ),
            dom.div(
              classes: 'arcane-sheet-content',
              styles: const dom.Styles(
                raw: <String, String>{
                  'flex': '1',
                  'overflow': 'auto',
                  'padding': '0 24px 24px',
                },
              ),
              <Component>[props.child],
            ),
            if (props.footer != null)
              dom.div(
                classes: 'arcane-sheet-footer',
                styles: const dom.Styles(
                  raw: <String, String>{
                    'padding': '24px',
                    'border-top': '1px solid var(--border)',
                    'flex-shrink': '0',
                  },
                ),
                <Component>[props.footer!],
              ),
          ],
        ),
      ],
    );
  }

  static int _autoCounter = 0;
  static String _autoId() {
    _autoCounter++;
    return 'arcane-sheet-$_autoCounter';
  }
}
