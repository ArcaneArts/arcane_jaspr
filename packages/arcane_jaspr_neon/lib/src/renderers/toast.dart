import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/toast_props.dart';
import 'package:arcane_jaspr/core/rendering/base/toast_render_base.dart';

/// Neon Toast renderer (neutralized skeleton).
class NeonToast extends ToastRenderBase {
  const NeonToast(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

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
  String get dismissClasses => 'neon-toast-dismiss';

  @override
  Map<String, String> get dismissStyles => const <String, String>{};
}

/// Neon Toast Container renderer (neutralized skeleton).
class NeonToastContainer extends ToastContainerRenderBase {
  const NeonToastContainer(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  Component buildToast(ToastProps toast) => NeonToast(toast);
}
