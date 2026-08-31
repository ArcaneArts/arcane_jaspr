import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';

/// Neon deliberately ignores decorative elevation.
///
/// Depth is reserved for transient overlays owned by their renderers. Cards,
/// controls, and other document surfaces remain flat.
Map<String, String> neonDecorationStyles(ArcaneDecoration? _) =>
    const <String, String>{};
