/// Application constants for the documentation site
class AppConstants {
  AppConstants._();

  /// Site name displayed in header and title
  static const String siteName = 'ArcaneJaspr Codex';

  /// Site description for meta tags
  static const String siteDescription =
      'Documentation for ArcaneJaspr - A dart package for building web ui with Jaspr.';

  /// GitHub repository URL (leave empty to hide GitHub link)
  static const String githubUrl = '';

  /// Base URL for the site (for GitHub Pages subdirectory hosting)
  ///
  /// In development: Empty string (serves from root)
  /// In production: '/arcane_jaspr' (GitHub Pages subdirectory)
  ///
  /// Usage:
  ///   - Dev: `jaspr serve` (defaults to empty)
  ///   - Build: `jaspr build --define=BASE_URL=/arcane_jaspr`
  static const String baseUrl = String.fromEnvironment(
    'BASE_URL',
    defaultValue: '', // Empty for local dev, override for production
  );
}
