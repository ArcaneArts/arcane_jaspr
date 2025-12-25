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

  /// Promise-based toast (internal use)
  promise,
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
  /// Button label
  final String label;

  /// Click handler
  final void Function() onPressed;

  /// Optional: makes this a destructive action (red styling)
  final bool destructive;

  const ToastAction({
    required this.label,
    required this.onPressed,
    this.destructive = false,
  });
}

/// Toast data model for the queue
class ToastData {
  /// Unique identifier for this toast
  final String id;

  /// Toast message
  final String message;

  /// Optional title
  final String? title;

  /// Toast variant/type
  final ToastVariant variant;

  /// Custom icon (overrides default)
  final Component? icon;

  /// Optional action button
  final ToastAction? action;

  /// Description text (shown below message)
  final String? description;

  /// Duration in milliseconds (0 = no auto-dismiss)
  final int duration;

  /// Whether this toast can be dismissed
  final bool dismissible;

  /// Callback when toast is dismissed
  final void Function()? onDismiss;

  /// Callback when toast auto-closes
  final void Function()? onAutoClose;

  /// Creation timestamp
  final DateTime createdAt;

  /// Whether this toast is expanded (shows full content)
  final bool expanded;

  ToastData({
    required this.id,
    required this.message,
    this.title,
    this.variant = ToastVariant.info,
    this.icon,
    this.action,
    this.description,
    this.duration = 4000,
    this.dismissible = true,
    this.onDismiss,
    this.onAutoClose,
    this.expanded = false,
  }) : createdAt = DateTime.now();

  ToastData copyWith({
    String? message,
    String? title,
    ToastVariant? variant,
    Component? icon,
    ToastAction? action,
    String? description,
    int? duration,
    bool? dismissible,
    void Function()? onDismiss,
    void Function()? onAutoClose,
    bool? expanded,
  }) {
    return ToastData(
      id: id,
      message: message ?? this.message,
      title: title ?? this.title,
      variant: variant ?? this.variant,
      icon: icon ?? this.icon,
      action: action ?? this.action,
      description: description ?? this.description,
      duration: duration ?? this.duration,
      dismissible: dismissible ?? this.dismissible,
      onDismiss: onDismiss ?? this.onDismiss,
      onAutoClose: onAutoClose ?? this.onAutoClose,
      expanded: expanded ?? this.expanded,
    );
  }
}

/// Global toast state manager (singleton)
class ToastManager {
  static ToastManager? _instance;
  static ToastManager get instance => _instance ??= ToastManager._();

  ToastManager._();

  /// List of active toasts
  final List<ToastData> _toasts = [];

  /// Listeners for toast state changes
  final List<void Function()> _listeners = [];

  /// Maximum number of visible toasts
  int maxVisible = 3;

  /// Get current toasts (most recent first, limited to maxVisible)
  List<ToastData> get toasts => _toasts.take(maxVisible).toList();

  /// Get all toasts including queued ones
  List<ToastData> get allToasts => List.unmodifiable(_toasts);

  /// Add a listener for state changes
  void addListener(void Function() listener) {
    _listeners.add(listener);
  }

  /// Remove a listener
  void removeListener(void Function() listener) {
    _listeners.remove(listener);
  }

  void _notifyListeners() {
    for (final listener in _listeners) {
      listener();
    }
  }

  /// Generate unique ID
  String _generateId() => 'toast_${DateTime.now().millisecondsSinceEpoch}';

  /// Show a toast and return its ID
  String show(ToastData data) {
    _toasts.insert(0, data);
    _notifyListeners();
    return data.id;
  }

  /// Update an existing toast by ID
  void update(String id, ToastData Function(ToastData) updater) {
    final index = _toasts.indexWhere((t) => t.id == id);
    if (index != -1) {
      _toasts[index] = updater(_toasts[index]);
      _notifyListeners();
    }
  }

