import 'package:jaspr/dom.dart' show Styles;
import '../arcane.dart';
import 'spacing.dart';
import 'colors.dart';
import 'borders.dart';
import 'layout.dart';
import 'typography.dart';
import 'effects.dart';

/// Immutable style configuration with type-safe enum properties.
class ArcaneStyleData {
  final Display? display;
  final FlexDirection? flexDirection;
  final FlexWrap? flexWrap;
  final MainAxisAlignment? mainAxisAlignment;
  final CrossAxisAlignment? crossAxisAlignment;
  final CrossAxisAlignment? alignSelf;
  final AlignItems? alignItems;
  final JustifyContent? justifyContent;
  final Position? position;
  final Visibility? visibility;
  final ZIndex? zIndex;
  final String? zIndexCustom;
  final Overflow? overflow;
  final OverflowAxis? overflowX;
  final OverflowAxis? overflowY;
  final String? overflowCustom;
  final String? displayCustom;

  final Size? width;
  final Size? height;
  final String? widthCustom;
  final String? heightCustom;
  final MaxWidth? maxWidth;
  final String? maxWidthCustom;
  final String? minWidth;
  final String? maxHeight;
  final String? minHeight;
  final int? flexGrow;
  final int? flexShrink;
  final String? flexBasis;
  final FlexPreset? flex;
  final String? flexCustom;

  final GridColumns? gridColumns;
  final String? gridColumnsCustom;
  final GridRows? gridRows;
  final String? gridRowsCustom;
  final GridAutoFlow? gridAutoFlow;
  final PlaceItems? placeItems;
  final PlaceContent? placeContent;

  final PaddingPreset? padding;
  final EdgeInsets? paddingCustom;
  final MarginPreset? margin;
  final EdgeInsets? marginCustom;
  final String? marginStringCustom;
  final String? paddingStringCustom;
  final Gap? gap;
  final String? gapCustom;
  final Gap? rowGap;
  final Gap? columnGap;

  final String? top;
  final String? right;
  final String? bottom;
  final String? left;
  final String? inset;

  final Background? background;
  final String? backgroundCustom;
  final TextColor? textColor;
  final String? textColorCustom;

  final BorderPreset? border;
  final String? borderCustom;
  final BorderPreset? borderTop;
  final BorderPreset? borderBottom;
  final BorderPreset? borderLeft;
  final BorderPreset? borderRight;
  final Radius? borderRadius;
  final String? borderRadiusCustom;
  final BorderRadius? borderRadiusClass;
  final OutlinePreset? outline;
  final String? outlineCustom;
  final String? outlineOffset;
  final BorderWidth? borderWidth;
  final BorderWidth? borderLeftWidth;
  final BorderWidth? borderRightWidth;
  final BorderWidth? borderTopWidth;
  final BorderWidth? borderBottomWidth;

  final FontSize? fontSize;
  final String? fontSizeCustom;
  final FontWeight? fontWeight;
  final String? fontWeightCustom;
  final LineHeight? lineHeight;
  final LetterSpacing? letterSpacing;
  final String? letterSpacingCustom;
  final TextAlign? textAlign;
  final String? textAlignCustom;
  final TextDecoration? textDecoration;
  final TextTransform? textTransform;
  final String? textTransformCustom;
  final WhiteSpace? whiteSpace;
  final WordBreak? wordBreak;
  final TextOverflow? textOverflow;
  final FontFamily? fontFamily;
  final FontStyle? fontStyle;

  final Shadow? shadow;
  final String? shadowCustom;
  final Transition? transition;
  final String? transitionCustom;
  final Opacity? opacity;
  final double? opacityCustom;
  final Cursor? cursor;
  final String? cursorCustom;
  final PointerEvents? pointerEvents;
  final UserSelect? userSelect;
  final Transform? transform;
  final String? transformCustom;
  final TransformOrigin? transformOrigin;
  final String? transformOriginCustom;
  final BackdropFilter? backdropFilter;
  final String? filterCustom;
  final Easing? easing;
  final AnimationPreset? animation;
  final String? animationCustom;
  final String? animationDelay;
  final String? textShadowCustom;

  final ObjectFit? objectFit;
  final String? objectFitCustom;
  final ObjectPosition? objectPosition;

  final String? borderCollapse;

  final String? paddingTop;
  final String? paddingRight;
  final String? paddingBottom;
  final String? paddingLeft;
  final String? borderTopCustom;
  final String? borderRightCustom;
  final String? borderBottomCustom;
  final String? borderLeftCustom;
  final BoxSizing? boxSizing;
  final String? backgroundClip;
  final String? backdropFilterCustom;

  /// Raw CSS properties escape hatch
  final Map<String, String>? raw;

