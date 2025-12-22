import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Demo builders for style reference section
class StyleDemos {
  /// Display & Layout demos
  static List<Component> display() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Display.flex', [
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  display: Display.flex,
                  gap: Gap.sm,
                  padding: PaddingPreset.md,
                  background: Background.surface,
                  borderRadius: Radius.md,
                ),
                children: [
                  _colorBox('1'),
                  _colorBox('2'),
                  _colorBox('3'),
                ],
              ),
            ]),
            _buildStyleDemo('Display.grid (3 columns)', [
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  display: Display.grid,
                  raw: {'grid-template-columns': 'repeat(3, 1fr)'},
                  gap: Gap.sm,
                  padding: PaddingPreset.md,
                  background: Background.surface,
                  borderRadius: Radius.md,
                ),
                children: [
                  for (int i = 1; i <= 6; i++) _colorBox('$i'),
                ],
              ),
            ]),
            _buildStyleDemo('FlexDirection comparison', [
              ArcaneRow(
                gapSize: Gap.lg,
                children: [
                  ArcaneColumn(
                    gapSize: Gap.xs,
                    children: [
                      ArcaneText('row', size: FontSize.xs, color: TextColor.muted),
                      ArcaneDiv(
                        styles: const ArcaneStyleData(
                          display: Display.flex,
                          flexDirection: FlexDirection.row,
                          gap: Gap.xs,
                          padding: PaddingPreset.sm,
                          background: Background.surface,
                          borderRadius: Radius.sm,
                        ),
                        children: [_smallBox(), _smallBox(), _smallBox()],
                      ),
                    ],
                  ),
                  ArcaneColumn(
                    gapSize: Gap.xs,
                    children: [
                      ArcaneText('column', size: FontSize.xs, color: TextColor.muted),
                      ArcaneDiv(
                        styles: const ArcaneStyleData(
                          display: Display.flex,
                          flexDirection: FlexDirection.column,
                          gap: Gap.xs,
                          padding: PaddingPreset.sm,
                          background: Background.surface,
                          borderRadius: Radius.sm,
                        ),
                        children: [_smallBox(), _smallBox(), _smallBox()],
                      ),
                    ],
                  ),
                ],
              ),
            ]),
          ],
        ),
      ];

  /// Spacing demos - gap, padding, margin
  static List<Component> spacing() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Gap sizes', [
              ArcaneColumn(
                gapSize: Gap.md,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final gap in [
                    ('Gap.xs', Gap.xs),
                    ('Gap.sm', Gap.sm),
                    ('Gap.md', Gap.md),
                    ('Gap.lg', Gap.lg),
                    ('Gap.xl', Gap.xl),
                  ])
                    ArcaneRow(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ArcaneDiv(
                          styles: const ArcaneStyleData(widthCustom: '80px'),
                          children: [ArcaneText(gap.$1, size: FontSize.xs, color: TextColor.muted)],
                        ),
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            display: Display.flex,
                            gap: gap.$2,
                            padding: PaddingPreset.sm,
                            background: Background.surface,
                            borderRadius: Radius.sm,
                          ),
                          children: [_smallBox(), _smallBox(), _smallBox()],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Padding presets', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final preset in [
                    ('sm', PaddingPreset.sm),
                    ('md', PaddingPreset.md),
                    ('lg', PaddingPreset.lg),
                    ('xl', PaddingPreset.xl),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneText(preset.$1, size: FontSize.xs, color: TextColor.muted),
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            padding: preset.$2,
                            background: Background.surface,
                            borderRadius: Radius.sm,
                            border: BorderPreset.standard,
                          ),
                          children: [
                            ArcaneDiv(
                              styles: const ArcaneStyleData(
                                widthCustom: '40px',
                                heightCustom: '20px',
                                background: Background.accent,
                                borderRadius: Radius.xs,
                              ),
                              children: [],
                            ),
                          ],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  /// Typography demos
  static List<Component> typography() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Font sizes', [
              ArcaneColumn(
                gapSize: Gap.sm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ArcaneText('FontSize.xs - Extra small text', size: FontSize.xs),
                  ArcaneText('FontSize.sm - Small text', size: FontSize.sm),
                  ArcaneText('FontSize.base - Base text', size: FontSize.base),
                  ArcaneText('FontSize.lg - Large text', size: FontSize.lg),
                  ArcaneText('FontSize.xl - Extra large text', size: FontSize.xl),
                  ArcaneText('FontSize.xl2 - 2XL text', size: FontSize.xl2),
                  ArcaneText('FontSize.xl3 - 3XL text', size: FontSize.xl3),
                ],
              ),
            ]),
            _buildStyleDemo('Font weights', [
              ArcaneRow(
                gapSize: Gap.lg,
                children: [
                  ArcaneText('Normal', weight: FontWeight.normal),
                  ArcaneText('Medium', weight: FontWeight.w500),
                  ArcaneText('Semibold', weight: FontWeight.w600),
                  ArcaneText('Bold', weight: FontWeight.bold),
                ],
              ),
            ]),
            _buildStyleDemo('Text colors', [
              ArcaneRow(
                gapSize: Gap.lg,
                children: [
                  ArcaneText('Primary', color: TextColor.primary),
                  ArcaneText('Muted', color: TextColor.muted),
                  ArcaneText('Accent', color: TextColor.accent),
                  ArcaneText('Success', color: TextColor.success),
                  ArcaneText('Warning', color: TextColor.warning),
                  ArcaneText('Error', color: TextColor.error),
                ],
              ),
            ]),
          ],
        ),
      ];

  /// Color demos
  static List<Component> colors() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Background colors', [
              ArcaneRow(
                gapSize: Gap.sm,
                children: [
                  for (final bg in [
                    ('surface', Background.surface),
                    ('surfaceVariant', Background.surfaceVariant),
                    ('accent', Background.accent),
                    ('success', Background.success),
                    ('warning', Background.warning),
                    ('error', Background.error),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '60px',
                            heightCustom: '40px',
                            background: bg.$2,
                            borderRadius: Radius.sm,
                            border: BorderPreset.subtle,
                          ),
                          children: [],
                        ),
                        ArcaneText(bg.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Text color swatches', [
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  padding: PaddingPreset.md,
                  background: Background.surface,
                  borderRadius: Radius.md,
                ),
                children: [
                  ArcaneRow(
                    gapSize: Gap.lg,
                    children: [
                      _textSwatch('primary', TextColor.primary),
                      _textSwatch('muted', TextColor.muted),
                      _textSwatch('accent', TextColor.accent),
                      _textSwatch('success', TextColor.success),
                      _textSwatch('error', TextColor.error),
                    ],
                  ),
                ],
              ),
            ]),
          ],
        ),
      ];

  /// Border demos
  static List<Component> borders() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Border presets', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final border in [
                    ('standard', BorderPreset.standard),
                    ('subtle', BorderPreset.subtle),
                    ('accent', BorderPreset.accent),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '80px',
                            heightCustom: '50px',
                            background: Background.surface,
                            borderRadius: Radius.md,
                            border: border.$2,
                          ),
                          children: [],
                        ),
                        ArcaneText(border.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Border radius', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final radius in [
                    ('xs', Radius.xs),
                    ('sm', Radius.sm),
                    ('md', Radius.md),
                    ('lg', Radius.lg),
                    ('xl', Radius.xl),
                    ('full', Radius.full),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '50px',
                            heightCustom: '50px',
                            background: Background.accent,
                            borderRadius: radius.$2,
                          ),
                          children: [],
                        ),
                        ArcaneText(radius.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  /// Effects demos (shadows, transitions)
  static List<Component> effects() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildStyleDemo('Shadows', [
              ArcaneRow(
                gapSize: Gap.lg,
                children: [
                  for (final shadow in [
                    ('sm', 'var(--arcane-shadow-sm)'),
                    ('md', 'var(--arcane-shadow-md)'),
                    ('lg', 'var(--arcane-shadow-lg)'),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '80px',
                            heightCustom: '50px',
                            background: Background.surface,
                            borderRadius: Radius.md,
                            raw: {'box-shadow': shadow.$2},
                          ),
                          children: [],
                        ),
                        ArcaneText(shadow.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            _buildStyleDemo('Opacity levels', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final opacity in [
                    ('100%', Opacity.full),
                    ('75%', Opacity.muted),
                    ('50%', Opacity.half),
                    ('25%', Opacity.light),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '50px',
                            heightCustom: '50px',
                            background: Background.accent,
                            borderRadius: Radius.md,
                            opacity: opacity.$2,
                          ),
                          children: [],
                        ),
                        ArcaneText(opacity.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
          ],
        ),
      ];

  // Helper methods
  static Component _buildStyleDemo(String title, List<Component> children) {
    return ArcaneColumn(
      gapSize: Gap.sm,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneText(title, weight: FontWeight.w600, size: FontSize.sm),
        ...children,
      ],
    );
  }

  static Component _colorBox(String label) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        widthCustom: '50px',
        heightCustom: '50px',
        background: Background.accent,
        borderRadius: Radius.sm,
        display: Display.flex,
        alignItems: AlignItems.center,
        justifyContent: JustifyContent.center,
      ),
      children: [ArcaneText(label, color: TextColor.primary, weight: FontWeight.w600)],
    );
  }

  static Component _smallBox() {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        widthCustom: '24px',
        heightCustom: '24px',
        background: Background.accent,
        borderRadius: Radius.xs,
      ),
      children: [],
    );
  }

  static Component _textSwatch(String name, TextColor color) {
    return ArcaneColumn(
      gapSize: Gap.xs,
      children: [
        ArcaneText('Aa', size: FontSize.xl, weight: FontWeight.bold, color: color),
        ArcaneText(name, size: FontSize.xs, color: TextColor.muted),
      ],
    );
  }
}
