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
        '1px solid var(--neon-panel-border)',
        'var(--neon-clip-md)',
      ),
      DisclosureVariant.filled => (
        'var(--neon-panel-surface)',
        '1px solid var(--neon-panel-border)',
        'var(--neon-clip-md)',
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
      DisclosureVariant.default_ => 'var(--neon-panel-tint)',
      DisclosureVariant.minimal => 'transparent',
      DisclosureVariant.bordered => 'transparent',
      DisclosureVariant.filled => 'var(--neon-panel-tint)',
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
    classes: 'neon-disclosure-chevron',
    styles: dom.Styles(
      raw: <String, String>{
        'color': 'var(--neon-accent)',
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
          '1px solid color-mix(in srgb, var(--neon-panel-border) 60%, transparent)',
        ),
        DisclosureVariant.minimal => ('0.25rem 0 0 0', 'none'),
        DisclosureVariant.bordered => (
          '1.25rem',
          '1px solid color-mix(in srgb, var(--neon-panel-border) 60%, transparent)',
        ),
        DisclosureVariant.filled => (
          '1.25rem',
          '1px solid color-mix(in srgb, var(--neon-panel-border) 60%, transparent)',
        ),
      };
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
