import 'package:arcane_jaspr/flutter.dart';

/// Center body component properties.
class CenterBodyProps {
  final Widget child;
  final double? maxWidth;
  final String? padding;
  final bool fillHeight;

  const CenterBodyProps({
    required this.child,
    this.maxWidth,
    this.padding,
    this.fillHeight = true,
  });
}

/// Page body component properties.
class PageBodyProps {
  final List<Widget> children;
  final double maxWidth;
  final String? padding;

  const PageBodyProps({
    required this.children,
    this.maxWidth = 1200,
    this.padding,
  });
}

/// Loading state component properties.
class LoadingStateProps {
  final String? message;

  const LoadingStateProps({
    this.message,
  });
}

/// Error state component properties.
class ErrorStateProps {
  final String? title;
  final String? message;
  final Widget? action;

  const ErrorStateProps({
    this.title,
    this.message,
    this.action,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for center body components.
mixin CenterBodyRendererContract {
  Widget centerBody(CenterBodyProps props);
  Widget pageBody(PageBodyProps props);
  Widget loadingState(LoadingStateProps props);
  Widget errorState(ErrorStateProps props);
}
