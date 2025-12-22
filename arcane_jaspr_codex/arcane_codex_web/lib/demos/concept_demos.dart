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

  /// Theming demo - shows accent colors and theme properties
  static List<Component> theming() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Accent color swatches
            _buildStyleDemo('Accent Color Themes', [
              ArcaneRow(
                gapSize: Gap.sm,
                children: [
                  for (final accent in [
                    ('Emerald', Colors.emerald),
                    ('Blue', Colors.blue),
                    ('Purple', Colors.purple),
                    ('Rose', Colors.rose),
                    ('Orange', Colors.orange),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '48px',
                            heightCustom: '48px',
                            borderRadius: Radius.md,
                            raw: {'background': accent.$2.css},
                          ),
                          children: [],
                        ),
                        ArcaneText(accent.$1, size: FontSize.xs, color: TextColor.muted),
                      ],
                    ),
                ],
              ),
            ]),
            // Theme mode
            _buildStyleDemo('Theme Modes', [
              ArcaneRow(
                gapSize: Gap.lg,
                children: [
                  ArcaneColumn(
                    gapSize: Gap.xs,
                    children: [
                      ArcaneDiv(
                        styles: const ArcaneStyleData(
                          widthCustom: '80px',
                          heightCustom: '50px',
                          borderRadius: Radius.md,
                          border: BorderPreset.subtle,
                          raw: {'background': '#1a1a1a'},
                        ),
                        children: [],
                      ),
                      ArcaneText('Dark', size: FontSize.xs, color: TextColor.muted),
                    ],
                  ),
                  ArcaneColumn(
                    gapSize: Gap.xs,
                    children: [
                      ArcaneDiv(
                        styles: const ArcaneStyleData(
                          widthCustom: '80px',
                          heightCustom: '50px',
                          borderRadius: Radius.md,
                          border: BorderPreset.subtle,
                          raw: {'background': '#f4f4f5'},
                        ),
                        children: [],
                      ),
                      ArcaneText('Light', size: FontSize.xs, color: TextColor.muted),
                    ],
                  ),
                ],
              ),
            ]),
            // Radius scaling
            _buildStyleDemo('Border Radius Scaling', [
              ArcaneRow(
                gapSize: Gap.md,
                children: [
                  for (final radius in [
                    ('0.0', Radius.xs),
                    ('0.25', Radius.sm),
                    ('0.5', Radius.md),
                    ('0.75', Radius.lg),
                    ('1.0', Radius.xl),
                  ])
                    ArcaneColumn(
                      gapSize: Gap.xs,
                      children: [
                        ArcaneDiv(
                          styles: ArcaneStyleData(
                            widthCustom: '40px',
                            heightCustom: '40px',
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
