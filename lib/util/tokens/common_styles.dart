/// Composable, spreadable style maps for common patterns
/// Use with spread operator: Styles(raw: {...ArcaneCommonStyles.flexRow, 'gap': '16px'})
///
/// Follows QualityNode's CommonStyles pattern for Flutter-like composition.

import 'tokens.dart';

/// Common reusable style patterns
class ArcaneCommonStyles {
  ArcaneCommonStyles._();

  // ===========================================================================
  // FLEXBOX LAYOUTS
  // ===========================================================================

  /// Flexbox row with center alignment
  static Map<String, String> get flexRow => {
        'display': 'flex',
        'align-items': 'center',
      };

  /// Flexbox row with space-between
  static Map<String, String> get flexRowSpaced => {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'space-between',
      };

  /// Flexbox row with start alignment
  static Map<String, String> get flexRowStart => {
        'display': 'flex',
        'align-items': 'flex-start',
      };

  /// Flexbox row with end alignment
  static Map<String, String> get flexRowEnd => {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'flex-end',
      };

  /// Flexbox column
  static Map<String, String> get flexCol => {
        'display': 'flex',
        'flex-direction': 'column',
      };

  /// Flexbox column with center alignment
  static Map<String, String> get flexColCenter => {
        'display': 'flex',
        'flex-direction': 'column',
        'align-items': 'center',
      };

  /// Center content both horizontally and vertically
  static Map<String, String> get flexCenter => {
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
      };

  /// Inline flex row
  static Map<String, String> get inlineFlex => {
        'display': 'inline-flex',
        'align-items': 'center',
      };

  /// Flex with wrap
  static Map<String, String> get flexWrap => {
        'display': 'flex',
        'flex-wrap': 'wrap',
      };

  // ===========================================================================
  // FLEXBOX WITH GAP
  // ===========================================================================

  /// Flex row with custom gap
  static Map<String, String> flexRowGap(String gap) => {
        ...flexRow,
        'gap': gap,
      };

  /// Flex column with custom gap
  static Map<String, String> flexColGap(String gap) => {
        ...flexCol,
        'gap': gap,
      };

  // ===========================================================================
  // GRID LAYOUTS
  // ===========================================================================

  /// Fixed column grid
  static Map<String, String> grid(int cols, {String gap = ArcaneSpacing.md}) => {
        'display': 'grid',
        'grid-template-columns': 'repeat($cols, 1fr)',
        'gap': gap,
      };

  /// Auto-fit responsive grid
  static Map<String, String> gridAuto({
    String minWidth = '300px',
    String gap = ArcaneSpacing.md,
  }) =>
      {
        'display': 'grid',
        'grid-template-columns': 'repeat(auto-fit, minmax($minWidth, 1fr))',
        'gap': gap,
      };

  /// Auto-fill responsive grid
  static Map<String, String> gridAutoFill({
    String minWidth = '300px',
    String gap = ArcaneSpacing.md,
  }) =>
      {
        'display': 'grid',
        'grid-template-columns': 'repeat(auto-fill, minmax($minWidth, 1fr))',
        'gap': gap,
      };

  /// Two column grid
  static Map<String, String> get grid2 => grid(2);

  /// Three column grid
  static Map<String, String> get grid3 => grid(3);

  /// Four column grid
  static Map<String, String> get grid4 => grid(4);

  // ===========================================================================
  // CARD STYLES
  // ===========================================================================

  /// Standard card styling
  static Map<String, String> get card => {
        'background': ArcaneColors.card,
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.lg,
        'padding': ArcaneSpacing.lg,
        'transition': 'all ${ArcaneEffects.transitionNormal}',
      };

  /// Card without padding (for custom content)
  static Map<String, String> get cardNoPadding => {
        'background': ArcaneColors.card,
        'border': '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.lg,
        'overflow': 'hidden',
        'transition': 'all ${ArcaneEffects.transitionNormal}',
      };

  /// Card with shadow
  static Map<String, String> cardWithShadow({int elevation = 1}) => {
        ...card,
        'box-shadow': switch (elevation) {
          0 => ArcaneEffects.shadowNone,
          1 => ArcaneEffects.shadowSm,
          2 => ArcaneEffects.shadowMd,
          3 => ArcaneEffects.shadowLg,
          _ => ArcaneEffects.shadowXl,
        },
      };

  /// Interactive card (clickable)
  static Map<String, String> get cardInteractive => {
        ...card,
        'cursor': 'pointer',
      };

  /// Glass/frosted card
  static Map<String, String> get cardGlass => {
        'background': ArcaneColors.onSurfaceAlpha05,
        'border': '1px solid ${ArcaneColors.onSurfaceAlpha10}',
        'border-radius': ArcaneRadius.lg,
        'padding': ArcaneSpacing.lg,
        'backdrop-filter': ArcaneEffects.backdropBlur,
        '-webkit-backdrop-filter': ArcaneEffects.backdropBlur,
      };

