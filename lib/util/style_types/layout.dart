import '../tokens/tokens.dart';

/// CSS display property for controlling element rendering.
///
/// The display property defines how an element generates boxes
/// for layout.
///
/// ## Common Display Values
///
/// | Value        | Description                           |
/// |--------------|---------------------------------------|
/// | `none`       | Hidden, removed from layout           |
/// | `block`      | Block-level, full width               |
/// | `inline`     | Inline, flows with text               |
/// | `flex`       | Flexbox container                     |
/// | `grid`       | CSS Grid container                    |
/// | `contents`   | Box replaced by children              |
///
/// ## Example
///
/// ```dart
/// ArcaneDiv(
///   styles: const ArcaneStyleData(
///     display: Display.flex,
///     flexDirection: FlexDirection.column,
///     gap: Gap.md,
///   ),
/// )
/// ```
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

/// Flex shorthand presets combining grow, shrink, and basis.
///
/// These presets simplify common flex patterns without needing
/// to remember the flex shorthand syntax.
///
/// ## Common Patterns
///
/// | Value      | CSS Value      | Behavior                      |
/// |------------|----------------|-------------------------------|
/// | `none`     | 0 0 auto       | Fixed size, no flex           |
/// | `initial`  | 0 1 auto       | Shrink only (default)         |
/// | `auto`     | 1 1 auto       | Grow and shrink               |
/// | `expand`   | 1 1 0%         | Fill available space          |
/// | `equal`    | 1 1 0          | Equal distribution            |
/// | `growOnly` | 1 0 auto       | Grow but never shrink         |
///
/// ## Example
///
/// ```dart
/// ArcaneRow(
///   children: [
///     ArcaneDiv(styles: const ArcaneStyleData(flex: FlexPreset.expand)),
///     ArcaneDiv(styles: const ArcaneStyleData(flex: FlexPreset.none)),
///   ],
/// )
/// ```
enum FlexPreset {
  /// No flex (flex: none = 0 0 auto)
  none,

  /// Initial flex (flex: initial = 0 1 auto)
  initial,

  /// Auto flex (flex: auto = 1 1 auto)
  auto,

  /// Expand to fill (flex: 1 = 1 1 0%)
  expand,

  /// Fixed size, no shrink (flex: 0 0 auto) - alias for none
  fixed,

  /// Grow but don't shrink (flex: 1 0 auto)
  growOnly,

  /// Shrink but don't grow (flex: 0 1 auto) - same as initial
  shrinkOnly,

  /// Equal distribution (flex: 1 1 0)
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

/// Grid template column presets for CSS Grid layouts.
///
/// These presets provide common grid configurations without
/// writing raw CSS grid-template-columns values.
///
/// ## Fixed Columns
///
/// | Value   | CSS Output       | Description           |
/// |---------|------------------|-----------------------|
/// | `one`   | 1fr              | Single column         |
/// | `two`   | repeat(2, 1fr)   | Two equal columns     |
/// | `three` | repeat(3, 1fr)   | Three equal columns   |
/// | `four`  | repeat(4, 1fr)   | Four equal columns    |
///
/// ## Responsive Columns
///
/// | Value        | Min Width | Description                |
/// |--------------|-----------|----------------------------|
/// | `autoFitSm`  | 200px     | Auto-fit small cards       |
/// | `autoFitMd`  | 280px     | Auto-fit medium cards      |
/// | `autoFitLg`  | 320px     | Auto-fit large cards       |
///
/// ## Layout Presets
///
/// | Value         | CSS Output         | Use Case            |
/// |---------------|--------------------|--------------------|
/// | `sidebar`     | 280px 1fr          | Sidebar + content  |
/// | `mainSidebar` | 1fr 300px          | Content + sidebar  |
/// | `holyGrail`   | 200px 1fr 200px    | Classic 3-column   |
///
/// ## Example
///
/// ```dart
/// ArcaneDiv(
///   styles: const ArcaneStyleData(
///     display: Display.grid,
///     gridColumns: GridColumns.autoFitMd,  // Responsive cards
///     gap: Gap.lg,
///   ),
/// )
/// ```
enum GridColumns {
  /// Single column
  one,

  /// Two equal columns
  two,

  /// Three equal columns
  three,

  /// Four equal columns
  four,

  /// Five equal columns
  five,

  /// Six equal columns
  six,

  /// Auto-fit with min 200px columns
  autoFitSm,

  /// Auto-fit with min 280px columns
  autoFitMd,

  /// Auto-fit with min 320px columns
  autoFitLg,

  /// Auto-fill with min 200px columns
  autoFillSm,

  /// Auto-fill with min 280px columns
  autoFillMd,

  /// Auto-fill with min 320px columns
  autoFillLg,

  /// Sidebar layout (280px auto)
  sidebar,

  /// Main with sidebar (1fr 300px)
  mainSidebar,

  /// Holy grail (200px 1fr 200px)
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
  /// Single row
  one,

  /// Two equal rows
  two,

  /// Three equal rows
  three,

  /// Auto rows
  auto,

  /// Header, content, footer layout
  headerContentFooter,

  /// Min-content rows
  minContent,

  /// Max-content rows
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

/// Grid auto-flow
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

/// Place items (align-items + justify-items shorthand)
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

/// Place content (align-content + justify-content shorthand)
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