  /// Dismiss a toast by ID
  void dismiss(String id) {
    final index = _toasts.indexWhere((t) => t.id == id);
    if (index != -1) {
      final toast = _toasts[index];
      toast.onDismiss?.call();
      _toasts.removeAt(index);
      _notifyListeners();
    }
  }

  /// Dismiss all toasts
  void dismissAll() {
    for (final toast in _toasts) {
      toast.onDismiss?.call();
    }
    _toasts.clear();
    _notifyListeners();
  }

  // ============================================================================
  // Convenience methods (Sonner-style API)
  // ============================================================================

  /// Show an info toast
  String info(
    String message, {
    String? title,
    String? description,
    int duration = 4000,
    ToastAction? action,
    Component? icon,
  }) {
    final id = _generateId();
    return show(ToastData(
      id: id,
      message: message,
      title: title,
      description: description,
      variant: ToastVariant.info,
      duration: duration,
      action: action,
      icon: icon,
    ));
  }

  /// Show a success toast
  String success(
    String message, {
    String? title,
    String? description,
    int duration = 4000,
    ToastAction? action,
    Component? icon,
  }) {
    final id = _generateId();
    return show(ToastData(
      id: id,
      message: message,
      title: title,
      description: description,
      variant: ToastVariant.success,
      duration: duration,
      action: action,
      icon: icon,
    ));
  }

  /// Show a warning toast
  String warning(
    String message, {
    String? title,
    String? description,
    int duration = 5000,
    ToastAction? action,
    Component? icon,
  }) {
    final id = _generateId();
    return show(ToastData(
      id: id,
      message: message,
      title: title,
      description: description,
      variant: ToastVariant.warning,
      duration: duration,
      action: action,
      icon: icon,
    ));
  }

  /// Show an error toast
  String error(
    String message, {
    String? title,
    String? description,
    int duration = 6000,
    ToastAction? action,
    Component? icon,
  }) {
    final id = _generateId();
    return show(ToastData(
      id: id,
      message: message,
      title: title,
      description: description,
      variant: ToastVariant.error,
      duration: duration,
      action: action,
      icon: icon,
    ));
  }

  /// Show a loading toast (no auto-dismiss)
  String loading(
    String message, {
    String? title,
    String? description,
  }) {
    final id = _generateId();
    return show(ToastData(
      id: id,
      message: message,
      title: title,
      description: description,
      variant: ToastVariant.loading,
      duration: 0, // No auto-dismiss for loading
      dismissible: false,
    ));
  }

  /// Show a promise-based toast that updates based on async result
  /// Returns the toast ID immediately
  String promise<T>(
    Future<T> promise, {
    required String loading,
    required String Function(T) success,
    required String Function(Object) error,
    String? title,
    int successDuration = 4000,
    int errorDuration = 6000,
  }) {
    final id = this.loading(loading, title: title);

    promise.then((result) {
      update(id, (t) => t.copyWith(
            message: success(result),
            variant: ToastVariant.success,
            duration: successDuration,
            dismissible: true,
          ));
    }).catchError((e) {
      update(id, (t) => t.copyWith(
            message: error(e),
            variant: ToastVariant.error,
            duration: errorDuration,
            dismissible: true,
          ));
    });

    return id;
  }

  /// Show a custom toast
  String custom(
    Component child, {
    int duration = 4000,
    bool dismissible = true,
  }) {
    final id = _generateId();
    return show(ToastData(
      id: id,
      message: '', // Not used for custom
      variant: ToastVariant.info,
      duration: duration,
      dismissible: dismissible,
      icon: child, // Abuse icon field for custom content
    ));
  }
}

/// Global toast function for easy access
/// Usage: toast.success('Saved!'), toast.error('Failed'), etc.
ToastManager get toast => ToastManager.instance;

/// A single toast notification component
class ArcaneToast extends StatefulComponent {
  /// Toast data
  final ToastData data;

  /// Close handler
  final void Function()? onClose;

