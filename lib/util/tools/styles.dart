import 'package:jaspr/dom.dart' as dom;
import '../appearance/colors.dart';
import '../arcane.dart';
import '../tokens/tokens.dart';
import '../tokens/style_presets.dart';
import '../tokens/common_styles.dart';

/// Helper class for building inline CSS styles
class ArcaneStyles {
  final Map<String, String> _styles = {};

  ArcaneStyles();

  /// Set a style property
  ArcaneStyles set(String property, String value) {
    _styles[property] = value;
    return this;
  }

  /// Remove a style property
  ArcaneStyles remove(String property) {
    _styles.remove(property);
    return this;
  }

  /// Display
  ArcaneStyles display(String value) => set('display', value);
  ArcaneStyles displayFlex() => set('display', 'flex');
  ArcaneStyles displayGrid() => set('display', 'grid');
  ArcaneStyles displayBlock() => set('display', 'block');
  ArcaneStyles displayInline() => set('display', 'inline');
  ArcaneStyles displayInlineFlex() => set('display', 'inline-flex');
  ArcaneStyles displayNone() => set('display', 'none');

  /// Flexbox
  ArcaneStyles flexDirection(String value) => set('flex-direction', value);
  ArcaneStyles flexRow() => set('flex-direction', 'row');
  ArcaneStyles flexColumn() => set('flex-direction', 'column');
  ArcaneStyles flexRowReverse() => set('flex-direction', 'row-reverse');
  ArcaneStyles flexColumnReverse() => set('flex-direction', 'column-reverse');

  ArcaneStyles flexWrap(String value) => set('flex-wrap', value);
  ArcaneStyles flexWrapWrap() => set('flex-wrap', 'wrap');
  ArcaneStyles flexWrapNowrap() => set('flex-wrap', 'nowrap');

  ArcaneStyles justifyContent(String value) => set('justify-content', value);
  ArcaneStyles justifyStart() => set('justify-content', 'flex-start');
  ArcaneStyles justifyEnd() => set('justify-content', 'flex-end');
  ArcaneStyles justifyCenter() => set('justify-content', 'center');
  ArcaneStyles justifyBetween() => set('justify-content', 'space-between');
  ArcaneStyles justifyAround() => set('justify-content', 'space-around');
  ArcaneStyles justifyEvenly() => set('justify-content', 'space-evenly');

  ArcaneStyles alignItems(String value) => set('align-items', value);
  ArcaneStyles alignItemsStart() => set('align-items', 'flex-start');
  ArcaneStyles alignItemsEnd() => set('align-items', 'flex-end');
  ArcaneStyles alignItemsCenter() => set('align-items', 'center');
  ArcaneStyles alignItemsStretch() => set('align-items', 'stretch');
  ArcaneStyles alignItemsBaseline() => set('align-items', 'baseline');

  ArcaneStyles alignSelf(String value) => set('align-self', value);
  ArcaneStyles flex(String value) => set('flex', value);
  ArcaneStyles flexGrow(int value) => set('flex-grow', '$value');
  ArcaneStyles flexShrink(int value) => set('flex-shrink', '$value');
  ArcaneStyles flexBasis(String value) => set('flex-basis', value);

  ArcaneStyles gap(double value) => set('gap', '${value}px');
  ArcaneStyles rowGap(double value) => set('row-gap', '${value}px');
  ArcaneStyles columnGap(double value) => set('column-gap', '${value}px');

  /// Grid
  ArcaneStyles gridTemplateColumns(String value) =>
      set('grid-template-columns', value);
  ArcaneStyles gridTemplateRows(String value) =>
      set('grid-template-rows', value);
  ArcaneStyles gridColumn(String value) => set('grid-column', value);
  ArcaneStyles gridRow(String value) => set('grid-row', value);

  /// Sizing
  ArcaneStyles width(String value) => set('width', value);
  ArcaneStyles widthPx(double value) => set('width', '${value}px');
  ArcaneStyles widthPercent(double value) => set('width', '$value%');
  ArcaneStyles widthFull() => set('width', '100%');
  ArcaneStyles widthAuto() => set('width', 'auto');

