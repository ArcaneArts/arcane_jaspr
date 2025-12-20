import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' show Styles;
import '../arcane.dart';
import 'spacing.dart';
import 'colors.dart';
import 'borders.dart';
import 'layout.dart';
import 'typography.dart';
import 'effects.dart';

/// Immutable style configuration that converts enum-based properties to CSS.
///
/// This is the core class that enables Flutter-like declarative styling.
/// All properties are optional and only non-null values are included in output.
///
/// Example:
/// ```dart
/// ArcaneStyleData(
///   display: Display.flex,
///   padding: PaddingPreset.md,
///   background: Background.card,
///   borderRadius: Radius.lg,
/// ).toStyles()
/// ```
class ArcaneStyleData {
  // -------------------------------------------------------------------------
  // Layout
  // -------------------------------------------------------------------------

  /// CSS display property
  final Display? display;

  /// Flex direction
  final FlexDirection? flexDirection;

  /// Flex wrap behavior
  final FlexWrap? flexWrap;

  /// Main axis alignment (justify-content)
  final MainAxisAlignment? mainAxisAlignment;

  /// Cross axis alignment (align-items)
  final CrossAxisAlignment? crossAxisAlignment;

  /// Align self
  final CrossAxisAlignment? alignSelf;

  /// Align items (cross-axis alignment)
  final AlignItems? alignItems;

  /// Justify content (main-axis alignment)
  final JustifyContent? justifyContent;

  /// CSS position property
  final Position? position;

  /// Visibility
  final Visibility? visibility;

  /// Z-index
  final ZIndex? zIndex;

  /// Overflow behavior (both axes)
  final Overflow? overflow;

  /// Overflow X axis
  final OverflowAxis? overflowX;

  /// Overflow Y axis
  final OverflowAxis? overflowY;

  // -------------------------------------------------------------------------
  // Sizing
  // -------------------------------------------------------------------------

  /// Width using Size enum
  final Size? width;

  /// Height using Size enum
  final Size? height;

  /// Custom width (px, %, etc.)
  final String? widthCustom;

  /// Custom height (px, %, etc.)
  final String? heightCustom;

  /// Max-width preset
  final MaxWidth? maxWidth;

  /// Custom max-width
  final String? maxWidthCustom;

  /// Min-width
  final String? minWidth;

  /// Max-height
  final String? maxHeight;

  /// Min-height
  final String? minHeight;

  /// Flex grow
  final int? flexGrow;

  /// Flex shrink
  final int? flexShrink;

  /// Flex basis
  final String? flexBasis;

  // -------------------------------------------------------------------------
  // Spacing
  // -------------------------------------------------------------------------

  /// Padding preset
  final PaddingPreset? padding;

  /// Custom padding via EdgeInsets
  final EdgeInsets? paddingCustom;

  /// Margin preset
  final MarginPreset? margin;

  /// Custom margin via EdgeInsets
  final EdgeInsets? marginCustom;

  /// Gap for flex/grid layouts
  final Gap? gap;

  /// Custom gap value
  final String? gapCustom;

  /// Row gap for grid
  final Gap? rowGap;

  /// Column gap for grid
  final Gap? columnGap;

  // -------------------------------------------------------------------------
  // Position offsets
  // -------------------------------------------------------------------------

  /// Top offset
  final String? top;

  /// Right offset
  final String? right;

  /// Bottom offset
  final String? bottom;

  /// Left offset
  final String? left;

  /// Inset (shorthand for all offsets)
  final String? inset;

  // -------------------------------------------------------------------------
  // Colors
  // -------------------------------------------------------------------------

  /// Background color
  final Background? background;

  /// Custom background color
  final String? backgroundCustom;

  /// Text/foreground color
  final TextColor? textColor;

  /// Custom text color
  final String? textColorCustom;

  // -------------------------------------------------------------------------
  // Borders
  // -------------------------------------------------------------------------

  /// Border preset (complete border)
  final BorderPreset? border;

  /// Custom border
  final String? borderCustom;

  /// Border top preset
  final BorderPreset? borderTop;

  /// Border bottom preset
  final BorderPreset? borderBottom;

  /// Border left preset
  final BorderPreset? borderLeft;

