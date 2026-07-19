/// Joins CSS class names into a single space-separated string, skipping nulls
/// and blank entries.
///
/// Replaces the ad-hoc `_joinClasses` helper that otherwise gets copy-pasted
/// across sites when composing conditional classes:
///
/// ```dart
/// classes: cx(<String?>['card', isActive ? 'is-active' : null, size]),
/// ```
String cx(List<String?> classes) =>
    classes.where((String? c) => c != null && c.trim().isNotEmpty).join(' ');
