import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/props/alert_props.dart';
import 'package:arcane_jaspr/core/rendering/base/alert_render_base.dart';

/// Neon Alert renderer (neutralized skeleton).
class NeonAlert extends AlertRenderBase {
  const NeonAlert(super.props, {super.key});

  @override
  Component get defaultIcon => Component.text(switch (props.color) {
    ColorVariant.info => 'i',
    ColorVariant.success => 'ok',
    ColorVariant.warning => '!',
    ColorVariant.destructive => 'x',
    ColorVariant.primary => 'i',
    ColorVariant.secondary => 'i',
  });

  @override
  String get rootClass => 'neon-alert ';

  @override
  Map<String, String> get rootAttributes => <String, String>{
    'role': 'alert',
    'data-variant': props.color.name,
    'data-style': props.variant.name,
  };

  @override
  Map<String, String> get rootLayoutStyles => const <String, String>{};

  @override
  Map<String, String> get containerStyles => const <String, String>{};

  @override
  String get iconClass => 'neon-alert-icon';

  @override
  Map<String, String> get iconStyles => const <String, String>{};

  @override
  String get contentClass => 'neon-alert-content';

  @override
  String get titleClass => 'neon-alert-title';

  @override
  Map<String, String> get titleStyles => const <String, String>{};

  @override
  String get descriptionClass => 'neon-alert-description';

  @override
  Map<String, String> get descriptionStyles => const <String, String>{};

  @override
  String get actionMarginTop => '12px';

  @override
  String get dismissClass => 'neon-alert-dismiss';

  @override
  Map<String, String> get dismissStyles => const <String, String>{};

  @override
  Component get dismissChild => const Component.text('x');
}
