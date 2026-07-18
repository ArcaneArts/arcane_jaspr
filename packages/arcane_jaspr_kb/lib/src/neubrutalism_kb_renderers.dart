import 'package:arcane_lexicon/arcane_lexicon.dart'
    show DefaultKnowledgeBaseRenderers, KnowledgeBaseRenderData;

/// Knowledge base (docs) chrome renderers for the Neubrutalism theme.
///
/// Extends the lexicon [DefaultKnowledgeBaseRenderers] so an `arcane_lexicon`
/// site can render its docs chrome with this theme by passing
/// `knowledgeBaseRenderers: const NeubrutalismKnowledgeBaseRenderers()`.
class NeubrutalismKnowledgeBaseRenderers extends DefaultKnowledgeBaseRenderers {
  const NeubrutalismKnowledgeBaseRenderers()
    : super(id: 'neubrutalism', prefix: 'nb');

  @override
  bool showTopBarBranding(KnowledgeBaseRenderData data) =>
      data.showNavigationBar && data.useTopPosition;
}
