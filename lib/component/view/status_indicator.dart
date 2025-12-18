import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Status indicator dot with optional label
class StatusIndicator extends StatelessComponent {
  final String status; // 'online', 'offline', 'busy', 'away'
  final String? label;
  final String size;
  final bool pulse;

  const StatusIndicator({
    required this.status,
    this.label,
    this.size = '10px',
    this.pulse = false,
  });

  String get _color {
    switch (status) {
      case 'online':
        return '#10B981';
      case 'offline':
        return '#71717A';
      case 'busy':
        return '#EF4444';
      case 'away':
        return '#F59E0B';
      default:
        return '#71717A';
    }
  }

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '8px',
      }),
      [
        // Dot
        div(
          styles: Styles(raw: {
            'position': 'relative',
            'width': size,
            'height': size,
            'border-radius': '50%',
            'background': _color,
            'flex-shrink': '0',
          }),
          [
            if (pulse && status == 'online')
              div(
                styles: Styles(raw: {
                  'position': 'absolute',
                  'inset': '-2px',
                  'border-radius': '50%',
                  'background': _color,
                  'opacity': '0.4',
                  'animation': 'pulse 2s infinite',
                }),
                [],
              ),
          ],
        ),
        // Label
        if (label != null)
          span(
            styles: Styles(raw: {
              'font-size': '14px',
              'color': '#A1A1AA',
            }),
            [text(label!)],
          ),
      ],
    );
  }
}

/// Status badge combining status indicator with text
class StatusBadge extends StatelessComponent {
  final String status;
  final String label;

  const StatusBadge({
    required this.status,
    required this.label,
  });

  String get _color {
    switch (status) {
      case 'success':
        return '#10B981';
      case 'error':
        return '#EF4444';
      case 'warning':
        return '#F59E0B';
      case 'info':
        return '#3B82F6';
      default:
        return '#71717A';
    }
  }

  String get _bgColor {
    switch (status) {
      case 'success':
        return 'rgba(16, 185, 129, 0.15)';
      case 'error':
        return 'rgba(239, 68, 68, 0.15)';
      case 'warning':
        return 'rgba(245, 158, 11, 0.15)';
      case 'info':
        return 'rgba(59, 130, 246, 0.15)';
      default:
        return 'rgba(113, 113, 122, 0.15)';
    }
  }

  @override
  Component build(BuildContext context) {
    return span(
      styles: Styles(raw: {
        'display': 'inline-flex',
        'align-items': 'center',
        'gap': '6px',
        'padding': '4px 10px',
        'border-radius': '6px',
        'background': _bgColor,
        'color': _color,
        'font-size': '13px',
        'font-weight': '500',
      }),
      [
        div(
          styles: Styles(raw: {
            'width': '6px',
            'height': '6px',
            'border-radius': '50%',
            'background': _color,
          }),
          [],
        ),
        text(label),
      ],
    );
  }
}