  const ArcaneStyleData({
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
    this.zIndexCustom,
    this.overflow,
    this.overflowX,
    this.overflowY,
    this.overflowCustom,
    this.displayCustom,
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
    this.flex,
    this.flexCustom,
    this.gridColumns,
    this.gridColumnsCustom,
    this.gridRows,
    this.gridRowsCustom,
    this.gridAutoFlow,
    this.placeItems,
    this.placeContent,
    this.padding,
    this.paddingCustom,
    this.margin,
    this.marginCustom,
    this.marginStringCustom,
    this.paddingStringCustom,
    this.gap,
    this.gapCustom,
    this.rowGap,
    this.columnGap,
    this.top,
    this.right,
    this.bottom,
    this.left,
    this.inset,
    this.background,
    this.backgroundCustom,
    this.textColor,
    this.textColorCustom,
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
    this.outlineCustom,
    this.outlineOffset,
    this.borderWidth,
    this.borderLeftWidth,
    this.borderRightWidth,
    this.borderTopWidth,
    this.borderBottomWidth,
    this.fontSize,
    this.fontSizeCustom,
    this.fontWeight,
    this.fontWeightCustom,
    this.lineHeight,
    this.letterSpacing,
    this.letterSpacingCustom,
    this.textAlign,
    this.textAlignCustom,
    this.textDecoration,
    this.textTransform,
    this.textTransformCustom,
    this.whiteSpace,
    this.wordBreak,
    this.textOverflow,
    this.fontFamily,
    this.fontStyle,
    this.shadow,
    this.shadowCustom,
    this.transition,
    this.transitionCustom,
    this.opacity,
    this.opacityCustom,
    this.cursor,
    this.cursorCustom,
    this.pointerEvents,
    this.userSelect,
    this.transform,
    this.transformCustom,
    this.transformOrigin,
    this.transformOriginCustom,
    this.backdropFilter,
    this.filterCustom,
    this.easing,
    this.animation,
    this.animationCustom,
    this.animationDelay,
    this.textShadowCustom,
    this.objectFit,
    this.objectFitCustom,
    this.objectPosition,
    this.borderCollapse,
    this.paddingTop,
    this.paddingRight,
    this.paddingBottom,
    this.paddingLeft,
    this.borderTopCustom,
    this.borderRightCustom,
    this.borderBottomCustom,
    this.borderLeftCustom,
    this.boxSizing,
    this.backgroundClip,
    this.backdropFilterCustom,
    this.raw,
  });

