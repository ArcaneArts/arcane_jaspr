import 'package:jaspr/dom.dart' as dom;
import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/scroll_rail_props.dart';

/// Shared structural bases for the neon/neubrutalism scroll rail renderers.
///
/// Both themes render the identical sticky-rail markup (width resolution, the
/// scroll-position persistence script, the layout ordering); only the CSS class,
/// the default id prefix, the default background, the border/scrollbar values
/// and the persistence id differ. These bases factor that structure and expose
/// the variation as abstract members.
///
/// The ShadCN theme renders these as top-level functions with a structurally
/// different persistence script and no CSS classes, so it does not extend these
/// bases.
///
/// These bases live in core and depend only on core props; they must never
/// depend on a theme package.

String _resolveWidth(ScrollRailSize size, String? width) {
  return width ??
      switch (size) {
        ScrollRailSize.narrow => '200px',
        ScrollRailSize.sm => '240px',
        ScrollRailSize.md => '280px',
        ScrollRailSize.lg => '320px',
        ScrollRailSize.xl => '360px',
      };
}

/// Sticky scroll rail. Shared between the neon and neubrutalism themes.
abstract class ScrollRailRenderBase extends StatelessComponent {
  const ScrollRailRenderBase(this.props, {super.key});

  final ScrollRailProps props;

  /// CSS class applied to the rail root element.
  String get railClass;

  /// Prefix for the auto-generated rail id (appended with the position name).
  String get idPrefix;

  /// Background used when [ScrollRailProps.background] is null.
  String get defaultBackground;

  /// Resolves the border shorthand for the rail's leading/trailing edge.
  String borderStyle(bool showBorder);

  /// `scrollbar-color` value when a custom scrollbar is requested.
  String get scrollbarColor;

  @override
  Component build(BuildContext context) {
    final String height =
        'calc(100vh - ${props.topOffset} - ${props.bottomOffset})';
    final String id =
        props.scrollPersistenceId ?? '$idPrefix${props.position.name}';
    final String width = _resolveWidth(props.size, props.width);

    return dom.div(
      id: id,
      classes: railClass,
      styles: dom.Styles(
        raw: <String, String>{
          'position': 'sticky',
          'top': props.topOffset,
          'width': width,
          'height': height,
          'max-height': height,
          'flex-shrink': '0',
          'overflow-y': 'auto',
          'overflow-x': 'hidden',
          'background': props.background ?? defaultBackground,
          if (props.position == ScrollRailPosition.left)
            'border-right': borderStyle(props.showBorder)
          else
            'border-left': borderStyle(props.showBorder),
          if (props.customScrollbar) ...<String, String>{
            'scrollbar-width': 'thin',
            'scrollbar-color': scrollbarColor,
          },
        },
      ),
      <Component>[
        dom.div(
          styles: dom.Styles(
            raw: <String, String>{'padding': props.padding, 'min-height': '100%'},
          ),
          props.children,
        ),
        if (props.scrollPersistenceId != null)
          dom.script(
            content:
                '''
            (function() {
              var rail = document.getElementById('$id');
              if (!rail) return;
              var storageKey = 'scroll-rail-$id';
              var savedPos = sessionStorage.getItem(storageKey);
              if (savedPos) rail.scrollTop = parseInt(savedPos, 10);
              var saveTimeout;
              rail.addEventListener('scroll', function() {
                clearTimeout(saveTimeout);
                saveTimeout = setTimeout(function() {
                  sessionStorage.setItem(storageKey, rail.scrollTop.toString());
                }, 100);
              });
            })();
          ''',
          ),
      ],
    );
  }
}

/// Scroll rail layout (rail + content). Shared between the neon and
/// neubrutalism themes.
abstract class ScrollRailLayoutRenderBase extends StatelessComponent {
  const ScrollRailLayoutRenderBase(this.props, {super.key});

  final ScrollRailLayoutProps props;

  /// CSS class applied to the layout root element.
  String get layoutClass;

  /// CSS class applied to the main content element.
  String get contentClass;

  /// Persistence id assigned to the embedded rail.
  String get mainRailPersistenceId;

  /// Background used when [ScrollRailLayoutProps.contentBackground] is null.
  String get defaultContentBackground;

  /// Builds the theme's rail for the embedded [railProps].
  Component buildRail(ScrollRailProps railProps);

  @override
  Component build(BuildContext context) {
    final Component rail = buildRail(
      ScrollRailProps(
        position: props.railPosition,
        size: props.railSize,
        width: props.railWidth,
        topOffset: props.headerHeight,
        showBorder: props.showBorder,
        background: props.railBackground,
        scrollPersistenceId: mainRailPersistenceId,
        children: <Component>[props.rail],
      ),
    );

    final Component content = dom.div(
      classes: contentClass,
      styles: dom.Styles(
        raw: <String, String>{
          'flex': '1',
          'min-width': '0',
          'background': props.contentBackground ?? defaultContentBackground,
        },
      ),
      <Component>[props.child],
    );

    return dom.div(
      classes: layoutClass,
      styles: const dom.Styles(
        raw: <String, String>{
          'display': 'flex',
          'min-height': '100vh',
          'width': '100%',
        },
      ),
      props.railPosition == ScrollRailPosition.left
          ? <Component>[rail, content]
          : <Component>[content, rail],
    );
  }
}
