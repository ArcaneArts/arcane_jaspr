import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/props/card_props.dart';
import 'package:arcane_jaspr/core/rendering/base/card_render_base.dart';

import 'decoration_styles.dart';

/// ShadCN Card renderer.
///
/// Reference: https://ui.shadcn.com/docs/components/card
class ShadcnCard extends CardRenderBase {
  const ShadcnCard(super.props, {super.key});

  @override
  String get cssClass => 'arcane-card';

  @override
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      shadcnDecorationStyles(decoration);

  // ShadCN Card: rounded-lg border bg-card text-card-foreground shadow-sm
  @override
  Map<String, String> baseStyles(CardProps props) => <String, String>{
    'border-radius': props.borderRadius ?? '0.5rem', // rounded-lg
    'color': 'var(--card-foreground)',
    if (props.padding != null)
      'padding': props.padding!
    else
      'padding': '1.5rem', // p-6
    if (props.fillWidth) 'width': '100%',
    if (props.onTap != null) 'cursor': 'pointer',
  };

  @override
  Map<String, String> variantStyles(CardProps props) => switch (props.variant) {
    CardVariant.elevated => <String, String>{
      'background-color': props.backgroundColor ?? 'var(--card)',
      'border': '1px solid var(--border)',
      'box-shadow': 'var(--shadow-xs)', // shadow-sm
    },
    CardVariant.flat => <String, String>{
      'background-color': props.backgroundColor ?? 'var(--card)',
      'border': '1px solid var(--border)',
      'box-shadow': 'none',
    },
    CardVariant.outlined => <String, String>{
      'background-color': props.backgroundColor ?? 'var(--background)',
      'border': '1px solid var(--border)',
      'box-shadow': 'none',
    },
    CardVariant.ghost => <String, String>{
      'background-color': 'transparent',
      'border': 'none',
      'box-shadow': 'none',
    },
    CardVariant.glass => <String, String>{
      'background-color': 'color-mix(in srgb, var(--card) 80%, transparent)',
      'border': '1px solid var(--border)',
      'box-shadow': 'var(--shadow-xs)',
      'backdrop-filter': 'blur(8px)',
      '-webkit-backdrop-filter': 'blur(8px)',
    },
    CardVariant.interactive => <String, String>{
      'background-color': props.backgroundColor ?? 'var(--card)',
      'border': '1px solid var(--border)',
      'box-shadow': 'var(--shadow-xs)',
      'transition': 'all var(--transition)',
    },
  };
}