  /// Convert to Jaspr Styles object
  Styles toStyles() {
    final Map<String, String> css = {};

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
    if (zIndexCustom != null) css['z-index'] = zIndexCustom!;
    if (overflow != null) css['overflow'] = overflow!.css;
    if (overflowX != null) css['overflow-x'] = overflowX!.css;
    if (overflowY != null) css['overflow-y'] = overflowY!.css;
    if (overflowCustom != null) css['overflow'] = overflowCustom!;
    if (displayCustom != null) css['display'] = displayCustom!;

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
    if (flex != null) css['flex'] = flex!.css;
    if (flexCustom != null) css['flex'] = flexCustom!;

    if (gridColumns != null) css['grid-template-columns'] = gridColumns!.css;
    if (gridColumnsCustom != null) {
      css['grid-template-columns'] = gridColumnsCustom!;
    }
    if (gridRows != null) css['grid-template-rows'] = gridRows!.css;
    if (gridRowsCustom != null) css['grid-template-rows'] = gridRowsCustom!;
    if (gridAutoFlow != null) css['grid-auto-flow'] = gridAutoFlow!.css;
    if (placeItems != null) css['place-items'] = placeItems!.css;
    if (placeContent != null) css['place-content'] = placeContent!.css;

    if (padding != null) css['padding'] = padding!.css;
    if (paddingCustom != null) css['padding'] = paddingCustom!.padding;
    if (paddingStringCustom != null) css['padding'] = paddingStringCustom!;
    if (margin != null) css['margin'] = margin!.css;
    if (marginCustom != null) css['margin'] = marginCustom!.margin;
    if (marginStringCustom != null) css['margin'] = marginStringCustom!;
    if (gap != null) css['gap'] = gap!.css;
    if (gapCustom != null) css['gap'] = gapCustom!;
    if (rowGap != null) css['row-gap'] = rowGap!.css;
    if (columnGap != null) css['column-gap'] = columnGap!.css;

    if (top != null) css['top'] = top!;
    if (right != null) css['right'] = right!;
    if (bottom != null) css['bottom'] = bottom!;
    if (left != null) css['left'] = left!;
    if (inset != null) css['inset'] = inset!;

    if (background != null) css['background-color'] = background!.css;
    if (backgroundCustom != null) css['background'] = backgroundCustom!;
    if (textColor != null) css['color'] = textColor!.css;
    if (textColorCustom != null) css['color'] = textColorCustom!;

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
    if (outlineCustom != null) css['outline'] = outlineCustom!;
    if (outlineOffset != null) css['outline-offset'] = outlineOffset!;
    if (borderWidth != null) css['border-width'] = borderWidth!.css;
    if (borderLeftWidth != null) css['border-left-width'] = borderLeftWidth!.css;
    if (borderRightWidth != null) {
      css['border-right-width'] = borderRightWidth!.css;
    }
    if (borderTopWidth != null) css['border-top-width'] = borderTopWidth!.css;
    if (borderBottomWidth != null) {
      css['border-bottom-width'] = borderBottomWidth!.css;
    }

    if (fontSize != null) css['font-size'] = fontSize!.css;
    if (fontSizeCustom != null) css['font-size'] = fontSizeCustom!;
    if (fontWeight != null) css['font-weight'] = fontWeight!.css;
    if (fontWeightCustom != null) css['font-weight'] = fontWeightCustom!;
    if (lineHeight != null) css['line-height'] = lineHeight!.css;
    if (letterSpacing != null) css['letter-spacing'] = letterSpacing!.css;
    if (letterSpacingCustom != null) css['letter-spacing'] = letterSpacingCustom!;
    if (textAlign != null) css['text-align'] = textAlign!.css;
    if (textAlignCustom != null) css['text-align'] = textAlignCustom!;
    if (textDecoration != null) css['text-decoration'] = textDecoration!.css;
    if (textTransform != null) css['text-transform'] = textTransform!.css;
    if (textTransformCustom != null) css['text-transform'] = textTransformCustom!;
    if (whiteSpace != null) css['white-space'] = whiteSpace!.css;
    if (wordBreak != null) css['word-break'] = wordBreak!.css;
    if (textOverflow != null) css['text-overflow'] = textOverflow!.css;
    if (fontFamily != null) css['font-family'] = fontFamily!.css;
    if (fontStyle != null) css['font-style'] = fontStyle!.css;

    if (shadow != null) css['box-shadow'] = shadow!.css;
    if (shadowCustom != null) css['box-shadow'] = shadowCustom!;
    if (transition != null) css['transition'] = transition!.css;
    if (transitionCustom != null) css['transition'] = transitionCustom!;
    if (opacity != null) css['opacity'] = opacity!.css;
    if (opacityCustom != null) css['opacity'] = '$opacityCustom';
    if (cursor != null) css['cursor'] = cursor!.css;
    if (cursorCustom != null) css['cursor'] = cursorCustom!;
    if (pointerEvents != null) css['pointer-events'] = pointerEvents!.css;
    if (userSelect != null) css['user-select'] = userSelect!.css;
    if (transform != null) css['transform'] = transform!.css;
    if (transformCustom != null) css['transform'] = transformCustom!;
    if (transformOrigin != null) css['transform-origin'] = transformOrigin!.css;
    if (transformOriginCustom != null) {
      css['transform-origin'] = transformOriginCustom!;
    }
    if (backdropFilter != null) {
      css['backdrop-filter'] = backdropFilter!.css;
      css['-webkit-backdrop-filter'] = backdropFilter!.css;
    }
    if (filterCustom != null) css['filter'] = filterCustom!;
    if (animation != null) css['animation'] = animation!.css;
    if (animationCustom != null) css['animation'] = animationCustom!;
    if (animationDelay != null) css['animation-delay'] = animationDelay!;
    if (textShadowCustom != null) css['text-shadow'] = textShadowCustom!;

    if (objectFit != null) css['object-fit'] = objectFit!.css;
    if (objectFitCustom != null) css['object-fit'] = objectFitCustom!;
    if (objectPosition != null) css['object-position'] = objectPosition!.css;

    if (borderCollapse != null) css['border-collapse'] = borderCollapse!;

    if (paddingTop != null) css['padding-top'] = paddingTop!;
    if (paddingRight != null) css['padding-right'] = paddingRight!;
    if (paddingBottom != null) css['padding-bottom'] = paddingBottom!;
    if (paddingLeft != null) css['padding-left'] = paddingLeft!;
    if (borderTopCustom != null) css['border-top'] = borderTopCustom!;
    if (borderRightCustom != null) css['border-right'] = borderRightCustom!;
    if (borderBottomCustom != null) css['border-bottom'] = borderBottomCustom!;
    if (borderLeftCustom != null) css['border-left'] = borderLeftCustom!;
    if (boxSizing != null) css['box-sizing'] = boxSizing!.css;
    if (backgroundClip != null) {
      css['background-clip'] = backgroundClip!;
      css['-webkit-background-clip'] = backgroundClip!;
    }
    if (backdropFilterCustom != null) {
      css['backdrop-filter'] = backdropFilterCustom!;
      css['-webkit-backdrop-filter'] = backdropFilterCustom!;
    }

    if (raw != null) css.addAll(raw!);

    return Styles(raw: css);
  }