  /// Subtle card (minimal styling)
  static Map<String, String> get cardSubtle => {
        'background': ArcaneColors.surfaceVariant,
        'border': '1px solid ${ArcaneColors.borderSubtle}',
        'border-radius': ArcaneRadius.lg,
        'padding': ArcaneSpacing.lg,
      };

  // ===========================================================================
  // TYPOGRAPHY
  // ===========================================================================

  /// Heading text style
  static Map<String, String> get heading => {
        'font-weight': ArcaneTypography.weightBold,
        'color': ArcaneColors.onSurface,
        'margin': '0',
        'line-height': ArcaneTypography.lineHeightTight,
      };

  /// Subheading text style
  static Map<String, String> get subheading => {
        'font-weight': ArcaneTypography.weightSemibold,
        'color': ArcaneColors.onSurface,
        'margin': '0',
      };

  /// Body text style
  static Map<String, String> get bodyText => {
        'color': ArcaneColors.muted,
        'line-height': ArcaneTypography.lineHeightRelaxed,
        'margin': '0',
      };

  /// Label text style (for form labels)
  static Map<String, String> get labelText => {
        'font-size': ArcaneTypography.fontSm,
        'font-weight': ArcaneTypography.weightMedium,
        'color': ArcaneColors.onSurface,
      };

  /// Muted/secondary text
  static Map<String, String> get mutedText => {
        'font-size': ArcaneTypography.fontSm,
        'color': ArcaneColors.muted,
      };

  /// Tiny text (captions, footnotes)
  static Map<String, String> get tinyText => {
        'font-size': ArcaneTypography.fontXs,
        'color': ArcaneColors.muted,
      };

  /// Monospace text (for code)
  static Map<String, String> get monoText => {
        'font-family': ArcaneTypography.fontFamilyMono,
        'font-size': ArcaneTypography.fontSm,
      };

  /// Truncate text with ellipsis
  static Map<String, String> get truncate => {
        'overflow': 'hidden',
        'text-overflow': 'ellipsis',
        'white-space': 'nowrap',
      };

  /// Truncate to N lines
  static Map<String, String> lineClamp(int lines) => {
        'display': '-webkit-box',
        '-webkit-line-clamp': '$lines',
        '-webkit-box-orient': 'vertical',
        'overflow': 'hidden',
      };

  // ===========================================================================
  // SECTION/CONTAINER LAYOUTS
  // ===========================================================================

  /// Section padding
  static Map<String, String> section({String? background}) => {
        'padding': '${ArcaneSpacing.xxxl} ${ArcaneSpacing.lg}',
        if (background != null) 'background': background,
      };

  /// Hero section padding
  static Map<String, String> heroSection({String? background}) => {
        'padding': '${ArcaneSpacing.massive} ${ArcaneSpacing.lg}',
        if (background != null) 'background': background,
      };

  /// Container with max width
  static Map<String, String> container({String maxWidth = ArcaneLayout.maxWidthContainer}) => {
        'max-width': maxWidth,
        'margin': '0 auto',
        'padding': '0 ${ArcaneSpacing.md}',
      };

  /// Content container (narrower)
  static Map<String, String> get containerContent => container(maxWidth: ArcaneLayout.maxWidthContent);

  /// Narrow container (for forms, text)
  static Map<String, String> get containerNarrow => container(maxWidth: ArcaneLayout.maxWidthNarrow);

  /// Text container (optimal reading width)
  static Map<String, String> get containerText => container(maxWidth: ArcaneLayout.maxWidthText);

  /// Section header (centered title area)
  static Map<String, String> get sectionHeader => {
        'text-align': 'center',
        'margin-bottom': ArcaneSpacing.xxl,
      };

  // ===========================================================================
  // IMAGE STYLES
  // ===========================================================================

  /// Image container (square)
  static Map<String, String> imageContainer(String size) => {
        'width': size,
        'height': size,
        'border-radius': ArcaneRadius.md,
        'overflow': 'hidden',
        'flex-shrink': '0',
      };

  /// Image cover (fills container)
  static Map<String, String> get imageCover => {
        'width': '100%',
        'height': '100%',
        'object-fit': 'cover',
      };

  /// Image contain (fits within container)
  static Map<String, String> get imageContain => {
        'width': '100%',
        'height': '100%',
        'object-fit': 'contain',
      };

  /// Circular image container
  static Map<String, String> imageCircle(String size) => {
        'width': size,
        'height': size,
        'border-radius': ArcaneRadius.full,
        'overflow': 'hidden',
        'flex-shrink': '0',
      };

  // ===========================================================================
  // STATUS BADGE
  // ===========================================================================

