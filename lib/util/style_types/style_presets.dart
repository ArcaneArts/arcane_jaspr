import 'arcane_style_data.dart';
import 'spacing.dart';
import 'colors.dart';
import 'borders.dart';
import 'layout.dart';
import 'typography.dart';
import 'effects.dart';
import '../arcane.dart';

/// Common layout style presets
class LayoutPresets {
  LayoutPresets._();

  /// Flex row with center alignment
  static const ArcaneStyleData flexRow = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.row,
    crossAxisAlignment: CrossAxisAlignment.center,
  );

  /// Flex row with space-between
  static const ArcaneStyleData flexRowSpaced = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.row,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
  );

  /// Flex row with end alignment
  static const ArcaneStyleData flexRowEnd = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.row,
    crossAxisAlignment: CrossAxisAlignment.center,
    mainAxisAlignment: MainAxisAlignment.end,
  );

  /// Flex column
  static const ArcaneStyleData flexColumn = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
  );

  /// Flex column with center alignment
  static const ArcaneStyleData flexColumnCenter = ArcaneStyleData(
    display: Display.flex,
    flexDirection: FlexDirection.column,
    crossAxisAlignment: CrossAxisAlignment.center,
  );

  /// Center content on both axes
  static const ArcaneStyleData flexCenter = ArcaneStyleData(
    display: Display.flex,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
  );

  /// Wrap flex items
  static const ArcaneStyleData flexWrap = ArcaneStyleData(
    display: Display.flex,
    flexWrap: FlexWrap.wrap,
  );

  /// Container with max width and centered
  static const ArcaneStyleData container = ArcaneStyleData(
    maxWidth: MaxWidth.container,
    margin: MarginPreset.autoX,
    padding: PaddingPreset.horizontalMd,
  );

  /// Full-width container
  static const ArcaneStyleData containerFull = ArcaneStyleData(
    maxWidth: MaxWidth.full,
    margin: MarginPreset.autoX,
    padding: PaddingPreset.horizontalLg,
  );

  /// Narrow container (for forms, text)
  static const ArcaneStyleData containerNarrow = ArcaneStyleData(
    maxWidth: MaxWidth.narrow,
    margin: MarginPreset.autoX,
    padding: PaddingPreset.horizontalMd,
  );

  /// Full width and height
  static const ArcaneStyleData fullSize = ArcaneStyleData(
    width: Size.full,
    height: Size.full,
  );

  /// Full screen
  static const ArcaneStyleData fullScreen = ArcaneStyleData(
    width: Size.screen,
    height: Size.screen,
  );

  /// Absolute fill (inset: 0)
  static const ArcaneStyleData absoluteFill = ArcaneStyleData(
    position: Position.absolute,
    inset: '0',
  );

  /// Fixed fill (inset: 0)
  static const ArcaneStyleData fixedFill = ArcaneStyleData(
    position: Position.fixed,
    inset: '0',
  );

  /// Sticky top
  static const ArcaneStyleData stickyTop = ArcaneStyleData(
    position: Position.sticky,
    top: '0',
    zIndex: ZIndex.sticky,
  );

  /// Fixed top
  static const ArcaneStyleData fixedTop = ArcaneStyleData(
    position: Position.fixed,
    top: '0',
    left: '0',
    right: '0',
    zIndex: ZIndex.fixed,
  );

  /// Fixed bottom
  static const ArcaneStyleData fixedBottom = ArcaneStyleData(
    position: Position.fixed,
    bottom: '0',
    left: '0',
    right: '0',
    zIndex: ZIndex.fixed,
  );
}

/// Common text style presets
class TextPresets {
  TextPresets._();

  /// Page heading (mega size)
  static const ArcaneStyleData pageTitle = ArcaneStyleData(
    fontSize: FontSize.mega,
    fontWeight: FontWeight.bold,
    lineHeight: LineHeight.tight,
    textColor: TextColor.primary,
    letterSpacing: LetterSpacing.tight,
  );

  /// Section heading (hero size)
  static const ArcaneStyleData sectionTitle = ArcaneStyleData(
    fontSize: FontSize.hero,
    fontWeight: FontWeight.bold,
    lineHeight: LineHeight.tight,
    textColor: TextColor.primary,
  );

