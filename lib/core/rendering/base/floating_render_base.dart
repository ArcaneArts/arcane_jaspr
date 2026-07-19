import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/decoration/arcane_decoration.dart';
import 'package:arcane_jaspr/core/interaction/interaction_attrs.dart';
import 'package:arcane_jaspr/core/props/floating_props.dart';

/// Shared structural base for themed floating renderers.
///
/// Floating is the unified tooltip/popover/hovercard component. Every theme
/// shares the exact same scaffolding: the `build()` dispatch between a CSS-only
/// text tooltip and a state-controlled panel, the trigger/anchor wiring, the
/// `surfaceAttrs` computation, the role logic, the arrow/content child
/// assembly, and the three position-math tables (which are byte-for-byte
/// identical across themes). This base factors all of that, leaving only the
/// theme-divergent CSS class strings and the four style maps (CSS tooltip,
/// floating content, arrow) plus the auto-id prefix to abstract members the
/// subclass supplies.
///
/// This base lives in core and depends only on core props and interaction
/// helpers; it must never depend on a theme package.
abstract class FloatingRenderBase extends StatelessComponent {
  const FloatingRenderBase(this.props, {super.key});

  final FloatingProps props;

  /// Class for the CSS-only tooltip trigger wrapper (e.g.
  /// `'arcane-floating-trigger'`).
  String get triggerClass;

  /// Class for the stateful floating container (e.g.
  /// `'arcane-floating-container'`).
  String get containerClass;

  /// Class string for the inner CSS-tooltip surface.
  String get cssTooltipClasses;

  /// Full style map for the inner CSS-tooltip surface. [positionStyles] are the
  /// resolved position offsets and must be spread last to match each theme.
  Map<String, String> cssTooltipStyles(Map<String, String> positionStyles);

  /// Class string for the floating content surface, given whether it carries
  /// rich content (popover) versus plain text (tooltip).
  String floatingContentClasses(bool hasRichContent);

  /// Full style map for the floating content surface.
  Map<String, String> floatingContentStyles({
    required String positionProp,
    required String positionValue,
    required Map<String, String> alignment,
    required bool hasRichContent,
    required double? maxWidth,
  });

  /// Per-instance decoration overrides. Default: none. A theme overrides this
  /// to translate an [ArcaneDecoration] (elevation intent, theme-specific
  /// fields) into its own CSS. Fields a theme does not implement are ignored.
  Map<String, String> decorationStyles(ArcaneDecoration? decoration) =>
      const <String, String>{};

  /// Class for the floating arrow element.
  String get arrowClass;

  /// Full style map for the floating arrow. [arrowPositionStyles] are the
  /// resolved arrow offsets and must be spread last to match each theme.
  Map<String, String> arrowStyles(Map<String, String> arrowPositionStyles);

  /// Generates a theme-prefixed auto id when no explicit id is supplied. Each
  /// subclass owns its static counter so the generated sequence is unchanged.
  String generateAutoId();

  @override
  Component build(BuildContext context) {
    // Simple text tooltip uses CSS :hover (no JS needed).
    if (props.isTextTooltip && props.triggerType == FloatingTrigger.hover) {
      return _buildCssTooltip();
    }

    // Rich content uses state-based rendering.
    return _buildStatefulFloating();
  }

  /// Builds a CSS-only tooltip for simple text hints.
  Component _buildCssTooltip() {
    return dom.div(
      classes: triggerClass,
      attributes: <String, String>{
        'data-tooltip': props.textContent ?? '',
        'data-tooltip-position': props.position.name,
      },
      styles: const dom.Styles(
        raw: <String, String>{
          'position': 'relative',
          'display': 'inline-flex',
        },
      ),
      <Component>[
        props.trigger,
        dom.div(
          classes: cssTooltipClasses,
          attributes: const <String, String>{'role': 'tooltip'},
          styles: dom.Styles(
            raw: <String, String>{
              ...cssTooltipStyles(_getPositionStyles(props.position)),
              ...?props.decoration?.universalStyles(),
              ...decorationStyles(props.decoration),
              ...?props.styles?.toMap(),
            },
          ),
          <Component>[Component.text(props.textContent ?? '')],
        ),
      ],
    );
  }

