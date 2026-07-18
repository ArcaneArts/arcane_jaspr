import 'package:arcane_lexicon/arcane_lexicon.dart'
    show DefaultKnowledgeBaseRenderers, KnowledgeBaseRenderData;

/// Knowledge base (docs) chrome renderers for the Windows 95 theme.
///
/// Extends the lexicon [DefaultKnowledgeBaseRenderers] with the Win95 top-bar
/// class hooks so an `arcane_lexicon` site can render its docs chrome with this
/// theme by passing `knowledgeBaseRenderers: const Win95KnowledgeBaseRenderers()`.
class Win95KnowledgeBaseRenderers extends DefaultKnowledgeBaseRenderers {
  const Win95KnowledgeBaseRenderers() : super(id: 'win95', prefix: 'win95');

  @override
  String get topBarClass => 'kb-topbar win95-kb-topbar win95-kb-topbar-owned';

  @override
  bool showTopBarBranding(KnowledgeBaseRenderData data) =>
      data.showNavigationBar && data.useTopPosition;
}
