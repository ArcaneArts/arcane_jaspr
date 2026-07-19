import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/avatar_props.dart';
import 'package:arcane_jaspr/core/rendering/base/avatar_render_base.dart';

/// Neon Avatar renderer (neutralized skeleton).
class NeonAvatar extends AvatarRenderBase {
  const NeonAvatar(super.props, {super.key});

  @override
  String get rootClass => 'neon-avatar';

  @override
  String get statusClass => 'neon-avatar-status';

  @override
  Map<String, String> rootStyles(AvatarProps props) => const <String, String>{};

  @override
  Map<String, String> statusStyles(AvatarProps props) =>
      const <String, String>{};

  @override
  Component buildBody(AvatarProps props) {
    final List<Component> children = <Component>[];

    if (props.imageUrl != null) {
      children.add(
        dom.img(
          src: props.imageUrl!,
          attributes: <String, String>{'alt': props.initials ?? 'Avatar'},
          styles: const dom.Styles(
            raw: <String, String>{
              'width': '100%',
              'height': '100%',
              'object-fit': 'cover',
            },
          ),
        ),
      );
    } else if (props.initials != null) {
      children.add(dom.span(<Component>[Component.text(props.initials!)]));
    } else {
      children.add(const dom.span(<Component>[Component.text('?')]));
    }

    return dom.div(
      classes: 'neon-avatar-inner',
      styles: const dom.Styles(
        raw: <String, String>{
          'width': '100%',
          'height': '100%',
          'display': 'flex',
          'align-items': 'center',
          'justify-content': 'center',
          'overflow': 'hidden',
        },
      ),
      children,
    );
  }
}
