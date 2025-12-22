import '../tokens/tokens.dart';

/// CSS display property
enum Display {
  none,
  block,
  inline,
  inlineBlock,
  flex,
  inlineFlex,
  grid,
  inlineGrid,
  contents,
  flowRoot;

  String get css => switch (this) {
        Display.none => 'none',
        Display.block => 'block',
        Display.inline => 'inline',
        Display.inlineBlock => 'inline-block',
        Display.flex => 'flex',
        Display.inlineFlex => 'inline-flex',
        Display.grid => 'grid',
        Display.inlineGrid => 'inline-grid',
        Display.contents => 'contents',
        Display.flowRoot => 'flow-root',
      };
}

/// Flex direction
enum FlexDirection {
  row,
  rowReverse,
  column,
  columnReverse;

  String get css => switch (this) {
        FlexDirection.row => 'row',
        FlexDirection.rowReverse => 'row-reverse',
        FlexDirection.column => 'column',
        FlexDirection.columnReverse => 'column-reverse',
      };
}

/// Flex wrap
enum FlexWrap {
  nowrap,
  wrap,
  wrapReverse;

  String get css => switch (this) {
        FlexWrap.nowrap => 'nowrap',
        FlexWrap.wrap => 'wrap',
        FlexWrap.wrapReverse => 'wrap-reverse',
      };
}

/// Position type
enum Position {
  static_,
  relative,
  absolute,
  fixed,
  sticky;

  String get css => switch (this) {
        Position.static_ => 'static',
        Position.relative => 'relative',
        Position.absolute => 'absolute',
        Position.fixed => 'fixed',
        Position.sticky => 'sticky',
      };
}

/// Sizing keywords
enum Size {
  auto,
  full,
  screen,
  fit,
  min,
  max,
  half,
  third,
  quarter,
  threeQuarter;

  String get css => switch (this) {
        Size.auto => 'auto',
        Size.full => '100%',
        Size.screen => '100vh',
        Size.fit => 'fit-content',
        Size.min => 'min-content',
        Size.max => 'max-content',
        Size.half => '50%',
        Size.third => '33.333%',
        Size.quarter => '25%',
        Size.threeQuarter => '75%',
      };

  /// CSS for width (uses vw for screen)
  String get widthCss => switch (this) {
        Size.screen => '100vw',
        _ => css,
      };
}

/// Max-width container presets
enum MaxWidth {
  /// No max-width
  none,

  /// Card width (400px)
  card,

  /// Form width (480px)
  form,

  /// Text column (640px)
  text,

  /// Narrow text (560px) - for narrow text blocks
  narrowText,

  /// Narrow content (768px)
  narrow,

  /// Content area (1024px)
  content,

  /// Main container (1280px)
  container,

  /// Full width (1440px)
  full;

  String get css => switch (this) {
        MaxWidth.none => 'none',
        MaxWidth.card => ArcaneLayout.maxWidthCard,
        MaxWidth.form => ArcaneLayout.maxWidthForm,
        MaxWidth.text => ArcaneLayout.maxWidthText,
        MaxWidth.narrowText => '560px',
        MaxWidth.narrow => ArcaneLayout.maxWidthNarrow,
        MaxWidth.content => ArcaneLayout.maxWidthContent,
        MaxWidth.container => ArcaneLayout.maxWidthContainer,
        MaxWidth.full => ArcaneLayout.maxWidthFull,
      };
}

/// Overflow behavior
enum Overflow {
  visible,
  hidden,
  scroll,
  auto,
  clip;

  String get css => switch (this) {
        Overflow.visible => 'visible',
        Overflow.hidden => 'hidden',
        Overflow.scroll => 'scroll',
        Overflow.auto => 'auto',
        Overflow.clip => 'clip',
      };
}

/// Overflow X/Y specific
enum OverflowAxis {
  visible,
  hidden,
  scroll,
  auto,
  clip;

  String get css => switch (this) {
        OverflowAxis.visible => 'visible',
        OverflowAxis.hidden => 'hidden',
        OverflowAxis.scroll => 'scroll',
        OverflowAxis.auto => 'auto',
        OverflowAxis.clip => 'clip',
      };
}

/// Z-index presets
enum ZIndex {
  /// Auto (default stacking)
  auto,

  /// Below content (-1)
  below,

  /// Base level (0)
  base,

  /// Dropdown menus (1000)
  dropdown,

  /// Sticky elements (1020)
  sticky,

  /// Fixed elements (1030)
  fixed,

  /// Floating action button (1035)
  fab,

  /// Modal backdrop (1040)
  modalBackdrop,

  /// Modal content (1050)
  modal,

  /// Popover (1060)
  popover,

  /// Tooltip (1070)
  tooltip,

  /// Toast notifications (1080)
  toast;

