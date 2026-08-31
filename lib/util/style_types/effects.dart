/// Box shadow presets
enum Shadow {
  none,
  xs,
  sm,
  md,
  lg,
  xl,
  card;

  String get css => switch (this) {
    Shadow.none => 'none',
    Shadow.xs => 'var(--arcane-shadow-xs, 0 1px 3px 0 rgba(0, 0, 0, 0.05))',
    Shadow.sm => 'var(--arcane-shadow-sm, 0 1px 3px 0 rgba(0, 0, 0, 0.1))',
    Shadow.md => 'var(--arcane-shadow-md, 0 4px 6px -1px rgba(0, 0, 0, 0.1))',
    Shadow.lg => 'var(--arcane-shadow-lg, 0 10px 15px -3px rgba(0, 0, 0, 0.1))',
    Shadow.xl => 'var(--arcane-shadow-xl, 0 20px 25px -5px rgba(0, 0, 0, 0.1))',
    Shadow.card =>
      '0 4px 6px -1px rgba(0, 0, 0, 0.2), 0 2px 4px -1px rgba(0, 0, 0, 0.1)',
  };
}

/// Transition presets
enum Transition {
  none,
  fast,
  normal,
  slow,
  bounce,
  allFast,
  allNormal,
  allSlow,
  colors,
  transform,
  opacity,
  shadow;

  String get css => switch (this) {
    Transition.none => 'none',
    Transition.fast => 'all 150ms ease',
    Transition.normal => 'all 200ms ease',
    Transition.slow => 'all 300ms ease',
    Transition.bounce => 'all 300ms cubic-bezier(0.68, -0.55, 0.265, 1.55)',
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
  transparent,
  faint,
  light,
  half,
  muted,
  high,
  full,
  disabled,
  hoverOverlay,
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

/// Pointer events presets
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

/// User select presets
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

/// Transform presets
enum Transform {
  none,
  center,
  centerX,
  centerY,
  rotate90,
  rotate180,
  rotate270,
  flipX,
  flipY;

  String get css => switch (this) {
    Transform.none => 'none',
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

/// Transform origin presets
enum TransformOrigin {
  center,
  top,
  topRight,
  right,
  bottomRight,
  bottom,
  bottomLeft,
  left,
  topLeft;

  String get css => switch (this) {
    TransformOrigin.center => 'center',
    TransformOrigin.top => 'top',
    TransformOrigin.topRight => 'top right',
    TransformOrigin.right => 'right',
    TransformOrigin.bottomRight => 'bottom right',
    TransformOrigin.bottom => 'bottom',
    TransformOrigin.bottomLeft => 'bottom left',
    TransformOrigin.left => 'left',
    TransformOrigin.topLeft => 'top left',
  };
}

/// Animation presets for common UI patterns
enum AnimationPreset {
  none,
  fadeIn,
  fadeOut,
  slideInUp,
  slideInDown,
  slideInLeft,
  slideInRight,
  scaleIn,
  scaleOut,
  bounce,
  pulse,
  spin,
  dropdownFade;

  String get css => switch (this) {
    AnimationPreset.none => 'none',
    AnimationPreset.fadeIn => 'arcane-fade-in 0.2s ease forwards',
    AnimationPreset.fadeOut => 'arcane-fade-out 0.2s ease forwards',
    AnimationPreset.slideInUp => 'arcane-slide-in-up 0.3s ease forwards',
    AnimationPreset.slideInDown => 'arcane-slide-in-down 0.3s ease forwards',
    AnimationPreset.slideInLeft => 'arcane-slide-in-left 0.3s ease forwards',
    AnimationPreset.slideInRight => 'arcane-slide-in-right 0.3s ease forwards',
    AnimationPreset.scaleIn => 'arcane-scale-in 0.2s ease forwards',
    AnimationPreset.scaleOut => 'arcane-scale-out 0.2s ease forwards',
    AnimationPreset.bounce => 'arcane-bounce 0.5s ease',
    AnimationPreset.pulse => 'arcane-pulse 2s ease-in-out infinite',
    AnimationPreset.spin => 'arcane-spin 1s linear infinite',
    AnimationPreset.dropdownFade =>
      'arcane-dropdown-fade 0.15s cubic-bezier(0.16, 1, 0.3, 1) forwards',
  };
}
