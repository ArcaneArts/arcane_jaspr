import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/toast_props.dart';
import 'package:arcane_jaspr/core/rendering/base/toast_render_base.dart';

/// Win95 Toast renderer (neutralized skeleton).
class Win95Toast extends ToastRenderBase {
  const Win95Toast(super.props, {super.key});

  @override
  String get classPrefix => 'win95';

  @override
  String get loadingAccent => 'var(--foreground)';

  @override
  Map<String, String> get rootAttributes => const <String, String>{};

  @override
  Map<String, String> rootBaseStyles(String accentVar) =>
      const <String, String>{};

  @override
  Map<String, String> actionStyles() => const <String, String>{};

  @override
  String get dismissClasses => 'win95-toast-dismiss';

  @override
  Map<String, String> get dismissStyles => const <String, String>{};
}

/// Win95 Toast Container renderer (neutralized skeleton).
class Win95ToastContainer extends ToastContainerRenderBase {
  const Win95ToastContainer(super.props, {super.key});

  @override
  String get classPrefix => 'win95';

  @override
  Component buildToast(ToastProps toast) => Win95Toast(toast);
}
