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
      const <String, String>{};

  @override
  Component buildChevron() => const dom.span(
    classes: 'neon-disclosure-chevron',
    <Component>[Component.text('▼')],
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