  const ArcaneToast({
    required this.data,
    this.onClose,
    super.key,
  });

  @override
  State<ArcaneToast> createState() => _ArcaneToastState();

  @css
  static final List<StyleRule> styles = [
    css('@keyframes arcane-toast-in').styles(raw: {
      'from': 'opacity: 0; transform: translateY(-12px) scale(0.95)',
      'to': 'opacity: 1; transform: translateY(0) scale(1)',
    }),
    css('@keyframes arcane-toast-out').styles(raw: {
      'from': 'opacity: 1; transform: translateY(0) scale(1)',
      'to': 'opacity: 0; transform: translateY(-12px) scale(0.95)',
    }),
    css('@keyframes arcane-toast-spin').styles(raw: {
      '0%': 'transform: rotate(0deg)',
      '100%': 'transform: rotate(360deg)',
    }),
    css('@keyframes arcane-toast-progress').styles(raw: {
      'from': 'width: 100%',
      'to': 'width: 0%',
    }),
    css('.arcane-toast-close:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
      'color': ArcaneColors.onSurface,
    }),
    css('.arcane-toast-action:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
  ];
}

class _ArcaneToastState extends State<ArcaneToast> {
  bool _isExiting = false;
  bool _isHovered = false;

  @override
  void initState() {
    super.initState();
    _startDismissTimer();
  }

  void _startDismissTimer() {
    if (component.data.duration > 0) {
      // Auto-dismiss after duration
      Future.delayed(Duration(milliseconds: component.data.duration), () {
        if (mounted && !_isHovered) {
          _dismiss();
        }
      });
    }
  }

  void _dismiss() {
    if (_isExiting) return;
    setState(() => _isExiting = true);

    // Wait for exit animation
    Future.delayed(const Duration(milliseconds: 200), () {
      component.data.onAutoClose?.call();
      component.onClose?.call();
    });
  }

