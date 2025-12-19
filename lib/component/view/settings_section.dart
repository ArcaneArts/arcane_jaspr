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

/// A settings section card with a title and content.
///
/// Use this for grouping related settings in a dashboard.
class ArcaneSettingsSection extends StatelessComponent {
  /// The section title
  final String title;

  /// Optional description below the title
  final String? description;

  /// The section content
  final List<Component> children;

  /// Whether this is a danger zone section (destructive actions)
  final bool danger;

  const ArcaneSettingsSection({
    super.key,
    required this.title,
    this.description,
    required this.children,
    this.danger = false,
  });

  /// Creates a danger zone section (red border, destructive styling)
  const ArcaneSettingsSection.danger({
    super.key,
    required this.title,
    this.description,
    required this.children,
  }) : danger = true;

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-settings-section ${danger ? 'danger' : ''}',
      styles: Styles(raw: {
        'background': danger ? 'rgba(239, 68, 68, 0.05)' : ArcaneColors.surface,
        'border': danger
            ? '1px solid rgba(239, 68, 68, 0.2)'
            : '1px solid ${ArcaneColors.border}',
        'border-radius': ArcaneRadius.lg,
        'padding': ArcaneSpacing.lg,
        'margin-bottom': ArcaneSpacing.lg,
      }),
      [
        // Header
        div(
          classes: 'arcane-settings-section-header',
          styles: Styles(raw: {
            'display': 'flex',
            'align-items': 'center',
            'gap': ArcaneSpacing.sm,
            'margin-bottom': ArcaneSpacing.lg,
            'padding-bottom': ArcaneSpacing.md,
            'border-bottom': '1px solid ${danger ? 'rgba(239, 68, 68, 0.2)' : ArcaneColors.border}',
          }),
          [
            h2(
              styles: Styles(raw: {
                'font-size': ArcaneTypography.fontLg,
                'font-weight': ArcaneTypography.weightSemibold,
                'color': danger ? ArcaneColors.error : ArcaneColors.onSurface,
                'margin': '0',
              }),
              [Component.text(title)],
            ),
          ],
        ),
        // Description
        if (description != null)
          p(
            styles: Styles(raw: {
              'font-size': ArcaneTypography.fontSm,
              'color': ArcaneColors.muted,
              'margin': '0 0 ${ArcaneSpacing.md} 0',
            }),
            [Component.text(description!)],
          ),
        // Content
        ...children,
      ],
    );
  }
}

/// A row displaying a label and value (for profile info, etc.)
class ArcaneSettingsInfoRow extends StatelessComponent {
  /// The label/name
  final String label;

  /// The value to display
  final String value;

  /// Whether to use monospace font for the value
  final bool monospace;

  const ArcaneSettingsInfoRow({
    super.key,
    required this.label,
    required this.value,
    this.monospace = false,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-settings-info-row',
      styles: Styles(raw: {
        'display': 'flex',
        'justify-content': 'space-between',
        'align-items': 'center',
        'padding': '${ArcaneSpacing.md} 0',
        'border-bottom': '1px solid ${ArcaneColors.border}',
      }),
      [
        span(
          styles: Styles(raw: {
            'font-size': ArcaneTypography.fontSm,
            'color': ArcaneColors.muted,
          }),
          [Component.text(label)],
        ),
        span(
          styles: Styles(raw: {
            'font-size': ArcaneTypography.fontSm,
            'color': ArcaneColors.onSurface,
            if (monospace) 'font-family': ArcaneTypography.fontFamilyMono,
          }),
          [Component.text(value)],
        ),
      ],
    );
  }
}

/// A toggle switch row for settings (title, description, toggle)
class ArcaneSettingsToggleRow extends StatelessComponent {
  /// The toggle title
  final String title;

  /// Optional description
  final String? description;

  /// Whether the toggle is enabled
  final bool enabled;

  /// Callback when toggle changes
  final void Function(bool)? onChanged;

  /// Whether the toggle is disabled
  final bool disabled;