  /// Border right preset
  final BorderPreset? borderRight;

  /// Border radius preset
  final Radius? borderRadius;

  /// Custom border radius
  final String? borderRadiusCustom;

  /// Border radius via BorderRadius class
  final BorderRadius? borderRadiusClass;

  /// Outline preset
  final OutlinePreset? outline;

  /// Outline offset
  final String? outlineOffset;

  // -------------------------------------------------------------------------
  // Typography
  // -------------------------------------------------------------------------

  /// Font size preset
  final FontSize? fontSize;

  /// Custom font size
  final String? fontSizeCustom;

  /// Font weight (from arcane.dart)
  final FontWeight? fontWeight;

  /// Line height preset
  final LineHeight? lineHeight;

  /// Letter spacing preset
  final LetterSpacing? letterSpacing;

  /// Text alignment (from arcane.dart)
  final TextAlign? textAlign;

  /// Text decoration
  final TextDecoration? textDecoration;

  /// Text transform
  final TextTransform? textTransform;

  /// White space handling
  final WhiteSpace? whiteSpace;

  /// Word break
  final WordBreak? wordBreak;

  /// Text overflow (from arcane.dart)
  final TextOverflow? textOverflow;

  /// Font family
  final FontFamily? fontFamily;

  /// Font style (italic, etc.)
  final FontStyle? fontStyle;

  // -------------------------------------------------------------------------
  // Effects
  // -------------------------------------------------------------------------

  /// Box shadow preset
  final Shadow? shadow;

  /// Custom box shadow
  final String? shadowCustom;

  /// Transition preset
  final Transition? transition;

  /// Custom transition
  final String? transitionCustom;

  /// Opacity preset
  final Opacity? opacity;

  /// Custom opacity (0-1)
  final double? opacityCustom;

  /// Cursor preset
  final Cursor? cursor;

  /// Pointer events
  final PointerEvents? pointerEvents;

  /// User select
  final UserSelect? userSelect;

  /// Transform preset
  final Transform? transform;

  /// Custom transform
  final String? transformCustom;

  /// Backdrop filter
  final BackdropFilter? backdropFilter;

  /// Animation easing
  final Easing? easing;

  // -------------------------------------------------------------------------
  // Object (for images)
  // -------------------------------------------------------------------------

  /// Object fit
  final ObjectFit? objectFit;

  /// Object position
  final ObjectPosition? objectPosition;

  // -------------------------------------------------------------------------
  // Raw escape hatch
  // -------------------------------------------------------------------------

  /// Raw CSS properties (for anything not covered by enums)
  final Map<String, String>? raw;

  const ArcaneStyleData({
    // Layout
    this.display,
    this.flexDirection,
    this.flexWrap,
    this.mainAxisAlignment,
    this.crossAxisAlignment,
    this.alignSelf,
    this.alignItems,
    this.justifyContent,
    this.position,
    this.visibility,
    this.zIndex,
    this.overflow,
    this.overflowX,
    this.overflowY,
    // Sizing
    this.width,
    this.height,
    this.widthCustom,
    this.heightCustom,
    this.maxWidth,
    this.maxWidthCustom,
    this.minWidth,
    this.maxHeight,
    this.minHeight,
    this.flexGrow,
    this.flexShrink,
    this.flexBasis,
    // Spacing
    this.padding,
    this.paddingCustom,
    this.margin,
    this.marginCustom,
    this.gap,
    this.gapCustom,
    this.rowGap,
    this.columnGap,
    // Position offsets
    this.top,
    this.right,
    this.bottom,
    this.left,
    this.inset,
    // Colors
    this.background,
    this.backgroundCustom,
    this.textColor,
    this.textColorCustom,
    // Borders
    this.border,
    this.borderCustom,
    this.borderTop,
    this.borderBottom,
    this.borderLeft,
    this.borderRight,
    this.borderRadius,
    this.borderRadiusCustom,
    this.borderRadiusClass,
    this.outline,
    this.outlineOffset,
    // Typography
    this.fontSize,
    this.fontSizeCustom,
    this.fontWeight,
    this.lineHeight,
    this.letterSpacing,
    this.textAlign,
    this.textDecoration,
    this.textTransform,
    this.whiteSpace,
    this.wordBreak,
    this.textOverflow,
    this.fontFamily,
    this.fontStyle,
    // Effects
    this.shadow,
    this.shadowCustom,
    this.transition,
    this.transitionCustom,
    this.opacity,
    this.opacityCustom,
    this.cursor,
    this.pointerEvents,
    this.userSelect,
    this.transform,
    this.transformCustom,
    this.backdropFilter,
    this.easing,
    // Object
    this.objectFit,
    this.objectPosition,
    // Raw
    this.raw,
  });

