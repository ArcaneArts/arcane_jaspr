import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/avatar_props.dart';
import 'package:arcane_jaspr/core/rendering/base/avatar_render_base.dart';

/// ShadCN Avatar renderer.
///
/// Outputs the exact HTML structure and CSS from ui.shadcn.com.
/// Reference: https://ui.shadcn.com/docs/components/avatar
class ShadcnAvatar extends AvatarRenderBase {
  const ShadcnAvatar(super.props, {super.key});

  @override
  String get rootClass => 'arcane-avatar';

  @override
  String get statusClass => 'arcane-avatar-status';

  // ShadCN Avatar sizes (default h-10 w-10 = 40px): (dimension, fontSize, statusSize)
  (String, String, String) _sizes(AvatarSize size) => switch (size) {
    AvatarSize.xs => ('24px', '10px', '8px'),
    AvatarSize.sm => ('32px', '12px', '10px'),
    AvatarSize.md => ('40px', '14px', '12px'), // ShadCN default
    AvatarSize.lg => ('56px', '18px', '14px'),
    AvatarSize.xl => ('80px', '24px', '18px'),
  };

  // Shape-specific border radius
  String _borderRadius(AvatarShape shape) => switch (shape) {
    AvatarShape.circle => '50%',
    AvatarShape.rounded => '0.5rem', // rounded-md
    AvatarShape.square => '0', // rounded-none
  };

  // ShadCN: relative flex h-10 w-10 shrink-0 overflow-hidden rounded-full
  @override
  Map<String, String> rootStyles(AvatarProps props) {
    final (dimension, _, _) = _sizes(props.size);
    final borderRadius = _borderRadius(props.shape);
    return <String, String>{
      'position': 'relative',
      'display': 'inline-flex',
      'align-items': 'center',
      'justify-content': 'center',
      'flex-shrink': '0',
      'overflow': 'hidden',
      'width': dimension,
      'height': dimension,
      'border-radius': borderRadius,
      if (props.borderColor != null) 'border': '2px solid ${props.borderColor}',
      if (props.onTap != null) 'cursor': 'pointer',
    };
  }

  @override
  Map<String, String> statusStyles(AvatarProps props) {
    final (_, _, statusSize) = _sizes(props.size);
    return <String, String>{
      'position': 'absolute',
      'bottom': '0',
      'right': '0',
      'width': statusSize,
      'height': statusSize,
      'border-radius': '50%',
      'background-color': props.statusColor ?? 'var(--success, #22c55e)',
      'border': '2px solid var(--background)',
    };
  }

  @override
  Component buildBody(AvatarProps props) {
    final (_, fontSize, _) = _sizes(props.size);
    final borderRadius = _borderRadius(props.shape);

    // Image or fallback
    if (props.imageUrl != null) {
      // ShadCN AvatarImage: aspect-square h-full w-full
      return dom.img(
        classes: 'arcane-avatar-image',
        src: props.imageUrl!,
        alt: props.initials ?? 'Avatar',
        styles: const dom.Styles(
          raw: {
            'aspect-ratio': '1',
            'height': '100%',
            'width': '100%',
            'object-fit': 'cover',
          },
        ),
      );
    }

    // ShadCN AvatarFallback: flex h-full w-full items-center justify-center rounded-full bg-muted
    return dom.div(
      classes: 'arcane-avatar-fallback',
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'height': '100%',
          'width': '100%',
          'align-items': 'center',
          'justify-content': 'center',
          'border-radius': borderRadius,
          'background-color': 'var(--muted)',
          'color': 'var(--muted-foreground)',
          'font-weight': 'var(--font-weight-medium)',
          'font-size': fontSize,
          'text-transform': 'uppercase',
        },
      ),
      [if (props.initials != null) Component.text(props.initials!)],
    );
  }
}
