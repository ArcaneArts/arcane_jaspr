import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/disclosure_props.dart';
import 'package:arcane_jaspr/core/rendering/base/disclosure_render_base.dart';

/// Win95 Disclosure renderer.
class Win95Disclosure extends DisclosureRenderBase {
  const Win95Disclosure(super.props, {super.key});

  @override
  String get classPrefix => 'win95';

  @override
  Map<String, String> containerStyles(DisclosureVariant variant) =>
      const <String, String>{};

  @override
  Map<String, String> summaryStyles(DisclosureVariant variant) =>
      const <String, String>{};

  @override
  Component buildChevron() => const dom.span(
    classes: 'win95-disclosure-chevron',
    <Component>[Component.text('▼')],
  );

  @override
  (String padding, String border) contentVariant(DisclosureVariant variant) =>
      ('0', 'none');
}

/// Win95 Disclosure Group renderer.
class Win95DisclosureGroup extends DisclosureGroupRenderBase {
  const Win95DisclosureGroup(super.props, {super.key});

  @override
  String get classPrefix => 'win95';

  @override
  Component buildDisclosure(DisclosureProps itemProps) =>
      Win95Disclosure(itemProps);
}