  /// Convert to raw CSS map
  Map<String, String> toMap() {
    final Map<String, String> css = {};

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
    if (zIndexCustom != null) css['z-index'] = zIndexCustom!;
    if (overflow != null) css['overflow'] = overflow!.css;
    if (overflowX != null) css['overflow-x'] = overflowX!.css;
    if (overflowY != null) css['overflow-y'] = overflowY!.css;
    if (overflowCustom != null) css['overflow'] = overflowCustom!;
    if (displayCustom != null) css['display'] = displayCustom!;

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
    if (flex != null) css['flex'] = flex!.css;
    if (flexCustom != null) css['flex'] = flexCustom!;

    if (gridColumns != null) css['grid-template-columns'] = gridColumns!.css;
    if (gridColumnsCustom != null) {
      css['grid-template-columns'] = gridColumnsCustom!;
    }
    if (gridRows != null) css['grid-template-rows'] = gridRows!.css;
    if (gridRowsCustom != null) css['grid-template-rows'] = gridRowsCustom!;
    if (gridAutoFlow != null) css['grid-auto-flow'] = gridAutoFlow!.css;
    if (placeItems != null) css['place-items'] = placeItems!.css;
    if (placeContent != null) css['place-content'] = placeContent!.css;

    if (padding != null) css['padding'] = padding!.css;
    if (paddingCustom != null) css['padding'] = paddingCustom!.padding;
    if (paddingStringCustom != null) css['padding'] = paddingStringCustom!;
    if (margin != null) css['margin'] = margin!.css;
    if (marginCustom != null) css['margin'] = marginCustom!.margin;
    if (marginStringCustom != null) css['margin'] = marginStringCustom!;
    if (gap != null) css['gap'] = gap!.css;
    if (gapCustom != null) css['gap'] = gapCustom!;
    if (rowGap != null) css['row-gap'] = rowGap!.css;
    if (columnGap != null) css['column-gap'] = columnGap!.css;

    if (top != null) css['top'] = top!;
    if (right != null) css['right'] = right!;
    if (bottom != null) css['bottom'] = bottom!;
    if (left != null) css['left'] = left!;
    if (inset != null) css['inset'] = inset!;

    if (background != null) css['background-color'] = background!.css;
    if (backgroundCustom != null) css['background'] = backgroundCustom!;
    if (textColor != null) css['color'] = textColor!.css;
    if (textColorCustom != null) css['color'] = textColorCustom!;

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
    if (outlineCustom != null) css['outline'] = outlineCustom!;
    if (outlineOffset != null) css['outline-offset'] = outlineOffset!;
    if (borderWidth != null) css['border-width'] = borderWidth!.css;
    if (borderLeftWidth != null) css['border-left-width'] = borderLeftWidth!.css;
    if (borderRightWidth != null) {
      css['border-right-width'] = borderRightWidth!.css;
    }
    if (borderTopWidth != null) css['border-top-width'] = borderTopWidth!.css;
    if (borderBottomWidth != null) {
      css['border-bottom-width'] = borderBottomWidth!.css;
    }

    if (fontSize != null) css['font-size'] = fontSize!.css;
    if (fontSizeCustom != null) css['font-size'] = fontSizeCustom!;
    if (fontWeight != null) css['font-weight'] = fontWeight!.css;
    if (fontWeightCustom != null) css['font-weight'] = fontWeightCustom!;
    if (lineHeight != null) css['line-height'] = lineHeight!.css;
    if (letterSpacing != null) css['letter-spacing'] = letterSpacing!.css;
    if (letterSpacingCustom != null) css['letter-spacing'] = letterSpacingCustom!;
    if (textAlign != null) css['text-align'] = textAlign!.css;
    if (textAlignCustom != null) css['text-align'] = textAlignCustom!;
    if (textDecoration != null) css['text-decoration'] = textDecoration!.css;
    if (textTransform != null) css['text-transform'] = textTransform!.css;
    if (textTransformCustom != null) css['text-transform'] = textTransformCustom!;
    if (whiteSpace != null) css['white-space'] = whiteSpace!.css;
    if (wordBreak != null) css['word-break'] = wordBreak!.css;
    if (textOverflow != null) css['text-overflow'] = textOverflow!.css;
    if (fontFamily != null) css['font-family'] = fontFamily!.css;
    if (fontStyle != null) css['font-style'] = fontStyle!.css;

    if (shadow != null) css['box-shadow'] = shadow!.css;
    if (shadowCustom != null) css['box-shadow'] = shadowCustom!;
    if (transition != null) css['transition'] = transition!.css;
    if (transitionCustom != null) css['transition'] = transitionCustom!;
    if (opacity != null) css['opacity'] = opacity!.css;
    if (opacityCustom != null) css['opacity'] = '$opacityCustom';
    if (cursor != null) css['cursor'] = cursor!.css;
    if (cursorCustom != null) css['cursor'] = cursorCustom!;
    if (pointerEvents != null) css['pointer-events'] = pointerEvents!.css;
    if (userSelect != null) css['user-select'] = userSelect!.css;
    if (transform != null) css['transform'] = transform!.css;
    if (transformCustom != null) css['transform'] = transformCustom!;
    if (transformOrigin != null) css['transform-origin'] = transformOrigin!.css;
    if (transformOriginCustom != null) {
      css['transform-origin'] = transformOriginCustom!;
    }
    if (backdropFilter != null) {
      css['backdrop-filter'] = backdropFilter!.css;
      css['-webkit-backdrop-filter'] = backdropFilter!.css;
    }
    if (filterCustom != null) css['filter'] = filterCustom!;
    if (animation != null) css['animation'] = animation!.css;
    if (animationCustom != null) css['animation'] = animationCustom!;
    if (animationDelay != null) css['animation-delay'] = animationDelay!;
    if (textShadowCustom != null) css['text-shadow'] = textShadowCustom!;

    if (objectFit != null) css['object-fit'] = objectFit!.css;
    if (objectFitCustom != null) css['object-fit'] = objectFitCustom!;
    if (objectPosition != null) css['object-position'] = objectPosition!.css;

    if (borderCollapse != null) css['border-collapse'] = borderCollapse!;

    if (paddingTop != null) css['padding-top'] = paddingTop!;
    if (paddingRight != null) css['padding-right'] = paddingRight!;
    if (paddingBottom != null) css['padding-bottom'] = paddingBottom!;
    if (paddingLeft != null) css['padding-left'] = paddingLeft!;
    if (borderTopCustom != null) css['border-top'] = borderTopCustom!;
    if (borderRightCustom != null) css['border-right'] = borderRightCustom!;
    if (borderBottomCustom != null) css['border-bottom'] = borderBottomCustom!;
    if (borderLeftCustom != null) css['border-left'] = borderLeftCustom!;
    if (boxSizing != null) css['box-sizing'] = boxSizing!.css;
    if (backgroundClip != null) {
      css['background-clip'] = backgroundClip!;
      css['-webkit-background-clip'] = backgroundClip!;
    }
    if (backdropFilterCustom != null) {
      css['backdrop-filter'] = backdropFilterCustom!;
      css['-webkit-backdrop-filter'] = backdropFilterCustom!;
    }

    if (raw != null) css.addAll(raw!);

    return css;
  }

