import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Social media icon link
class ArcaneSocialIcon extends StatelessComponent {
  final String platform; // 'twitter', 'github', 'discord', 'youtube', 'linkedin'
  final String? url;
  final String size;
  final String? color;

  const ArcaneSocialIcon({
    required this.platform,
    this.url,
    this.size = '24px',
    this.color,
  });

  String get _icon {
    switch (platform) {
      case 'twitter':
        return '𝕏';
      case 'github':
        return '⌘';
      case 'discord':
        return '💬';
      case 'youtube':
        return '▶';
      case 'linkedin':
        return 'in';
      case 'instagram':
        return '📷';
      case 'facebook':
        return 'f';
      default:
        return '•';
    }
  }

  @override
  Component build(BuildContext context) {
    final iconColor = color ?? '#A1A1AA';

    final content = div(
      styles: Styles(raw: {
        'width': size,
        'height': size,
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'center',
        'border-radius': '8px',
        'background': 'rgba(63, 63, 70, 0.3)',
        'color': iconColor,
        'font-size': 'calc($size * 0.5)',
        'font-weight': '600',
        'transition': 'all 0.2s ease',
        'cursor': 'pointer',
      }),
      [text(_icon)],
    );

    if (url != null) {
      return a(
        href: url!,
        attributes: {'target': '_blank', 'rel': 'noopener noreferrer'},
        styles: Styles(raw: {'text-decoration': 'none'}),
        [content],
      );
    } else {
      return content;
    }
  }
}

/// Group of social icons
class ArcaneSocialIconGroup extends StatelessComponent {
  final List<ArcaneSocialIcon> icons;
  final String gap;

  const ArcaneSocialIconGroup({
    required this.icons,
    this.gap = '12px',
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
        'gap': gap,
      }),
      icons,
    );
  }
}