  @override
  Component build(BuildContext context) {
    final data = component.data;

    final (String borderColor, String iconColor, String defaultIcon) =
        switch (data.variant) {
      ToastVariant.info => (
          ArcaneColors.border,
          ArcaneColors.accent,
          '○',
        ),
      ToastVariant.success => (
          ArcaneColors.success,
          ArcaneColors.success,
          '✓',
        ),
      ToastVariant.warning => (
          ArcaneColors.warning,
          ArcaneColors.warning,
          '⚠',
        ),
      ToastVariant.error => (
          ArcaneColors.error,
          ArcaneColors.error,
          '✕',
        ),
      ToastVariant.loading => (
          ArcaneColors.accent,
          ArcaneColors.accent,
          '◌',
        ),
      ToastVariant.promise => (
          ArcaneColors.accent,
          ArcaneColors.accent,
          '◌',
        ),
    };

    final isLoading = data.variant == ToastVariant.loading;

    return div(
      classes:
          'arcane-toast arcane-toast-${data.variant.name} ${_isExiting ? "arcane-toast-exit" : ""}',
      attributes: {
        'role': 'alert',
        'aria-live': 'polite',
        'data-toast-id': data.id,
      },
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'flex-start',
        'gap': ArcaneSpacing.sm,
        'padding': ArcaneSpacing.md,
        'background-color': ArcaneColors.surface,
        'border': '1px solid $borderColor',
        'border-radius': ArcaneRadius.lg,
        'box-shadow': ArcaneEffects.shadowLg,
        'min-width': '320px',
        'max-width': '420px',
        'animation': _isExiting
            ? 'arcane-toast-out 200ms ease forwards'
            : 'arcane-toast-in 300ms cubic-bezier(0.21, 1.02, 0.73, 1) forwards',
        'pointer-events': 'auto',
        'position': 'relative',
        'overflow': 'hidden',
      }),
      events: {
        'mouseenter': (e) => setState(() => _isHovered = true),
        'mouseleave': (e) {
          setState(() => _isHovered = false);
          if (data.duration > 0) {
            _startDismissTimer();
          }
        },
      },
      [
        // Icon
        div(
          classes: 'arcane-toast-icon',
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'center',
            'width': '20px',
            'height': '20px',
            'font-size': '16px',
            'color': iconColor,
            'flex-shrink': '0',
            if (isLoading) 'animation': 'arcane-toast-spin 1s linear infinite',
          }),
          [data.icon ?? text(defaultIcon)],
        ),

        // Content
        div(
          classes: 'arcane-toast-content',
          styles: const Styles(raw: {
            'flex': '1',
            'min-width': '0',
          }),
          [
            // Title
            if (data.title != null)
              div(
                classes: 'arcane-toast-title',
                styles: const Styles(raw: {
                  'font-weight': ArcaneTypography.weightSemibold,
                  'color': ArcaneColors.onSurface,
                  'font-size': ArcaneTypography.fontMd,
                  'line-height': '1.4',
                }),
                [text(data.title!)],
              ),

            // Message
            div(
              classes: 'arcane-toast-message',
              styles: Styles(raw: {
                'font-size': ArcaneTypography.fontSm,
                'color': data.title != null
                    ? ArcaneColors.muted
                    : ArcaneColors.onSurface,
                'line-height': '1.5',
                if (data.title != null) 'margin-top': '2px',
              }),
              [text(data.message)],
            ),

            // Description
            if (data.description != null)
              div(
                classes: 'arcane-toast-description',
                styles: const Styles(raw: {
                  'font-size': ArcaneTypography.fontSm,
                  'color': ArcaneColors.muted,
                  'line-height': '1.5',
                  'margin-top': ArcaneSpacing.xs,
                }),
                [text(data.description!)],
              ),

            // Action button
            if (data.action != null)
              div(
                styles: const Styles(raw: {
                  'margin-top': ArcaneSpacing.sm,
                }),
                [
                  button(
                    classes: 'arcane-toast-action',
                    attributes: {'type': 'button'},
                    styles: Styles(raw: {
                      'display': 'inline-flex',
                      'align-items': 'center',
                      'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
                      'font-size': ArcaneTypography.fontSm,
                      'font-weight': ArcaneTypography.weightMedium,
                      'color': data.action!.destructive
                          ? ArcaneColors.error
                          : ArcaneColors.accent,
                      'background': ArcaneColors.transparent,
                      'border': 'none',
                      'border-radius': ArcaneRadius.sm,
                      'cursor': 'pointer',
                      'transition': ArcaneEffects.transitionFast,
                    }),
                    events: {
                      'click': (e) => data.action!.onPressed(),
                    },
                    [text(data.action!.label)],
                  ),
                ],
              ),
          ],
        ),

        // Close button
        if (data.dismissible)
          button(
            classes: 'arcane-toast-close',
            attributes: {'type': 'button', 'aria-label': 'Close notification'},
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': '24px',
              'height': '24px',
              'border-radius': ArcaneRadius.sm,
              'background': ArcaneColors.transparent,
              'border': 'none',
              'color': ArcaneColors.muted,
              'cursor': 'pointer',
              'transition': ArcaneEffects.transitionFast,
              'flex-shrink': '0',
              'margin-left': ArcaneSpacing.xs,
            }),
            events: {
              'click': (event) {
                data.onDismiss?.call();
                component.onClose?.call();
              },
            },
            [text('×')],
          ),

        // Progress bar (for auto-dismiss)
        if (data.duration > 0 && !_isHovered)
          div(
            classes: 'arcane-toast-progress',
            styles: Styles(raw: {
              'position': 'absolute',
              'bottom': '0',
              'left': '0',
              'height': '2px',
              'background': iconColor,
              'opacity': '0.3',
              'animation':
                  'arcane-toast-progress ${data.duration}ms linear forwards',
            }),
            [],
          ),
      ],
    );
  }
}

