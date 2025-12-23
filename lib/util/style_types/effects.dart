import '../tokens/tokens.dart';

/// Box shadow presets for depth and emphasis.
///
/// Shadows create visual hierarchy by simulating elevation.
/// The Arcane design system includes both standard shadows
/// and colored glows for gaming/neon aesthetics.
///
/// ## Standard Shadows
///
/// | Value  | Description                   | Use Case            |
/// |--------|-------------------------------|---------------------|
/// | `none` | No shadow                     | Flat elements       |
/// | `xs`   | Minimal shadow                | Subtle elevation    |
/// | `sm`   | Small shadow                  | Buttons, inputs     |
/// | `md`   | Medium shadow (default)       | Cards, dialogs      |
/// | `lg`   | Large shadow                  | Modals, popovers    |
/// | `xl`   | Extra large shadow            | Floating elements   |
/// | `card` | Card-specific shadow          | Card components     |
///
/// ## Glow Effects
///
/// | Value         | Color   | Use Case                |
/// |---------------|---------|-------------------------|
/// | `glowAccent`  | Theme   | Highlighted buttons     |
/// | `glowSuccess` | Green   | Success states          |
/// | `glowError`   | Red     | Error states            |
/// | `glowCyan`    | Cyan    | Gaming/neon style       |
/// | `glowPurple`  | Purple  | Gaming/neon style       |
/// | `glowPink`    | Pink    | Gaming/neon style       |
///
/// ## Example
///
/// ```dart
/// ArcaneDiv(
///   styles: const ArcaneStyleData(
///     boxShadow: Shadow.lg,          // Standard elevation
///     // boxShadow: Shadow.glowCyan, // Neon glow
///   ),
/// )
/// ```
enum Shadow {
  /// No shadow
  none,

  /// Extra small shadow
  xs,

  /// Small shadow
  sm,

  /// Medium shadow (default)
  md,

  /// Large shadow
  lg,

  /// Extra large shadow
  xl,

  /// Card shadow
  card,

  /// Accent glow
  glowAccent,

  /// Success glow
  glowSuccess,

  /// Error glow
  glowError,

  /// Primary/green glow (gaming)
  glowPrimary,

  /// Green glow
  glowGreen,

  /// Cyan glow
  glowCyan,

  /// Purple glow
  glowPurple,

  /// Orange glow
  glowOrange,

  /// Pink glow
  glowPink;

  String get css => switch (this) {
        Shadow.none => ArcaneEffects.shadowNone,
        Shadow.xs => ArcaneEffects.shadowXs,
        Shadow.sm => ArcaneEffects.shadowSm,
        Shadow.md => ArcaneEffects.shadowMd,
        Shadow.lg => ArcaneEffects.shadowLg,
        Shadow.xl => ArcaneEffects.shadowXl,
        Shadow.card => ArcaneEffects.shadowCard,
        Shadow.glowAccent => ArcaneEffects.glowAccent,
        Shadow.glowSuccess => ArcaneEffects.glowSuccess,
        Shadow.glowError => ArcaneEffects.glowError,
        Shadow.glowPrimary => ArcaneEffects.glowPrimary,
        Shadow.glowGreen => ArcaneEffects.glowGreen,
        Shadow.glowCyan => ArcaneEffects.glowCyan,
        Shadow.glowPurple => ArcaneEffects.glowPurple,
        Shadow.glowOrange => ArcaneEffects.glowOrange,
        Shadow.glowPink => ArcaneEffects.glowPink,
      };
}

/// Transition presets for smooth state changes.
///
/// Transitions animate property changes between states, improving
/// perceived performance and user experience.
///
/// ## Timing Presets
///
/// | Value    | Duration | Use Case                      |
/// |----------|----------|-------------------------------|
/// | `none`   | -        | Instant changes               |
/// | `fast`   | 150ms    | Micro-interactions            |
/// | `normal` | 200ms    | Standard transitions          |
/// | `slow`   | 300ms    | Emphasis, modals              |
/// | `bounce` | 300ms    | Playful interactions          |
///
/// ## Property-Specific
///
/// | Value       | Properties             |
/// |-------------|------------------------|
/// | `colors`    | Color changes only     |
/// | `transform` | Transform changes only |
/// | `opacity`   | Fade in/out            |
/// | `shadow`    | Shadow changes         |
///
/// ## Example
///
/// ```dart
/// ArcaneButton(
///   styles: const ArcaneStyleData(
///     transition: Transition.fast,  // Quick hover response
///   ),
/// )
/// ```
enum Transition {
  /// No transition
  none,

