import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' hide Color, Colors, ColorScheme, Gap, Padding, TextAlign, TextOverflow, Border, BorderRadius, BoxShadow, FontWeight;
import '../../util/tools/styles.dart';

/// Avatar component for displaying user images or initials
class ArcaneAvatar extends StatelessComponent {
  final String? imageUrl;
  final String? initials;
  final String size;
  final String? borderColor;
  final bool showStatus;
  final String statusColor;

  const ArcaneAvatar({
    this.imageUrl,
    this.initials,
    this.size = '48px',
    this.borderColor,
    this.showStatus = false,
    this.statusColor = '#10B981',
  });

  @override
  Component build(BuildContext context) {
    return div(
      styles: Styles(raw: {
        'position': 'relative',
        'display': 'inline-flex',
        'align-items': 'center',
        'justify-content': 'center',
        'width': size,
        'height': size,
        'border-radius': '50%',
        'overflow': 'hidden',
        'background': imageUrl != null
            ? 'url($imageUrl) center/cover no-repeat'
            : 'linear-gradient(135deg, #6366F1 0%, #8B5CF6 100%)',
        'border': borderColor != null ? '2px solid $borderColor' : 'none',
        'color': '#FFFFFF',
        'font-weight': '600',
        'font-size': 'calc($size / 2.5)',
        'flex-shrink': '0',
      }),
      [
        if (imageUrl == null && initials != null) text(initials!),
        if (showStatus)
          div(
            styles: Styles(raw: {
              'position': 'absolute',
              'bottom': '0',
              'right': '0',
              'width': 'calc($size / 4)',
              'height': 'calc($size / 4)',
              'border-radius': '50%',
              'background': statusColor,
              'border': '2px solid #0A0A0B',
            }),
            [],
          ),
      ],
    );
  }
}

/// Avatar group for stacking multiple avatars
class AvatarGroup extends StatelessComponent {
  final List<ArcaneAvatar> avatars;
  final int maxVisible;
  final String size;

  const AvatarGroup({
    required this.avatars,
    this.maxVisible = 4,
    this.size = '40px',
  });

  @override
  Component build(BuildContext context) {
    final visible = avatars.take(maxVisible).toList();
    final overflow = avatars.length - maxVisible;

    return div(
      styles: Styles(raw: {
        'display': 'flex',
        'align-items': 'center',
      }),
      [
        for (var i = 0; i < visible.length; i++)
          div(
            styles: Styles(raw: {
              'margin-left': i > 0 ? '-12px' : '0',
              'position': 'relative',
              'z-index': '${visible.length - i}',
            }),
            [visible[i]],
          ),
        if (overflow > 0)
          div(
            styles: Styles(raw: {
              'margin-left': '-12px',
              'display': 'flex',
              'align-items': 'center',
              'justify-content': 'center',
              'width': size,
              'height': size,
              'border-radius': '50%',
              'background': '#27272A',
              'border': '2px solid #0A0A0B',
              'color': '#A1A1AA',
              'font-size': '12px',
              'font-weight': '500',
            }),
            [text('+$overflow')],
          ),
      ],
    );
  }
}
