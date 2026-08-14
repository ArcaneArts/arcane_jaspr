# Changelog

## x.x.x

### Changed

- Rounded cards and alerts now use complete accent borders instead of clipped
  top strips or thick left edges.

## 3.3.0

- Align package version and Arcane Jaspr dependency with the 3.3.0 core release.
- Require the current Jaspr 0.23.1 dependency line.
- Export `NeonKnowledgeBaseRenderers` (moved here from `arcane_lexicon`). The
  package now depends on `arcane_lexicon` and owns its docs-chrome renderers, so a
  lexicon site selects this theme's chrome via
  `knowledgeBaseRenderers: const NeonKnowledgeBaseRenderers()`.

## 3.1.0

- Initial standalone Neon renderer package for Arcane Jaspr.
- Adds Neon component and adaptive layout renderers.
