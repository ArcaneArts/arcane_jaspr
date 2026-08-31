import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/disclosure_props.dart';
import 'package:arcane_jaspr/core/rendering/base/disclosure_render_base.dart';

/// Neon Disclosure renderer.
class NeonDisclosure extends DisclosureRenderBase {
  const NeonDisclosure(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  Map<String, String> containerStyles(DisclosureVariant variant) =>
      const <String, String>{};

  @override
  Map<String, String> summaryStyles(DisclosureVariant variant) =>
      const <String, String>{
        'display': 'flex',
        'align-items': 'center',
        'justify-content': 'space-between',
        'gap': 'var(--space-4)',
        'cursor': 'pointer',
        'list-style': 'none',
        '-webkit-user-select': 'none',
        'user-select': 'none',
      };

  @override
  Component buildChevron() => const Component.element(
    tag: 'span',
    classes: 'neon-disclosure-chevron',
    attributes: <String, String>{'aria-hidden': 'true'},
    styles: dom.Styles(
      raw: <String, String>{
        'display': 'inline-block',
        'flex': '0 0 auto',
        'font-size': '1rem',
        'font-weight': '400',
        'line-height': '1',
        'transform-origin': 'center',
      },
    ),
    children: <Component>[Component.text('+')],
  );

  @override
  (String padding, String border) contentVariant(DisclosureVariant variant) =>
      ('0', 'none');
}

/// Neon Disclosure Group renderer.
class NeonDisclosureGroup extends DisclosureGroupRenderBase {
  const NeonDisclosureGroup(super.props, {super.key});

  @override
  String get classPrefix => 'neon';

  @override
  Component buildDisclosure(DisclosureProps itemProps) =>
      NeonDisclosure(itemProps);
}
