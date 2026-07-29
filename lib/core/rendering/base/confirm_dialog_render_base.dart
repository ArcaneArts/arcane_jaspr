import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/button_props.dart';
import 'package:arcane_jaspr/core/props/confirm_dialog_props.dart';
import 'package:arcane_jaspr/core/props/dialog_props.dart';

/// Shared structural base for themed confirm-dialog renderers.
///
/// Every theme's confirm dialog is a thin composition over that theme's own
/// dialog and button renderers: it assembles a centered content column (an
/// optional icon plus the message) and a cancel/confirm action pair, then hands
/// the resulting [DialogProps] to the theme dialog. The assembly is identical
/// across themes; only the wrapping dialog/button widgets, a handful of values
/// (max width, gap, message font size, the content class) and the icon node
/// differ. Those divergent pieces are exposed as abstract members.
///
/// This base lives in core and depends only on core props; it must never depend
/// on a theme package — the theme dialog/button are supplied via [buildDialog]
/// and [buildButton].
abstract class ConfirmDialogRenderBase extends StatelessComponent {
  const ConfirmDialogRenderBase(this.props, {super.key});

  final ConfirmDialogProps props;

  /// Wraps the assembled [DialogProps] in the theme's dialog renderer.
  Component buildDialog(DialogProps props);

  /// Wraps [ButtonProps] in the theme's button renderer.
  Component buildButton(ButtonProps props);

  /// `max-width` (px) handed to the underlying dialog.
  double get maxWidth;

  /// CSS class applied to the content column.
  String get contentClass;

  /// `gap` between the icon and message in the content column.
  String get contentGap;

  /// `font-size` applied to the message text.
  String get messageFontSize;

  /// Builds the (theme-specific) icon node shown above the message.
  Component buildIcon(Component icon, bool destructive);

  @override
  Component build(BuildContext context) {
    return buildDialog(
      DialogProps(
        isOpen: true,
        title: props.title,
        onClose: props.onCancel,
        maxWidth: maxWidth,
        styles: props.styles,
        decoration: props.decoration,
        content: <Component>[
          dom.div(
            classes: contentClass,
            styles: dom.Styles(
              raw: <String, String>{
                'display': 'flex',
                'flex-direction': 'column',
                'align-items': 'center',
                'text-align': 'center',
                'gap': contentGap,
              },
            ),
            <Component>[
              if (props.icon != null) buildIcon(props.icon!, props.destructive),
              dom.div(
                styles: dom.Styles(
                  raw: <String, String>{
                    'color': 'var(--foreground)',
                    'font-size': messageFontSize,
                    'line-height': '1.625',
                  },
                ),
                <Component>[Component.text(props.message)],
              ),
            ],
          ),
        ],
        actions: <Component>[
          buildButton(
            ButtonProps(
              label: props.cancelText,
              variant: ButtonVariant.outline,
              onPressed: props.onCancel,
            ),
          ),
          props.destructive
              ? buildButton(
                  ButtonProps(
                    label: props.confirmText,
                    variant: ButtonVariant.destructive,
                    onPressed: props.onConfirm,
                  ),
                )
              : buildButton(
                  ButtonProps(
                    label: props.confirmText,
                    variant: ButtonVariant.primary,
                    onPressed: props.onConfirm,
                  ),
                ),
        ],
      ),
    );
  }
}

/// Shared structural base for themed alert-dialog renderers.
///
/// The alert dialog is the single-button sibling of the confirm dialog: a
/// centered icon/message column and one dismiss button. The content column has
/// no CSS class (unlike the confirm dialog) and the icon never reflects a
/// destructive state. Divergent pieces are exposed as abstract members.
abstract class AlertDialogRenderBase extends StatelessComponent {
  const AlertDialogRenderBase(this.props, {super.key});

  final AlertDialogProps props;

  /// Wraps the assembled [DialogProps] in the theme's dialog renderer.
  Component buildDialog(DialogProps props);

  /// Wraps [ButtonProps] in the theme's button renderer.
  Component buildButton(ButtonProps props);

  /// `max-width` (px) handed to the underlying dialog.
  double get maxWidth;

  /// `gap` between the icon and message in the content column.
  String get contentGap;

  /// `font-size` applied to the message text.
  String get messageFontSize;

  /// Builds the (theme-specific) icon node shown above the message.
  Component buildIcon(Component icon);

  @override
  Component build(BuildContext context) {
    return buildDialog(
      DialogProps(
        isOpen: true,
        title: props.title,
        onClose: props.onDismiss,
        maxWidth: maxWidth,
        styles: props.styles,
        decoration: props.decoration,
        content: <Component>[
          dom.div(
            styles: dom.Styles(
              raw: <String, String>{
                'display': 'flex',
                'flex-direction': 'column',
                'align-items': 'center',
                'text-align': 'center',
                'gap': contentGap,
              },
            ),
            <Component>[
              if (props.icon != null) buildIcon(props.icon!),
              dom.div(
                styles: dom.Styles(
                  raw: <String, String>{
                    'color': 'var(--foreground)',
                    'font-size': messageFontSize,
                    'line-height': '1.625',
                  },
                ),
                <Component>[Component.text(props.message)],
              ),
            ],
          ),
        ],
        actions: <Component>[
          buildButton(
            ButtonProps(
              label: props.buttonText,
              variant: ButtonVariant.primary,
              onPressed: props.onDismiss,
            ),
          ),
        ],
      ),
    );
  }
}
