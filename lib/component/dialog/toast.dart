import 'dart:async';

import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';
import '../view/icon.dart';

/// Toast notification variant
enum ToastVariant {
  /// Default informational toast
  info,

  /// Success toast with green accent
  success,

  /// Warning toast with yellow/orange accent
  warning,

  /// Error toast with red accent
  error,

  /// Loading toast with spinner
  loading,
}

/// Toast position on screen
enum ToastPosition {
  topLeft,
  topCenter,
  topRight,
  bottomLeft,
  bottomCenter,
  bottomRight,
}

/// Toast action button configuration
class ToastAction {
  final String label;
  final void Function() onPressed;
  final bool destructive;

  const ToastAction({
    required this.label,
    required this.onPressed,
    this.destructive = false,
  });
}

/// A toast notification component.
///
/// Can be used standalone or with the global [toast] API.
///
/// ## Standalone Usage
/// ```dart
/// ArcaneToast(
///   message: 'Changes saved!',
///   variant: ToastVariant.success,
///   position: ToastPosition.bottomRight,
/// )
/// ```
///
/// ## Global API Usage
/// ```dart
/// // Add ArcaneToast.container() once at app root
/// toast.success('Saved!');
/// toast.error('Failed!');
/// toast.warning('Check input');
/// toast.info('New update');
/// toast.loading('Processing...');
/// ```
class ArcaneToast extends StatefulComponent {
  /// Toast message (required)
  final String message;

  /// Optional title displayed above message
  final String? title;

  /// Optional description displayed below message
  final String? description;

  /// Toast variant (info, success, warning, error, loading)
  final ToastVariant variant;

  /// Screen position
  final ToastPosition position;

  /// Auto-dismiss duration in milliseconds (0 = no auto-dismiss)
  final int duration;

  /// Whether the toast can be dismissed by clicking close
  final bool dismissible;

  /// Optional action button
  final ToastAction? action;

  /// Custom icon (overrides default variant icon)
  final Component? icon;

  /// Callback when toast is closed
  final void Function()? onClose;

  /// Unique ID for this toast (used by toast manager)
  final String? id;

  const ArcaneToast({
    required this.message,
    this.title,
    this.description,
    this.variant = ToastVariant.info,
    this.position = ToastPosition.bottomRight,
    this.duration = 4000,
    this.dismissible = true,
    this.action,
    this.icon,
    this.onClose,
    this.id,
    super.key,
  });

  /// Creates a toast container for the global toast API.
  /// Place this once at your app root.
  static Component container({
    ToastPosition position = ToastPosition.bottomRight,
    int maxVisible = 3,
    double gap = 12,
    double offset = 20,
    Key? key,
  }) {
    return _ToastContainer(
      position: position,
      maxVisible: maxVisible,
      gap: gap,
      offset: offset,
      key: key,
    );
  }

  @override
  State<ArcaneToast> createState() => _ArcaneToastState();

  @css
  static final List<StyleRule> styles = [
    // Entry animation
    css('@keyframes arcane-toast-enter').styles(raw: {
      '0%': 'opacity: 0; transform: translateY(16px) scale(0.95)',
      '100%': 'opacity: 1; transform: translateY(0) scale(1)',
    }),
    // Exit animation
    css('@keyframes arcane-toast-exit').styles(raw: {
      '0%': 'opacity: 1; transform: translateY(0) scale(1)',
      '100%': 'opacity: 0; transform: translateY(-16px) scale(0.95)',
    }),
    // Spinner animation
    css('@keyframes arcane-toast-spin').styles(raw: {
      '0%': 'transform: rotate(0deg)',
      '100%': 'transform: rotate(360deg)',
    }),
    // Progress bar animation
    css('@keyframes arcane-toast-progress').styles(raw: {
      '0%': 'width: 100%',
      '100%': 'width: 0%',
    }),
    // Hover effects
    css('.arcane-toast:hover .arcane-toast-close').styles(raw: {
      'opacity': '1',
    }),
    css('.arcane-toast-close:hover').styles(raw: {
      'background': 'rgba(255, 255, 255, 0.1)',
    }),
    css('.arcane-toast-action:hover').styles(raw: {
      'opacity': '0.8',
    }),
  ];
}

