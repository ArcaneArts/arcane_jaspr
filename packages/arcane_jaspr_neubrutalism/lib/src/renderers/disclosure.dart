import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/disclosure_props.dart';
import 'package:arcane_jaspr/core/rendering/base/disclosure_render_base.dart';

/// Neubrutalism Disclosure renderer.
class NeubrutalismDisclosure extends DisclosureRenderBase {
  const NeubrutalismDisclosure(super.props, {super.key});

  @override
  String get classPrefix => 'neubrutalism';

  @override
  Map<String, String> containerStyles(DisclosureVariant variant) {
    final (
      String containerBg,
      String containerBorder,
      String? containerClip,
    ) = switch (variant) {
      DisclosureVariant.default_ => ('transparent', 'none', null),
      DisclosureVariant.minimal => ('transparent', 'none', null),
      DisclosureVariant.bordered => (
        'transparent',
        'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
        'none',
      ),
      DisclosureVariant.filled => (
        'var(--nb-paper, var(--card))',
        'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
        'none',
      ),
    };
    return <String, String>{
      'background': containerBg,
      'border': containerBorder,
      'clip-path': ?containerClip,
      'overflow': 'hidden',
    };
  }

  @override
  Map<String, String> summaryStyles(DisclosureVariant variant) {
    final String summaryBg = switch (variant) {
      DisclosureVariant.default_ => 'transparent',
      DisclosureVariant.minimal => 'transparent',
      DisclosureVariant.bordered => 'transparent',
      DisclosureVariant.filled => 'transparent',
    };
    return <String, String>{
      'display': 'flex',
      'align-items': 'center',
      'justify-content': 'space-between',
      'gap': 'var(--space-4)',
      'padding': '0.75rem 1.25rem',
      'background': summaryBg,
      'font-family': 'var(--font-heading)',
      'font-weight': 'var(--font-weight-semibold)',
      'letter-spacing': '0.04em',
      'cursor': 'pointer',
      'transition': 'background 140ms ease',
      'list-style': 'none',
      '-webkit-user-select': 'none',
      'user-select': 'none',
    };
  }

  @override
  Component buildChevron() => const dom.span(
    classes: 'neubrutalism-disclosure-chevron',
    styles: dom.Styles(
      raw: <String, String>{
        'color': 'var(--nb-accent, var(--primary))',
        'font-size': '0.625rem',
        'transition': 'transform 200ms ease',
      },
    ),
    <Component>[Component.text('\u25BC')],
  );

  @override
  (String padding, String border) contentVariant(DisclosureVariant variant) =>
      switch (variant) {
        DisclosureVariant.default_ => (
          '1.25rem',
          'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
        ),
        DisclosureVariant.minimal => ('0.25rem 0 0 0', 'none'),
        DisclosureVariant.bordered => (
          '1.25rem',
          'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
        ),
        DisclosureVariant.filled => (
          '1.25rem',
          'var(--nb-border-thin, 2px) solid var(--nb-line, #000)',
        ),
      };
}

/// Neubrutalism Disclosure Group renderer.
class NeubrutalismDisclosureGroup extends DisclosureGroupRenderBase {
  const NeubrutalismDisclosureGroup(super.props, {super.key});

  @override
  String get classPrefix => 'neubrutalism';

  @override
  Component buildDisclosure(DisclosureProps itemProps) =>
      NeubrutalismDisclosure(itemProps);
}