  /// Large heading (xl3)
  static const ArcaneStyleData heading1 = ArcaneStyleData(
    fontSize: FontSize.xl3,
    fontWeight: FontWeight.bold,
    lineHeight: LineHeight.tight,
    textColor: TextColor.primary,
  );

  /// Medium heading (xl2)
  static const ArcaneStyleData heading2 = ArcaneStyleData(
    fontSize: FontSize.xl2,
    fontWeight: FontWeight.w600,
    lineHeight: LineHeight.snug,
    textColor: TextColor.primary,
  );

  /// Small heading (xl)
  static const ArcaneStyleData heading3 = ArcaneStyleData(
    fontSize: FontSize.xl,
    fontWeight: FontWeight.w600,
    lineHeight: LineHeight.snug,
    textColor: TextColor.primary,
  );

  /// Subheading
  static const ArcaneStyleData subheading = ArcaneStyleData(
    fontSize: FontSize.lg,
    fontWeight: FontWeight.w500,
    lineHeight: LineHeight.normal,
    textColor: TextColor.secondary,
  );

  /// Body text (default)
  static const ArcaneStyleData body = ArcaneStyleData(
    fontSize: FontSize.base,
    lineHeight: LineHeight.relaxed,
    textColor: TextColor.muted,
  );

  /// Body large
  static const ArcaneStyleData bodyLarge = ArcaneStyleData(
    fontSize: FontSize.lg,
    lineHeight: LineHeight.relaxed,
    textColor: TextColor.muted,
  );

  /// Body small
  static const ArcaneStyleData bodySmall = ArcaneStyleData(
    fontSize: FontSize.sm,
    lineHeight: LineHeight.normal,
    textColor: TextColor.muted,
  );

  /// Label text
  static const ArcaneStyleData label = ArcaneStyleData(
    fontSize: FontSize.sm,
    fontWeight: FontWeight.w500,
    textColor: TextColor.primary,
  );

  /// Caption/helper text
  static const ArcaneStyleData caption = ArcaneStyleData(
    fontSize: FontSize.xs,
    textColor: TextColor.subtle,
  );

  /// Code/monospace text
  static const ArcaneStyleData code = ArcaneStyleData(
    fontFamily: FontFamily.mono,
    fontSize: FontSize.sm,
    textColor: TextColor.accent,
  );

  /// Link text
  static const ArcaneStyleData link = ArcaneStyleData(
    textColor: TextColor.accent,
    textDecoration: TextDecoration.none,
    cursor: Cursor.pointer,
    transition: Transition.colors,
  );

  /// Truncated text (single line with ellipsis)
  static const ArcaneStyleData truncate = ArcaneStyleData(
    whiteSpace: WhiteSpace.nowrap,
    textOverflow: TextOverflow.ellipsis,
    overflow: Overflow.hidden,
  );
}

/// Common card/surface style presets
class CardPresets {
  CardPresets._();

  /// Standard card
  static const ArcaneStyleData standard = ArcaneStyleData(
    background: Background.card,
    border: BorderPreset.subtle,
    borderRadius: Radius.lg,
    padding: PaddingPreset.lg,
  );

  /// Elevated card (with shadow)
  static const ArcaneStyleData elevated = ArcaneStyleData(
    background: Background.card,
    border: BorderPreset.subtle,
    borderRadius: Radius.lg,
    padding: PaddingPreset.lg,
    shadow: Shadow.md,
  );

  /// Flat card (no border)
  static const ArcaneStyleData flat = ArcaneStyleData(
    background: Background.card,
    borderRadius: Radius.lg,
    padding: PaddingPreset.lg,
  );

  /// Outlined card (transparent background)
  static const ArcaneStyleData outlined = ArcaneStyleData(
    background: Background.transparent,
    border: BorderPreset.standard,
    borderRadius: Radius.lg,
    padding: PaddingPreset.lg,
  );

  /// Glass card (blur effect)
  static const ArcaneStyleData glass = ArcaneStyleData(
    background: Background.surfaceVariant,
    border: BorderPreset.subtle,
    borderRadius: Radius.lg,
    padding: PaddingPreset.lg,
    backdropFilter: BackdropFilter.blur,
  );