  /// Builds a state-controlled floating panel for rich content.
  Component _buildStatefulFloating() {
    final bool isOpen = props.isOpen ?? false;
    final bool useHoverEvents = props.triggerType == FloatingTrigger.hover;
    final bool useClickEvents = props.triggerType == FloatingTrigger.click;
    final String surfaceId = props.id ?? generateAutoId();
    final String anchorId = '$surfaceId-trigger';
    final String surfaceKind = useHoverEvents ? 'hovercard' : 'popover';

    final Map<String, String> triggerWrapperAttrs = <String, String>{
      'data-arcane-anchor-id': anchorId,
      if (useClickEvents) 'data-arcane-action': 'surface.toggle:$surfaceId',
      if (useHoverEvents) ...<String, String>{
        'data-arcane-mouseenter': 'surface.hoverOpen:$surfaceId',
        'data-arcane-mouseleave': 'surface.hoverClose:$surfaceId',
      },
      if (useHoverEvents && props.openDelay > 0)
        'data-arcane-hover-open-delay': props.openDelay.toString(),
      if (useHoverEvents && props.closeDelay > 0)
        'data-arcane-hover-close-delay': props.closeDelay.toString(),
    };

    return dom.div(
      classes: containerClass,
      styles: const dom.Styles(
        raw: <String, String>{
          'position': 'relative',
          'display': 'inline-block',
        },
      ),
      events: <String, EventCallback>{
        if (useHoverEvents) 'mouseenter': (_) => props.onMouseEnter?.call(),
        if (useHoverEvents) 'mouseleave': (_) => props.onMouseLeave?.call(),
      },
      <Component>[
        dom.div(
          attributes: triggerWrapperAttrs,
          styles: const dom.Styles(
            raw: <String, String>{'display': 'inline-block'},
          ),
          events: <String, EventCallback>{
            if (useClickEvents) 'click': (_) => props.onToggle?.call(),
          },
          <Component>[props.trigger],
        ),
        _buildFloatingContent(
          surfaceId: surfaceId,
          anchorId: anchorId,
          surfaceKind: surfaceKind,
          initiallyOpen: isOpen,
        ),
      ],
    );
  }

  Component _buildFloatingContent({
    required String surfaceId,
    required String anchorId,
    required String surfaceKind,
    required bool initiallyOpen,
  }) {
    final (String positionProp, String positionValue, Map<String, String> alignment) =
        _getPositionStylesForPanel();
    final bool hasRichContent = props.content != null;
    final double? maxWidth = props.maxWidth;

    final Map<String, String> surfAttrs = surfaceAttrs(
      surface: surfaceKind,
      id: surfaceId,
      initiallyOpen: initiallyOpen,
      dismissible: props.closeOnOutsideClick,
      escapeCloses: props.closeOnEscape,
      focusTrap: false,
      scrimCloses: false,
      restoreFocus: true,
      anchorId: anchorId,
      anchorPlacement: props.position.name,
      anchorOffset: props.offset.toString(),
    );

    return dom.div(
      classes: floatingContentClasses(hasRichContent),
      attributes: <String, String>{
        'role': surfaceKind == 'hovercard' ? 'tooltip' : 'dialog',
        ...surfAttrs,
      },
      styles: dom.Styles(
        raw: <String, String>{
          ...floatingContentStyles(
            positionProp: positionProp,
            positionValue: positionValue,
            alignment: alignment,
            hasRichContent: hasRichContent,
            maxWidth: maxWidth,
          ),
          ...?props.decoration?.universalStyles(),
          ...decorationStyles(props.decoration),
          ...?props.styles?.toMap(),
        },
      ),
      <Component>[
        if (props.showArrow) _buildArrow(),
        if (props.content != null)
          props.content!
        else if (props.textContent != null)
          Component.text(props.textContent!),
      ],
    );
  }