class _ArcaneToastState extends State<ArcaneToast> {
  bool _isExiting = false;
  bool _isHovered = false;
  Timer? _dismissTimer;
  Timer? _exitTimer;

  @override
  void initState() {
    super.initState();
    _scheduleDismissTimer();
  }

  @override
  void dispose() {
    _cancelTimers();
    super.dispose();
  }

  void _cancelTimers() {
    _dismissTimer?.cancel();
    _dismissTimer = null;
    _exitTimer?.cancel();
    _exitTimer = null;
  }

  void _scheduleDismissTimer() {
    _dismissTimer?.cancel();
    if (component.duration > 0 && !_isHovered) {
      _dismissTimer = Timer(
        Duration(milliseconds: component.duration),
        () {
          if (mounted && !_isHovered) {
            _startExitAnimation();
          }
        },
      );
    }
  }

  void _startExitAnimation() {
    if (_isExiting) return;
    setState(() => _isExiting = true);

    _exitTimer = Timer(
      const Duration(milliseconds: 200),
      () {
        if (mounted) {
          component.onClose?.call();
        }
      },
    );
  }

  void _onMouseEnter() {
    setState(() => _isHovered = true);
    _dismissTimer?.cancel();
    _dismissTimer = null;
  }

  void _onMouseLeave() {
    setState(() => _isHovered = false);
    _scheduleDismissTimer();
  }

  void _onDismissClick() {
    _startExitAnimation();
  }

  Component _buildIcon() {
    if (component.icon != null) {
      return component.icon!;
    }

    final iconWidget = switch (component.variant) {
      ToastVariant.success => ArcaneIcon.success(size: IconSize.md),
      ToastVariant.error => ArcaneIcon.error(size: IconSize.md),
      ToastVariant.warning => ArcaneIcon.warning(size: IconSize.md),
      ToastVariant.info => ArcaneIcon.info(size: IconSize.md),
      ToastVariant.loading => ArcaneIcon.loader(size: IconSize.md),
    };

    final isLoading = component.variant == ToastVariant.loading;

    return div(
      styles: Styles(raw: {
        'color': _getIconColor(),
        if (isLoading) 'animation': 'arcane-toast-spin 1s linear infinite',
      }),
      [iconWidget],
    );
  }

  String _getIconColor() {
    return switch (component.variant) {
      ToastVariant.success => ArcaneColors.success,
      ToastVariant.error => ArcaneColors.error,
      ToastVariant.warning => ArcaneColors.warning,
      ToastVariant.info => ArcaneColors.info,
      ToastVariant.loading => ArcaneColors.accent,
    };
  }

  String _getBorderColor() {
    return switch (component.variant) {
      ToastVariant.success => ArcaneColors.successAlpha30,
      ToastVariant.error => ArcaneColors.errorAlpha30,
      ToastVariant.warning => ArcaneColors.warningAlpha30,
      ToastVariant.info => ArcaneColors.infoAlpha30,
      ToastVariant.loading => ArcaneColors.border,
    };
  }

  String _getBackgroundColor() {
    return switch (component.variant) {
      ToastVariant.success => ArcaneColors.successAlpha05,
      ToastVariant.error => ArcaneColors.errorAlpha05,
      ToastVariant.warning => ArcaneColors.warningAlpha05,
      ToastVariant.info => ArcaneColors.infoAlpha05,
      ToastVariant.loading => ArcaneColors.surface,
    };
  }

