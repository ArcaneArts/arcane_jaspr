import 'package:arcane_jaspr/flutter.dart';

enum LoaderVariant {
  spinner,
  dots,
  pulse,
}

/// Loader component properties.
class LoaderProps {
  final LoaderVariant variant;
  final String size;
  final String? color;
  final String strokeWidth;
  final String dotSize;

  const LoaderProps({
    this.variant = LoaderVariant.spinner,
    this.size = '32px',
    this.color,
    this.strokeWidth = '3px',
    this.dotSize = '8px',
  });

  const LoaderProps.spinner({
    this.size = '32px',
    this.color,
    this.strokeWidth = '3px',
  })  : variant = LoaderVariant.spinner,
        dotSize = '8px';

  const LoaderProps.dots({
    this.color,
    this.dotSize = '8px',
  })  : variant = LoaderVariant.dots,
        size = '32px',
        strokeWidth = '3px';

  const LoaderProps.pulse({
    this.size = '40px',
    this.color,
  })  : variant = LoaderVariant.pulse,
        strokeWidth = '3px',
        dotSize = '8px';
}

/// Loading overlay component properties.
class LoadingOverlayProps {
  final Widget? loader;
  final String? message;

  const LoadingOverlayProps({
    this.loader,
    this.message,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for loader components.
mixin LoaderRendererContract {
  Widget loader(LoaderProps props);
  Widget loadingOverlay(LoadingOverlayProps props);
}
