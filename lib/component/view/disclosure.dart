import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart'
    hide
        Color,
        Colors,
        ColorScheme,
        Gap,
        Padding,
        TextAlign,
        TextOverflow,
        Border,
        BorderRadius,
        BoxShadow,
        FontWeight;

import '../../util/tokens/tokens.dart';

/// A disclosure widget that uses native HTML details/summary elements.
///
/// Unlike [ArcaneExpander], this component works on static sites without
/// JavaScript because browsers handle the expand/collapse behavior natively.
///
/// Example:
/// ```dart
/// ArcaneDisclosure(
///   summary: ArcaneText('Click to expand'),
///   child: ArcaneText('Hidden content here'),
/// )
/// ```
class ArcaneDisclosure extends StatelessComponent {
  /// The always-visible summary/header content
  final Component summary;

  /// The collapsible content
  final Component child;

  /// Whether initially open
  final bool open;

  /// Visual variant
  final DisclosureVariant variant;

  /// Whether to show the chevron indicator
  final bool showChevron;

  /// Custom CSS class for the container
  final String? classes;

  const ArcaneDisclosure({
    required this.summary,
    required this.child,
    this.open = false,
    this.variant = DisclosureVariant.default_,
    this.showChevron = true,
    this.classes,
    super.key,
  });

  /// Creates a minimal disclosure with no borders or background
  const ArcaneDisclosure.minimal({
    required this.summary,
    required this.child,
    this.open = false,
    this.showChevron = true,
    this.classes,
    super.key,
  }) : variant = DisclosureVariant.minimal;

  /// Creates a bordered disclosure
  const ArcaneDisclosure.bordered({
    required this.summary,
    required this.child,
    this.open = false,
    this.showChevron = true,
    this.classes,
    super.key,
  }) : variant = DisclosureVariant.bordered;

  /// Creates a filled disclosure with background
  const ArcaneDisclosure.filled({
    required this.summary,
    required this.child,
    this.open = false,
    this.showChevron = true,
    this.classes,
    super.key,
  }) : variant = DisclosureVariant.filled;

