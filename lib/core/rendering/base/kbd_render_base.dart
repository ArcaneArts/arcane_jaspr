import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/props/kbd_props.dart';

/// Shared structural base for themed keyboard-shortcut (`kbd`) renderers.
///
/// Factors the identical build logic shared by every theme's kbd renderer
/// (the single-key vs key-combo branch, the combo wrapper span, the per-key
/// `<kbd>` element, and the identical separator span) into one place. A
/// concrete theme renderer only supplies the value-producing members below:
/// the optional CSS class on each `<kbd>` element, the gap used between combo
/// keys, and the resolved per-`<kbd>` style map (which already folds in the
/// theme's size and style-variant values).
///
/// This base lives in core and depends only on core props; it must never
/// depend on a theme package.
abstract class KbdRenderBase extends StatelessComponent {
  const KbdRenderBase(this.props, {super.key});

  final KbdProps props;

  /// CSS class applied to each `<kbd>` element, or `null` for no class.
  String? get kbdClasses;

  /// `gap` value applied to the combo wrapper span between keys.
  String get keysWrapperGap;

  /// Resolved inline styles for each `<kbd>` element (size + style variant).
  Map<String, String> get styleMap;

  /// Per-instance decoration overrides. Default: none. A theme overrides this
  /// to translate an [ArcaneDecoration] (elevation intent, theme-specific
  /// fields) into its own CSS. Fields a theme does not implement are ignored.
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      const <String, String>{};

  @override
  Component build(BuildContext context) {
    if (props.keys != null && props.keys!.isNotEmpty) {
      return dom.span(
        styles: dom.Styles(
          raw: <String, String>{
            'display': 'inline-flex',
            'align-items': 'center',
            'gap': keysWrapperGap,
          },
        ),
        <Component>[
          for (int i = 0; i < props.keys!.length; i++) ...<Component>[
            Component.element(
              tag: 'kbd',
              classes: kbdClasses,
              styles: dom.Styles(
                raw: <String, String>{
                  ...styleMap,
                  ...?props.decoration?.universalStyles(),
                  ...decorationStyles(props.decoration),
                  ...?props.styles?.toMap(),
                },
              ),
              children: <Component>[Component.text(props.keys![i])],
            ),
            if (i < props.keys!.length - 1)
              dom.span(
                styles: const dom.Styles(
                  raw: <String, String>{
                    'color': 'var(--muted-foreground)',
                    'font-size': 'var(--font-size-xs)',
                  },
                ),
                <Component>[Component.text(props.separator)],
              ),
          ],
        ],
      );
    }

    return Component.element(
      tag: 'kbd',
      classes: kbdClasses,
      styles: dom.Styles(
        raw: <String, String>{
          ...styleMap,
          ...?props.decoration?.universalStyles(),
          ...decorationStyles(props.decoration),
          ...?props.styles?.toMap(),
        },
      ),
      children: <Component>[Component.text(props.keyText ?? '')],
    );
  }
}
