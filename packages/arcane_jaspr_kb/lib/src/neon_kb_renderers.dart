import 'package:arcane_lexicon/arcane_lexicon.dart'
    show DefaultKnowledgeBaseRenderers, KnowledgeBaseRenderData;

/// Knowledge base (docs) chrome renderers for the Neon theme.
///
/// Extends the lexicon [DefaultKnowledgeBaseRenderers] with the Neon top-bar
/// class hooks so an `arcane_lexicon` site can render its docs chrome with this
/// theme by passing `knowledgeBaseRenderers: const NeonKnowledgeBaseRenderers()`.
class NeonKnowledgeBaseRenderers extends DefaultKnowledgeBaseRenderers {
  const NeonKnowledgeBaseRenderers() : super(id: 'neon', prefix: 'neon');

  @override
  String get topBarClass => 'kb-topbar neon-kb-topbar neon-kb-topbar-owned';

  @override
  bool showTopBarBranding(KnowledgeBaseRenderData data) =>
      data.showNavigationBar && data.useTopPosition;
}