  /// Convert to Jaspr Styles object
  Styles toStyles() {
    final Map<String, String> css = {};

    // Layout
    if (display != null) css['display'] = display!.css;
    if (flexDirection != null) css['flex-direction'] = flexDirection!.css;
    if (flexWrap != null) css['flex-wrap'] = flexWrap!.css;
    if (mainAxisAlignment != null) {
      css['justify-content'] = mainAxisAlignment!.css;
    }
    if (crossAxisAlignment != null) css['align-items'] = crossAxisAlignment!.css;
    if (alignItems != null) css['align-items'] = alignItems!.css;
    if (justifyContent != null) css['justify-content'] = justifyContent!.css;
    if (alignSelf != null) css['align-self'] = alignSelf!.css;
    if (position != null) css['position'] = position!.css;
    if (visibility != null) css['visibility'] = visibility!.css;
    if (zIndex != null) css['z-index'] = zIndex!.css;
    if (overflow != null) css['overflow'] = overflow!.css;
    if (overflowX != null) css['overflow-x'] = overflowX!.css;
    if (overflowY != null) css['overflow-y'] = overflowY!.css;

    // Sizing
    if (width != null) css['width'] = width!.widthCss;
    if (widthCustom != null) css['width'] = widthCustom!;
    if (height != null) css['height'] = height!.css;
    if (heightCustom != null) css['height'] = heightCustom!;
    if (maxWidth != null) css['max-width'] = maxWidth!.css;
    if (maxWidthCustom != null) css['max-width'] = maxWidthCustom!;
    if (minWidth != null) css['min-width'] = minWidth!;
    if (maxHeight != null) css['max-height'] = maxHeight!;
    if (minHeight != null) css['min-height'] = minHeight!;
    if (flexGrow != null) css['flex-grow'] = '$flexGrow';
    if (flexShrink != null) css['flex-shrink'] = '$flexShrink';
    if (flexBasis != null) css['flex-basis'] = flexBasis!;

    // Spacing
    if (padding != null) css['padding'] = padding!.css;
    if (paddingCustom != null) css['padding'] = paddingCustom!.padding;
    if (margin != null) css['margin'] = margin!.css;
    if (marginCustom != null) css['margin'] = marginCustom!.margin;
    if (gap != null) css['gap'] = gap!.css;
    if (gapCustom != null) css['gap'] = gapCustom!;
    if (rowGap != null) css['row-gap'] = rowGap!.css;
    if (columnGap != null) css['column-gap'] = columnGap!.css;

    // Position offsets
    if (top != null) css['top'] = top!;
    if (right != null) css['right'] = right!;
    if (bottom != null) css['bottom'] = bottom!;
    if (left != null) css['left'] = left!;
    if (inset != null) css['inset'] = inset!;

    // Colors
    if (background != null) css['background-color'] = background!.css;
    if (backgroundCustom != null) css['background-color'] = backgroundCustom!;
    if (textColor != null) css['color'] = textColor!.css;
    if (textColorCustom != null) css['color'] = textColorCustom!;

    // Borders
    if (border != null) css['border'] = border!.css;
    if (borderCustom != null) css['border'] = borderCustom!;
    if (borderTop != null) css['border-top'] = borderTop!.css;
    if (borderBottom != null) css['border-bottom'] = borderBottom!.css;
    if (borderLeft != null) css['border-left'] = borderLeft!.css;
    if (borderRight != null) css['border-right'] = borderRight!.css;
    if (borderRadius != null) css['border-radius'] = borderRadius!.css;
    if (borderRadiusCustom != null) css['border-radius'] = borderRadiusCustom!;
    if (borderRadiusClass != null) css['border-radius'] = borderRadiusClass!.css;
    if (outline != null) css['outline'] = outline!.css;
    if (outlineOffset != null) css['outline-offset'] = outlineOffset!;

    // Typography
    if (fontSize != null) css['font-size'] = fontSize!.css;
    if (fontSizeCustom != null) css['font-size'] = fontSizeCustom!;
    if (fontWeight != null) css['font-weight'] = fontWeight!.css;
    if (lineHeight != null) css['line-height'] = lineHeight!.css;
    if (letterSpacing != null) css['letter-spacing'] = letterSpacing!.css;
    if (textAlign != null) css['text-align'] = textAlign!.css;
    if (textDecoration != null) css['text-decoration'] = textDecoration!.css;
    if (textTransform != null) css['text-transform'] = textTransform!.css;
    if (whiteSpace != null) css['white-space'] = whiteSpace!.css;
    if (wordBreak != null) css['word-break'] = wordBreak!.css;
    if (textOverflow != null) css['text-overflow'] = textOverflow!.css;
    if (fontFamily != null) css['font-family'] = fontFamily!.css;
    if (fontStyle != null) css['font-style'] = fontStyle!.css;

    // Effects
    if (shadow != null) css['box-shadow'] = shadow!.css;
    if (shadowCustom != null) css['box-shadow'] = shadowCustom!;
    if (transition != null) css['transition'] = transition!.css;
    if (transitionCustom != null) css['transition'] = transitionCustom!;
    if (opacity != null) css['opacity'] = opacity!.css;
    if (opacityCustom != null) css['opacity'] = '$opacityCustom';
    if (cursor != null) css['cursor'] = cursor!.css;
    if (pointerEvents != null) css['pointer-events'] = pointerEvents!.css;
    if (userSelect != null) css['user-select'] = userSelect!.css;
    if (transform != null) css['transform'] = transform!.css;
    if (transformCustom != null) css['transform'] = transformCustom!;
    if (backdropFilter != null) {
      css['backdrop-filter'] = backdropFilter!.css;
      css['-webkit-backdrop-filter'] = backdropFilter!.css;
    }

    // Object
    if (objectFit != null) css['object-fit'] = objectFit!.css;
    if (objectPosition != null) css['object-position'] = objectPosition!.css;

    // Raw overrides (applied last to allow full customization)
    if (raw != null) css.addAll(raw!);

    return Styles(raw: css);
  }

