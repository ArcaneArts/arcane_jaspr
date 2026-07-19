import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/progress_props.dart';
import 'package:arcane_jaspr/core/rendering/base/progress_render_base.dart';

/// ShadCN Progress renderer.
///
/// Reference: https://ui.shadcn.com/docs/components/progress
///
/// ShadCN's linear progress diverges structurally from the other themes (it
/// carries the `progressbar` ARIA attributes on the root and renders the
/// indicator directly without a track wrapper or value readout), so it is not
/// migrated to [ProgressRenderBase].
class ShadcnProgress extends StatelessComponent {
  final ProgressProps props;

  const ShadcnProgress(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    // Clamp value between 0 and 1
    final clampedValue = props.value.clamp(0.0, 1.0);
    final percentage = (clampedValue * 100).round();

    // Size-specific height
    final height = switch (props.size) {
      ComponentSize.sm => '0.25rem', // 4px
      ComponentSize.md =>
        '0.5rem', // 8px - ShadCN default is h-4 but that's too tall
      ComponentSize.lg => '0.75rem', // 12px
    };

    // Variant-specific indicator color
    final indicatorColor =
        props.indicatorColor ??
        switch (props.variant) {
          ProgressVariant.primary => 'var(--primary)',
          ProgressVariant.success => 'var(--success, #22c55e)',
          ProgressVariant.warning => 'var(--warning, #f59e0b)',
          ProgressVariant.error => 'var(--destructive)',
          ProgressVariant.info => 'var(--info, #3b82f6)',
        };

    final trackColor = props.trackColor ?? 'var(--secondary)';

    // ShadCN Progress: relative h-4 w-full overflow-hidden rounded-full bg-secondary
    return dom.div(
      classes: 'arcane-progress',
      attributes: {
        'role': 'progressbar',
        'aria-valuemin': '0',
        'aria-valuemax': '100',
        'aria-valuenow': '$percentage',
      },
      styles: dom.Styles(
        raw: {
          'position': 'relative',
          'width': '100%',
          'height': height,
          'overflow': 'hidden',
          'border-radius': 'var(--radius-full)', // rounded-full
          'background-color': trackColor,
          ...?props.decoration?.universalStyles(),
          ...?props.styles?.toMap(),
        },
      ),
      [
        // ShadCN Progress indicator: h-full w-full flex-1 bg-primary transition-all
        dom.div(
          classes:
              'arcane-progress-indicator ${props.indeterminate ? 'indeterminate' : ''}',
          styles: dom.Styles(
            raw: {
              'height': '100%',
              'background-color': indicatorColor,
              'border-radius': 'var(--radius-full)',
              'transition': 'width var(--transition-slow)',
              if (props.indeterminate) ...{
                'width': '50%',
                'animation':
                    'arcane-progress-indeterminate 1.5s ease-in-out infinite',
              } else ...{
                'width': '$percentage%',
              },
            },
          ),
          [],
        ),
      ],
    );
  }
}

/// ShadCN Circular Progress renderer.
class ShadcnCircularProgress extends CircularProgressRenderBase {
  const ShadcnCircularProgress(super.props, {super.key});

  @override
  String get rootClass => 'arcane-circular-progress';

  @override
  Map<String, String> rootStyles(CircularProgressProps props) {
    final String actualSize = props.size ?? '80px';
    return <String, String>{
      'position': 'relative',
      'width': actualSize,
      'height': actualSize,
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'center',
    };
  }

  @override
  Map<String, String> ringStyles(CircularProgressProps props) {
    final String actualStroke = props.strokeWidth ?? '8px';
    final String fillColor = props.fillColor ?? 'var(--primary)';
    final String trackColor = props.trackColor ?? 'var(--muted)';
    return <String, String>{
      'position': 'absolute',
      'width': '100%',
      'height': '100%',
      'border-radius': 'var(--radius-full)',
      'background':
          'conic-gradient($fillColor 0deg ${props.value * 360}deg, $trackColor ${props.value * 360}deg 360deg)',
      'mask':
          'radial-gradient(farthest-side, transparent calc(100% - $actualStroke), #fff calc(100% - $actualStroke))',
      '-webkit-mask':
          'radial-gradient(farthest-side, transparent calc(100% - $actualStroke), #fff calc(100% - $actualStroke))',
    };
  }

  @override
  bool showCenter(CircularProgressProps props) => true;

  @override
  Map<String, String> get percentStyles => <String, String>{
    'font-size': 'var(--font-size-xl)',
    'font-weight': 'var(--font-weight-bold)',
    'color': 'var(--foreground)',
  };

  @override
  Map<String, String> get labelStyles => <String, String>{
    'font-size': 'var(--font-size-sm)',
    'color': 'var(--muted-foreground)',
  };
}

/// ShadCN Loading Spinner renderer.
///
/// Renders a `<div role="status">`, unlike the bare `<span>` used by the other
/// themes, so it is not migrated to [LoadingSpinnerRenderBase].
class ShadcnLoadingSpinner extends StatelessComponent {
  final LoadingSpinnerProps props;

  const ShadcnLoadingSpinner(this.props, {super.key});

  @override
  Component build(BuildContext context) {
    final actualSize = props.size ?? '24px';
    final spinnerColor = props.color ?? 'var(--primary)';

    return dom.div(
      classes: 'arcane-loading-spinner',
      attributes: {'role': 'status', 'aria-label': 'Loading'},
      styles: dom.Styles(
        raw: {
          'width': actualSize,
          'height': actualSize,
          'border': '3px solid var(--border)',
          'border-top-color': spinnerColor,
          'border-radius': 'var(--radius-full)',
          'animation': 'arcane-spin 0.75s linear infinite',
          ...?props.decoration?.universalStyles(),
          ...?props.styles?.toMap(),
        },
      ),
      [],
    );
  }
}