  @override
  Component build(BuildContext context) {
    final (
      String containerBg,
      String containerBorder,
      String summaryBg,
      String contentBorder,
    ) = switch (variant) {
      DisclosureVariant.default_ => (
          ArcaneColors.transparent,
          'none',
          ArcaneColors.surfaceVariant,
          '1px solid ${ArcaneColors.border}',
        ),
      DisclosureVariant.minimal => (
          ArcaneColors.transparent,
          'none',
          ArcaneColors.transparent,
          'none',
        ),
      DisclosureVariant.bordered => (
          ArcaneColors.transparent,
          '1px solid ${ArcaneColors.border}',
          ArcaneColors.transparent,
          '1px solid ${ArcaneColors.border}',
        ),
      DisclosureVariant.filled => (
          ArcaneColors.surface,
          '1px solid ${ArcaneColors.border}',
          ArcaneColors.surfaceVariant,
          '1px solid ${ArcaneColors.border}',
        ),
    };

    final allClasses = [
      'arcane-disclosure',
      'arcane-disclosure-${variant.name}',
      if (classes != null) classes,
    ].join(' ');

    return Component.element(
      tag: 'details',
      classes: allClasses,
      attributes: {
        if (open) 'open': '',
      },
      styles: Styles(raw: {
        'background-color': containerBg,
        'border': containerBorder,
        'border-radius': ArcaneRadius.lg,
        'overflow': 'hidden',
      }),
      children: [
        // Summary (clickable header)
        Component.element(
          tag: 'summary',
          classes: 'arcane-disclosure-summary',
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'justify-content': 'space-between',
            'gap': ArcaneSpacing.md,
            'padding': '${ArcaneSpacing.sm} ${ArcaneSpacing.md}',
            'background-color': summaryBg,
            'cursor': 'pointer',
            'transition': ArcaneEffects.transitionFast,
            'list-style': 'none',
            '-webkit-user-select': 'none',
            'user-select': 'none',
          }),
          children: [
            Component.element(
              tag: 'span',
              classes: 'arcane-disclosure-summary-content',
              styles: const Styles(raw: {
                'flex': '1',
                'min-width': '0',
              }),
              children: [summary],
            ),
            if (showChevron)
              const Component.element(
                tag: 'span',
                classes: 'arcane-disclosure-chevron',
                styles: Styles(raw: {
                  'color': ArcaneColors.muted,
                  'font-size': ArcaneTypography.fontSm,
                  'transition': ArcaneEffects.transitionFast,
                }),
                children: [Component.text('▼')],
              ),
          ],
        ),
        // Content
        Component.element(
          tag: 'div',
          classes: 'arcane-disclosure-content',
          styles: Styles(raw: {
            'padding': ArcaneSpacing.md,
            'border-top': contentBorder,
          }),
          children: [child],
        ),
      ],
    );
  }

  @css
  static final List<StyleRule> styles = [
    // Hide default browser marker
    css('.arcane-disclosure summary::-webkit-details-marker').styles(raw: {
      'display': 'none',
    }),
    css('.arcane-disclosure summary::marker').styles(raw: {
      'display': 'none',
    }),
    // Rotate chevron when open
    css('.arcane-disclosure[open] .arcane-disclosure-chevron').styles(raw: {
      'transform': 'rotate(180deg)',
    }),
    // Hover effect on summary
    css('.arcane-disclosure summary:hover').styles(raw: {
      'background-color': ArcaneColors.surfaceVariant,
    }),
    // Focus styles for accessibility
    css('.arcane-disclosure summary:focus').styles(raw: {
      'outline': '2px solid ${ArcaneColors.accent}',
      'outline-offset': '-2px',
    }),
    css('.arcane-disclosure summary:focus:not(:focus-visible)').styles(raw: {
      'outline': 'none',
    }),
  ];
}

/// Visual variants for [ArcaneDisclosure]
enum DisclosureVariant {
  /// Default style with subtle summary background
  default_,

  /// Minimal style with no backgrounds or borders
  minimal,

  /// Bordered container
  bordered,

  /// Filled background with border
  filled,
}

/// A group of disclosure widgets where optionally only one can be open at a time.
///
/// Note: The "only one open" behavior requires JavaScript. If running on a
/// static site without JS hydration, all disclosures will be independently
/// controllable (like a regular accordion).
///
/// For guaranteed static-site compatibility with exclusive behavior, consider
/// using separate [ArcaneDisclosure] widgets with `open` set appropriately.
class ArcaneDisclosureGroup extends StatelessComponent {
  /// The disclosure items
  final List<ArcaneDisclosureItem> items;

  /// Gap between items
  final String gap;

  /// Visual variant for all items
  final DisclosureVariant variant;

  /// Index of initially open item (null for all closed)
  final int? initialOpenIndex;

  const ArcaneDisclosureGroup({
    required this.items,
    this.gap = ArcaneSpacing.sm,
    this.variant = DisclosureVariant.default_,
    this.initialOpenIndex,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return Component.element(
      tag: 'div',
      classes: 'arcane-disclosure-group',
      styles: Styles(raw: {
        'display': 'flex',
        'flex-direction': 'column',
        'gap': gap,
      }),
      children: [
        for (var i = 0; i < items.length; i++)
          ArcaneDisclosure(
            summary: items[i].summary,
            child: items[i].content,
            open: i == initialOpenIndex,
            variant: variant,
            showChevron: items[i].showChevron,
          ),
      ],
    );
  }
}

/// An item in an [ArcaneDisclosureGroup]
class ArcaneDisclosureItem {
  /// The summary/header component
  final Component summary;

  /// The collapsible content
  final Component content;

  /// Whether to show the chevron
  final bool showChevron;

  const ArcaneDisclosureItem({
    required this.summary,
    required this.content,
    this.showChevron = true,
  });
}