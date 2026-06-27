import 'package:arcane_jaspr/flutter.dart';

/// Settings section component properties.
class SettingsSectionProps {
  final String title;
  final String? description;
  final List<Widget> children;
  final bool danger;

  const SettingsSectionProps({
    required this.title,
    this.description,
    required this.children,
    this.danger = false,
  });
}

/// Settings info row component properties.
class SettingsInfoRowProps {
  final String label;
  final String value;
  final bool monospace;

  const SettingsInfoRowProps({
    required this.label,
    required this.value,
    this.monospace = false,
  });
}

/// Settings toggle row component properties.
class SettingsToggleRowProps {
  final String title;
  final String? description;
  final bool enabled;
  final void Function(bool)? onChanged;
  final bool disabled;

  const SettingsToggleRowProps({
    required this.title,
    this.description,
    required this.enabled,
    this.onChanged,
    this.disabled = false,
  });
}

/// Settings subheader component properties.
class SettingsSubheaderProps {
  final String title;
  final String? description;

  const SettingsSubheaderProps({
    required this.title,
    this.description,
  });
}

enum SettingsNoteVariant { info, warning, success }

/// Settings note component properties.
class SettingsNoteProps {
  final String text;
  final SettingsNoteVariant variant;

  const SettingsNoteProps({
    required this.text,
    this.variant = SettingsNoteVariant.info,
  });
}

// ============================================================================
// RENDERER CONTRACT
// ============================================================================

/// Mixin defining the renderer methods for settings section components.
mixin SettingsSectionRendererContract {
  Widget settingsSection(SettingsSectionProps props);
  Widget settingsInfoRow(SettingsInfoRowProps props);
  Widget settingsToggleRow(SettingsToggleRowProps props);
  Widget settingsSubheader(SettingsSubheaderProps props);
  Widget settingsNote(SettingsNoteProps props);
}