  ArcaneStyles height(String value) => set('height', value);
  ArcaneStyles heightPx(double value) => set('height', '${value}px');
  ArcaneStyles heightPercent(double value) => set('height', '$value%');
  ArcaneStyles heightFull() => set('height', '100%');
  ArcaneStyles heightAuto() => set('height', 'auto');

  ArcaneStyles minWidth(String value) => set('min-width', value);
  ArcaneStyles minWidthPx(double value) => set('min-width', '${value}px');
  ArcaneStyles maxWidth(String value) => set('max-width', value);
  ArcaneStyles maxWidthPx(double value) => set('max-width', '${value}px');

  ArcaneStyles minHeight(String value) => set('min-height', value);
  ArcaneStyles minHeightPx(double value) => set('min-height', '${value}px');
  ArcaneStyles maxHeight(String value) => set('max-height', value);
  ArcaneStyles maxHeightPx(double value) => set('max-height', '${value}px');

  /// Spacing
  ArcaneStyles padding(EdgeInsets value) => set('padding', value.padding);
  ArcaneStyles paddingAll(double value) =>
      set('padding', EdgeInsets.all(value).padding);
  ArcaneStyles paddingSymmetric({double horizontal = 0, double vertical = 0}) =>
      set('padding',
          EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical).padding);
  ArcaneStyles paddingOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      set('padding',
          EdgeInsets.only(left: left, top: top, right: right, bottom: bottom).padding);

  ArcaneStyles margin(EdgeInsets value) => set('margin', value.margin);
  ArcaneStyles marginAll(double value) =>
      set('margin', EdgeInsets.all(value).margin);
  ArcaneStyles marginSymmetric({double horizontal = 0, double vertical = 0}) =>
      set('margin',
          EdgeInsets.symmetric(horizontal: horizontal, vertical: vertical).margin);
  ArcaneStyles marginOnly({
    double left = 0,
    double top = 0,
    double right = 0,
    double bottom = 0,
  }) =>
      set('margin',
          EdgeInsets.only(left: left, top: top, right: right, bottom: bottom).margin);
  ArcaneStyles marginAuto() => set('margin', 'auto');

  /// Colors
  ArcaneStyles backgroundColor(Color color) =>
      set('background-color', color.css);
  ArcaneStyles backgroundColorVar(String varName) =>
      set('background-color', 'var($varName)');
  ArcaneStyles background(String value) => set('background', value);

  ArcaneStyles color(Color c) => set('color', c.css);
  ArcaneStyles colorVar(String varName) => set('color', 'var($varName)');

  /// Border
  ArcaneStyles border(String value) => set('border', value);
  ArcaneStyles borderWidth(double value) => set('border-width', '${value}px');
  ArcaneStyles borderStyle(String value) => set('border-style', value);
  ArcaneStyles borderColor(Color color) => set('border-color', color.css);
  ArcaneStyles borderColorVar(String varName) =>
      set('border-color', 'var($varName)');

  ArcaneStyles borderTop(String value) => set('border-top', value);
  ArcaneStyles borderRight(String value) => set('border-right', value);
  ArcaneStyles borderBottom(String value) => set('border-bottom', value);
  ArcaneStyles borderLeft(String value) => set('border-left', value);

  ArcaneStyles borderRadius(BorderRadius value) =>
      set('border-radius', value.css);
  ArcaneStyles borderRadiusAll(double value) =>
      set('border-radius', '${value}px');
  ArcaneStyles borderRadiusVar(String varName) =>
      set('border-radius', 'var($varName)');

  /// Shadow
  ArcaneStyles boxShadow(BoxShadow shadow) => set('box-shadow', shadow.css);
  ArcaneStyles boxShadowMultiple(List<BoxShadow> shadows) =>
      set('box-shadow', shadows.map((s) => s.css).join(', '));
  ArcaneStyles boxShadowNone() => set('box-shadow', 'none');

  /// Typography
  ArcaneStyles fontSize(double value) => set('font-size', '${value}px');
  ArcaneStyles fontSizeRem(double value) => set('font-size', '${value}rem');
  ArcaneStyles fontWeight(FontWeight weight) =>
      set('font-weight', weight.css);
  ArcaneStyles fontFamily(String value) => set('font-family', value);
  ArcaneStyles fontStyle(String value) => set('font-style', value);
  ArcaneStyles lineHeight(double value) => set('line-height', '$value');
  ArcaneStyles letterSpacing(double value) =>
      set('letter-spacing', '${value}px');
  ArcaneStyles textAlign(TextAlign align) => set('text-align', align.css);
  ArcaneStyles textDecoration(String value) => set('text-decoration', value);
  ArcaneStyles textTransform(String value) => set('text-transform', value);
  ArcaneStyles whiteSpace(String value) => set('white-space', value);
  ArcaneStyles wordBreak(String value) => set('word-break', value);
  ArcaneStyles overflow(String value) => set('overflow', value);
  ArcaneStyles textOverflow(TextOverflow value) =>
      set('text-overflow', value.css);

  /// Position
  ArcaneStyles position(String value) => set('position', value);
  ArcaneStyles positionRelative() => set('position', 'relative');
  ArcaneStyles positionAbsolute() => set('position', 'absolute');
  ArcaneStyles positionFixed() => set('position', 'fixed');
  ArcaneStyles positionSticky() => set('position', 'sticky');
  ArcaneStyles positionStatic() => set('position', 'static');

  ArcaneStyles top(String value) => set('top', value);
  ArcaneStyles topPx(double value) => set('top', '${value}px');
  ArcaneStyles right(String value) => set('right', value);
  ArcaneStyles rightPx(double value) => set('right', '${value}px');
  ArcaneStyles bottom(String value) => set('bottom', value);
  ArcaneStyles bottomPx(double value) => set('bottom', '${value}px');
  ArcaneStyles left(String value) => set('left', value);
  ArcaneStyles leftPx(double value) => set('left', '${value}px');
  ArcaneStyles inset(String value) => set('inset', value);
  ArcaneStyles insetPx(double value) => set('inset', '${value}px');

  ArcaneStyles zIndex(int value) => set('z-index', '$value');

  /// Transform & Effects
  ArcaneStyles transform(String value) => set('transform', value);
  ArcaneStyles translateX(String value) => set('transform', 'translateX($value)');
  ArcaneStyles translateY(String value) => set('transform', 'translateY($value)');
  ArcaneStyles scale(double value) => set('transform', 'scale($value)');
  ArcaneStyles rotate(String value) => set('transform', 'rotate($value)');

  ArcaneStyles opacity(double value) => set('opacity', '$value');
  ArcaneStyles visibility(String value) => set('visibility', value);

  ArcaneStyles filter(String value) => set('filter', value);
  ArcaneStyles blur(double value) => set('filter', 'blur(${value}px)');
  ArcaneStyles backdropFilter(String value) => set('backdrop-filter', value);
  ArcaneStyles backdropBlur(double value) =>
      set('backdrop-filter', 'blur(${value}px)');

  /// Transitions & Animations
  ArcaneStyles transition(String value) => set('transition', value);
  ArcaneStyles transitionAll({Duration duration = const Duration(milliseconds: 200)}) =>
      set('transition', 'all ${duration.inMilliseconds}ms ease');
  ArcaneStyles transitionProperty(String property,
          {Duration duration = const Duration(milliseconds: 200),
          String timing = 'ease'}) =>
      set('transition', '$property ${duration.inMilliseconds}ms $timing');

  ArcaneStyles animation(String value) => set('animation', value);

  /// Cursor & Interaction
  ArcaneStyles cursor(String value) => set('cursor', value);
  ArcaneStyles cursorPointer() => set('cursor', 'pointer');
  ArcaneStyles cursorDefault() => set('cursor', 'default');
  ArcaneStyles cursorNotAllowed() => set('cursor', 'not-allowed');

  ArcaneStyles pointerEvents(String value) => set('pointer-events', value);
  ArcaneStyles pointerEventsNone() => set('pointer-events', 'none');
  ArcaneStyles pointerEventsAuto() => set('pointer-events', 'auto');

  ArcaneStyles userSelect(String value) => set('user-select', value);
  ArcaneStyles userSelectNone() => set('user-select', 'none');
  ArcaneStyles userSelectAll() => set('user-select', 'all');

  /// Overflow
  ArcaneStyles overflowHidden() => set('overflow', 'hidden');
  ArcaneStyles overflowAuto() => set('overflow', 'auto');
  ArcaneStyles overflowScroll() => set('overflow', 'scroll');
  ArcaneStyles overflowVisible() => set('overflow', 'visible');
  ArcaneStyles overflowX(String value) => set('overflow-x', value);
  ArcaneStyles overflowY(String value) => set('overflow-y', value);

  /// Object fit (for images)
  ArcaneStyles objectFit(BoxFit fit) => set('object-fit', fit.css);
  ArcaneStyles objectPosition(String value) => set('object-position', value);

  /// Outline
  ArcaneStyles outline(String value) => set('outline', value);
  ArcaneStyles outlineNone() => set('outline', 'none');
  ArcaneStyles outlineOffset(double value) => set('outline-offset', '${value}px');

  /// Merge styles from another ArcaneStyles instance
  ArcaneStyles merge(ArcaneStyles other) {
    _styles.addAll(other._styles);
    return this;
  }

  /// Conditionally apply styles
  ArcaneStyles when(bool condition, ArcaneStyles Function(ArcaneStyles s) builder) {
    if (condition) {
      return builder(this);
    }
    return this;
  }

  // ===========================================================================
  // TOKEN-AWARE METHODS
  // ===========================================================================

  /// Merge a map of styles into this builder
  ArcaneStyles mergeMap(Map<String, String> styles) {
    _styles.addAll(styles);
    return this;
  }

  /// Apply a ButtonStyle preset
  ArcaneStyles applyButtonStyle(ButtonStyle style) {
    _styles.addAll(style.base);
    return this;
  }

  /// Apply a ButtonSizeStyle preset
  ArcaneStyles applyButtonSize(ButtonSizeStyle size) {
    _styles.addAll(size.styles);
    return this;
  }

  /// Apply a BadgeStyle preset
  ArcaneStyles applyBadgeStyle(BadgeStyle style) {
    _styles.addAll(style.styles);
    return this;
  }

  /// Apply a CardStyle preset
  ArcaneStyles applyCardStyle(CardStyle style) {
    _styles.addAll(style.styles);
    return this;
  }

  /// Apply an InputStyle preset (base styles)
  ArcaneStyles applyInputStyle(InputStyle style) {
    _styles.addAll(style.base);
    return this;
  }

  /// Apply an InputSizeStyle preset
  ArcaneStyles applyInputSize(InputSizeStyle size) {
    _styles.addAll(size.styles);
    return this;
  }

  /// Apply an AlertStyle preset
  ArcaneStyles applyAlertStyle(AlertStyle style) {
    _styles.addAll(style.styles);
    return this;
  }

  /// Apply a ChipStyle preset
  ArcaneStyles applyChipStyle(ChipStyle style) {
    _styles.addAll(style.styles);
    return this;
  }

  // ===========================================================================
  // COMMON STYLE SHORTCUTS
  // ===========================================================================

  /// Apply card styling with optional elevation
  ArcaneStyles cardStyle({int elevation = 0}) {
    _styles.addAll(ArcaneCommonStyles.cardWithShadow(elevation: elevation));
    return this;
  }

  /// Apply flex row layout
  ArcaneStyles flexRowLayout({double? gapPx}) {
    _styles.addAll(ArcaneCommonStyles.flexRow);
    if (gapPx != null) _styles['gap'] = '${gapPx}px';
    return this;
  }

  /// Apply flex row with spacing
  ArcaneStyles flexRowSpacedLayout() {
    _styles.addAll(ArcaneCommonStyles.flexRowSpaced);
    return this;
  }

  /// Apply flex column layout
  ArcaneStyles flexColLayout({double? gapPx}) {
    _styles.addAll(ArcaneCommonStyles.flexCol);
    if (gapPx != null) _styles['gap'] = '${gapPx}px';
    return this;
  }

  /// Apply flex center layout
  ArcaneStyles flexCenterLayout() {
    _styles.addAll(ArcaneCommonStyles.flexCenter);
    return this;
  }

  /// Apply inline flex layout
  ArcaneStyles inlineFlexLayout({double? gapPx}) {
    _styles.addAll(ArcaneCommonStyles.inlineFlex);
    if (gapPx != null) _styles['gap'] = '${gapPx}px';
    return this;
  }

  /// Apply grid layout with N columns
  ArcaneStyles gridLayout(int cols, {String gap = ArcaneSpacing.md}) {
    _styles.addAll(ArcaneCommonStyles.grid(cols, gap: gap));
    return this;
  }

  /// Apply auto-fit grid layout
  ArcaneStyles gridAutoLayout({String minWidth = '300px', String gap = ArcaneSpacing.md}) {
    _styles.addAll(ArcaneCommonStyles.gridAuto(minWidth: minWidth, gap: gap));
    return this;
  }

  /// Apply heading text style
  ArcaneStyles headingStyle() {
    _styles.addAll(ArcaneCommonStyles.heading);
    return this;
  }

  /// Apply body text style
  ArcaneStyles bodyStyle() {
    _styles.addAll(ArcaneCommonStyles.bodyText);
    return this;
  }

  /// Apply muted text style
  ArcaneStyles mutedStyle() {
    _styles.addAll(ArcaneCommonStyles.mutedText);
    return this;
  }

  /// Apply label text style
  ArcaneStyles labelStyle() {
    _styles.addAll(ArcaneCommonStyles.labelText);
    return this;
  }

  /// Apply container layout
  ArcaneStyles containerLayout({String maxWidth = ArcaneLayout.maxWidthContainer}) {
    _styles.addAll(ArcaneCommonStyles.container(maxWidth: maxWidth));
    return this;
  }

  /// Apply section padding
  ArcaneStyles sectionLayout({String? background}) {
    _styles.addAll(ArcaneCommonStyles.section(background: background));
    return this;
  }

  /// Apply text truncation
  ArcaneStyles truncateText() {
    _styles.addAll(ArcaneCommonStyles.truncate);
    return this;
  }

  /// Apply clickable styles
  ArcaneStyles clickableStyle() {
    _styles.addAll(ArcaneCommonStyles.clickable);
    return this;
  }

  /// Apply disabled styles
  ArcaneStyles disabledStyle() {
    _styles.addAll(ArcaneCommonStyles.disabled);
    return this;
  }

  // ===========================================================================
  // TOKEN-BASED SETTERS
  // ===========================================================================

  /// Set gap using token
  ArcaneStyles gapToken(String token) => set('gap', token);

  /// Set padding using token
  ArcaneStyles paddingToken(String token) => set('padding', token);

  /// Set margin using token
  ArcaneStyles marginToken(String token) => set('margin', token);

  /// Set background color using token
  ArcaneStyles bgToken(String token) => set('background-color', token);

  /// Set background (including gradients) using token
  ArcaneStyles backgroundToken(String token) => set('background', token);

  /// Set text color using token
  ArcaneStyles textColorToken(String token) => set('color', token);

  /// Set border color using token
  ArcaneStyles borderColorToken(String token) => set('border-color', token);

  /// Set font size using token
  ArcaneStyles fontSizeToken(String token) => set('font-size', token);

  /// Set font weight using token
  ArcaneStyles fontWeightToken(String token) => set('font-weight', token);

  /// Set line height using token
  ArcaneStyles lineHeightToken(String token) => set('line-height', token);

  /// Set border radius using token
  ArcaneStyles radiusToken(String token) => set('border-radius', token);

  /// Set box shadow using token
  ArcaneStyles shadowToken(String token) => set('box-shadow', token);

  /// Set transition using token
  ArcaneStyles transitionToken(String token) => set('transition', token);

  // ===========================================================================
  // OUTPUT METHODS
  // ===========================================================================

  /// Convert to CSS string
  String get css => _styles.entries.map((e) => '${e.key}: ${e.value}').join('; ');

  /// Convert to style attribute map
  Map<String, String> get attributes => {'style': css};

  /// Get the raw style map
  Map<String, String> get raw => Map.unmodifiable(_styles);

  /// Convert to Jaspr Styles object
  dom.Styles toStyles() => dom.Styles(raw: _styles);

  @override
  String toString() => css;
}

/// Convenience function to create a new ArcaneStyles instance
ArcaneStyles arcaneStyles() => ArcaneStyles();

/// Helper to create Jaspr Styles from a raw map.
/// Usage: rawStyles({'color': 'red', 'padding': '10px'})
dom.Styles rawStyles(Map<String, String> properties) {
  return dom.Styles(raw: properties);
}