  String _getProgressColor() {
    return switch (component.variant) {
      ToastVariant.success => ArcaneColors.success,
      ToastVariant.error => ArcaneColors.error,
      ToastVariant.warning => ArcaneColors.warning,
      ToastVariant.info => ArcaneColors.info,
      ToastVariant.loading => ArcaneColors.accent,
    };
  }

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-toast arcane-toast-${component.variant.name}',
      id: component.id != null ? 'toast-${component.id}' : null,
      attributes: {
        'role': 'alert',
        'aria-live':
            component.variant == ToastVariant.error ? 'assertive' : 'polite',
        'aria-atomic': 'true',
        'data-variant': component.variant.name,
        'data-duration': '${component.duration}',
        'data-dismissible': '${component.dismissible}',
        'data-position': component.position.name,
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': ArcaneSpacing.sm,
        'padding': ArcaneSpacing.md,
        'background': _getBackgroundColor(),
        'border': '1px solid ${_getBorderColor()}',
        'border-radius': ArcaneRadius.lg,
        'box-shadow': ArcaneEffects.shadowLg,
        'min-width': '320px',
        'max-width': '420px',
        'pointer-events': 'auto',
        'position': 'relative',
        'overflow': 'hidden',
        'backdrop-filter': 'blur(8px)',
        'transition': 'all 200ms cubic-bezier(0.4, 0, 0.2, 1)',
        'animation': _isExiting
            ? 'arcane-toast-exit 200ms cubic-bezier(0.4, 0, 1, 1) forwards'
            : 'arcane-toast-enter 300ms cubic-bezier(0, 0, 0.2, 1) forwards',
      }),
      events: {
        'mouseenter': (_) => _onMouseEnter(),
        'mouseleave': (_) => _onMouseLeave(),
      },
      [
        // Icon
        div(
          classes: 'arcane-toast-icon',
          styles: const Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '20px',
            'height': '20px',
            'flex-shrink': '0',
            'margin-top': '2px',
          }),
          [_buildIcon()],
        ),

        // Content
        div(
          classes: 'arcane-toast-content',
          styles: const Styles(raw: {
            'flex': '1',
            'min-width': '0',
            'display': 'flex',
            'flex-direction': 'column',
            'gap': '2px',
          }),
          [
            if (component.title != null)
              span(
                classes: 'arcane-toast-title',
                styles: const Styles(raw: {
                  'font-weight': ArcaneTypography.weightSemibold,
                  'font-size': ArcaneTypography.fontSm,
                  'color': ArcaneColors.onSurface,
                  'line-height': '1.4',
                }),
                [Component.text(component.title!)],
              ),
            span(
              classes: 'arcane-toast-message',
              styles: Styles(raw: {
                'font-size': ArcaneTypography.fontSm,
                'color': component.title != null
                    ? ArcaneColors.muted
                    : ArcaneColors.onSurface,
                'line-height': '1.5',
              }),
              [Component.text(component.message)],
            ),
            if (component.description != null)
              span(
                classes: 'arcane-toast-description',
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontXs,
                  'color': ArcaneColors.muted,
                  'line-height': '1.5',
                  'margin-top': '4px',
                }),
                [Component.text(component.description!)],
              ),
            if (component.action != null)
              div(
                styles: const Styles(raw: {'margin-top': ArcaneSpacing.sm}),
                [
                  button(
                    classes: 'arcane-toast-action',
                    attributes: {'type': 'button'},
                    styles: Styles(raw: {
                      'display': 'inline-flex',
                      'align-items': 'center',
                      'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
                      'font-size': ArcaneTypography.fontXs,
                      'font-weight': ArcaneTypography.weightMedium,
                      'color': component.action!.destructive
                          ? ArcaneColors.error
                          : ArcaneColors.accent,
                      'background': 'transparent',
                      'border':
                          '1px solid ${component.action!.destructive ? ArcaneColors.errorAlpha30 : ArcaneColors.border}',
                      'border-radius': ArcaneRadius.sm,
                      'cursor': 'pointer',
                      'transition': ArcaneEffects.transitionFast,
                    }),
                    events: {'click': (_) => component.action!.onPressed()},
                    [Component.text(component.action!.label)],
                  ),
                ],
              ),
          ],
        ),

        // Close button
        if (component.dismissible)
          button(
            classes: 'arcane-toast-close',
            attributes: {'type': 'button', 'aria-label': 'Dismiss'},
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '24px',
              'height': '24px',
              'padding': '0',
              'border': 'none',
              'background': 'transparent',
              'color': ArcaneColors.muted,
              'cursor': 'pointer',
              'border-radius': ArcaneRadius.sm,
              'transition': ArcaneEffects.transitionFast,
              'flex-shrink': '0',
              'opacity': '0.7',
            }),
            events: {'click': (_) => _onDismissClick()},
            [ArcaneIcon.close(size: IconSize.sm)],
          ),

        // Progress bar
        if (component.duration > 0 && !_isHovered && !_isExiting)
          div(
            classes: 'arcane-toast-progress',
            styles: Styles(raw: {
              'position': 'absolute',
              'bottom': '0',
              'left': '0',
              'height': '2px',
              'background': _getProgressColor(),
              'border-radius': '0 0 0 ${ArcaneRadius.lg}',
              'animation':
                  'arcane-toast-progress ${component.duration}ms linear forwards',
            }),
            [],
          ),
      ],
    );
  }
}

