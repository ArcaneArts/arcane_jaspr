import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import 'package:fast_log/fast_log.dart';

import '../../util/appearance/theme.dart';
import '../../util/arcane.dart';

/// Root application component for Arcane Jaspr apps.
///
/// Wraps the app with theme provider and applies CSS custom properties.
class ArcaneApp extends StatefulComponent {
  /// The theme configuration
  final ArcaneTheme theme;

  /// The child component to render
  final Component child;

  /// Optional document title
  final String? title;

  /// Optional meta description
  final String? description;

  /// Optional additional head elements
  final List<Component>? head;

  const ArcaneApp({
    this.theme = const ArcaneTheme(),
    required this.child,
    this.title,
    this.description,
    this.head,
    super.key,
  });

  @override
  State<ArcaneApp> createState() => _ArcaneAppState();

  @css
  static final List<StyleRule> styles = [
    // Reset styles
    css('*, *::before, *::after').styles(raw: {
      'box-sizing': 'border-box',
      'margin': '0',
      'padding': '0',
    }),
    css('html, body').styles(raw: {
      'height': '100%',
      'margin': '0',
      'padding': '0',
    }),
    css('body').styles(raw: {
      'line-height': '1.5',
    }),
    css('img, picture, video, canvas, svg').styles(raw: {
      'display': 'block',
      'max-width': '100%',
    }),
    css('input, button, textarea, select').styles(raw: {
      'font': 'inherit',
    }),
    css('p, h1, h2, h3, h4, h5, h6').styles(raw: {
      'overflow-wrap': 'break-word',
    }),
    css('a').styles(raw: {
      'color': 'inherit',
      'text-decoration': 'none',
    }),
    css('button').styles(raw: {
      'cursor': 'pointer',
      'background': 'none',
      'border': 'none',
    }),
    // Scrollbar styling
    css('::-webkit-scrollbar').styles(raw: {
      'width': '8px',
      'height': '8px',
    }),
    css('::-webkit-scrollbar-track').styles(raw: {
      'background': 'var(--arcane-surface-variant)',
      'border-radius': '4px',
    }),
    css('::-webkit-scrollbar-thumb').styles(raw: {
      'background': 'var(--arcane-outline)',
      'border-radius': '4px',
    }),
    css('::-webkit-scrollbar-thumb:hover').styles(raw: {
      'background': 'var(--arcane-on-surface-variant)',
    }),
  ];
}

class _ArcaneAppState extends State<ArcaneApp> {
  @override
  void initState() {
    super.initState();
    info('_ArcaneAppState.initState()');
    // Set global theme reference
    Arcane.globalTheme = component.theme;
    verbose('_ArcaneAppState.initState() - globalTheme set');
  }

  @override
  void didUpdateComponent(ArcaneApp oldComponent) {
    super.didUpdateComponent(oldComponent);
    if (oldComponent.theme != component.theme) {
      Arcane.globalTheme = component.theme;
    }
  }

  @override
  Component build(BuildContext context) {
    info('_ArcaneAppState.build() started');

    final theme = component.theme;
    verbose('_ArcaneAppState.build() - got theme');

    final isDark = theme.brightness == Brightness.dark;
    verbose('_ArcaneAppState.build() - isDark: $isDark');

    verbose('_ArcaneAppState.build() - getting cssVariables...');
    final cssVars = theme.cssVariables;
    verbose('_ArcaneAppState.build() - cssVariables count: ${cssVars.length}');

    verbose('_ArcaneAppState.build() - creating div...');
    final rootDiv = div(
      id: 'arcane-root',
      classes: isDark ? 'arcane-dark' : 'arcane-light',
      styles: Styles(raw: {
        ...cssVars,
        'min-height': '100vh',
        'background-color': 'var(--arcane-background)',
        'color': 'var(--arcane-on-background)',
        'font-family':
            '"GeistSans", -apple-system, BlinkMacSystemFont, "Segoe UI", Roboto, sans-serif',
        '-webkit-font-smoothing': 'antialiased',
        '-moz-osx-font-smoothing': 'grayscale',
      }),
      [component.child],
    );
    verbose('_ArcaneAppState.build() - div created');

    verbose('_ArcaneAppState.build() - creating ArcaneThemeProvider...');
    final result = ArcaneThemeProvider(
      theme: theme,
      child: rootDiv,
    );
    info('_ArcaneAppState.build() - complete');

    return result;
  }
}

/// ArcaneWindow for web - just wraps ArcaneApp with optional background styling
class ArcaneWindow extends StatelessComponent {
  final ArcaneTheme theme;
  final Component child;
  final Color? windowColor;

  const ArcaneWindow({
    this.theme = const ArcaneTheme(),
    required this.child,
    this.windowColor,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return ArcaneApp(
      theme: theme,
      child: child,
    );
  }
}
