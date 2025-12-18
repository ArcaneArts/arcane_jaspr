import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight, StyleRule;

import '../../util/appearance/theme.dart';
import '../../util/arcane.dart';
import '../../util/tools/styles.dart';
import '../view/bar.dart';

/// A screen that fills the entire viewport.
class FillScreen extends StatelessComponent {
  /// Main content
  final Component child;

  /// Header bar
  final Component? header;

  /// Title text
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

  /// Background component
  final Component? background;

  /// Loading progress (0.0 to 1.0)
  final double? loadingProgress;

  /// Whether loading is indeterminate
  final bool loadingIndeterminate;

  /// Back button handler
  final void Function()? onBack;

  /// Whether to scroll the content
  final bool scrollable;

  const FillScreen({
    required this.child,
    this.header,
    this.title,
    this.subtitle,
    this.actions,
    this.footer,
    this.sidebar,
    this.sidebarRight = false,
    this.background,
    this.loadingProgress,
    this.loadingIndeterminate = false,
    this.onBack,
    this.scrollable = true,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    final theme = ArcaneTheme.of(context);

    final effectiveHeader = header ??
        (title != null
            ? Bar(
                titleText: title,
                subtitleText: subtitle,
                trailing: actions,
                onBack: onBack,
                backButton:
                    onBack != null ? BarBackButtonMode.always : BarBackButtonMode.never,
              )
            : null);

    return div(
      classes: 'arcane-fill-screen',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'min-height': '100vh',
        'height': '100%',
        'position': 'relative',
        'background-color': 'var(--arcane-background)',
      }),
      [
        // Background
        if (background != null)
          div(
            classes: 'arcane-fill-screen-background',
            styles: Styles(raw: {
              'position': 'absolute',
              'inset': '0',
              'z-index': '0',
              'overflow': 'hidden',
            }),
            [background!],
          ),

        // Content
        div(
          classes: 'arcane-fill-screen-content',
          styles: Styles(raw: {
            'display': 'flex',
            'flex-direction': 'column',
            'flex': '1',
            'position': 'relative',
            'z-index': '1',
            'min-height': '0',
          }),
          [
            // Loading bar
            if (loadingProgress != null || loadingIndeterminate)
              _buildLoadingBar(),

            // Header
            if (effectiveHeader != null) effectiveHeader,

            // Body
            div(
              classes: 'arcane-fill-screen-body',
              styles: Styles(raw: {
                'display': 'flex',
                'flex': '1',
                'min-height': '0',
              }),
              [
                if (sidebar != null && !sidebarRight) sidebar!,
                div(
                  classes: 'arcane-fill-screen-main',
                  styles: Styles(raw: {
                    'flex': '1',
                    if (scrollable) 'overflow-y': 'auto',
                    'overflow-x': 'hidden',
                    'display': 'flex',
                    'flex-direction': 'column',
                  }),
                  [child],
                ),
                if (sidebar != null && sidebarRight) sidebar!,
              ],
            ),

            // Footer
            if (footer != null)
              div(
                classes: 'arcane-fill-screen-footer',
                styles: Styles(raw: {
                  'flex-shrink': '0',
                }),
                [footer!],
              ),
          ],
        ),
      ],
    );
  }

  Component _buildLoadingBar() {
    return div(
      classes: 'arcane-fill-screen-loading',
      styles: Styles(raw: {
        'height': '3px',
        'background-color': 'var(--arcane-outline-variant)',
        'overflow': 'hidden',
        'flex-shrink': '0',
      }),
      [
        div(
          styles: Styles(raw: {
            'height': '100%',
            'background-color': 'var(--arcane-primary)',
            if (!loadingIndeterminate)
              'width': '${(loadingProgress ?? 0) * 100}%',
            if (loadingIndeterminate) 'width': '30%',
            if (loadingIndeterminate)
              'animation': 'arcane-loading-slide 1.5s ease-in-out infinite',
          }),
          [],
        ),
      ],
    );
  }
}

/// A simple fullscreen container
class FullScreen extends StatelessComponent {
  final Component child;
  final Color? backgroundColor;

  const FullScreen({
    required this.child,
    this.backgroundColor,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-fullscreen',
      styles: Styles(raw: {
        'min-height': '100vh',
        'width': '100%',
        'background-color':
            backgroundColor?.css ?? 'var(--arcane-background)',
      }),
      [child],
    );
  }
}
