import 'package:arcane_jaspr/flutter.dart';

/// Search result item data.
class SearchResult {
  final String title;
  final String? subtitle;
  final String? href;
  final VoidCallback? onTap;

  const SearchResult({
    required this.title,
    this.subtitle,
    this.href,
    this.onTap,
  });
}