  const ArcaneSettingsToggleRow({
    super.key,
    required this.title,
    this.description,
    required this.enabled,
    this.onChanged,
    this.disabled = false,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-settings-toggle-row ${disabled ? 'disabled' : ''}',
      styles: Styles(raw: {
        'display': 'flex',
        'justify-content': 'space-between',
        'align-items': 'center',
        'padding': ArcaneSpacing.md,
        'border-bottom': '1px solid ${ArcaneColors.border}',
        if (disabled) 'opacity': '0.5',
      }),
      [
        // Labels
        div(
          styles: Styles(raw: {
            'flex': '1',
          }),
          [
            div(
              styles: Styles(raw: {
                'font-size': ArcaneTypography.fontSm,
                'font-weight': ArcaneTypography.weightMedium,
                'color': ArcaneColors.onSurface,
              }),
              [Component.text(title)],
            ),
            if (description != null)
              div(
                styles: Styles(raw: {
                  'font-size': ArcaneTypography.fontXs,
                  'color': ArcaneColors.muted,
                  'margin-top': '2px',
                }),
                [Component.text(description!)],
              ),
          ],
        ),
        // Toggle
        button(
          classes: 'arcane-toggle ${enabled ? 'enabled' : ''}',
          attributes: {
            'type': 'button',
            'role': 'switch',
            'aria-checked': enabled.toString(),
            if (disabled) 'disabled': 'true',
          },
          styles: Styles(raw: {
            'width': '44px',
            'height': '24px',
            'background': enabled ? ArcaneColors.accent : ArcaneColors.surfaceVariant,
            'border-radius': '12px',
            'border': 'none',
            'cursor': disabled ? 'not-allowed' : 'pointer',
            'position': 'relative',
            'transition': ArcaneEffects.transitionFast,
            'flex-shrink': '0',
          }),
          events: {
            if (!disabled && onChanged != null)
              'click': (e) => onChanged!(!enabled),
          },
          [
            div(
              classes: 'arcane-toggle-thumb',
              styles: Styles(raw: {
                'width': '20px',
                'height': '20px',
                'background': ArcaneColors.accentForeground,
                'border-radius': ArcaneRadius.full,
                'position': 'absolute',
                'top': '2px',
                'left': enabled ? '22px' : '2px',
                'transition': ArcaneEffects.transitionFast,
              }),
              [],
            ),
          ],
        ),
      ],
    );
  }
}

/// A subsection header within a settings section
class ArcaneSettingsSubheader extends StatelessComponent {
  /// The subsection title
  final String title;

  /// Optional description
  final String? description;

  const ArcaneSettingsSubheader({
    super.key,
    required this.title,
    this.description,
  });

  @override
  Component build(BuildContext context) {
    return div(
      classes: 'arcane-settings-subheader',
      styles: Styles(raw: {
        'margin-bottom': ArcaneSpacing.md,
      }),
      [
        div(
          styles: Styles(raw: {
            'font-size': ArcaneTypography.fontSm,
            'font-weight': ArcaneTypography.weightMedium,
            'color': ArcaneColors.onSurface,
            'margin-bottom': description != null ? ArcaneSpacing.xs : '0',
          }),
          [Component.text(title)],
        ),
        if (description != null)
          p(
            styles: Styles(raw: {
              'font-size': ArcaneTypography.fontXs,
              'color': ArcaneColors.muted,
              'margin': '0',
            }),
            [Component.text(description!)],
          ),
      ],
    );
  }
}

/// A note/info box within a settings section
class ArcaneSettingsNote extends StatelessComponent {
  /// The note text
  final String text;

  /// The note variant
  final ArcaneSettingsNoteVariant variant;

  const ArcaneSettingsNote({
    super.key,
    required this.text,
    this.variant = ArcaneSettingsNoteVariant.info,
  });

  const ArcaneSettingsNote.info({super.key, required this.text})
      : variant = ArcaneSettingsNoteVariant.info;

  const ArcaneSettingsNote.warning({super.key, required this.text})
      : variant = ArcaneSettingsNoteVariant.warning;

  const ArcaneSettingsNote.success({super.key, required this.text})
      : variant = ArcaneSettingsNoteVariant.success;

  @override
  Component build(BuildContext context) {
    final colors = _getColors();
    return div(
      classes: 'arcane-settings-note ${variant.name}',
      styles: Styles(raw: {
        'margin-top': ArcaneSpacing.md,
        'padding': ArcaneSpacing.md,
        'background': colors.background,
        'border-radius': ArcaneRadius.md,
      }),
      [
        p(
          styles: Styles(raw: {
            'font-size': ArcaneTypography.fontSm,
            'color': ArcaneColors.muted,
            'margin': '0',
          }),
          [Component.text(text)],
        ),
      ],
    );
  }

  ({String background}) _getColors() {
    switch (variant) {
      case ArcaneSettingsNoteVariant.info:
        return (background: 'rgba(147, 51, 234, 0.1)');
      case ArcaneSettingsNoteVariant.warning:
        return (background: 'rgba(245, 158, 11, 0.1)');
      case ArcaneSettingsNoteVariant.success:
        return (background: 'rgba(16, 185, 129, 0.1)');
    }
  }
}

enum ArcaneSettingsNoteVariant { info, warning, success }
