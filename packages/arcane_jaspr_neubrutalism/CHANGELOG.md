# Changelog

## 3.3.0

- Align package version and Arcane Jaspr dependency with the 3.3.0 core release.
- Require the current Jaspr 0.23.1 dependency line.
- Export `NeubrutalismKnowledgeBaseRenderers` (moved here from `arcane_lexicon`).
  The package now depends on `arcane_lexicon` and owns its docs-chrome renderers,
  so a lexicon site selects this theme's chrome via
  `knowledgeBaseRenderers: const NeubrutalismKnowledgeBaseRenderers()`.

## 3.1.0

- Initial standalone Neubrutalism renderer package for Arcane Jaspr.
- Adds Neubrutalism component and adaptive layout renderers.
