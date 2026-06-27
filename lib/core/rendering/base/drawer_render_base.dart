import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/drawer_props.dart';

/// Shared structural base for the Neon-family drawer renderers (Neon and
/// Neubrutalism).
///
/// Both share an identical DOM: a single overlay (carrying the optional
/// backdrop) wrapping a fixed panel that holds an optional header (a flexible
/// header slot plus a close button), the content, and an optional footer. They
/// differ only in the theme class prefix, the panel-edge border, the overlay
/// backdrop styles, the panel decoration styles, the header/footer border, the
/// close button styles, and the auto-generated surface id prefix.
///
/// The ShadCN drawer uses a different DOM (a container with a separate backdrop
/// element and pointer-events toggling) and therefore does not extend this base.
///
/// This base lives in core and depends only on core props and interaction
/// helpers; it must never depend on a theme package.
abstract class DrawerRenderBase extends StatelessComponent {
  const DrawerRenderBase(this.props, {super.key});

  final DrawerProps props;

  /// CSS class prefix (e.g. `'neon'`, `'neubrutalism'`).
  String get themePrefix;

  /// Border applied to the panel edge that faces the viewport interior.
  String get positionBorder;

  /// Inline styles appended to the overlay when [DrawerProps.showBackdrop] is
  /// true (the backdrop color and any blur).
  Map<String, String> get overlayBackdropStyles;

  /// Decoration styles appended to the panel after its layout styles
  /// (background, shadow, blur, overflow).
  Map<String, String> get panelDecorationStyles;

  /// Border applied to the header bottom and the footer top.
  String get headerFooterBorder;

  /// Inline styles for the close button.
  Map<String, String> get closeButtonStyles;

  /// Generates the fallback surface id when [DrawerProps.id] is null. Each theme
  /// keeps its own static counter so the generated id sequence is preserved.
  String generateAutoId();

  @override
  Component build(BuildContext context) {
    final String surfaceId = props.id ?? generateAutoId();
    final bool isHorizontal =
        props.position == DrawerPosition.left ||
        props.position == DrawerPosition.right;

    final String sizeValue = switch (props.size) {
      DrawerSize.sm => isHorizontal ? '320px' : '30vh',
      DrawerSize.md => isHorizontal ? '400px' : '50vh',
      DrawerSize.lg => isHorizontal ? '540px' : '70vh',
      DrawerSize.xl => isHorizontal ? '720px' : '90vh',
      DrawerSize.full => '100%',
    };

    final Map<String, String> positionStyles = switch (props.position) {
      DrawerPosition.left => <String, String>{
        'left': '0',
        'top': '0',
        'bottom': '0',
        'width': props.width ?? sizeValue,
        'border-right': positionBorder,
      },
      DrawerPosition.right => <String, String>{
        'right': '0',
        'top': '0',
        'bottom': '0',
        'width': props.width ?? sizeValue,
        'border-left': positionBorder,
      },
      DrawerPosition.top => <String, String>{
        'left': '0',
        'right': '0',
        'top': '0',
        'height': props.height ?? sizeValue,
        'border-bottom': positionBorder,
      },
      DrawerPosition.bottom => <String, String>{
        'left': '0',
        'right': '0',
        'bottom': '0',
        'height': props.height ?? sizeValue,
        'border-top': positionBorder,
      },
    };

    return dom.div(
      classes: '$themePrefix-drawer-overlay',
      attributes: <String, String>{
        ...surfaceAttrs(
          surface: 'drawer',
          id: surfaceId,
          initiallyOpen: props.isOpen,
          dismissible: props.closeOnBackdropClick,
          escapeCloses: props.escapeCloses,
          focusTrap: props.focusTrap,
          scrimCloses: props.closeOnBackdropClick,
          restoreFocus: props.restoreFocus,
        ),
        'data-arcane-scrim': '',
        'data-position': props.position.name,
      },
      styles: dom.Styles(
        raw: <String, String>{
          'position': 'fixed',
          'inset': '0',
          'z-index': '50',
          if (props.showBackdrop) ...overlayBackdropStyles,
        },
      ),
      events: <String, EventCallback>{
        if (props.closeOnBackdropClick && props.onClose != null)
          'click': (event) {
            if (event.target == event.currentTarget) {
              props.onClose!();
            }
          },
      },
      <Component>[
        dom.div(
          classes: '$themePrefix-drawer',
          attributes: const <String, String>{
            'role': 'dialog',
            'aria-modal': 'true',
            'data-arcane-autofocus': '',
          },
          styles: dom.Styles(
            raw: <String, String>{
              'position': 'fixed',
              ...positionStyles,
              'display': 'flex',
              'flex-direction': 'column',
              ...panelDecorationStyles,
            },
          ),
          events: <String, EventCallback>{
            'click': (event) => event.stopPropagation(),
          },
          <Component>[
            if (props.header != null || props.showCloseButton)
              dom.div(
                classes: '$themePrefix-drawer-header',
                styles: dom.Styles(
                  raw: <String, String>{
                    'display': 'flex',
                    'align-items': 'center',
                    'justify-content': 'space-between',
                    'flex-shrink': '0',
                    'padding': '1.25rem 1.5rem',
                    'border-bottom': headerFooterBorder,
                  },
                ),
                <Component>[
                  if (props.header != null)
                    dom.div(
                      styles: const dom.Styles(raw: <String, String>{'flex': '1'}),
                      <Component>[props.header!],
                    )
                  else
                    const dom.div(
                      <Component>[],
                      styles: dom.Styles(raw: <String, String>{'flex': '1'}),
                    ),
                  if (props.showCloseButton)
                    dom.button(
                      classes: '$themePrefix-drawer-close',
                      attributes: <String, String>{
                        'type': 'button',
                        'aria-label': 'Close drawer',
                        ...dismissAttrs(),
                      },
                      styles: dom.Styles(raw: closeButtonStyles),
                      events: props.onClose == null
                          ? null
                          : <String, EventCallback>{
                              'click': (_) => props.onClose!(),
                            },
                      const <Component>[Component.text('\u2715')],
                    ),
                ],
              ),
            dom.div(
              classes: '$themePrefix-drawer-content',
              styles: const dom.Styles(
                raw: <String, String>{
                  'flex': '1',
                  'overflow-y': 'auto',
                  'padding': '1.5rem',
                },
              ),
              <Component>[props.child],
            ),
            if (props.footer != null)
              dom.div(
                classes: '$themePrefix-drawer-footer',
                styles: dom.Styles(
                  raw: <String, String>{
                    'flex-shrink': '0',
                    'padding': '1.25rem 1.5rem',
                    'border-top': headerFooterBorder,
                  },
                ),
                <Component>[props.footer!],
              ),
          ],
        ),
      ],
    );
  }
}