  /// Convert to raw CSS map
  Map<String, String> toMap() {
    final Map<String, String> css = {};

    // Layout
    if (display != null) css['display'] = display!.css;
    if (flexDirection != null) css['flex-direction'] = flexDirection!.css;
    if (flexWrap != null) css['flex-wrap'] = flexWrap!.css;
    if (mainAxisAlignment != null) {
      css['justify-content'] = mainAxisAlignment!.css;
    }
    if (crossAxisAlignment != null) css['align-items'] = crossAxisAlignment!.css;
    if (alignItems != null) css['align-items'] = alignItems!.css;
    if (justifyContent != null) css['justify-content'] = justifyContent!.css;
    if (alignSelf != null) css['align-self'] = alignSelf!.css;
    if (position != null) css['position'] = position!.css;
    if (visibility != null) css['visibility'] = visibility!.css;
    if (zIndex != null) css['z-index'] = zIndex!.css;
    if (overflow != null) css['overflow'] = overflow!.css;
    if (overflowX != null) css['overflow-x'] = overflowX!.css;
    if (overflowY != null) css['overflow-y'] = overflowY!.css;

    // Sizing
    if (width != null) css['width'] = width!.widthCss;
    if (widthCustom != null) css['width'] = widthCustom!;
    if (height != null) css['height'] = height!.css;
    if (heightCustom != null) css['height'] = heightCustom!;
    if (maxWidth != null) css['max-width'] = maxWidth!.css;
    if (maxWidthCustom != null) css['max-width'] = maxWidthCustom!;
    if (minWidth != null) css['min-width'] = minWidth!;
    if (maxHeight != null) css['max-height'] = maxHeight!;
    if (minHeight != null) css['min-height'] = minHeight!;
    if (flexGrow != null) css['flex-grow'] = '$flexGrow';
    if (flexShrink != null) css['flex-shrink'] = '$flexShrink';
    if (flexBasis != null) css['flex-basis'] = flexBasis!;

    // Spacing
    if (padding != null) css['padding'] = padding!.css;
    if (paddingCustom != null) css['padding'] = paddingCustom!.padding;
    if (margin != null) css['margin'] = margin!.css;
    if (marginCustom != null) css['margin'] = marginCustom!.margin;
    if (gap != null) css['gap'] = gap!.css;
    if (gapCustom != null) css['gap'] = gapCustom!;
    if (rowGap != null) css['row-gap'] = rowGap!.css;
    if (columnGap != null) css['column-gap'] = columnGap!.css;

    // Position offsets
    if (top != null) css['top'] = top!;
    if (right != null) css['right'] = right!;
    if (bottom != null) css['bottom'] = bottom!;
    if (left != null) css['left'] = left!;
    if (inset != null) css['inset'] = inset!;

    // Colors
    if (background != null) css['background-color'] = background!.css;
    if (backgroundCustom != null) css['background-color'] = backgroundCustom!;
    if (textColor != null) css['color'] = textColor!.css;
    if (textColorCustom != null) css['color'] = textColorCustom!;

    // Borders
    if (border != null) css['border'] = border!.css;
    if (borderCustom != null) css['border'] = borderCustom!;
    if (borderTop != null) css['border-top'] = borderTop!.css;
    if (borderBottom != null) css['border-bottom'] = borderBottom!.css;
    if (borderLeft != null) css['border-left'] = borderLeft!.css;
    if (borderRight != null) css['border-right'] = borderRight!.css;
    if (borderRadius != null) css['border-radius'] = borderRadius!.css;
    if (borderRadiusCustom != null) css['border-radius'] = borderRadiusCustom!;
    if (borderRadiusClass != null) css['border-radius'] = borderRadiusClass!.css;
    if (outline != null) css['outline'] = outline!.css;
    if (outlineOffset != null) css['outline-offset'] = outlineOffset!;

    // Typography
    if (fontSize != null) css['font-size'] = fontSize!.css;
    if (fontSizeCustom != null) css['font-size'] = fontSizeCustom!;
    if (fontWeight != null) css['font-weight'] = fontWeight!.css;
    if (lineHeight != null) css['line-height'] = lineHeight!.css;
    if (letterSpacing != null) css['letter-spacing'] = letterSpacing!.css;
    if (textAlign != null) css['text-align'] = textAlign!.css;
    if (textDecoration != null) css['text-decoration'] = textDecoration!.css;
    if (textTransform != null) css['text-transform'] = textTransform!.css;
    if (whiteSpace != null) css['white-space'] = whiteSpace!.css;
    if (wordBreak != null) css['word-break'] = wordBreak!.css;
    if (textOverflow != null) css['text-overflow'] = textOverflow!.css;
    if (fontFamily != null) css['font-family'] = fontFamily!.css;
    if (fontStyle != null) css['font-style'] = fontStyle!.css;

    // Effects
    if (shadow != null) css['box-shadow'] = shadow!.css;
    if (shadowCustom != null) css['box-shadow'] = shadowCustom!;
    if (transition != null) css['transition'] = transition!.css;
    if (transitionCustom != null) css['transition'] = transitionCustom!;
    if (opacity != null) css['opacity'] = opacity!.css;
    if (opacityCustom != null) css['opacity'] = '$opacityCustom';
    if (cursor != null) css['cursor'] = cursor!.css;
    if (pointerEvents != null) css['pointer-events'] = pointerEvents!.css;
    if (userSelect != null) css['user-select'] = userSelect!.css;
    if (transform != null) css['transform'] = transform!.css;
    if (transformCustom != null) css['transform'] = transformCustom!;
    if (backdropFilter != null) {
      css['backdrop-filter'] = backdropFilter!.css;
      css['-webkit-backdrop-filter'] = backdropFilter!.css;
    }

    // Object
    if (objectFit != null) css['object-fit'] = objectFit!.css;
    if (objectPosition != null) css['object-position'] = objectPosition!.css;

    // Raw overrides (applied last to allow full customization)
    if (raw != null) css.addAll(raw!);

    return css;
  }

