import 'package:arcane_jaspr/core/rendering/base/drawer_render_base.dart';

/// Neon Drawer renderer.
///
/// Implements the Neon design language:
/// - Glass effect with backdrop blur
/// - Subtle accent glow on border
/// - OLED-optimized dark background
class NeonDrawer extends DrawerRenderBase {
  const NeonDrawer(super.props, {super.key});

  @override
  String get themePrefix => 'neon';

  @override
  String get positionBorder => '1px solid var(--neon-panel-border-hot)';

  @override
  Map<String, String> get overlayBackdropStyles => <String, String>{
    'background-color':
        'color-mix(in srgb, var(--neon-surface-0) 78%, transparent)',
    'backdrop-filter': 'blur(8px) saturate(1.1)',
    '-webkit-backdrop-filter': 'blur(8px) saturate(1.1)',
  };

  @override
  Map<String, String> get panelDecorationStyles => <String, String>{
    'background':
        'var(--neon-panel-tint), color-mix(in srgb, var(--neon-panel-surface) 94%, transparent)',
    'backdrop-filter': 'blur(20px) saturate(1.2)',
    '-webkit-backdrop-filter': 'blur(20px) saturate(1.2)',
    'box-shadow': 'var(--neon-shadow-lg), var(--neon-glow-md)',
    'overflow': 'hidden',
  };

  @override
  String get headerFooterBorder => '1px solid var(--neon-panel-border)';

  @override
  Map<String, String> get closeButtonStyles => <String, String>{
    'width': '32px',
    'height': '32px',
    'display': 'flex',
    'align-items': 'center',
    'justify-content': 'center',
    'background': 'transparent',
    'border': 'none',
    'border-radius': 'var(--neon-radius-control)',
    'color': 'var(--muted-foreground)',
    'cursor': 'pointer',
    'transition': 'color 0.15s ease, background 0.15s ease',
  };

  static int _autoCounter = 0;

  @override
  String generateAutoId() {
    _autoCounter++;
    return 'neon-drawer-$_autoCounter';
  }
}
