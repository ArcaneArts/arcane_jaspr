import 'package:jaspr/jaspr.dart';
import 'appearance/theme.dart';

/// Core Arcane utility class for app-wide operations
class Arcane {
  Arcane._();

  /// Global theme reference (set by ArcaneApp)
  static ArcaneTheme _globalTheme = const ArcaneTheme();

  /// Get the global theme
  static ArcaneTheme get globalTheme => _globalTheme;

  /// Set the global theme (called by ArcaneApp)
  static set globalTheme(ArcaneTheme theme) => _globalTheme = theme;

  /// Get theme from context or fall back to global
  static ArcaneTheme themeOf(BuildContext context) {
    return ArcaneTheme.maybeOf(context) ?? globalTheme;
  }

  /// Navigate to a new component (client-side routing)
  static void navigateTo(BuildContext context, String path) {
    // In Jaspr, navigation is typically handled differently
    // This is a placeholder for routing integration
  }
}

/// Edge insets for padding/margin
class EdgeInsets {
  final double left;
  final double top;
  final double right;
  final double bottom;

  const EdgeInsets.all(double value)
      : left = value,
        top = value,
        right = value,
        bottom = value;

  const EdgeInsets.symmetric({double horizontal = 0, double vertical = 0})
      : left = horizontal,
        top = vertical,
        right = horizontal,
        bottom = vertical;

  const EdgeInsets.only({
    this.left = 0,
    this.top = 0,
    this.right = 0,
    this.bottom = 0,
  });

  static const EdgeInsets zero = EdgeInsets.all(0);

  /// Convert to CSS padding string
  String get padding => '${top}px ${right}px ${bottom}px ${left}px';

  /// Convert to CSS margin string
  String get margin => '${top}px ${right}px ${bottom}px ${left}px';

  EdgeInsets copyWith({
    double? left,
    double? top,
    double? right,
    double? bottom,
  }) {
    return EdgeInsets.only(
      left: left ?? this.left,
      top: top ?? this.top,
      right: right ?? this.right,
      bottom: bottom ?? this.bottom,
    );
  }

  EdgeInsets operator +(EdgeInsets other) {
    return EdgeInsets.only(
      left: left + other.left,
      top: top + other.top,
      right: right + other.right,
      bottom: bottom + other.bottom,
    );
  }

  EdgeInsets operator *(double factor) {
    return EdgeInsets.only(
      left: left * factor,
      top: top * factor,
      right: right * factor,
      bottom: bottom * factor,
    );
  }
}

/// Box constraints
class BoxConstraints {
  final double? minWidth;
  final double? maxWidth;
  final double? minHeight;
  final double? maxHeight;

  const BoxConstraints({
    this.minWidth,
    this.maxWidth,
    this.minHeight,
    this.maxHeight,
  });

  const BoxConstraints.tight(double width, double height)
      : minWidth = width,
        maxWidth = width,
        minHeight = height,
        maxHeight = height;

  const BoxConstraints.expand({double? width, double? height})
      : minWidth = width ?? double.infinity,
        maxWidth = width ?? double.infinity,
        minHeight = height ?? double.infinity,
        maxHeight = height ?? double.infinity;
}

/// Alignment
enum Alignment {
  topLeft,
  topCenter,
  topRight,
  centerLeft,
  center,
  centerRight,
  bottomLeft,
  bottomCenter,
  bottomRight;

  String get cssJustifyContent {
    switch (this) {
      case Alignment.topLeft:
      case Alignment.centerLeft:
      case Alignment.bottomLeft:
        return 'flex-start';
      case Alignment.topCenter:
      case Alignment.center:
      case Alignment.bottomCenter:
        return 'center';
      case Alignment.topRight:
      case Alignment.centerRight:
      case Alignment.bottomRight:
        return 'flex-end';
    }
  }

  String get cssAlignItems {
    switch (this) {
      case Alignment.topLeft:
      case Alignment.topCenter:
      case Alignment.topRight:
        return 'flex-start';
      case Alignment.centerLeft:
      case Alignment.center:
      case Alignment.centerRight:
        return 'center';
      case Alignment.bottomLeft:
      case Alignment.bottomCenter:
      case Alignment.bottomRight:
        return 'flex-end';
    }
  }
}

/// Main axis alignment
enum MainAxisAlignment {
  start,
  end,
  center,
  spaceBetween,
  spaceAround,
  spaceEvenly;

  String get css {
    switch (this) {
      case MainAxisAlignment.start:
        return 'flex-start';
      case MainAxisAlignment.end:
        return 'flex-end';
      case MainAxisAlignment.center:
        return 'center';
      case MainAxisAlignment.spaceBetween:
        return 'space-between';
      case MainAxisAlignment.spaceAround:
        return 'space-around';
      case MainAxisAlignment.spaceEvenly:
        return 'space-evenly';
    }
  }
}