  /// Merge with another ArcaneStyleData (other takes precedence)
  ArcaneStyleData merge(ArcaneStyleData? other) {
    if (other == null) return this;
    return ArcaneStyleData(
      display: other.display ?? display,
      flexDirection: other.flexDirection ?? flexDirection,
      flexWrap: other.flexWrap ?? flexWrap,
      mainAxisAlignment: other.mainAxisAlignment ?? mainAxisAlignment,
      crossAxisAlignment: other.crossAxisAlignment ?? crossAxisAlignment,
      alignItems: other.alignItems ?? alignItems,
      justifyContent: other.justifyContent ?? justifyContent,
      alignSelf: other.alignSelf ?? alignSelf,
      position: other.position ?? position,
      visibility: other.visibility ?? visibility,
      zIndex: other.zIndex ?? zIndex,
      zIndexCustom: other.zIndexCustom ?? zIndexCustom,
      overflow: other.overflow ?? overflow,
      overflowX: other.overflowX ?? overflowX,
      overflowY: other.overflowY ?? overflowY,
      overflowCustom: other.overflowCustom ?? overflowCustom,
      displayCustom: other.displayCustom ?? displayCustom,
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
      flex: other.flex ?? flex,
      flexCustom: other.flexCustom ?? flexCustom,
      gridColumns: other.gridColumns ?? gridColumns,
      gridColumnsCustom: other.gridColumnsCustom ?? gridColumnsCustom,
      gridRows: other.gridRows ?? gridRows,
      gridRowsCustom: other.gridRowsCustom ?? gridRowsCustom,
      gridAutoFlow: other.gridAutoFlow ?? gridAutoFlow,
      placeItems: other.placeItems ?? placeItems,
      placeContent: other.placeContent ?? placeContent,
      padding: other.padding ?? padding,
      paddingCustom: other.paddingCustom ?? paddingCustom,
      margin: other.margin ?? margin,
      marginCustom: other.marginCustom ?? marginCustom,
      marginStringCustom: other.marginStringCustom ?? marginStringCustom,
      paddingStringCustom: other.paddingStringCustom ?? paddingStringCustom,
      gap: other.gap ?? gap,
      gapCustom: other.gapCustom ?? gapCustom,
      rowGap: other.rowGap ?? rowGap,
      columnGap: other.columnGap ?? columnGap,
      top: other.top ?? top,
      right: other.right ?? right,
      bottom: other.bottom ?? bottom,
      left: other.left ?? left,
      inset: other.inset ?? inset,
      background: other.background ?? background,
      backgroundCustom: other.backgroundCustom ?? backgroundCustom,
      textColor: other.textColor ?? textColor,
      textColorCustom: other.textColorCustom ?? textColorCustom,
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
      outlineCustom: other.outlineCustom ?? outlineCustom,
      outlineOffset: other.outlineOffset ?? outlineOffset,
      borderWidth: other.borderWidth ?? borderWidth,
      borderLeftWidth: other.borderLeftWidth ?? borderLeftWidth,
      borderRightWidth: other.borderRightWidth ?? borderRightWidth,
      borderTopWidth: other.borderTopWidth ?? borderTopWidth,
      borderBottomWidth: other.borderBottomWidth ?? borderBottomWidth,
      fontSize: other.fontSize ?? fontSize,
      fontSizeCustom: other.fontSizeCustom ?? fontSizeCustom,
      fontWeight: other.fontWeight ?? fontWeight,
      fontWeightCustom: other.fontWeightCustom ?? fontWeightCustom,
      lineHeight: other.lineHeight ?? lineHeight,
      letterSpacing: other.letterSpacing ?? letterSpacing,
      letterSpacingCustom: other.letterSpacingCustom ?? letterSpacingCustom,
      textAlign: other.textAlign ?? textAlign,
      textAlignCustom: other.textAlignCustom ?? textAlignCustom,
      textDecoration: other.textDecoration ?? textDecoration,
      textTransform: other.textTransform ?? textTransform,
      textTransformCustom: other.textTransformCustom ?? textTransformCustom,
      whiteSpace: other.whiteSpace ?? whiteSpace,
      wordBreak: other.wordBreak ?? wordBreak,
      textOverflow: other.textOverflow ?? textOverflow,
      fontFamily: other.fontFamily ?? fontFamily,
      fontStyle: other.fontStyle ?? fontStyle,
      shadow: other.shadow ?? shadow,
      shadowCustom: other.shadowCustom ?? shadowCustom,
      transition: other.transition ?? transition,
      transitionCustom: other.transitionCustom ?? transitionCustom,
      opacity: other.opacity ?? opacity,
      opacityCustom: other.opacityCustom ?? opacityCustom,
      cursor: other.cursor ?? cursor,
      cursorCustom: other.cursorCustom ?? cursorCustom,
      pointerEvents: other.pointerEvents ?? pointerEvents,
      userSelect: other.userSelect ?? userSelect,
      transform: other.transform ?? transform,
      transformCustom: other.transformCustom ?? transformCustom,
      transformOrigin: other.transformOrigin ?? transformOrigin,
      transformOriginCustom: other.transformOriginCustom ?? transformOriginCustom,
      backdropFilter: other.backdropFilter ?? backdropFilter,
      filterCustom: other.filterCustom ?? filterCustom,
      easing: other.easing ?? easing,
      animation: other.animation ?? animation,
      animationCustom: other.animationCustom ?? animationCustom,
      animationDelay: other.animationDelay ?? animationDelay,
      textShadowCustom: other.textShadowCustom ?? textShadowCustom,
      objectFit: other.objectFit ?? objectFit,
      objectFitCustom: other.objectFitCustom ?? objectFitCustom,
      objectPosition: other.objectPosition ?? objectPosition,
      borderCollapse: other.borderCollapse ?? borderCollapse,
      paddingTop: other.paddingTop ?? paddingTop,
      paddingRight: other.paddingRight ?? paddingRight,
      paddingBottom: other.paddingBottom ?? paddingBottom,
      paddingLeft: other.paddingLeft ?? paddingLeft,
      borderTopCustom: other.borderTopCustom ?? borderTopCustom,
      borderRightCustom: other.borderRightCustom ?? borderRightCustom,
      borderBottomCustom: other.borderBottomCustom ?? borderBottomCustom,
      borderLeftCustom: other.borderLeftCustom ?? borderLeftCustom,
      boxSizing: other.boxSizing ?? boxSizing,
      backgroundClip: other.backgroundClip ?? backgroundClip,
      backdropFilterCustom: other.backdropFilterCustom ?? backdropFilterCustom,
      raw: {...?raw, ...?other.raw},
    );
  }

