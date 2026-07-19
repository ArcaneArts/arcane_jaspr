/// Applies each map in [overrides] onto [base] so that every overridden key
/// ends up LAST in iteration order — and therefore last in the emitted inline
/// `style` attribute, where it wins.
///
/// A plain `<String, String>{...base, ...override}` spread does NOT guarantee
/// this: a Dart map keeps a key's ORIGINAL insertion position when a later
/// spread merely overwrites its value. So an override `background` (shorthand)
/// can be emitted before an earlier `background-color` (longhand) and lose the
/// CSS cascade even though it was "spread last". Remove-then-reinsert moves each
/// overridden key to the end, making "later layer" == "later in the CSS".
///
/// This is the mechanism behind the permeability contract: theme base/variant
/// styles form [base]; the per-instance `decoration` (universal), theme-resolved
/// `decorationStyles`, and the literal `styles:` escape hatch are the ordered
/// [overrides], so the literal layer always wins.
Map<String, String> layerStyles(
  Map<String, String> base,
  List<Map<String, String>?> overrides,
) {
  for (final Map<String, String>? o in overrides) {
    if (o == null) continue;
    for (final MapEntry<String, String> e in o.entries) {
      base
        ..remove(e.key)
        ..[e.key] = e.value;
    }
  }
  return base;
}
