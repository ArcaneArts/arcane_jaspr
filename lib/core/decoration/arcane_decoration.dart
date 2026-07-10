import '../../util/arcane.dart' show EdgeInsets;
import '../../util/style_types/index.dart';

/// Theme-neutral elevation *intent*.
///
/// A component asks for a depth; the active theme decides what that renders as:
/// the default/shadcn theme emits an ambient blurred drop shadow, neubrutalism
/// a hard offset block, neon a colored glow. The call site never names pixels —
/// it names intent, which is what keeps a decoration portable across themes.
enum Elevation { none, xs, sm, md, lg, xl }

/// A per-instance, theme-permeable box surface — the semantic counterpart to
/// the literal [ArcaneStyleData] escape hatch (`styles:`).
///
/// Fields fall into three buckets:
///
/// * **Universal** ([color], [gradient], [borderRadius], [border], [padding],
///   [backdropFilter], …) — rendered literally and identically on every theme.
///   [universalStyles] compiles them to CSS.
/// * **Intent** ([elevation]) — every theme maps it to its own idiom via the
///   render base's `decorationStyles` hook.
/// * **Theme-specific** ([shadowColor]) — read by the theme(s) that implement it
///   (neubrutalism recolors its offset shadow) and silently ignored by the rest.
///
/// Colors are CSS strings (hex, `var(--x)`, a runtime accent, or the typed
/// `ArcaneColor.*.css`), consistent with the rest of the style DSL.
class ArcaneDecoration {
  // --- Universal (literal on every theme) ---
  final String? color;
  final String? gradient;
  final Radius? borderRadius;
  final String? borderRadiusCustom;
  final String? border;
  final EdgeInsets? padding;
  final String? paddingCustom;
  final BackdropFilter? backdropFilter;
  final String? backdropFilterCustom;

  // --- Intent (theme maps to its idiom) ---
  final Elevation? elevation;

  // --- Theme-specific (honored by some themes, ignored by others) ---
  final String? shadowColor;

  const ArcaneDecoration({
    this.color,
    this.gradient,
    this.borderRadius,
    this.borderRadiusCustom,
    this.border,
    this.padding,
    this.paddingCustom,
    this.backdropFilter,
    this.backdropFilterCustom,
    this.elevation,
    this.shadowColor,
  });

  /// The universal fields compiled to CSS. Intent ([elevation]) and
  /// theme-specific ([shadowColor]) fields are deliberately absent — a theme
  /// resolves those through its `decorationStyles` override.
  Map<String, String> universalStyles() => ArcaneStyleData(
        backgroundCustom: gradient ?? color,
        borderRadius: borderRadius,
        borderRadiusCustom: borderRadiusCustom,
        borderCustom: border,
        paddingCustom: padding,
        paddingStringCustom: paddingCustom,
        backdropFilter: backdropFilter,
        backdropFilterCustom: backdropFilterCustom,
      ).toMap();

  ArcaneDecoration copyWith({
    String? color,
    String? gradient,
    Radius? borderRadius,
    String? borderRadiusCustom,
    String? border,
    EdgeInsets? padding,
    String? paddingCustom,
    BackdropFilter? backdropFilter,
    String? backdropFilterCustom,
    Elevation? elevation,
    String? shadowColor,
  }) =>
      ArcaneDecoration(
        color: color ?? this.color,
        gradient: gradient ?? this.gradient,
        borderRadius: borderRadius ?? this.borderRadius,
        borderRadiusCustom: borderRadiusCustom ?? this.borderRadiusCustom,
        border: border ?? this.border,
        padding: padding ?? this.padding,
        paddingCustom: paddingCustom ?? this.paddingCustom,
        backdropFilter: backdropFilter ?? this.backdropFilter,
        backdropFilterCustom: backdropFilterCustom ?? this.backdropFilterCustom,
        elevation: elevation ?? this.elevation,
        shadowColor: shadowColor ?? this.shadowColor,
      );
}