  /// Create a copy with some properties changed
  ArcaneStyleData copyWith({
    Display? display,
    FlexDirection? flexDirection,
    FlexWrap? flexWrap,
    MainAxisAlignment? mainAxisAlignment,
    CrossAxisAlignment? crossAxisAlignment,
    CrossAxisAlignment? alignSelf,
    AlignItems? alignItems,
    JustifyContent? justifyContent,
    Position? position,
    Visibility? visibility,
    ZIndex? zIndex,
    String? zIndexCustom,
    Overflow? overflow,
    OverflowAxis? overflowX,
    OverflowAxis? overflowY,
    String? overflowCustom,
    String? displayCustom,
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
    FlexPreset? flex,
    String? flexCustom,
    GridColumns? gridColumns,
    String? gridColumnsCustom,
    GridRows? gridRows,
    String? gridRowsCustom,
    GridAutoFlow? gridAutoFlow,
    PlaceItems? placeItems,
    PlaceContent? placeContent,
    PaddingPreset? padding,
    EdgeInsets? paddingCustom,
    MarginPreset? margin,
    EdgeInsets? marginCustom,
    String? marginStringCustom,
    String? paddingStringCustom,
    Gap? gap,
    String? gapCustom,
    Gap? rowGap,
    Gap? columnGap,
    String? top,
    String? right,
    String? bottom,
    String? left,
    String? inset,
    Background? background,
    String? backgroundCustom,
    TextColor? textColor,
    String? textColorCustom,
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
    String? outlineCustom,
    String? outlineOffset,
    BorderWidth? borderWidth,
    BorderWidth? borderLeftWidth,
    BorderWidth? borderRightWidth,
    BorderWidth? borderTopWidth,
    BorderWidth? borderBottomWidth,
    FontSize? fontSize,
    String? fontSizeCustom,
    FontWeight? fontWeight,
    String? fontWeightCustom,
    LineHeight? lineHeight,
    LetterSpacing? letterSpacing,
    String? letterSpacingCustom,
    TextAlign? textAlign,
    String? textAlignCustom,
    TextDecoration? textDecoration,
    TextTransform? textTransform,
    String? textTransformCustom,
    WhiteSpace? whiteSpace,
    WordBreak? wordBreak,
    TextOverflow? textOverflow,
    FontFamily? fontFamily,
    FontStyle? fontStyle,
    Shadow? shadow,
    String? shadowCustom,
    Transition? transition,
    String? transitionCustom,
    Opacity? opacity,
    double? opacityCustom,
    Cursor? cursor,
    String? cursorCustom,
    PointerEvents? pointerEvents,
    UserSelect? userSelect,
    Transform? transform,
    String? transformCustom,
    TransformOrigin? transformOrigin,
    String? transformOriginCustom,
    BackdropFilter? backdropFilter,
    String? filterCustom,
    Easing? easing,
    AnimationPreset? animation,
    String? animationCustom,
    String? animationDelay,
    String? textShadowCustom,
    ObjectFit? objectFit,
    String? objectFitCustom,
    ObjectPosition? objectPosition,
    String? borderCollapse,
    String? paddingTop,
    String? paddingRight,
    String? paddingBottom,
    String? paddingLeft,
    String? borderTopCustom,
    String? borderRightCustom,
    String? borderBottomCustom,
    String? borderLeftCustom,
    BoxSizing? boxSizing,
    String? backgroundClip,
    String? backdropFilterCustom,
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
      zIndexCustom: zIndexCustom ?? this.zIndexCustom,
      overflow: overflow ?? this.overflow,
      overflowX: overflowX ?? this.overflowX,
      overflowY: overflowY ?? this.overflowY,
      overflowCustom: overflowCustom ?? this.overflowCustom,
      displayCustom: displayCustom ?? this.displayCustom,
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
      flex: flex ?? this.flex,
      flexCustom: flexCustom ?? this.flexCustom,
      gridColumns: gridColumns ?? this.gridColumns,
      gridColumnsCustom: gridColumnsCustom ?? this.gridColumnsCustom,
      gridRows: gridRows ?? this.gridRows,
      gridRowsCustom: gridRowsCustom ?? this.gridRowsCustom,
      gridAutoFlow: gridAutoFlow ?? this.gridAutoFlow,
      placeItems: placeItems ?? this.placeItems,
      placeContent: placeContent ?? this.placeContent,
      padding: padding ?? this.padding,
      paddingCustom: paddingCustom ?? this.paddingCustom,
      margin: margin ?? this.margin,
      marginCustom: marginCustom ?? this.marginCustom,
      marginStringCustom: marginStringCustom ?? this.marginStringCustom,
      paddingStringCustom: paddingStringCustom ?? this.paddingStringCustom,
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
      outlineCustom: outlineCustom ?? this.outlineCustom,
      outlineOffset: outlineOffset ?? this.outlineOffset,
      borderWidth: borderWidth ?? this.borderWidth,
      borderLeftWidth: borderLeftWidth ?? this.borderLeftWidth,
      borderRightWidth: borderRightWidth ?? this.borderRightWidth,
      borderTopWidth: borderTopWidth ?? this.borderTopWidth,
      borderBottomWidth: borderBottomWidth ?? this.borderBottomWidth,
      fontSize: fontSize ?? this.fontSize,
      fontSizeCustom: fontSizeCustom ?? this.fontSizeCustom,
      fontWeight: fontWeight ?? this.fontWeight,
      fontWeightCustom: fontWeightCustom ?? this.fontWeightCustom,
      lineHeight: lineHeight ?? this.lineHeight,
      letterSpacing: letterSpacing ?? this.letterSpacing,
      letterSpacingCustom: letterSpacingCustom ?? this.letterSpacingCustom,
      textAlign: textAlign ?? this.textAlign,
      textAlignCustom: textAlignCustom ?? this.textAlignCustom,
      textDecoration: textDecoration ?? this.textDecoration,
      textTransform: textTransform ?? this.textTransform,
      textTransformCustom: textTransformCustom ?? this.textTransformCustom,
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
      cursorCustom: cursorCustom ?? this.cursorCustom,
      pointerEvents: pointerEvents ?? this.pointerEvents,
      userSelect: userSelect ?? this.userSelect,
      transform: transform ?? this.transform,
      transformCustom: transformCustom ?? this.transformCustom,
      transformOrigin: transformOrigin ?? this.transformOrigin,
      transformOriginCustom: transformOriginCustom ?? this.transformOriginCustom,
      backdropFilter: backdropFilter ?? this.backdropFilter,
      filterCustom: filterCustom ?? this.filterCustom,
      easing: easing ?? this.easing,
      animation: animation ?? this.animation,
      animationCustom: animationCustom ?? this.animationCustom,
      animationDelay: animationDelay ?? this.animationDelay,
      textShadowCustom: textShadowCustom ?? this.textShadowCustom,
      objectFit: objectFit ?? this.objectFit,
      objectFitCustom: objectFitCustom ?? this.objectFitCustom,
      objectPosition: objectPosition ?? this.objectPosition,
      borderCollapse: borderCollapse ?? this.borderCollapse,
      paddingTop: paddingTop ?? this.paddingTop,
      paddingRight: paddingRight ?? this.paddingRight,
      paddingBottom: paddingBottom ?? this.paddingBottom,
      paddingLeft: paddingLeft ?? this.paddingLeft,
      borderTopCustom: borderTopCustom ?? this.borderTopCustom,
      borderRightCustom: borderRightCustom ?? this.borderRightCustom,
      borderBottomCustom: borderBottomCustom ?? this.borderBottomCustom,
      borderLeftCustom: borderLeftCustom ?? this.borderLeftCustom,
      boxSizing: boxSizing ?? this.boxSizing,
      backgroundClip: backgroundClip ?? this.backgroundClip,
      backdropFilterCustom: backdropFilterCustom ?? this.backdropFilterCustom,
      raw: raw ?? this.raw,
    );
  }

