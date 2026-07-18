import 'package:arcane_jaspr/flutter.dart';

import '../html/div.dart';
import '../html/arcane_span.dart';
import '../html/arcane_link.dart';
import '../typography/text.dart';
import '../view/icon.dart';
import '../../util/style_types/index.dart';
import '../../util/arcane.dart';

/// Hover-based navigation dropdown for header menus.
///
/// Opens on hover with an invisible bridge element to maintain hover state
/// when moving from trigger to content. Supports left/right alignment.
///
/// Example:
/// ```dart
/// ArcaneNavDropdown(
///   label: 'Products',
///   width: '300px',
///   content: Column([...]),
/// )
/// ```
class ArcaneNavDropdown extends StatefulWidget {
  /// The trigger label text.
  final String label;

  /// Width of the dropdown panel.
  final String width;

  /// Content to display in the dropdown panel.
  final Widget content;

  /// Whether to align the dropdown to the right side.
  final bool alignRight;

  const ArcaneNavDropdown({
    required this.label,
    required this.width,
    required this.content,
    this.alignRight = false,
    super.key,
  });

  @override
  State<ArcaneNavDropdown> createState() => _ArcaneNavDropdownState();
}

class _ArcaneNavDropdownState extends State<ArcaneNavDropdown> {
  bool _isOpen = false;

  @override
  Widget build(BuildContext context) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        position: Position.relative,
        display: Display.inlineFlex,
      ),
      events: {
        'mouseenter': (_) => setState(() => _isOpen = true),
        'mouseleave': (_) => setState(() => _isOpen = false),
      },
      children: [
        // Trigger button
        ArcaneDiv(
          styles: ArcaneStyleData(
            display: Display.flex,
            alignItems: AlignItems.center,
            justifyContent:
                component.alignRight ? null : JustifyContent.center,
            gap: Gap.xs,
            padding: PaddingPreset.smMd,
            borderRadius: Radius.sm,
            cursor: Cursor.pointer,
            textColorCustom:
                _isOpen ? 'var(--foreground)' : 'var(--muted-foreground)',
            fontSize: FontSize.sm,
            fontWeight: FontWeight.w500,
            transition: Transition.allFast,
            backgroundCustom: _isOpen
                ? 'color-mix(in srgb, var(--foreground) 5%, transparent)'
                : 'transparent',
          ),
          children: [
            Text(component.label),
            ArcaneDiv(
              styles: ArcaneStyleData(
                transition: Transition.allFast,
                transformCustom: _isOpen ? 'rotate(180deg)' : 'rotate(0deg)',
              ),
              children: [ArcaneIcon.chevronDown(size: IconSize.xs)],
            ),
          ],
        ),
        // Dropdown panel with bridge for hover continuity
        if (_isOpen) ...[
          // Invisible bridge to maintain hover when moving to dropdown
          const ArcaneDiv(
            styles: ArcaneStyleData(
              position: Position.absolute,
              top: '100%',
              left: '0',
              right: '0',
              heightCustom: '12px',
            ),
            children: [],
          ),
          ArcaneDiv(
            styles: ArcaneStyleData(
              position: Position.absolute,
              top: 'calc(100% + 8px)',
              left: component.alignRight ? null : '0',
              right: component.alignRight ? '0' : null,
              background: Background.card,
              borderCustom:
                  '1px solid color-mix(in srgb, var(--foreground) 10%, transparent)',
              borderRadius: Radius.lg,
              minWidth: component.width,
              shadowCustom:
                  '0 10px 40px rgba(0,0,0,0.4), 0 0 0 1px rgba(255,255,255,0.02)',
              zIndex: ZIndex.popover,
              animation: AnimationPreset.dropdownFade,
              transformOrigin:
                  component.alignRight ? TransformOrigin.topRight : TransformOrigin.topLeft,
            ),
            children: [component.content],
          ),
        ],
      ],
    );
  }
}

/// Section header for dropdown menus - compact uppercase label.
class ArcaneDropdownSectionHeader extends StatelessWidget {
  final String title;

  const ArcaneDropdownSectionHeader({required this.title, super.key});

