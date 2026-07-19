library;

/// Per-theme knowledge-base (docs) chrome renderers, split out of the theme
/// packages so those stay web-safe (free of the arcane_lexicon / dart:io docs
/// stack). A docs site depends on `arcane_jaspr_kb` and passes the matching
/// renderer, e.g. `knowledgeBaseRenderers: const Win95KnowledgeBaseRenderers()`.
export 'src/shadcn_kb_renderers.dart';
export 'src/neubrutalism_kb_renderers.dart';
export 'src/neon_kb_renderers.dart';
export 'src/win95_kb_renderers.dart';