/// The Toaster component - renders all active toasts
/// Place this once at the root of your app
class ArcaneToaster extends StatefulComponent {
  /// Position of the toast container
  final ToastPosition position;

  /// Gap between toasts
  final double gap;

  /// Maximum number of visible toasts
  final int maxVisible;

  /// Whether to show expand button when toasts are stacked
  final bool expandable;

  /// Custom offset from edges
  final double offset;

  const ArcaneToaster({
    this.position = ToastPosition.bottomRight,
    this.gap = 8,
    this.maxVisible = 3,
    this.expandable = true,
    this.offset = 16,
    super.key,
  });

  @override
  State<ArcaneToaster> createState() => _ArcaneToasterState();

  @css
  static final List<StyleRule> styles = [
    css('.arcane-toaster-expand:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
      'color': ArcaneColors.onSurface,
    }),
  ];
}

class _ArcaneToasterState extends State<ArcaneToaster> {
  bool _expanded = false;

  @override
  void initState() {
    super.initState();
    ToastManager.instance.maxVisible = component.maxVisible;
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

  @override
  Component build(BuildContext context) {
    final toasts = _expanded
        ? ToastManager.instance.allToasts
        : ToastManager.instance.toasts;

    final position = component.position;
    final offset = '${component.offset}px';
    final hasMore = ToastManager.instance.allToasts.length >
        ToastManager.instance.maxVisible;

    final Map<String, String> positionStyles = switch (position) {
      ToastPosition.topLeft => {
          'top': offset,
          'left': offset,
          'align-items': 'flex-start',
        },
      ToastPosition.topCenter => {
          'top': offset,
          'left': '50%',
          'transform': 'translateX(-50%)',
          'align-items': 'center',
        },
      ToastPosition.topRight => {
          'top': offset,
          'right': offset,
          'align-items': 'flex-end',
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

    return div(
      classes: 'arcane-toaster',
      attributes: {
        'aria-live': 'polite',
        'aria-label': 'Notifications',
      },
      styles: Styles(raw: {
        'position': 'fixed',
        'z-index': '9999',
        'display': 'flex',
        'flex-direction': 'column',
        'gap': '${component.gap}px',
        'pointer-events': 'none',
        'max-height': 'calc(100vh - 32px)',
        'overflow': 'visible',
        ...positionStyles,
      }),
      [
        // Toast items
        for (var i = 0; i < toasts.length; i++)
          div(
            styles: Styles(raw: {
              'transition': 'all 200ms ease',
              if (!_expanded && i > 0)
                'transform': 'scale(${1 - (i * 0.05)}) translateY(${i * -8}px)',
              if (!_expanded && i > 0) 'opacity': '${1 - (i * 0.15)}',
            }),
            [
              ArcaneToast(
                key: ValueKey(toasts[i].id),
                data: toasts[i],
                onClose: () => ToastManager.instance.dismiss(toasts[i].id),
              ),
            ],
          ),

        // Expand/collapse button when there are more toasts
        if (hasMore && component.expandable)
          button(
            classes: 'arcane-toaster-expand',
            attributes: {'type': 'button'},
            styles: const Styles(raw: {
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'padding': '${ArcaneSpacing.xs} ${ArcaneSpacing.sm}',
              'margin-top': ArcaneSpacing.xs,
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
              'background': ArcaneColors.surface,
              'border': '1px solid ${ArcaneColors.border}',
              'border-radius': ArcaneRadius.md,
              'cursor': 'pointer',
              'pointer-events': 'auto',
              'transition': ArcaneEffects.transitionFast,
            }),
            events: {
              'click': (e) => setState(() => _expanded = !_expanded),
            },
            [
              text(_expanded
                  ? 'Collapse'
                  : '+${ToastManager.instance.allToasts.length - ToastManager.instance.maxVisible} more'),
            ],
          ),
      ],
    );
  }
}

