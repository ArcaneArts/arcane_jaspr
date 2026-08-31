import '../../util/arcane.dart' show EdgeInsets;
import '../../util/style_types/index.dart';

/// Theme-neutral elevation *intent*.
///
/// A component asks for a depth; the active theme decides what that renders as:
/// the default/shadcn theme emits an ambient drop shadow, while neubrutalism
/// uses a hard offset block. The call site never names pixels —
/// it names intent, which is what keeps a decoration portable across themes.
enum Elevation { none, xs, sm, md, lg, xl }

/// A per-instance, theme-permeable box surface — the semantic counterpart to
/// bounded literal [ArcaneStyleData] overrides (`styles:`).
///
/// Fields fall into three buckets:
///
/// * **Universal** ([color], [borderRadius], [border], [padding], …) — rendered
///   literally and identically on every theme.
///   [universalStyles] compiles them to CSS.
/// * **Intent** ([elevation]) — every theme maps it to its own idiom via the
///   render base's `decorationStyles` hook.
/// Colors are CSS strings (hex, `var(--x)`, a runtime accent, or the typed
/// `ArcaneColor.*.css`), consistent with the rest of the style DSL.
class ArcaneDecoration {
  // --- Universal (literal on every theme) ---
  final String? color;
  final Radius? borderRadius;
  final String? border;
  final EdgeInsets? padding;
  final String? paddingCustom;

  // --- Intent (theme maps to its idiom) ---
  final Elevation? elevation;

  const ArcaneDecoration({
    this.color,
    this.borderRadius,
    this.border,
    this.padding,
    this.paddingCustom,
    this.elevation,
  });

  /// The universal fields compiled to CSS. Intent ([elevation]) is deliberately
  /// absent because a theme resolves it through `decorationStyles`.
  Map<String, String> universalStyles() => ArcaneStyleData(
    backgroundCustom: color,
    borderRadius: borderRadius,
    borderCustom: border,
    paddingCustom: padding,
    paddingStringCustom: paddingCustom,
  ).toMap();

  ArcaneDecoration copyWith({
    String? color,
    Radius? borderRadius,
    String? border,
    EdgeInsets? padding,
    String? paddingCustom,
    Elevation? elevation,
  }) => ArcaneDecoration(
    color: color ?? this.color,
    borderRadius: borderRadius ?? this.borderRadius,
    border: border ?? this.border,
    padding: padding ?? this.padding,
    paddingCustom: paddingCustom ?? this.paddingCustom,
    elevation: elevation ?? this.elevation,
  );
}
