import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;

import '../../util/arcane.dart';
import '../../util/tokens/tokens.dart';
import '../view/bar.dart';

/// Base screen component that provides consistent layout structure.
class ArcaneScreen extends StatelessComponent {
  /// Main content
  final Component child;

  /// Header bar
  final Component? header;

  /// Title text (creates a Bar if no header provided)
  final String? title;

  /// Subtitle text
  final String? subtitle;

  /// Trailing actions
  final List<Component>? actions;

  /// Footer component
  final Component? footer;

  /// Sidebar component
  final Component? sidebar;

  /// Whether sidebar is on the right
  final bool sidebarRight;

  /// Floating action button
  final Component? fab;

  /// Background component
  final Component? background;

  /// Foreground overlay component
  final Component? foreground;

  /// Loading progress (0.0 to 1.0)
  final double? loadingProgress;

  /// Whether loading is indeterminate
  final bool loadingIndeterminate;

  /// Custom padding
  final EdgeInsets? padding;

  /// Back button handler
  final void Function()? onBack;

  const ArcaneScreen({
    required this.child,
    this.header,
    this.title,
    this.subtitle,
    this.actions,
    this.footer,
    this.sidebar,
    this.sidebarRight = false,
    this.fab,
    this.background,
    this.foreground,
    this.loadingProgress,
    this.loadingIndeterminate = false,
    this.padding,
    this.onBack,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    // Build header if title provided
    final Component? effectiveHeader = header ??
        (title != null
            ? ArcaneBar(
                titleText: title,
                subtitleText: subtitle,
                trailing: actions,
                onBack: onBack,
                backButton:
                    onBack != null ? BarBackButtonMode.always : BarBackButtonMode.never,
              )
            : null);

    return div(
      classes: 'arcane-screen',
      styles: const Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'height': '100%',
        'position': 'relative',
        'background-color': ArcaneColors.background,
      }),
      [
        // Background layer
        if (background != null)
          div(
            classes: 'arcane-screen-background',
            styles: const Styles(raw: {
              'position': 'absolute',
              'inset': '0',
              'z-index': '0',
              'overflow': 'hidden',
            }),
            [background!],
          ),

        // Main content wrapper
        div(
          classes: 'arcane-screen-content',
          styles: const Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'flex': '1',
            'position': 'relative',
            'z-index': '1',
            'min-height': '0',
          }),
          [
            // Loading progress bar
            if (loadingProgress != null || loadingIndeterminate)
              _buildLoadingBar(),

            // Header
            if (effectiveHeader != null) effectiveHeader,

            // Body with optional sidebar
            div(
              classes: 'arcane-screen-body',
              styles: const Styles(raw: {
                'display': 'flex',
                'flex': '1',
                'min-height': '0',
                'overflow': 'hidden',
              }),
              [
                if (sidebar != null && !sidebarRight) sidebar!,
                div(
                  classes: 'arcane-screen-main',
                  styles: Styles(raw: {
                    'flex': '1',
                    'overflow-y': 'auto',
                    'overflow-x': 'hidden',
                    if (padding != null) 'padding': padding!.padding,
                  }),
                  [child],
                ),
                if (sidebar != null && sidebarRight) sidebar!,
              ],
            ),

            // Footer
            if (footer != null)
              div(
                classes: 'arcane-screen-footer',
                styles: const Styles(raw: {
                  'flex-shrink': '0',
                }),
                [footer!],
              ),
          ],
        ),

        // Foreground layer
        if (foreground != null)
          div(
            classes: 'arcane-screen-foreground',
            styles: const Styles(raw: {
              'position': 'absolute',
              'inset': '0',
              'z-index': '10',
              'pointer-events': 'none',
            }),
            [foreground!],
          ),

        // FAB
        if (fab != null) fab!,
      ],
    );
  }

  Component _buildLoadingBar() {
    return div(
      classes: 'arcane-screen-loading',
      styles: const Styles(raw: {
        'height': '3px',
        'background-color': ArcaneColors.border,
        'overflow': 'hidden',
        'flex-shrink': '0',
      }),
      [
        div(
          classes: 'arcane-screen-loading-bar ${loadingIndeterminate ? 'indeterminate' : ''}',
          styles: Styles(raw: {
            'height': '100%',
            'background-color': ArcaneColors.accent,
            if (!loadingIndeterminate)
              'width': '${(loadingProgress ?? 0) * 100}%',
            if (!loadingIndeterminate) 'transition': ArcaneEffects.transitionFast,
            if (loadingIndeterminate) 'width': '30%',
            if (loadingIndeterminate)
              'animation': 'arcane-loading-slide 1.5s ease-in-out infinite',
          }),
          [],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-loading-slide').styles(raw: {
      '0%': 'transform: translateX(-100%)',
      '100%': 'transform: translateX(400%)',
    }),
  ];
}