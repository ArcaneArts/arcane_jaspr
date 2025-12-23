import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Demo builders for concept pages (aliases, styling, theming, tokens)
class ConceptDemos {
  /// Aliases demo - shows component with full name vs alias
  static List<Component> aliases() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Show the naming pattern
            ArcaneDiv(
              styles: const ArcaneStyleData(
                padding: PaddingPreset.md,
                background: Background.surface,
                borderRadius: Radius.md,
              ),
              children: [
                ArcaneColumn(
                  gapSize: Gap.md,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ArcaneText('Component Aliases', weight: FontWeight.w600),
                    ArcaneRow(
                      gapSize: Gap.lg,
                      children: [
                        // Full name example
                        ArcaneColumn(
                          gapSize: Gap.xs,
                          children: [
                            ArcaneText('Full Name', size: FontSize.xs, color: TextColor.muted),
                            ArcaneButton.primary(label: 'ArcaneButton', onPressed: () {}),
                          ],
                        ),
                        // Alias example
                        ArcaneColumn(
                          gapSize: Gap.xs,
                          children: [
                            ArcaneText('Alias', size: FontSize.xs, color: TextColor.muted),
                            ArcaneButton.primary(label: 'AButton', onPressed: () {}),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
            // Common aliases table
            ArcaneDiv(
              styles: const ArcaneStyleData(
                background: Background.surface,
                borderRadius: Radius.md,
                overflow: Overflow.hidden,
              ),
              children: [
                ArcaneStaticTable(
                  headers: const ['Full Name', 'Alias'],
                  rows: [
                    [ArcaneText('ArcaneButton'), ArcaneText('AButton')],
                    [ArcaneText('ArcaneCard'), ArcaneText('ACard')],
                    [ArcaneText('ArcaneText'), ArcaneText('AText')],
                    [ArcaneText('ArcaneDiv'), ArcaneText('ADiv')],
                    [ArcaneText('ArcaneRow'), ArcaneText('ARow')],
                  ],
                ),
              ],
            ),
          ],
        ),
      ];

  /// Styling demo - shows ArcaneStyleData in action
  static List<Component> styling() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Type-safe styling example
            _buildStyleDemo('Type-Safe Styling', [
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  display: Display.flex,
                  gap: Gap.md,
                  padding: PaddingPreset.lg,
                  background: Background.surface,
                  borderRadius: Radius.lg,
                  border: BorderPreset.subtle,
                ),
                children: [
                  _styledBox('Display.flex'),
                  _styledBox('Gap.md'),
                  _styledBox('Padding.lg'),
                ],
              ),
            ]),
            // Static presets
            _buildStyleDemo('Static Presets', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  ArcaneDiv(
                    styles: ArcaneStyleData.flexCenter,
                    children: [
                      ArcaneDiv(
                        styles: const ArcaneStyleData(
                          padding: PaddingPreset.sm,
                          background: Background.accent,
                          borderRadius: Radius.sm,
                        ),
                        children: [ArcaneText('flexCenter', size: FontSize.xs)],
                      ),
                    ],
                  ),
                  ArcaneDiv(
                    styles: ArcaneStyleData.row,
                    children: [
                      _smallBox(),
                      _smallBox(),
                      _smallBox(),
                    ],
                  ),
                ],
              ),
            ]),
            // Raw CSS fallback
            _buildStyleDemo('Raw CSS Fallback', [
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  padding: PaddingPreset.md,
                  background: Background.surface,
                  borderRadius: Radius.md,
                  raw: {
                    'background': 'linear-gradient(135deg, var(--arcane-accent) 0%, var(--arcane-accent-container) 100%)',
                  },
                ),
                children: [
                  ArcaneText('Custom Gradient', color: TextColor.primary),
                ],
              ),
            ]),
          ],
        ),
      ];

  /// Theming demo - shows all theme presets as interactive buttons
  static List<Component> theming() => [
        ArcaneColumn(
          gapSize: Gap.xl,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Primary color themes
            _buildStyleDemo('Primary Colors', [
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  display: Display.flex,
                  flexWrap: FlexWrap.wrap,
                  gap: Gap.sm,
                ),
                children: [
                  _themeButton('red', 'Red', '#ef4444'),
                  _themeButton('orange', 'Orange', '#f97316'),
                  _themeButton('yellow', 'Yellow', '#f59e0b'),
                  _themeButton('green', 'Green', '#22c55e'),
                  _themeButton('blue', 'Blue', '#3b82f6'),
                  _themeButton('indigo', 'Indigo', '#6366f1'),
                  _themeButton('purple', 'Purple', '#8b5cf6'),
                  _themeButton('pink', 'Pink', '#ec4899'),
                ],
              ),
            ]),
            // Neutral themes
            _buildStyleDemo('Neutral / Monochromatic', [
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  display: Display.flex,
                  flexWrap: FlexWrap.wrap,
                  gap: Gap.sm,
                ),
                children: [
                  _themeButton('dark-grey', 'Dark Grey', '#3f3f46'),
                  _themeButton('grey', 'Grey', '#71717a'),
                  _themeButton('light-grey', 'Light Grey', '#a1a1aa'),
                  _themeButton('white', 'White', '#f4f4f5'),
                  _themeButton('black', 'Black', '#18181b'),
                ],
              ),
            ]),
            // OLED themes
            _buildStyleDemo('OLED (True Black)', [
              ArcaneDiv(
                styles: const ArcaneStyleData(
                  display: Display.flex,
                  flexWrap: FlexWrap.wrap,
                  gap: Gap.sm,
                ),
                children: [
                  _themeButton('oled-red', 'OLED Red', '#ef4444'),
                  _themeButton('oled-green', 'OLED Green', '#22c55e'),
                  _themeButton('oled-blue', 'OLED Blue', '#3b82f6'),
                  _themeButton('oled-purple', 'OLED Purple', '#8b5cf6'),
                  _themeButton('oled-white', 'OLED White', '#e4e4e7'),
                ],
              ),
            ]),
            // Instructions
            ArcaneDiv(
              styles: const ArcaneStyleData(
                padding: PaddingPreset.md,
                background: Background.surfaceVariant,
                borderRadius: Radius.md,
                margin: MarginPreset.topMd,
              ),
              children: [
                ArcaneText(
                  'Click any theme above to change the entire Codex appearance. Use the sun/moon toggle in the header to switch between light and dark modes.',
                  size: FontSize.sm,
                  color: TextColor.muted,
                ),
              ],
            ),
          ],
        ),
      ];

  /// Create a theme button with data attribute for JS handling
  static Component _themeButton(String id, String name, String color) {
    return ArcaneButton.outline(
      attributes: {'data-theme-preset': id},
      size: ButtonSize.small,
      child: ArcaneRow(
        gapSize: Gap.sm,
        mainAxisSize: MainAxisSize.min,
        children: [
          // Color swatch
          ArcaneDiv(
            styles: ArcaneStyleData(
              widthCustom: '16px',
              heightCustom: '16px',
              borderRadius: Radius.sm,
              raw: {'background': color},
            ),
            children: const [],
          ),
          // Label
          ArcaneText(name, size: FontSize.sm),
        ],
      ),
    );
  }

  /// Design tokens demo - shows colors, spacing, etc
  static List<Component> tokens() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Status colors
            _buildStyleDemo('Status Colors', [
              ArcaneRow(
                gapSize: Gap.sm,
                children: [
                  for (final color in [
                    ('success', Background.success),
                    ('warning', Background.warning),
                    ('error', Background.error),
                    ('info', Background.info),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '48px',
                            heightCustom: '32px',
                            background: color.$2,
                            borderRadius: Radius.sm,
                          ),
                          children: [],
                        ),
                        ArcaneText(color.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            // Spacing scale
            _buildStyleDemo('Spacing Scale', [
              ArcaneColumn(
                gapSize: Gap.sm,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (final spacing in [
                    ('xs (4px)', '4px'),
                    ('sm (8px)', '8px'),
                    ('md (16px)', '16px'),
                    ('lg (24px)', '24px'),
                    ('xl (32px)', '32px'),
                  ])
                    ArcaneRow(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ArcaneDiv(
                          styles: const ArcaneStyleData(widthCustom: '80px'),
                          children: [ArcaneText(spacing.$1, size: FontSize.xs, color: TextColor.muted)],
                        ),
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: spacing.$2,
                            heightCustom: '16px',
                            background: Background.accent,
                            borderRadius: Radius.xs,
                          ),
                          children: [],
                        ),
                      ],
                    ),
                ],
              ),
            ]),
            // Surface colors
            _buildStyleDemo('Surface Tokens', [
              ArcaneRow(
                gapSize: Gap.sm,
                children: [
                  for (final surface in [
                    ('background', Background.background),
                    ('surface', Background.surface),
                    ('card', Background.card),
                    ('input', Background.input),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '60px',
                            heightCustom: '40px',
                            background: surface.$2,
                            borderRadius: Radius.sm,
                            border: BorderPreset.subtle,
                          ),
                          children: [],
                        ),
                        ArcaneText(surface.$1, size: FontSize.xs, color: TextColor.muted),
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

  static Component _styledBox(String label) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        padding: PaddingPreset.sm,
        background: Background.accent,
        borderRadius: Radius.sm,
      ),
      children: [ArcaneText(label, size: FontSize.xs)],
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
}