  @override
  Widget build(BuildContext context) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(
        padding: PaddingPreset.xs,
        margin: MarginPreset.bottomXs,
      ),
      children: [
        ArcaneSpan(
          styles: const ArcaneStyleData(
            fontSize: FontSize.xxs,
            fontWeight: FontWeight.w600,
            textColor: TextColor.muted,
            textTransform: TextTransform.uppercase,
            letterSpacing: LetterSpacing.wide,
          ),
          child: Text(title),
        ),
      ],
    );
  }
}

/// Divider for dropdown menus - subtle horizontal line.
class ArcaneDropdownDivider extends StatelessWidget {
  const ArcaneDropdownDivider({super.key});

  @override
  Widget build(BuildContext context) {
    return const ArcaneDiv(
      styles: ArcaneStyleData(
        heightCustom: '1px',
        backgroundCustom:
            'color-mix(in srgb, var(--foreground) 8%, transparent)',
        marginStringCustom: '6px 0',
      ),
      children: [],
    );
  }
}

/// Style variants for dropdown items
enum ArcaneDropdownItemStyle {
  /// Icon in styled container with optional description - for primary items
  iconBadge,

  /// Simple icon + label with subtle background - for resource links
  simple,

  /// Minimal padding and spacing - for compact lists
  compact,
}

/// Dropdown item component with multiple style variants.
///
/// Supports icon badge style with colored containers, simple style with
/// inline icons, and compact style for dense lists.
class ArcaneDropdownItem extends StatefulWidget {
  final String label;
  final String? description;
  final String href;
  final Widget icon;
  final String? accentColor;
  final bool isExternal;
  final ArcaneDropdownItemStyle variant;

  const ArcaneDropdownItem({
    required this.label,
    required this.href,
    required this.icon,
    this.description,
    this.accentColor,
    this.isExternal = false,
    this.variant = ArcaneDropdownItemStyle.iconBadge,
    super.key,
  });

  @override
  State<ArcaneDropdownItem> createState() => _ArcaneDropdownItemState();
}

