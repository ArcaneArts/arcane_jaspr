# Repository Guidelines

## Project Structure & Module Organization

- `lib/` holds the Arcane Jaspr UI library source. Key entry point is `lib/arcane_jaspr.dart`, with components under `lib/component/` and utilities under `lib/util/`.
- `test/` contains Dart tests (`*_test.dart`) for styles, themes, and auth.
- `assets/` stores fonts and other static assets used by the design system.
- `arcane_jaspr_codex/` is the documentation site workspace; the Jaspr app lives in `arcane_jaspr_codex/arcane_codex_web/`.

## Build, Test, and Development Commands

- `dart pub get` installs dependencies for the package.
- `dart analyze lib/` runs the analyzer with the repository lint rules.
- `dart test` runs the unit tests; use `dart test -p chrome` when tests require web APIs (noted in `README.md`).
- `dart run build_runner build --delete-conflicting-outputs` runs code generation.
- `dart-auto-const` applies auto-const optimizations (see `pubspec.yaml` scripts).
- Docs site: `cd arcane_jaspr_codex/arcane_codex_web && dart pub get && jaspr serve`.

## Coding Style & Naming Conventions

- Follow Dart style conventions (2-space indentation, `UpperCamelCase` for types, `lowerCamelCase` for members, `snake_case` for file names).
- Linting uses `package:lints/recommended` plus const/final preference rules in `analysis_options.yaml`.
- Prefer `const` constructors and `final` locals/fields when possible.

## Testing Guidelines

- Tests live in `test/` and should be named `*_test.dart` (e.g., `test/theme_test.dart`).
- Run tests with `dart test` and target Chrome when web APIs are involved.

## Commit & Pull Request Guidelines

- Proposed commit format: `type(scope): summary` (Conventional Commits style). Types: `feat`, `fix`, `docs`, `style`, `refactor`, `test`, `chore`, `ci`, `build`, `revert`.
- Keep the subject <= 72 chars, imperative voice, no period. Example: `feat(components): add arcane tooltip variants`.
- Use a body for rationale, breaking changes, or migration notes; wrap at ~72 chars.
- PRs should describe what changed, why it changed, and link relevant issues or docs updates. Include screenshots or snippets for visual component changes.

## Documentation Updates

- If you add or change public components or APIs, update the docs site under `arcane_jaspr_codex/` (navigation, demos, and markdown content as outlined in `CLAUDE.md`).