  /// Status badge with color
  static Map<String, String> statusBadge(String bgColor, String textColor) => {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': ArcaneSpacing.xs,
        'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
        'background': bgColor,
        'border-radius': ArcaneRadius.sm,
        'font-size': ArcaneTypography.fontXs,
        'font-weight': ArcaneTypography.weightMedium,
        'color': textColor,
      };

  /// Success status badge
  static Map<String, String> get statusSuccess => statusBadge(
        ArcaneColors.successAlpha15,
        ArcaneColors.success,
      );

  /// Warning status badge
  static Map<String, String> get statusWarning => statusBadge(
        ArcaneColors.warningAlpha15,
        ArcaneColors.warning,
      );

  /// Error status badge
  static Map<String, String> get statusError => statusBadge(
        ArcaneColors.errorAlpha15,
        ArcaneColors.error,
      );

  /// Info status badge
  static Map<String, String> get statusInfo => statusBadge(
        ArcaneColors.infoAlpha15,
        ArcaneColors.info,
      );

  // ===========================================================================
  // DIVIDERS
  // ===========================================================================

  /// Horizontal divider
  static Map<String, String> get divider => {
        'width': '100%',
        'height': '1px',
        'background': ArcaneColors.border,
        'margin': '${ArcaneSpacing.md} 0',
      };

  /// Vertical divider
  static Map<String, String> get dividerVertical => {
        'width': '1px',
        'height': '100%',
        'background': ArcaneColors.border,
        'margin': '0 ${ArcaneSpacing.md}',
      };

  // ===========================================================================
  // INTERACTIVE STATES
  // ===========================================================================

  /// Clickable element
  static Map<String, String> get clickable => {
        'cursor': 'pointer',
        'transition': 'all ${ArcaneEffects.transitionFast}',
      };

  /// Disabled state
  static Map<String, String> get disabled => {
        'opacity': '0.5',
        'cursor': 'not-allowed',
        'pointer-events': 'none',
      };

  /// Hidden element
  static Map<String, String> get hidden => {
        'display': 'none',
      };

  /// Visually hidden (accessible)
  static Map<String, String> get visuallyHidden => {
        'position': 'absolute',
        'width': '1px',
        'height': '1px',
        'padding': '0',
        'margin': '-1px',
        'overflow': 'hidden',
        'clip': 'rect(0, 0, 0, 0)',
        'white-space': 'nowrap',
        'border': '0',
      };

  // ===========================================================================
  // OVERLAYS
  // ===========================================================================

  /// Overlay backdrop
  static Map<String, String> get overlay => {
        'position': 'fixed',
        'inset': '0',
        'background': ArcaneColors.scrim,
        'backdrop-filter': ArcaneEffects.backdropBlur,
        '-webkit-backdrop-filter': ArcaneEffects.backdropBlur,
        'z-index': ArcaneZIndex.modalBackdrop,
      };

  /// Centered modal container
  static Map<String, String> get modalContainer => {
        'position': 'fixed',
        'inset': '0',
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'padding': ArcaneSpacing.md,
        'z-index': ArcaneZIndex.modal,
      };

  // ===========================================================================
  // POSITIONING
  // ===========================================================================

  /// Absolute fill parent
  static Map<String, String> get absoluteFill => {
        'position': 'absolute',
        'inset': '0',
      };

  /// Fixed fill viewport
  static Map<String, String> get fixedFill => {
        'position': 'fixed',
        'inset': '0',
      };

  /// Sticky top
  static Map<String, String> stickyTop({String top = '0'}) => {
        'position': 'sticky',
        'top': top,
        'z-index': ArcaneZIndex.sticky,
      };

  // ===========================================================================
  // SCROLLING
  // ===========================================================================

  /// Scrollable container (vertical)
  static Map<String, String> get scrollY => {
        'overflow-y': 'auto',
        'overflow-x': 'hidden',
      };

  /// Scrollable container (horizontal)
  static Map<String, String> get scrollX => {
        'overflow-x': 'auto',
        'overflow-y': 'hidden',
      };

  /// Hide scrollbar but keep scrollable
  static Map<String, String> get scrollHideScrollbar => {
        'overflow': 'auto',
        'scrollbar-width': 'none',
        '-ms-overflow-style': 'none',
      };

  // ===========================================================================
  // FULL PAGE LAYOUTS
  // ===========================================================================

  /// Full viewport height container
  static Map<String, String> get fullHeight => {
        'min-height': '100vh',
        'display': 'flex',
        'flex-direction': 'column',
      };

  /// Page wrapper with background
  static Map<String, String> get pageWrapper => {
        'min-height': '100vh',
        'display': 'flex',
        'flex-direction': 'column',
        'background': ArcaneColors.background,
        'color': ArcaneColors.onBackground,
      };

  /// Main content area (grows to fill)
  static Map<String, String> get mainContent => {
        'flex': '1',
        'display': 'flex',
        'flex-direction': 'column',
      };
}
