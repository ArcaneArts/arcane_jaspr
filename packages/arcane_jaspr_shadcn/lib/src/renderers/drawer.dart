import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/component/view/icon.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/drawer_props.dart';

/// ShadCN Drawer renderer.
///
/// Outputs drawer HTML matching the ShadCN/ui design language.
/// Reference: https://ui.shadcn.com/docs/components/sheet
class ShadcnDrawer extends StatelessComponent {
  final DrawerProps props;

  const ShadcnDrawer(this.props, {super.key});

  bool get _isHorizontal =>
      props.position == DrawerPosition.left ||
      props.position == DrawerPosition.right;

  String get _sizeValue {
    if (_isHorizontal) {
      return props.width ??
          switch (props.size) {
            DrawerSize.sm => '280px',
            DrawerSize.md => '360px',
            DrawerSize.lg => '480px',
            DrawerSize.xl => '640px',
            DrawerSize.full => '100%',
          };
    } else {
      return props.height ??
          switch (props.size) {
            DrawerSize.sm => '30vh',
            DrawerSize.md => '50vh',
            DrawerSize.lg => '70vh',
            DrawerSize.xl => '90vh',
            DrawerSize.full => '100%',
          };
    }
  }

  Map<String, String> get _positionStyles => switch (props.position) {
    DrawerPosition.left => {
      'left': '0',
      'top': '0',
      'bottom': '0',
      'width': _sizeValue,
      'border-right': '1px solid var(--border)',
    },
    DrawerPosition.right => {
      'right': '0',
      'top': '0',
      'bottom': '0',
      'width': _sizeValue,
      'border-left': '1px solid var(--border)',
    },
    DrawerPosition.top => {
      'top': '0',
      'left': '0',
      'right': '0',
      'height': _sizeValue,
      'border-bottom': '1px solid var(--border)',
    },
    DrawerPosition.bottom => {
      'bottom': '0',
      'left': '0',
      'right': '0',
      'height': _sizeValue,
      'border-top': '1px solid var(--border)',
    },
  };

  String get _borderRadius => props.size == DrawerSize.full
      ? '0'
      : switch (props.position) {
          DrawerPosition.left => '0 0.5rem 0.5rem 0',
          DrawerPosition.right => '0.5rem 0 0 0.5rem',
          DrawerPosition.top => '0 0 0.5rem 0.5rem',
          DrawerPosition.bottom => '0.5rem 0.5rem 0 0',
        };

  @override
  Component build(BuildContext context) {
    final String surfaceId = props.id ?? _autoId();
    final Map<String, String> surfAttrs = surfaceAttrs(
      surface: 'drawer',
      id: surfaceId,
      initiallyOpen: props.isOpen,
      dismissible: props.closeOnBackdropClick,
      escapeCloses: props.escapeCloses,
      focusTrap: props.focusTrap,
      scrimCloses: props.closeOnBackdropClick,
      restoreFocus: props.restoreFocus,
    );

    return dom.div(
      classes: 'arcane-drawer-container',
      attributes: <String, String>{
        ...surfAttrs,
        'data-position': props.position.name,
      },
      styles: dom.Styles(
        raw: {
          'position': 'fixed',
          'top': '0',
          'left': '0',
          'right': '0',
          'bottom': '0',
          // ShadCN: z-50
          'z-index': '50',
          'pointer-events': props.isOpen ? 'auto' : 'none',
        },
      ),
      [
        // Backdrop - ShadCN: bg-black/80
        if (props.showBackdrop)
          dom.div(
            classes: 'arcane-drawer-backdrop',
            attributes: const <String, String>{
              'data-arcane-scrim': '',
            },
            styles: const dom.Styles(
              raw: {
                'position': 'absolute',
                'top': '0',
                'left': '0',
                'right': '0',
                'bottom': '0',
                'background-color': 'rgba(0, 0, 0, 0.8)',
                'transition': 'opacity var(--transition-slower)',
              },
            ),
            events: props.closeOnBackdropClick
                ? {'click': (_) => props.onClose?.call()}
                : null,
            [],
          ),

        // Drawer panel - ShadCN Sheet styles
        dom.div(
          classes: 'arcane-drawer arcane-drawer-${props.position.name}',
          attributes: const <String, String>{
            'role': 'dialog',
            'aria-modal': 'true',
            'data-arcane-autofocus': '',
          },
          styles: dom.Styles(
            raw: {
              'position': 'absolute',
              // ShadCN: bg-background
              'background-color': 'var(--background)',
              'color': 'var(--foreground)',
              // ShadCN: shadow-lg
              'box-shadow':
                  '0 10px 15px -3px rgb(0 0 0 / 0.1), 0 4px 6px -4px rgb(0 0 0 / 0.1)',
              'display': 'flex',
              'flex-direction': 'column',
              // ShadCN: transition ease-in-out
              'transition': 'transform var(--transition-slower)',
              'border-radius': _borderRadius,
              ..._positionStyles,
              ...?props.decoration?.universalStyles(),
              ...?props.styles?.toMap(),
            },
          ),
          [
            // Header - ShadCN: p-6
            if (props.header != null || props.showCloseButton)
              dom.div(
                classes: 'arcane-drawer-header',
                styles: const dom.Styles(
                  raw: {
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'space-between',
                    // ShadCN: p-6
                    'padding': '24px',
                    'padding-bottom': '0',
                    'flex-shrink': '0',
                  },
                ),
                [
                  if (props.header != null) props.header!,
                  if (props.header == null)
                    const dom.span(styles: dom.Styles(raw: {}), []),
                  if (props.showCloseButton)
                    dom.button(
                      classes: 'arcane-drawer-close',
                      attributes: <String, String>{
                        'type': 'button',
                        'aria-label': 'Close drawer',
                        ...dismissAttrs(),
                      },
                      styles: const dom.Styles(
                        raw: {
                          'width': '24px',
                          'height': '24px',
                          'display': 'inline-flex',
                          'align-items': 'center',
                          'justify-content': 'center',
                          'padding': '0',
                          'border': 'none',
                          'background': 'transparent',
                          // ShadCN: opacity-70
                          'opacity': '0.7',
                          'color': 'var(--foreground)',
                          'cursor': 'pointer',
                          // ShadCN: rounded-sm
                          'border-radius': 'var(--radius-xs)',
                          'font-size': 'var(--font-size-base)',
                          // ShadCN: transition-opacity
                          'transition': 'opacity var(--transition)',
                        },
                      ),
                      events: {'click': (_) => props.onClose?.call()},
                      [ArcaneIcon.x(size: IconSize.sm)],
                    ),
                ],
              ),

            // Content - ShadCN: p-6
            dom.div(
              classes: 'arcane-drawer-content',
              styles: const dom.Styles(
                raw: {'flex': '1', 'overflow': 'auto', 'padding': '24px'},
              ),
              [props.child],
            ),

            // Footer
            if (props.footer != null)
              dom.div(
                classes: 'arcane-drawer-footer',
                styles: const dom.Styles(
                  raw: {
                    'padding': '24px',
                    'padding-top': '0',
                    'flex-shrink': '0',
                  },
                ),
                [props.footer!],
              ),
          ],
        ),
      ],
    );
  }

  static int _autoCounter = 0;
  static String _autoId() {
    _autoCounter++;
    return 'arcane-drawer-$_autoCounter';
  }
}