  /// Fast (150ms)
  fast,

  /// Normal (200ms)
  normal,

  /// Slow (300ms)
  slow,

  /// Bounce effect
  bounce,

  /// All properties fast
  allFast,

  /// All properties normal
  allNormal,

  /// All properties slow
  allSlow,

  /// Colors only
  colors,

  /// Transform only
  transform,

  /// Opacity only
  opacity,

  /// Shadow only
  shadow;

  String get css => switch (this) {
        Transition.none => 'none',
        Transition.fast => ArcaneEffects.transitionFast,
        Transition.normal => ArcaneEffects.transitionNormal,
        Transition.slow => ArcaneEffects.transitionSlow,
        Transition.bounce => ArcaneEffects.transitionBounce,
        Transition.allFast => 'all 0.15s ease',
        Transition.allNormal => 'all 0.2s ease',
        Transition.allSlow => 'all 0.3s ease',
        Transition.colors =>
          'color 0.2s ease, background-color 0.2s ease, border-color 0.2s ease',
        Transition.transform => 'transform 0.2s ease',
        Transition.opacity => 'opacity 0.2s ease',
        Transition.shadow => 'box-shadow 0.2s ease',
      };
}

/// Opacity presets
enum Opacity {
  /// Fully transparent (0)
  transparent,

  /// Very faint (0.1)
  faint,

  /// Light (0.25)
  light,

  /// Half (0.5)
  half,

  /// Muted (0.75)
  muted,

  /// Nearly opaque (0.9)
  high,

  /// Fully opaque (1)
  full,

  /// Disabled state (0.5)
  disabled,

  /// Hover overlay (0.04)
  hoverOverlay,

  /// Press overlay (0.08)
  pressOverlay;

  String get css => switch (this) {
        Opacity.transparent => '0',
        Opacity.faint => '0.1',
        Opacity.light => '0.25',
        Opacity.half => '0.5',
        Opacity.muted => '0.75',
        Opacity.high => '0.9',
        Opacity.full => '1',
        Opacity.disabled => '0.5',
        Opacity.hoverOverlay => '0.04',
        Opacity.pressOverlay => '0.08',
      };
}

/// Cursor presets
enum Cursor {
  auto,
  default_,
  pointer,
  text,
  move,
  grab,
  grabbing,
  notAllowed,
  wait,
  progress,
  crosshair,
  zoomIn,
  zoomOut,
  help,
  none,
  colResize,
  rowResize,
  nResize,
  eResize,
  sResize,
  wResize;

  String get css => switch (this) {
        Cursor.auto => 'auto',
        Cursor.default_ => 'default',
        Cursor.pointer => 'pointer',
        Cursor.text => 'text',
        Cursor.move => 'move',
        Cursor.grab => 'grab',
        Cursor.grabbing => 'grabbing',
        Cursor.notAllowed => 'not-allowed',
        Cursor.wait => 'wait',
        Cursor.progress => 'progress',
        Cursor.crosshair => 'crosshair',
        Cursor.zoomIn => 'zoom-in',
        Cursor.zoomOut => 'zoom-out',
        Cursor.help => 'help',
        Cursor.none => 'none',
        Cursor.colResize => 'col-resize',
        Cursor.rowResize => 'row-resize',
        Cursor.nResize => 'n-resize',
        Cursor.eResize => 'e-resize',
        Cursor.sResize => 's-resize',
        Cursor.wResize => 'w-resize',
      };
}

/// Pointer events
enum PointerEvents {
  auto,
  none,
  all;

  String get css => switch (this) {
        PointerEvents.auto => 'auto',
        PointerEvents.none => 'none',
        PointerEvents.all => 'all',
      };
}