/// Cross axis alignment
enum CrossAxisAlignment {
  start,
  end,
  center,
  stretch,
  baseline;

  String get css {
    switch (this) {
      case CrossAxisAlignment.start:
        return 'flex-start';
      case CrossAxisAlignment.end:
        return 'flex-end';
      case CrossAxisAlignment.center:
        return 'center';
      case CrossAxisAlignment.stretch:
        return 'stretch';
      case CrossAxisAlignment.baseline:
        return 'baseline';
    }
  }
}

/// Main axis size
enum MainAxisSize {
  min,
  max;

  String get css => this == MainAxisSize.max ? '1' : '0';
}

/// Axis
enum Axis { horizontal, vertical }

/// Wrap behavior
enum WrapAlignment {
  start,
  end,
  center,
  spaceBetween,
  spaceAround,
  spaceEvenly;

  String get css {
    switch (this) {
      case WrapAlignment.start:
        return 'flex-start';
      case WrapAlignment.end:
        return 'flex-end';
      case WrapAlignment.center:
        return 'center';
      case WrapAlignment.spaceBetween:
        return 'space-between';
      case WrapAlignment.spaceAround:
        return 'space-around';
      case WrapAlignment.spaceEvenly:
        return 'space-evenly';
    }
  }
}

/// Text alignment
enum TextAlign {
  left,
  right,
  center,
  justify,
  start,
  end;

  String get css {
    switch (this) {
      case TextAlign.left:
        return 'left';
      case TextAlign.right:
        return 'right';
      case TextAlign.center:
        return 'center';
      case TextAlign.justify:
        return 'justify';
      case TextAlign.start:
        return 'start';
      case TextAlign.end:
        return 'end';
    }
  }
}

/// Font weight
enum FontWeight {
  w100,
  w200,
  w300,
  w400,
  w500,
  w600,
  w700,
  w800,
  w900;

  int get value {
    switch (this) {
      case FontWeight.w100:
        return 100;
      case FontWeight.w200:
        return 200;
      case FontWeight.w300:
        return 300;
      case FontWeight.w400:
        return 400;
      case FontWeight.w500:
        return 500;
      case FontWeight.w600:
        return 600;
      case FontWeight.w700:
        return 700;
      case FontWeight.w800:
        return 800;
      case FontWeight.w900:
        return 900;
    }
  }

  String get css => '$value';

  static const FontWeight normal = FontWeight.w400;
  static const FontWeight bold = FontWeight.w700;
}

/// Text overflow
enum TextOverflow {
  clip,
  ellipsis,
  visible;

  String get css {
    switch (this) {
      case TextOverflow.clip:
        return 'clip';
      case TextOverflow.ellipsis:
        return 'ellipsis';
      case TextOverflow.visible:
        return 'visible';
    }
  }
}

/// Box fit
enum BoxFit {
  contain,
  cover,
  fill,
  fitHeight,
  fitWidth,
  none,
  scaleDown;

  String get css {
    switch (this) {
      case BoxFit.contain:
        return 'contain';
      case BoxFit.cover:
        return 'cover';
      case BoxFit.fill:
        return 'fill';
      case BoxFit.fitHeight:
        return 'contain';
      case BoxFit.fitWidth:
        return 'contain';
      case BoxFit.none:
        return 'none';
      case BoxFit.scaleDown:
        return 'scale-down';
    }
  }
}

/// Border radius
class BorderRadius {
  final double topLeft;
  final double topRight;
  final double bottomLeft;
  final double bottomRight;

  const BorderRadius.all(double radius)
      : topLeft = radius,
        topRight = radius,
        bottomLeft = radius,
        bottomRight = radius;

  const BorderRadius.circular(double radius)
      : topLeft = radius,
        topRight = radius,
        bottomLeft = radius,
        bottomRight = radius;

  const BorderRadius.only({
    this.topLeft = 0,
    this.topRight = 0,
    this.bottomLeft = 0,
    this.bottomRight = 0,
  });

  static const BorderRadius zero = BorderRadius.all(0);

  String get css =>
      '${topLeft}px ${topRight}px ${bottomRight}px ${bottomLeft}px';
}

/// Box shadow
class BoxShadow {
  final Color color;
  final double blurRadius;
  final double spreadRadius;
  final double offsetX;
  final double offsetY;

  const BoxShadow({
    this.color = const Color(0x33000000),
    this.blurRadius = 0,
    this.spreadRadius = 0,
    this.offsetX = 0,
    this.offsetY = 0,
  });

  String get css =>
      '${offsetX}px ${offsetY}px ${blurRadius}px ${spreadRadius}px ${color.css}';
}

/// Duration extension for convenience
extension DurationExtension on int {
  Duration get ms => Duration(milliseconds: this);
  Duration get seconds => Duration(seconds: this);
}
