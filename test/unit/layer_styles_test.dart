// Unit tests for layerStyles — the cascade helper that backs the permeability
// contract. It applies each override map onto the base so every overridden key
// ends up LAST in iteration order (and therefore last in the emitted inline
// `style` attribute, where the CSS cascade lets it win). A plain map spread
// keeps a key's ORIGINAL position, so the remove-then-reinsert is load-bearing:
// we assert the resulting contents AND key order, not the implementation.

import 'package:arcane_jaspr/core/rendering/base/style_layering.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
  group('layerStyles', () {
    test('a later override wins over an earlier key', () {
      final Map<String, String> result = layerStyles(
        <String, String>{'background-color': 'red', 'color': 'black'},
        <Map<String, String>?>[
          <String, String>{'background-color': 'blue'},
        ],
      );
      expect(result['background-color'], 'blue');
      expect(result['color'], 'black');
    });

    test('an overridden key is MOVED to the last position, not left in place',
        () {
      final Map<String, String> result = layerStyles(
        <String, String>{
          'background-color': 'red',
          'color': 'black',
          'border': '1px',
        },
        <Map<String, String>?>[
          <String, String>{'background-color': 'blue'},
        ],
      );
      // 'background-color' was first; overriding it moves it to the end so it
      // is emitted last in the inline style and wins the cascade. Untouched
      // keys keep their relative order.
      expect(result.keys.toList(), <String>['color', 'border', 'background-color']);
    });

    test('a brand-new override key is appended at the end', () {
      final Map<String, String> result = layerStyles(
        <String, String>{'color': 'black'},
        <Map<String, String>?>[
          <String, String>{'background': 'linear-gradient(180deg, #000, #111)'},
        ],
      );
      expect(result.keys.toList(), <String>['color', 'background']);
      expect(result['background'], 'linear-gradient(180deg, #000, #111)');
    });

    test('null override maps are skipped', () {
      final Map<String, String> result = layerStyles(
        <String, String>{'a': '1'},
        <Map<String, String>?>[
          null,
          <String, String>{'b': '2'},
          null,
        ],
      );
      expect(result, <String, String>{'a': '1', 'b': '2'});
      expect(result.keys.toList(), <String>['a', 'b']);
    });

    test('an absent (empty) override map is a no-op', () {
      final Map<String, String> result = layerStyles(
        <String, String>{'a': '1', 'b': '2'},
        <Map<String, String>?>[
          <String, String>{},
        ],
      );
      expect(result, <String, String>{'a': '1', 'b': '2'});
      expect(result.keys.toList(), <String>['a', 'b']);
    });

    test('multiple override maps apply left-to-right (last map wins)', () {
      final Map<String, String> result = layerStyles(
        <String, String>{'x': '0'},
        <Map<String, String>?>[
          <String, String>{'x': '1'},
          <String, String>{'x': '2'},
          <String, String>{'x': '3'},
        ],
      );
      expect(result['x'], '3');
      expect(result.keys.toList(), <String>['x']);
    });

    test('later layers move a key past keys that earlier layers appended', () {
      // Models the permeability layer order: base, then decoration, then the
      // literal `styles:` escape hatch — the literal (last) layer must end up
      // last in iteration order even when an earlier layer touched the key.
      final Map<String, String> result = layerStyles(
        <String, String>{'background': 'base'},
        <Map<String, String>?>[
          <String, String>{'background': 'decoration', 'padding': '8px'},
          <String, String>{'background': 'literal'},
        ],
      );
      expect(result['background'], 'literal');
      expect(result['padding'], '8px');
      // 'background' overridden last, so it lands after 'padding'.
      expect(result.keys.toList(), <String>['padding', 'background']);
    });
  });
}