  String get css => switch (this) {
        ZIndex.auto => 'auto',
        ZIndex.below => '-1',
        ZIndex.base => '0',
        ZIndex.dropdown => ArcaneZIndex.dropdown,
        ZIndex.sticky => ArcaneZIndex.sticky,
        ZIndex.fixed => ArcaneZIndex.fixed,
        ZIndex.fab => ArcaneZIndex.fab,
        ZIndex.modalBackdrop => ArcaneZIndex.modalBackdrop,
        ZIndex.modal => ArcaneZIndex.modal,
        ZIndex.popover => ArcaneZIndex.popover,
        ZIndex.tooltip => ArcaneZIndex.tooltip,
        ZIndex.toast => ArcaneZIndex.toast,
      };
}

/// Object fit (for images/videos)
enum ObjectFit {
  contain,
  cover,
  fill,
  none,
  scaleDown;

  String get css => switch (this) {
        ObjectFit.contain => 'contain',
        ObjectFit.cover => 'cover',
        ObjectFit.fill => 'fill',
        ObjectFit.none => 'none',
        ObjectFit.scaleDown => 'scale-down',
      };
}

/// Object position
enum ObjectPosition {
  center,
  top,
  bottom,
  left,
  right,
  topLeft,
  topRight,
  bottomLeft,
  bottomRight;

  String get css => switch (this) {
        ObjectPosition.center => 'center',
        ObjectPosition.top => 'top',
        ObjectPosition.bottom => 'bottom',
        ObjectPosition.left => 'left',
        ObjectPosition.right => 'right',
        ObjectPosition.topLeft => 'top left',
        ObjectPosition.topRight => 'top right',
        ObjectPosition.bottomLeft => 'bottom left',
        ObjectPosition.bottomRight => 'bottom right',
      };
}

/// Visibility
enum Visibility {
  visible,
  hidden,
  collapse;

  String get css => switch (this) {
        Visibility.visible => 'visible',
        Visibility.hidden => 'hidden',
        Visibility.collapse => 'collapse',
      };
}

/// Align items (cross-axis alignment in flex/grid)
enum AlignItems {
  stretch,
  flexStart,
  flexEnd,
  center,
  baseline;

  String get css => switch (this) {
        AlignItems.stretch => 'stretch',
        AlignItems.flexStart => 'flex-start',
        AlignItems.flexEnd => 'flex-end',
        AlignItems.center => 'center',
        AlignItems.baseline => 'baseline',
      };
}

/// Justify content (main-axis alignment in flex/grid)
enum JustifyContent {
  flexStart,
  flexEnd,
  center,
  spaceBetween,
  spaceAround,
  spaceEvenly;

  String get css => switch (this) {
        JustifyContent.flexStart => 'flex-start',
        JustifyContent.flexEnd => 'flex-end',
        JustifyContent.center => 'center',
        JustifyContent.spaceBetween => 'space-between',
        JustifyContent.spaceAround => 'space-around',
        JustifyContent.spaceEvenly => 'space-evenly',
      };
}

/// Align self (individual item cross-axis alignment)
enum AlignSelf {
  auto,
  stretch,
  flexStart,
  flexEnd,
  center,
  baseline;

  String get css => switch (this) {
        AlignSelf.auto => 'auto',
        AlignSelf.stretch => 'stretch',
        AlignSelf.flexStart => 'flex-start',
        AlignSelf.flexEnd => 'flex-end',
        AlignSelf.center => 'center',
        AlignSelf.baseline => 'baseline',
      };
}

/// Max height presets
enum MaxHeight {
  /// No max height
  none,

  /// Small content area (200px)
  sm,

  /// Medium content area (300px)
  md,

  /// Large content area (400px)
  lg,

  /// Code block (500px)
  codeBlock,

  /// Extra large (600px)
  xl,

  /// Modal height (80vh)
  modal,

  /// Full screen (100vh)
  screen;

  String get css => switch (this) {
        MaxHeight.none => 'none',
        MaxHeight.sm => '200px',
        MaxHeight.md => '300px',
        MaxHeight.lg => '400px',
        MaxHeight.codeBlock => '500px',
        MaxHeight.xl => '600px',
        MaxHeight.modal => '80vh',
        MaxHeight.screen => '100vh',
      };
}

/// Min width presets
enum MinWidth {
  /// No min width
  none,

  /// Minimum touch target (44px)
  touchTarget,

  /// Small (100px)
  sm,

  /// Medium (200px)
  md,

  /// Large (300px)
  lg;

  String get css => switch (this) {
        MinWidth.none => '0',
        MinWidth.touchTarget => '44px',
        MinWidth.sm => '100px',
        MinWidth.md => '200px',
        MinWidth.lg => '300px',
      };
}
