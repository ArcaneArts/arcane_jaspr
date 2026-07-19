import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/disclosure_props.dart';
import 'package:arcane_jaspr/core/rendering/base/disclosure_render_base.dart';

/// ShadCN Disclosure renderer.
///
/// Uses native HTML details/summary elements for static site compatibility.
/// Similar to ShadCN Collapsible but using native browser behavior.
class ShadcnDisclosure extends DisclosureRenderBase {
  const ShadcnDisclosure(super.props, {super.key});

  @override
  String get classPrefix => 'arcane';

  @override
  Map<String, String> containerStyles(DisclosureVariant variant) {
    final (String containerBg, String containerBorder) = switch (variant) {
      DisclosureVariant.default_ => ('transparent', 'none'),
      DisclosureVariant.minimal => ('transparent', 'none'),
      DisclosureVariant.bordered => ('transparent', '1px solid var(--border)'),
      DisclosureVariant.filled => ('var(--card)', '1px solid var(--border)'),
    };
    return <String, String>{
      'background-color': containerBg,
      'border': containerBorder,
      'border-radius': 'var(--radius)',
      'overflow': 'hidden',
    };
  }

  @override
  Map<String, String> summaryStyles(DisclosureVariant variant) {
    final String summaryBg = switch (variant) {
      DisclosureVariant.default_ => 'var(--muted)',
      DisclosureVariant.minimal => 'transparent',
      DisclosureVariant.bordered => 'transparent',
      DisclosureVariant.filled => 'var(--muted)',
    };
    return <String, String>{
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'space-between',
      'gap': 'var(--space-4)',
      'padding': '0.5rem 1rem',
      'background-color': summaryBg,
      'cursor': 'pointer',
      'transition': 'all var(--transition)',
      'list-style': 'none',
      '-webkit-user-select': 'none',
      'user-select': 'none',
    };
  }

  @override
  Component buildChevron() => const dom.span(
    classes: 'arcane-disclosure-chevron',
    styles: dom.Styles(
      raw: <String, String>{
        'color': 'var(--muted-foreground)',
        'font-size': 'var(--font-size-sm)',
        'transition': 'transform var(--transition)',
      },
    ),
    <Component>[Component.text('\u25BC')],
  );

  @override
  (String padding, String border) contentVariant(DisclosureVariant variant) =>
      switch (variant) {
        DisclosureVariant.default_ => ('1rem', '1px solid var(--border)'),
        DisclosureVariant.minimal => ('0.25rem 0 0 0', 'none'),
        DisclosureVariant.bordered => ('1rem', '1px solid var(--border)'),
        DisclosureVariant.filled => ('1rem', '1px solid var(--border)'),
      };
}

/// ShadCN Disclosure Group renderer.
class ShadcnDisclosureGroup extends DisclosureGroupRenderBase {
  const ShadcnDisclosureGroup(super.props, {super.key});

  @override
  String get classPrefix => 'arcane';

  @override
  Component buildDisclosure(DisclosureProps itemProps) =>
      ShadcnDisclosure(itemProps);
}