  /// Interactive card (with hover transition)
  static const ArcaneStyleData interactive = ArcaneStyleData(
    background: Background.card,
    border: BorderPreset.subtle,
    borderRadius: Radius.lg,
    padding: PaddingPreset.lg,
    cursor: Cursor.pointer,
    transition: Transition.allNormal,
  );
}

/// Common button style presets
class ButtonPresets {
  ButtonPresets._();

  /// Base button styles (applied to all buttons)
  static const ArcaneStyleData base = ArcaneStyleData(
    display: Display.inlineFlex,
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    borderRadius: Radius.md,
    fontWeight: FontWeight.w500,
    cursor: Cursor.pointer,
    transition: Transition.allNormal,
    userSelect: UserSelect.none,
  );

  /// Primary button
  static const ArcaneStyleData primary = ArcaneStyleData(
    background: Background.accent,
    textColor: TextColor.accentForeground,
    border: BorderPreset.none,
  );

  /// Secondary button
  static const ArcaneStyleData secondary = ArcaneStyleData(
    background: Background.surface,
    textColor: TextColor.primary,
    border: BorderPreset.standard,
  );

  /// Outline button
  static const ArcaneStyleData outline = ArcaneStyleData(
    background: Background.transparent,
    textColor: TextColor.primary,
    border: BorderPreset.standard,
  );

  /// Ghost button
  static const ArcaneStyleData ghost = ArcaneStyleData(
    background: Background.transparent,
    textColor: TextColor.muted,
    border: BorderPreset.none,
  );

  /// Destructive button
  static const ArcaneStyleData destructive = ArcaneStyleData(
    background: Background.error,
    textColor: TextColor.errorForeground,
    border: BorderPreset.none,
  );

  /// Success button
  static const ArcaneStyleData success = ArcaneStyleData(
    background: Background.success,
    textColor: TextColor.successForeground,
    border: BorderPreset.none,
  );

  /// Disabled state
  static const ArcaneStyleData disabled = ArcaneStyleData(
    opacity: Opacity.disabled,
    cursor: Cursor.notAllowed,
    pointerEvents: PointerEvents.none,
  );

  /// Button size: small
  static const ArcaneStyleData sizeSmall = ArcaneStyleData(
    padding: PaddingPreset.buttonSm,
    fontSize: FontSize.sm,
  );

  /// Button size: medium (default)
  static const ArcaneStyleData sizeMedium = ArcaneStyleData(
    padding: PaddingPreset.buttonMd,
    fontSize: FontSize.sm,
  );

  /// Button size: large
  static const ArcaneStyleData sizeLarge = ArcaneStyleData(
    padding: PaddingPreset.buttonLg,
    fontSize: FontSize.base,
  );

  /// Full width button
  static const ArcaneStyleData fullWidth = ArcaneStyleData(
    width: Size.full,
  );
}

/// Common input style presets
class InputPresets {
  InputPresets._();

  /// Base input styles
  static const ArcaneStyleData base = ArcaneStyleData(
    display: Display.flex,
    width: Size.full,
    background: Background.input,
    textColor: TextColor.primary,
    border: BorderPreset.subtle,
    borderRadius: Radius.md,
    fontSize: FontSize.sm,
    transition: Transition.allNormal,
  );

  /// Input size: small
  static const ArcaneStyleData sizeSmall = ArcaneStyleData(
    padding: PaddingPreset.xsSm,
    fontSize: FontSize.xs,
  );

  /// Input size: medium (default)
  static const ArcaneStyleData sizeMedium = ArcaneStyleData(
    padding: PaddingPreset.smMd,
    fontSize: FontSize.sm,
  );

  /// Input size: large
  static const ArcaneStyleData sizeLarge = ArcaneStyleData(
    padding: PaddingPreset.mdLg,
    fontSize: FontSize.base,
  );

  /// Disabled input
  static const ArcaneStyleData disabled = ArcaneStyleData(
    opacity: Opacity.disabled,
    cursor: Cursor.notAllowed,
    background: Background.surfaceVariant,
  );

  /// Error state
  static const ArcaneStyleData error = ArcaneStyleData(
    border: BorderPreset.error,
    textColor: TextColor.error,
  );
}

/// Common badge style presets
class BadgePresets {
  BadgePresets._();