  static const row = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.row,
    crossAxisAlignment: CrossAxisAlignment.center,
  );

  static const rowSpaced = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.row,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
  );

  static const column = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
  );

  static const flexCenter = ArcaneStyleData(
    display: Display.flex,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
  );

  static const fullSize = ArcaneStyleData(
    width: Size.full,
    height: Size.full,
  );

  static const absoluteFill = ArcaneStyleData(
    position: Position.absolute,
    inset: '0',
  );

  static const centered = flexCenter;

  static const gridCenter = ArcaneStyleData(
    display: Display.grid,
    placeItems: PlaceItems.center,
  );

  static const padded = ArcaneStyleData(
    padding: PaddingPreset.md,
  );

  static const paddedLg = ArcaneStyleData(
    padding: PaddingPreset.lg,
  );

  static const paddedSm = ArcaneStyleData(
    padding: PaddingPreset.sm,
  );

  static const paddedXs = ArcaneStyleData(
    padding: PaddingPreset.xs,
  );

  static const paddedXl = ArcaneStyleData(
    padding: PaddingPreset.xl,
  );

  static const spaced = ArcaneStyleData(
    gap: Gap.md,
  );

  static const spacedLg = ArcaneStyleData(
    gap: Gap.lg,
  );

  static const spacedSm = ArcaneStyleData(
    gap: Gap.sm,
  );

  static const spacedXs = ArcaneStyleData(
    gap: Gap.xs,
  );

  static const spacedXl = ArcaneStyleData(
    gap: Gap.xl,
  );

  static const fullWidth = ArcaneStyleData(
    width: Size.full,
  );

  static const fullHeight = ArcaneStyleData(
    height: Size.full,
  );

  static const scrollable = ArcaneStyleData(
    overflow: Overflow.auto,
  );

  static const scrollableY = ArcaneStyleData(
    overflowY: OverflowAxis.auto,
    overflowX: OverflowAxis.hidden,
  );

  static const scrollableX = ArcaneStyleData(
    overflowX: OverflowAxis.auto,
    overflowY: OverflowAxis.hidden,
  );

  static const clipContent = ArcaneStyleData(
    overflow: Overflow.hidden,
  );

  static const grow = ArcaneStyleData(
    flex: FlexPreset.expand,
  );

  static const noGrow = ArcaneStyleData(
    flex: FlexPreset.none,
  );

  static const columnSpaced = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.md,
  );

  static const columnTight = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.sm,
  );

  static const columnLoose = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    gap: Gap.lg,
  );

  static const rowTight = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.row,
    crossAxisAlignment: CrossAxisAlignment.center,
    gap: Gap.sm,
  );

  static const rowGapped = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.row,
    crossAxisAlignment: CrossAxisAlignment.center,
    gap: Gap.md,
  );

  static const rowLoose = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.row,
    crossAxisAlignment: CrossAxisAlignment.center,
    gap: Gap.lg,
  );

  static const truncate = ArcaneStyleData(
    textOverflow: TextOverflow.ellipsis,
    whiteSpace: WhiteSpace.nowrap,
    overflow: Overflow.hidden,
  );

  static const textCenter = ArcaneStyleData(
    textAlign: TextAlign.center,
  );

  static const textRight = ArcaneStyleData(
    textAlign: TextAlign.right,
  );

  static const textLeft = ArcaneStyleData(
    textAlign: TextAlign.left,
  );

  static const stack = ArcaneStyleData(
    position: Position.relative,
  );

  static const stackChild = ArcaneStyleData(
    position: Position.absolute,
  );

  static const fixed = ArcaneStyleData(
    position: Position.fixed,
  );

  static const sticky = ArcaneStyleData(
    position: Position.sticky,
  );

  static const clickable = ArcaneStyleData(
    cursor: Cursor.pointer,
  );

  static const nonInteractive = ArcaneStyleData(
    pointerEvents: PointerEvents.none,
  );

  static const unselectable = ArcaneStyleData(
    userSelect: UserSelect.none,
  );
}