/// User select
enum UserSelect {
  auto,
  none,
  text,
  all,
  contain;

  String get css => switch (this) {
        UserSelect.auto => 'auto',
        UserSelect.none => 'none',
        UserSelect.text => 'text',
        UserSelect.all => 'all',
        UserSelect.contain => 'contain',
      };
}

/// Transform presets for visual manipulations.
///
/// Transforms modify element appearance without affecting layout.
/// Common for hover effects, centering, and animations.
///
/// ## Hover Effects
///
/// | Value             | Effect          | Use Case             |
/// |-------------------|-----------------|----------------------|
/// | `hoverLift`       | translateY(-4px)| Cards, buttons       |
/// | `hoverScale`      | scale(1.02)     | Interactive elements |
/// | `hoverScaleSubtle`| scale(1.01)     | Subtle feedback      |
///
/// ## Positioning
///
/// | Value     | Transform              | Use Case            |
/// |-----------|------------------------|---------------------|
/// | `center`  | translate(-50%, -50%)  | Absolute centering  |
/// | `centerX` | translateX(-50%)       | Horizontal center   |
/// | `centerY` | translateY(-50%)       | Vertical center     |
///
/// ## Rotation
///
/// | Value       | Degrees | Use Case              |
/// |-------------|---------|----------------------|
/// | `rotate90`  | 90°     | Rotated icons        |
/// | `rotate180` | 180°    | Flipped elements     |
/// | `flipX`     | scaleX(-1)| Mirror horizontal  |
/// | `flipY`     | scaleY(-1)| Mirror vertical    |
///
/// ## Example
///
/// ```dart
/// ArcaneCard(
///   styles: const ArcaneStyleData(
///     hoverTransform: Transform.hoverLift,  // Lift on hover
///   ),
/// )
/// ```
enum Transform {
  /// No transform
  none,

  /// Lift on hover (-4px Y)
  hoverLift,

  /// Scale on hover (1.02)
  hoverScale,

  /// Subtle scale (1.01)
  hoverScaleSubtle,

  /// Center (translate -50%, -50%)
  center,

  /// Center X only
  centerX,

  /// Center Y only
  centerY,

  /// Rotate 90 degrees
  rotate90,

  /// Rotate 180 degrees
  rotate180,

  /// Rotate 270 degrees
  rotate270,

  /// Flip horizontal
  flipX,

  /// Flip vertical
  flipY;

  String get css => switch (this) {
        Transform.none => 'none',
        Transform.hoverLift => ArcaneEffects.hoverLift,
        Transform.hoverScale => ArcaneEffects.hoverScale,
        Transform.hoverScaleSubtle => ArcaneEffects.hoverScaleSubtle,
        Transform.center => 'translate(-50%, -50%)',
        Transform.centerX => 'translateX(-50%)',
        Transform.centerY => 'translateY(-50%)',
        Transform.rotate90 => 'rotate(90deg)',
        Transform.rotate180 => 'rotate(180deg)',
        Transform.rotate270 => 'rotate(270deg)',
        Transform.flipX => 'scaleX(-1)',
        Transform.flipY => 'scaleY(-1)',
      };
}

/// Backdrop filter presets
enum BackdropFilter {
  none,
  blur,
  blurStrong,
  blurLight;

  String get css => switch (this) {
        BackdropFilter.none => 'none',
        BackdropFilter.blur => ArcaneEffects.backdropBlur,
        BackdropFilter.blurStrong => ArcaneEffects.backdropBlurStrong,
        BackdropFilter.blurLight => 'blur(8px)',
      };
}

/// Animation timing functions
enum Easing {
  linear,
  ease,
  easeIn,
  easeOut,
  easeInOut,
  bounce;

  String get css => switch (this) {
        Easing.linear => 'linear',
        Easing.ease => 'ease',
        Easing.easeIn => 'ease-in',
        Easing.easeOut => 'ease-out',
        Easing.easeInOut => 'ease-in-out',
        Easing.bounce => 'cubic-bezier(0.68, -0.55, 0.265, 1.55)',
      };
}
