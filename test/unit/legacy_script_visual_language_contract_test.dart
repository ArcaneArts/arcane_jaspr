import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
  test('legacy scripts do not recreate rejected visual-language shortcuts', () {
    final String scripts = ArcaneScripts.legacy;

    for (final String forbidden in <String>[
      '--glow-color',
      '.arcane-chip',
      '.arcane-radio-chip',
      '.arcane-tag',
      'backdrop-filter',
      'bindChips',
      'bindTagInputs',
      'bindToasts',
      'bindTabs',
      'borderBottom',
      'border-bottom: 2px',
      'createToast',
      'arcane-toast-progress',
      'arcane-toast-spin',
      'button[aria-expanded]',
    ]) {
      expect(scripts, isNot(contains(forbidden)), reason: forbidden);
    }

    expect(scripts, contains('background: var(--popover)'));
    expect(scripts, contains('color: var(--popover-foreground)'));
  });
}