  /// Base badge styles
  static const ArcaneStyleData base = ArcaneStyleData(
    display: Display.inlineFlex,
    crossAxisAlignment: CrossAxisAlignment.center,
    padding: PaddingPreset.xsSm,
    borderRadius: Radius.full,
    fontSize: FontSize.xs,
    fontWeight: FontWeight.w500,
  );

  /// Primary badge
  static const ArcaneStyleData primary = ArcaneStyleData(
    background: Background.accent,
    textColor: TextColor.accentForeground,
  );

  /// Secondary badge
  static const ArcaneStyleData secondary = ArcaneStyleData(
    background: Background.surface,
    textColor: TextColor.muted,
  );

  /// Success badge
  static const ArcaneStyleData success = ArcaneStyleData(
    background: Background.successContainer,
    textColor: TextColor.success,
  );

  /// Warning badge
  static const ArcaneStyleData warning = ArcaneStyleData(
    background: Background.warning,
    textColor: TextColor.warningForeground,
  );

  /// Error badge
  static const ArcaneStyleData error = ArcaneStyleData(
    background: Background.error,
    textColor: TextColor.errorForeground,
  );

  /// Info badge
  static const ArcaneStyleData info = ArcaneStyleData(
    background: Background.info,
    textColor: TextColor.infoForeground,
  );

  /// Outline badge
  static const ArcaneStyleData outline = ArcaneStyleData(
    background: Background.transparent,
    border: BorderPreset.standard,
    textColor: TextColor.muted,
  );
}

/// Common section/page style presets
class SectionPresets {
  SectionPresets._();

  /// Standard page section
  static const ArcaneStyleData standard = ArcaneStyleData(
    padding: PaddingPreset.sectionY,
  );

  /// Hero section (larger padding)
  static const ArcaneStyleData hero = ArcaneStyleData(
    padding: PaddingPreset.heroY,
  );

  /// Dark section background
  static const ArcaneStyleData dark = ArcaneStyleData(
    background: Background.background,
    padding: PaddingPreset.sectionY,
  );

  /// Alternate section background
  static const ArcaneStyleData alternate = ArcaneStyleData(
    background: Background.backgroundSecondary,
    padding: PaddingPreset.sectionY,
  );

  /// Card section (with card styling)
  static const ArcaneStyleData card = ArcaneStyleData(
    background: Background.card,
    border: BorderPreset.subtle,
    borderRadius: Radius.xl,
    padding: PaddingPreset.section,
  );
}

/// Overlay/modal presets
class OverlayPresets {
  OverlayPresets._();

  /// Modal backdrop
  static const ArcaneStyleData backdrop = ArcaneStyleData(
    position: Position.fixed,
    inset: '0',
    background: Background.overlay,
    backdropFilter: BackdropFilter.blur,
    zIndex: ZIndex.modalBackdrop,
  );

  /// Modal content
  static const ArcaneStyleData modal = ArcaneStyleData(
    position: Position.fixed,
    zIndex: ZIndex.modal,
    background: Background.card,
    border: BorderPreset.subtle,
    borderRadius: Radius.xl,
    shadow: Shadow.xl,
    padding: PaddingPreset.lg,
  );

  /// Dropdown menu
  static const ArcaneStyleData dropdown = ArcaneStyleData(
    position: Position.absolute,
    zIndex: ZIndex.dropdown,
    background: Background.card,
    border: BorderPreset.subtle,
    borderRadius: Radius.md,
    shadow: Shadow.lg,
    padding: PaddingPreset.xs,
    overflow: Overflow.hidden,
  );

  /// Tooltip
  static const ArcaneStyleData tooltip = ArcaneStyleData(
    position: Position.absolute,
    zIndex: ZIndex.tooltip,
    background: Background.tooltip,
    textColor: TextColor.tooltipForeground,
    borderRadius: Radius.sm,
    padding: PaddingPreset.xsSm,
    fontSize: FontSize.xs,
  );

  /// Toast notification
  static const ArcaneStyleData toast = ArcaneStyleData(
    position: Position.fixed,
    zIndex: ZIndex.toast,
    background: Background.card,
    border: BorderPreset.subtle,
    borderRadius: Radius.lg,
    shadow: Shadow.lg,
    padding: PaddingPreset.mdLg,
  );
}