class _ArcaneDropdownItemState extends State<ArcaneDropdownItem> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    return switch (component.variant) {
      ArcaneDropdownItemStyle.iconBadge => _buildIconBadgeStyle(),
      ArcaneDropdownItemStyle.simple => _buildSimpleStyle(),
      ArcaneDropdownItemStyle.compact => _buildCompactStyle(),
    };
  }

  /// Icon badge style - compact icon in subtle colored container
  Widget _buildIconBadgeStyle() {
    final String accent = component.accentColor ?? 'var(--primary)';

    return ArcaneLink.children(
      href: component.href,
      styles: ArcaneStyleData(
        display: Display.flex,
        alignItems: AlignItems.center,
        gap: Gap.sm,
        padding: PaddingPreset.sm,
        borderRadius: Radius.md,
        textDecoration: TextDecoration.none,
        overflow: Overflow.hidden,
        transition: Transition.allFast,
        backgroundCustom: _isHovered
            ? 'color-mix(in srgb, $accent 8%, transparent)'
            : 'transparent',
        borderCustom: _isHovered
            ? '1px solid color-mix(in srgb, $accent 20%, transparent)'
            : '1px solid transparent',
      ),
      events: {
        'mouseenter': (_) => setState(() => _isHovered = true),
        'mouseleave': (_) => setState(() => _isHovered = false),
      },
      children: [
        // Icon container
        ArcaneDiv(
          styles: ArcaneStyleData(
            display: Display.flex,
            alignItems: AlignItems.center,
            justifyContent: JustifyContent.center,
            widthCustom: '32px',
            heightCustom: '32px',
            borderRadius: Radius.sm,
            backgroundCustom: _isHovered
                ? 'color-mix(in srgb, $accent 15%, transparent)'
                : 'color-mix(in srgb, $accent 8%, transparent)',
            textColorCustom: accent,
            flexShrink: 0,
            transition: Transition.allFast,
          ),
          children: [component.icon],
        ),
        // Text content
        ArcaneDiv(
          styles: const ArcaneStyleData(
            display: Display.flex,
            flexDirection: FlexDirection.column,
            flexGrow: 1,
          ),
          children: [
            ArcaneSpan(
              styles: const ArcaneStyleData(
                fontSize: FontSize.sm,
                fontWeight: FontWeight.w500,
                textColor: TextColor.primary,
              ),
              child: Text(component.label),
            ),
            if (component.description != null)
              ArcaneSpan(
                styles: const ArcaneStyleData(
                  fontSize: FontSize.xs,
                  textColor: TextColor.muted,
                ),
                child: Text(component.description!),
              ),
          ],
        ),
        // External link indicator or arrow
        if (component.isExternal)
          ArcaneDiv(
            styles: ArcaneStyleData(
              textColorCustom: _isHovered ? accent : 'var(--muted-foreground)',
              opacity: _isHovered ? Opacity.high : Opacity.half,
              transition: Transition.allFast,
            ),
            children: [ArcaneIcon.externalLink(size: IconSize.xs)],
          )
        else
          ArcaneDiv(
            styles: ArcaneStyleData(
              textColorCustom: _isHovered ? accent : 'var(--muted-foreground)',
              opacity: _isHovered ? Opacity.high : Opacity.half,
              transition: Transition.allFast,
            ),
            children: [ArcaneIcon.chevronRight(size: IconSize.xs)],
          ),
      ],
    );
  }

  /// Simple style - compact minimal design with icon
  Widget _buildSimpleStyle() {
    return ArcaneLink.children(
      href: component.href,
      styles: ArcaneStyleData(
        display: Display.flex,
        alignItems: AlignItems.center,
        gap: Gap.sm,
        padding: PaddingPreset.sm,
        borderRadius: Radius.sm,
        textDecoration: TextDecoration.none,
        fontSize: FontSize.sm,
        transition: Transition.allFast,
        textColorCustom:
            _isHovered ? 'var(--foreground)' : 'var(--muted-foreground)',
        backgroundCustom: _isHovered
            ? 'color-mix(in srgb, var(--foreground) 5%, transparent)'
            : 'transparent',
      ),
      events: {
        'mouseenter': (_) => setState(() => _isHovered = true),
        'mouseleave': (_) => setState(() => _isHovered = false),
      },
      children: [
        // Icon
        ArcaneDiv(
          styles: ArcaneStyleData(
            textColorCustom:
                _isHovered ? 'var(--foreground)' : 'var(--muted-foreground)',
            transition: Transition.allFast,
          ),
          children: [component.icon],
        ),
        // Label
        ArcaneSpan(
          styles: const ArcaneStyleData(
            flexGrow: 1,
          ),
          child: Text(component.label),
        ),
        // External indicator
        if (component.isExternal)
          ArcaneDiv(
            styles: ArcaneStyleData(
              textColor: TextColor.muted,
              opacity: _isHovered ? Opacity.high : Opacity.half,
              transition: Transition.allFast,
            ),
            children: [ArcaneIcon.externalLink(size: IconSize.xs)],
          ),
      ],
    );
  }

  /// Compact style - minimal padding and spacing
  Widget _buildCompactStyle() {
    return ArcaneLink.children(
      href: component.href,
      styles: ArcaneStyleData(
        display: Display.flex,
        alignItems: AlignItems.center,
        gap: Gap.sm,
        padding: PaddingPreset.sm,
        borderRadius: Radius.sm,
        textDecoration: TextDecoration.none,
        fontSize: FontSize.sm,
        transition: Transition.allFast,
        textColorCustom:
            _isHovered ? 'var(--foreground)' : 'var(--muted-foreground)',
        backgroundCustom: _isHovered
            ? 'color-mix(in srgb, var(--foreground) 5%, transparent)'
            : 'transparent',
      ),
      events: {
        'mouseenter': (_) => setState(() => _isHovered = true),
        'mouseleave': (_) => setState(() => _isHovered = false),
      },
      children: [
        ArcaneDiv(
          styles: ArcaneStyleData(
            textColorCustom:
                _isHovered ? 'var(--foreground)' : 'var(--muted-foreground)',
            transition: Transition.allFast,
          ),
          children: [component.icon],
        ),
        Text(component.label),
      ],
    );
  }
}