// =============================================================================
// Toast Manager & Container (Global API)
// =============================================================================

/// Toast data for the queue
class ToastData {
  final String id;
  final String message;
  final String? title;
  final String? description;
  final ToastVariant variant;
  final int duration;
  final bool dismissible;
  final ToastAction? action;
  final Component? icon;
  final ToastPosition position;

  ToastData({
    required this.id,
    required this.message,
    this.title,
    this.description,
    this.variant = ToastVariant.info,
    this.duration = 4000,
    this.dismissible = true,
    this.action,
    this.icon,
    this.position = ToastPosition.bottomRight,
  });

  ToastData copyWith({
    String? message,
    String? title,
    String? description,
    ToastVariant? variant,
    int? duration,
    bool? dismissible,
    ToastAction? action,
    Component? icon,
  }) {
    return ToastData(
      id: id,
      message: message ?? this.message,
      title: title ?? this.title,
      description: description ?? this.description,
      variant: variant ?? this.variant,
      duration: duration ?? this.duration,
      dismissible: dismissible ?? this.dismissible,
      action: action ?? this.action,
      icon: icon ?? this.icon,
      position: position,
    );
  }
}

/// Global toast manager singleton
class ToastManager {
  static ToastManager? _instance;
  static ToastManager get instance => _instance ??= ToastManager._();

  ToastManager._();

  final List<ToastData> _toasts = [];
  final List<void Function()> _listeners = [];
  ToastPosition _defaultPosition = ToastPosition.bottomRight;

  List<ToastData> get toasts => List.unmodifiable(_toasts);

  void setDefaultPosition(ToastPosition position) {
    _defaultPosition = position;
  }

  void addListener(void Function() listener) => _listeners.add(listener);
  void removeListener(void Function() listener) => _listeners.remove(listener);
  void _notify() {
    for (final l in _listeners) {
      l();
    }
  }

  String _generateId() => 'toast_${DateTime.now().millisecondsSinceEpoch}';

  String _show(ToastData data) {
    _toasts.insert(0, data);
    _notify();
    return data.id;
  }

  void dismiss(String id) {
    _toasts.removeWhere((t) => t.id == id);
    _notify();
  }

  void dismissAll() {
    _toasts.clear();
    _notify();
  }

  void update(String id, ToastData Function(ToastData) updater) {
    final index = _toasts.indexWhere((t) => t.id == id);
    if (index != -1) {
      _toasts[index] = updater(_toasts[index]);
      _notify();
    }
  }

  // Convenience methods
  String info(
    String message, {
    String? title,
    String? description,
    int duration = 4000,
    ToastAction? action,
    Component? icon,
    ToastPosition? position,
  }) {
    return _show(ToastData(
      id: _generateId(),
      message: message,
      title: title,
      description: description,
      variant: ToastVariant.info,
      duration: duration,
      action: action,
      icon: icon,
      position: position ?? _defaultPosition,
    ));
  }

  String success(
    String message, {
    String? title,
    String? description,
    int duration = 4000,
    ToastAction? action,
    Component? icon,
    ToastPosition? position,
  }) {
    return _show(ToastData(
      id: _generateId(),
      message: message,
      title: title,
      description: description,
      variant: ToastVariant.success,
      duration: duration,
      action: action,
      icon: icon,
      position: position ?? _defaultPosition,
    ));
  }

  String warning(
    String message, {
    String? title,
    String? description,
    int duration = 5000,
    ToastAction? action,
    Component? icon,
    ToastPosition? position,
  }) {
    return _show(ToastData(
      id: _generateId(),
      message: message,
      title: title,
      description: description,
      variant: ToastVariant.warning,
      duration: duration,
      action: action,
      icon: icon,
      position: position ?? _defaultPosition,
    ));
  }

  String error(
    String message, {
    String? title,
    String? description,
    int duration = 6000,
    ToastAction? action,
    Component? icon,
    ToastPosition? position,
  }) {
    return _show(ToastData(
      id: _generateId(),
      message: message,
      title: title,
      description: description,
      variant: ToastVariant.error,
      duration: duration,
      action: action,
      icon: icon,
      position: position ?? _defaultPosition,
    ));
  }