  Component _buildArrow() {
    return dom.div(
      classes: arrowClass,
      styles: dom.Styles(raw: arrowStyles(_getArrowStyles())),
      const <Component>[],
    );
  }

  Map<String, String> _getPositionStyles(FloatingPosition position) {
    return switch (position) {
      FloatingPosition.top => const <String, String>{
        'bottom': '100%',
        'left': '50%',
        'transform': 'translateX(-50%) translateY(-4px)',
        'margin-bottom': '8px',
      },
      FloatingPosition.bottom => const <String, String>{
        'top': '100%',
        'left': '50%',
        'transform': 'translateX(-50%) translateY(4px)',
        'margin-top': '8px',
      },
      FloatingPosition.left => const <String, String>{
        'right': '100%',
        'top': '50%',
        'transform': 'translateY(-50%) translateX(-4px)',
        'margin-right': '8px',
      },
      FloatingPosition.right => const <String, String>{
        'left': '100%',
        'top': '50%',
        'transform': 'translateY(-50%) translateX(4px)',
        'margin-left': '8px',
      },
      FloatingPosition.topStart => const <String, String>{
        'bottom': '100%',
        'left': '0',
        'margin-bottom': '8px',
      },
      FloatingPosition.topEnd => const <String, String>{
        'bottom': '100%',
        'right': '0',
        'margin-bottom': '8px',
      },
      FloatingPosition.bottomStart => const <String, String>{
        'top': '100%',
        'left': '0',
        'margin-top': '8px',
      },
      FloatingPosition.bottomEnd => const <String, String>{
        'top': '100%',
        'right': '0',
        'margin-top': '8px',
      },
    };
  }

  (String, String, Map<String, String>) _getPositionStylesForPanel() {
    final String offsetPx = '${props.offset}px';

    return switch (props.position) {
      FloatingPosition.top => (
        'bottom',
        'calc(100% + $offsetPx)',
        const <String, String>{'left': '50%', 'transform': 'translateX(-50%)'},
      ),
      FloatingPosition.bottom => (
        'top',
        'calc(100% + $offsetPx)',
        const <String, String>{'left': '50%', 'transform': 'translateX(-50%)'},
      ),
      FloatingPosition.left => (
        'right',
        'calc(100% + $offsetPx)',
        const <String, String>{'top': '50%', 'transform': 'translateY(-50%)'},
      ),
      FloatingPosition.right => (
        'left',
        'calc(100% + $offsetPx)',
        const <String, String>{'top': '50%', 'transform': 'translateY(-50%)'},
      ),
      FloatingPosition.topStart => (
        'bottom',
        'calc(100% + $offsetPx)',
        const <String, String>{'left': '0'},
      ),
      FloatingPosition.topEnd => (
        'bottom',
        'calc(100% + $offsetPx)',
        const <String, String>{'right': '0'},
      ),
      FloatingPosition.bottomStart => (
        'top',
        'calc(100% + $offsetPx)',
        const <String, String>{'left': '0'},
      ),
      FloatingPosition.bottomEnd => (
        'top',
        'calc(100% + $offsetPx)',
        const <String, String>{'right': '0'},
      ),
    };
  }

  Map<String, String> _getArrowStyles() {
    return switch (props.position) {
      FloatingPosition.top ||
      FloatingPosition.topStart ||
      FloatingPosition.topEnd => const <String, String>{
        'bottom': '-6px',
        'left': '50%',
        'transform': 'translateX(-50%) rotate(225deg)',
      },
      FloatingPosition.bottom ||
      FloatingPosition.bottomStart ||
      FloatingPosition.bottomEnd => const <String, String>{
        'top': '-6px',
        'left': '50%',
        'transform': 'translateX(-50%) rotate(45deg)',
      },
      FloatingPosition.left => const <String, String>{
        'right': '-6px',
        'top': '50%',
        'transform': 'translateY(-50%) rotate(135deg)',
      },
      FloatingPosition.right => const <String, String>{
        'left': '-6px',
        'top': '50%',
        'transform': 'translateY(-50%) rotate(-45deg)',
      },
    };
  }
}
