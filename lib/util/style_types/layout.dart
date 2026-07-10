/// CSS display property values
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

/// Flex direction values
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

/// Flex wrap values
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

/// CSS position values
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

/// Size keyword presets
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

  String get widthCss => switch (this) {
        Size.screen => '100vw',
        _ => css,
      };
}

/// Max-width container presets
enum MaxWidth {
  none,
  card,
  form,
  text,
  narrowText,
  narrow,
  content,
  container,
  full;

  String get css => switch (this) {
        MaxWidth.none => 'none',
        MaxWidth.card => '400px',
        MaxWidth.form => '480px',
        MaxWidth.text => '680px',
        MaxWidth.narrowText => '560px',
        MaxWidth.narrow => '800px',
        MaxWidth.content => '1024px',
        MaxWidth.container => '1280px',
        MaxWidth.full => '100%',
      };
}

/// Overflow behavior values
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

/// Overflow X/Y specific values
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

/// Z-index layer presets
enum ZIndex {
  auto,
  below,
  base,
  dropdown,
  sticky,
  fixed,
  fab,
  modalBackdrop,
  modal,
  popover,
  tooltip,
  toast;

  String get css => switch (this) {
        ZIndex.auto => 'auto',
        ZIndex.below => '-1',
        ZIndex.base => '0',
        ZIndex.dropdown => '1000',
        ZIndex.sticky => '1010',
        ZIndex.fixed => '1020',
        ZIndex.fab => '1030',
        ZIndex.modalBackdrop => '1040',
        ZIndex.modal => '1050',
        ZIndex.popover => '1060',
        ZIndex.tooltip => '1070',
        ZIndex.toast => '1080',
      };
}

/// Object fit values
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

/// Object position values
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

/// Visibility values
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

/// Align items values
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

/// Justify content values
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

/// Align self values
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
  none,
  sm,
  md,
  lg,
  codeBlock,
  xl,
  modal,
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
  none,
  touchTarget,
  sm,
  md,
  lg;

  String get css => switch (this) {
        MinWidth.none => '0',
        MinWidth.touchTarget => '44px',
        MinWidth.sm => '100px',
        MinWidth.md => '200px',
        MinWidth.lg => '300px',
      };
}

/// Flex shorthand presets
enum FlexPreset {
  none,
  initial,
  auto,
  expand,
  fixed,
  growOnly,
  shrinkOnly,
  equal;

  String get css => switch (this) {
        FlexPreset.none => '0 0 auto',
        FlexPreset.initial => '0 1 auto',
        FlexPreset.auto => '1 1 auto',
        FlexPreset.expand => '1 1 0%',
        FlexPreset.fixed => '0 0 auto',
        FlexPreset.growOnly => '1 0 auto',
        FlexPreset.shrinkOnly => '0 1 auto',
        FlexPreset.equal => '1 1 0',
      };
}

/// Grid template column presets
enum GridColumns {
  one,
  two,
  three,
  four,
  five,
  six,
  autoFitSm,
  autoFitMd,
  autoFitLg,
  autoFillSm,
  autoFillMd,
  autoFillLg,
  sidebar,
  mainSidebar,
  holyGrail;

  String get css => switch (this) {
        GridColumns.one => '1fr',
        GridColumns.two => 'repeat(2, 1fr)',
        GridColumns.three => 'repeat(3, 1fr)',
        GridColumns.four => 'repeat(4, 1fr)',
        GridColumns.five => 'repeat(5, 1fr)',
        GridColumns.six => 'repeat(6, 1fr)',
        GridColumns.autoFitSm => 'repeat(auto-fit, minmax(200px, 1fr))',
        GridColumns.autoFitMd => 'repeat(auto-fit, minmax(280px, 1fr))',
        GridColumns.autoFitLg => 'repeat(auto-fit, minmax(320px, 1fr))',
        GridColumns.autoFillSm => 'repeat(auto-fill, minmax(200px, 1fr))',
        GridColumns.autoFillMd => 'repeat(auto-fill, minmax(280px, 1fr))',
        GridColumns.autoFillLg => 'repeat(auto-fill, minmax(320px, 1fr))',
        GridColumns.sidebar => '280px 1fr',
        GridColumns.mainSidebar => '1fr 300px',
        GridColumns.holyGrail => '200px 1fr 200px',
      };
}

/// Grid template row presets
enum GridRows {
  one,
  two,
  three,
  auto,
  headerContentFooter,
  minContent,
  maxContent;

  String get css => switch (this) {
        GridRows.one => '1fr',
        GridRows.two => 'repeat(2, 1fr)',
        GridRows.three => 'repeat(3, 1fr)',
        GridRows.auto => 'auto',
        GridRows.headerContentFooter => 'auto 1fr auto',
        GridRows.minContent => 'min-content',
        GridRows.maxContent => 'max-content',
      };
}

/// Grid auto-flow values
enum GridAutoFlow {
  row,
  column,
  dense,
  rowDense,
  columnDense;

  String get css => switch (this) {
        GridAutoFlow.row => 'row',
        GridAutoFlow.column => 'column',
        GridAutoFlow.dense => 'dense',
        GridAutoFlow.rowDense => 'row dense',
        GridAutoFlow.columnDense => 'column dense',
      };
}

/// Place items values
enum PlaceItems {
  start,
  end,
  center,
  stretch,
  baseline;

  String get css => switch (this) {
        PlaceItems.start => 'start',
        PlaceItems.end => 'end',
        PlaceItems.center => 'center',
        PlaceItems.stretch => 'stretch',
        PlaceItems.baseline => 'baseline',
      };
}

/// Place content values
enum PlaceContent {
  start,
  end,
  center,
  stretch,
  spaceBetween,
  spaceAround,
  spaceEvenly;

  String get css => switch (this) {
        PlaceContent.start => 'start',
        PlaceContent.end => 'end',
        PlaceContent.center => 'center',
        PlaceContent.stretch => 'stretch',
        PlaceContent.spaceBetween => 'space-between',
        PlaceContent.spaceAround => 'space-around',
        PlaceContent.spaceEvenly => 'space-evenly',
      };
}

/// `box-sizing` presets.
enum BoxSizing {
  contentBox,
  borderBox;

  String get css => switch (this) {
        BoxSizing.contentBox => 'content-box',
        BoxSizing.borderBox => 'border-box',
      };
}