  String loading(
    String message, {
    String? title,
    String? description,
    ToastPosition? position,
  }) {
    return _show(ToastData(
      id: _generateId(),
      message: message,
      title: title,
      description: description,
      variant: ToastVariant.loading,
      duration: 0,
      dismissible: false,
      position: position ?? _defaultPosition,
    ));
  }

  String promise<T>(
    Future<T> future, {
    required String loading,
    required String Function(T) success,
    required String Function(Object) error,
    String? title,
    ToastPosition? position,
  }) {
    final id = this.loading(loading, title: title, position: position);

    future.then((result) {
      update(
          id,
          (t) => t.copyWith(
                message: success(result),
                variant: ToastVariant.success,
                duration: 4000,
                dismissible: true,
              ));
    }).catchError((e) {
      update(
          id,
          (t) => t.copyWith(
                message: error(e),
                variant: ToastVariant.error,
                duration: 6000,
                dismissible: true,
              ));
    });

    return id;
  }
}

/// Global toast accessor
ToastManager get toast => ToastManager.instance;

/// Toast container component - renders all active toasts
class _ToastContainer extends StatefulComponent {
  final ToastPosition position;
  final int maxVisible;
  final double gap;
  final double offset;

  const _ToastContainer({
    this.position = ToastPosition.bottomRight,
    this.maxVisible = 3,
    this.gap = 12,
    this.offset = 20,
    super.key,
  });

  @override
  State<_ToastContainer> createState() => _ToastContainerState();
}

class _ToastContainerState extends State<_ToastContainer> {
  @override
  void initState() {
    super.initState();
    ToastManager.instance.setDefaultPosition(component.position);
    ToastManager.instance.addListener(_onToastsChanged);
  }

  @override
  void dispose() {
    ToastManager.instance.removeListener(_onToastsChanged);
    super.dispose();
  }

  void _onToastsChanged() {
    setState(() {});
  }

  Map<String, String> _getPositionStyles() {
    final offset = '${component.offset}px';

    return switch (component.position) {
      ToastPosition.topLeft => {
          'top': offset,
          'left': offset,
          'align-items': 'flex-start',
          'flex-direction': 'column',
        },
      ToastPosition.topCenter => {
          'top': offset,
          'left': '50%',
          'transform': 'translateX(-50%)',
          'align-items': 'center',
          'flex-direction': 'column',
        },
      ToastPosition.topRight => {
          'top': offset,
          'right': offset,
          'align-items': 'flex-end',
          'flex-direction': 'column',
        },
      ToastPosition.bottomLeft => {
          'bottom': offset,
          'left': offset,
          'align-items': 'flex-start',
          'flex-direction': 'column-reverse',
        },
      ToastPosition.bottomCenter => {
          'bottom': offset,
          'left': '50%',
          'transform': 'translateX(-50%)',
          'align-items': 'center',
          'flex-direction': 'column-reverse',
        },
      ToastPosition.bottomRight => {
          'bottom': offset,
          'right': offset,
          'align-items': 'flex-end',
          'flex-direction': 'column-reverse',
        },
    };
  }

  @override
  Component build(BuildContext context) {
    final toasts = ToastManager.instance.toasts.take(component.maxVisible);

    return div(
      classes: 'arcane-toaster',
      attributes: {
        'role': 'region',
        'aria-label': 'Notifications',
        'data-position': component.position.name,
      },
      styles: Styles(raw: {
        'position': 'fixed',
        'z-index': ArcaneZIndex.toast,
        'display': 'flex',
        'gap': '${component.gap}px',
        'pointer-events': 'none',
        'max-height': 'calc(100vh - 40px)',
        'overflow': 'visible',
        ..._getPositionStyles(),
      }),
      [
        for (final data in toasts)
          ArcaneToast(
            key: ValueKey(data.id),
            id: data.id,
            message: data.message,
            title: data.title,
            description: data.description,
            variant: data.variant,
            duration: data.duration,
            dismissible: data.dismissible,
            action: data.action,
            icon: data.icon,
            position: data.position,
            onClose: () => ToastManager.instance.dismiss(data.id),
          ),
      ],
    );
  }
}

/// Short alias for ArcaneToast
typedef AToast = ArcaneToast;