  /// Merge with another ArcaneStyleData (other takes precedence)
  ArcaneStyleData merge(ArcaneStyleData? other) {
    if (other == null) return this;
    return ArcaneStyleData(
      // Layout
      display: other.display ?? display,
      flexDirection: other.flexDirection ?? flexDirection,
      flexWrap: other.flexWrap ?? flexWrap,
      mainAxisAlignment: other.mainAxisAlignment ?? mainAxisAlignment,
      crossAxisAlignment: other.crossAxisAlignment ?? crossAxisAlignment,
      alignSelf: other.alignSelf ?? alignSelf,
      position: other.position ?? position,
      visibility: other.visibility ?? visibility,
      zIndex: other.zIndex ?? zIndex,
      overflow: other.overflow ?? overflow,
      overflowX: other.overflowX ?? overflowX,
      overflowY: other.overflowY ?? overflowY,
      // Sizing
      width: other.width ?? width,
      height: other.height ?? height,
      widthCustom: other.widthCustom ?? widthCustom,
      heightCustom: other.heightCustom ?? heightCustom,
      maxWidth: other.maxWidth ?? maxWidth,
      maxWidthCustom: other.maxWidthCustom ?? maxWidthCustom,
      minWidth: other.minWidth ?? minWidth,
      maxHeight: other.maxHeight ?? maxHeight,
      minHeight: other.minHeight ?? minHeight,
      flexGrow: other.flexGrow ?? flexGrow,
      flexShrink: other.flexShrink ?? flexShrink,
      flexBasis: other.flexBasis ?? flexBasis,
      // Spacing
      padding: other.padding ?? padding,
      paddingCustom: other.paddingCustom ?? paddingCustom,
      margin: other.margin ?? margin,
      marginCustom: other.marginCustom ?? marginCustom,
      gap: other.gap ?? gap,
      gapCustom: other.gapCustom ?? gapCustom,
      rowGap: other.rowGap ?? rowGap,
      columnGap: other.columnGap ?? columnGap,
      // Position
      top: other.top ?? top,
      right: other.right ?? right,
      bottom: other.bottom ?? bottom,
      left: other.left ?? left,
      inset: other.inset ?? inset,
      // Colors
      background: other.background ?? background,
      backgroundCustom: other.backgroundCustom ?? backgroundCustom,
      textColor: other.textColor ?? textColor,
      textColorCustom: other.textColorCustom ?? textColorCustom,
      // Borders
      border: other.border ?? border,
      borderCustom: other.borderCustom ?? borderCustom,
      borderTop: other.borderTop ?? borderTop,
      borderBottom: other.borderBottom ?? borderBottom,
      borderLeft: other.borderLeft ?? borderLeft,
      borderRight: other.borderRight ?? borderRight,
      borderRadius: other.borderRadius ?? borderRadius,
      borderRadiusCustom: other.borderRadiusCustom ?? borderRadiusCustom,
      borderRadiusClass: other.borderRadiusClass ?? borderRadiusClass,
      outline: other.outline ?? outline,
      outlineOffset: other.outlineOffset ?? outlineOffset,
      // Typography
      fontSize: other.fontSize ?? fontSize,
      fontSizeCustom: other.fontSizeCustom ?? fontSizeCustom,
      fontWeight: other.fontWeight ?? fontWeight,
      lineHeight: other.lineHeight ?? lineHeight,
      letterSpacing: other.letterSpacing ?? letterSpacing,
      textAlign: other.textAlign ?? textAlign,
      textDecoration: other.textDecoration ?? textDecoration,
      textTransform: other.textTransform ?? textTransform,
      whiteSpace: other.whiteSpace ?? whiteSpace,
      wordBreak: other.wordBreak ?? wordBreak,
      textOverflow: other.textOverflow ?? textOverflow,
      fontFamily: other.fontFamily ?? fontFamily,
      fontStyle: other.fontStyle ?? fontStyle,
      // Effects
      shadow: other.shadow ?? shadow,
      shadowCustom: other.shadowCustom ?? shadowCustom,
      transition: other.transition ?? transition,
      transitionCustom: other.transitionCustom ?? transitionCustom,
      opacity: other.opacity ?? opacity,
      opacityCustom: other.opacityCustom ?? opacityCustom,
      cursor: other.cursor ?? cursor,
      pointerEvents: other.pointerEvents ?? pointerEvents,
      userSelect: other.userSelect ?? userSelect,
      transform: other.transform ?? transform,
      transformCustom: other.transformCustom ?? transformCustom,
      backdropFilter: other.backdropFilter ?? backdropFilter,
      easing: other.easing ?? easing,
      // Object
      objectFit: other.objectFit ?? objectFit,
      objectPosition: other.objectPosition ?? objectPosition,
      // Raw - merge maps
      raw: {...?raw, ...?other.raw},
    );
  }

  /// Create a copy with some properties changed
  ArcaneStyleData copyWith({
    // Layout
    Display? display,
    FlexDirection? flexDirection,
    FlexWrap? flexWrap,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    CrossAxisAlignment? alignSelf,
    Position? position,
    Visibility? visibility,
    ZIndex? zIndex,
    Overflow? overflow,
    OverflowAxis? overflowX,
    OverflowAxis? overflowY,
    // Sizing
    Size? width,
    Size? height,
    String? widthCustom,
    String? heightCustom,
    MaxWidth? maxWidth,
    String? maxWidthCustom,
    String? minWidth,
    String? maxHeight,
    String? minHeight,
    int? flexGrow,
    int? flexShrink,
    String? flexBasis,
    // Spacing
    PaddingPreset? padding,
    EdgeInsets? paddingCustom,
    MarginPreset? margin,
    EdgeInsets? marginCustom,
    Gap? gap,
    String? gapCustom,
    Gap? rowGap,
    Gap? columnGap,
    // Position
    String? top,
    String? right,
    String? bottom,
    String? left,
    String? inset,
    // Colors
    Background? background,
    String? backgroundCustom,
    TextColor? textColor,
    String? textColorCustom,
    // Borders
    BorderPreset? border,
    String? borderCustom,
    BorderPreset? borderTop,
    BorderPreset? borderBottom,
    BorderPreset? borderLeft,
    BorderPreset? borderRight,
    Radius? borderRadius,
    String? borderRadiusCustom,
    BorderRadius? borderRadiusClass,
    OutlinePreset? outline,
    String? outlineOffset,
    // Typography
    FontSize? fontSize,
    String? fontSizeCustom,
    FontWeight? fontWeight,
    LineHeight? lineHeight,
    LetterSpacing? letterSpacing,
    TextAlign? textAlign,
    TextDecoration? textDecoration,
    TextTransform? textTransform,
    WhiteSpace? whiteSpace,
    WordBreak? wordBreak,
    TextOverflow? textOverflow,
    FontFamily? fontFamily,
    FontStyle? fontStyle,
    // Effects
    Shadow? shadow,
    String? shadowCustom,
    Transition? transition,
    String? transitionCustom,
    Opacity? opacity,
    double? opacityCustom,
    Cursor? cursor,
    PointerEvents? pointerEvents,
    UserSelect? userSelect,
    Transform? transform,
    String? transformCustom,
    BackdropFilter? backdropFilter,
    Easing? easing,
    // Object
    ObjectFit? objectFit,
    ObjectPosition? objectPosition,
    // Raw
    Map<String, String>? raw,
  }) {
    return ArcaneStyleData(
      display: display ?? this.display,
      flexDirection: flexDirection ?? this.flexDirection,
      flexWrap: flexWrap ?? this.flexWrap,
      mainAxisAlignment: mainAxisAlignment ?? this.mainAxisAlignment,
      crossAxisAlignment: crossAxisAlignment ?? this.crossAxisAlignment,
      alignSelf: alignSelf ?? this.alignSelf,
      alignItems: alignItems ?? this.alignItems,
      justifyContent: justifyContent ?? this.justifyContent,
      position: position ?? this.position,
      visibility: visibility ?? this.visibility,
      zIndex: zIndex ?? this.zIndex,
      overflow: overflow ?? this.overflow,
      overflowX: overflowX ?? this.overflowX,
      overflowY: overflowY ?? this.overflowY,
      width: width ?? this.width,
      height: height ?? this.height,
      widthCustom: widthCustom ?? this.widthCustom,
      heightCustom: heightCustom ?? this.heightCustom,
      maxWidth: maxWidth ?? this.maxWidth,
      maxWidthCustom: maxWidthCustom ?? this.maxWidthCustom,
      minWidth: minWidth ?? this.minWidth,
      maxHeight: maxHeight ?? this.maxHeight,
      minHeight: minHeight ?? this.minHeight,
      flexGrow: flexGrow ?? this.flexGrow,
      flexShrink: flexShrink ?? this.flexShrink,
      flexBasis: flexBasis ?? this.flexBasis,
      padding: padding ?? this.padding,
      paddingCustom: paddingCustom ?? this.paddingCustom,
      margin: margin ?? this.margin,
      marginCustom: marginCustom ?? this.marginCustom,
      gap: gap ?? this.gap,
      gapCustom: gapCustom ?? this.gapCustom,
      rowGap: rowGap ?? this.rowGap,
      columnGap: columnGap ?? this.columnGap,
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
      left: left ?? this.left,
      inset: inset ?? this.inset,
      background: background ?? this.background,
      backgroundCustom: backgroundCustom ?? this.backgroundCustom,
      textColor: textColor ?? this.textColor,
      textColorCustom: textColorCustom ?? this.textColorCustom,
      border: border ?? this.border,
      borderCustom: borderCustom ?? this.borderCustom,
      borderTop: borderTop ?? this.borderTop,
      borderBottom: borderBottom ?? this.borderBottom,
      borderLeft: borderLeft ?? this.borderLeft,
      borderRight: borderRight ?? this.borderRight,
      borderRadius: borderRadius ?? this.borderRadius,
      borderRadiusCustom: borderRadiusCustom ?? this.borderRadiusCustom,
      borderRadiusClass: borderRadiusClass ?? this.borderRadiusClass,
      outline: outline ?? this.outline,
      outlineOffset: outlineOffset ?? this.outlineOffset,
      fontSize: fontSize ?? this.fontSize,
      fontSizeCustom: fontSizeCustom ?? this.fontSizeCustom,
      fontWeight: fontWeight ?? this.fontWeight,
      lineHeight: lineHeight ?? this.lineHeight,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      textAlign: textAlign ?? this.textAlign,
      textDecoration: textDecoration ?? this.textDecoration,
      textTransform: textTransform ?? this.textTransform,
      whiteSpace: whiteSpace ?? this.whiteSpace,
      wordBreak: wordBreak ?? this.wordBreak,
      textOverflow: textOverflow ?? this.textOverflow,
      fontFamily: fontFamily ?? this.fontFamily,
      fontStyle: fontStyle ?? this.fontStyle,
      shadow: shadow ?? this.shadow,
      shadowCustom: shadowCustom ?? this.shadowCustom,
      transition: transition ?? this.transition,
      transitionCustom: transitionCustom ?? this.transitionCustom,
      opacity: opacity ?? this.opacity,
      opacityCustom: opacityCustom ?? this.opacityCustom,
      cursor: cursor ?? this.cursor,
      pointerEvents: pointerEvents ?? this.pointerEvents,
      userSelect: userSelect ?? this.userSelect,
      transform: transform ?? this.transform,
      transformCustom: transformCustom ?? this.transformCustom,
      backdropFilter: backdropFilter ?? this.backdropFilter,
      easing: easing ?? this.easing,
      objectFit: objectFit ?? this.objectFit,
      objectPosition: objectPosition ?? this.objectPosition,
      raw: raw ?? this.raw,
    );
  }

  /// Common preset: Flex row
  static const row = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.row,
    crossAxisAlignment: CrossAxisAlignment.center,
  );

  /// Common preset: Flex row with space-between
  static const rowSpaced = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.row,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
  );

  /// Common preset: Flex column
  static const column = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
  );

  /// Common preset: Flex center (both axes)
  static const flexCenter = ArcaneStyleData(
    display: Display.flex,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
  );

  /// Common preset: Full width and height
  static const fullSize = ArcaneStyleData(
    width: Size.full,
    height: Size.full,
  );

  /// Common preset: Absolute fill (inset 0)
  static const absoluteFill = ArcaneStyleData(
    position: Position.absolute,
    inset: '0',
  );
}
