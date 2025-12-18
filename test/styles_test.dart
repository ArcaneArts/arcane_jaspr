import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
  group('EdgeInsets', () {
    test('all creates uniform padding', () {
      final insets = EdgeInsets.all(16);
      expect(insets.left, equals(16));
      expect(insets.top, equals(16));
      expect(insets.right, equals(16));
      expect(insets.bottom, equals(16));
    });

    test('symmetric creates horizontal/vertical padding', () {
      final insets = EdgeInsets.symmetric(horizontal: 10, vertical: 20);
      expect(insets.left, equals(10));
      expect(insets.right, equals(10));
      expect(insets.top, equals(20));
      expect(insets.bottom, equals(20));
    });

    test('only creates specific side padding', () {
      final insets = EdgeInsets.only(left: 5, top: 10, right: 15, bottom: 20);
      expect(insets.left, equals(5));
      expect(insets.top, equals(10));
      expect(insets.right, equals(15));
      expect(insets.bottom, equals(20));
    });

    test('zero creates no padding', () {
      final insets = EdgeInsets.zero;
      expect(insets.left, equals(0));
      expect(insets.top, equals(0));
      expect(insets.right, equals(0));
      expect(insets.bottom, equals(0));
    });

    test('padding getter returns CSS string', () {
      final insets = EdgeInsets.all(16);
      expect(insets.padding, contains('px'));
    });

    test('margin getter returns CSS string', () {
      final insets = EdgeInsets.all(16);
      expect(insets.margin, contains('px'));
    });
  });

  group('BorderRadius', () {
    test('all creates uniform radius', () {
      final radius = BorderRadius.all(8);
      expect(radius.topLeft, equals(8));
      expect(radius.topRight, equals(8));
      expect(radius.bottomRight, equals(8));
      expect(radius.bottomLeft, equals(8));
    });

    test('circular creates circular radius', () {
      final radius = BorderRadius.circular(12);
      expect(radius.topLeft, equals(12));
      expect(radius.topRight, equals(12));
      expect(radius.bottomRight, equals(12));
      expect(radius.bottomLeft, equals(12));
    });

    test('only creates specific corner radius', () {
      final radius = BorderRadius.only(
        topLeft: 1,
        topRight: 2,
        bottomRight: 3,
        bottomLeft: 4,
      );
      expect(radius.topLeft, equals(1));
      expect(radius.topRight, equals(2));
      expect(radius.bottomRight, equals(3));
      expect(radius.bottomLeft, equals(4));
    });

    test('zero creates no radius', () {
      final radius = BorderRadius.zero;
      expect(radius.topLeft, equals(0));
      expect(radius.topRight, equals(0));
      expect(radius.bottomRight, equals(0));
      expect(radius.bottomLeft, equals(0));
    });

    test('css getter returns CSS string', () {
      final radius = BorderRadius.all(8);
      expect(radius.css, contains('px'));
    });
  });

  group('BoxShadow', () {
    test('creates shadow with all parameters', () {
      final shadow = BoxShadow(
        color: Color(0x40000000),
        offsetX: 2,
        offsetY: 4,
        blurRadius: 8,
        spreadRadius: 0,
      );
      expect(shadow.offsetX, equals(2));
      expect(shadow.offsetY, equals(4));
      expect(shadow.blurRadius, equals(8));
      expect(shadow.spreadRadius, equals(0));
    });

    test('css getter returns valid CSS shadow', () {
      final shadow = BoxShadow(
        color: Color(0x40000000),
        offsetX: 2,
        offsetY: 4,
        blurRadius: 8,
      );
      expect(shadow.css, contains('px'));
      expect(shadow.css, contains('rgba'));
    });
  });

  group('FontWeight', () {
    test('predefined weights have correct values', () {
      expect(FontWeight.normal.css, equals('400'));
      expect(FontWeight.bold.css, equals('700'));
    });

    test('custom weight values work', () {
      expect(FontWeight.w100.css, equals('100'));
      expect(FontWeight.w400.css, equals('400'));
      expect(FontWeight.w700.css, equals('700'));
      expect(FontWeight.w900.css, equals('900'));
    });
  });

  group('TextAlign', () {
    test('alignments have correct CSS values', () {
      expect(TextAlign.left.css, equals('left'));
      expect(TextAlign.center.css, equals('center'));
      expect(TextAlign.right.css, equals('right'));
      expect(TextAlign.justify.css, equals('justify'));
    });
  });

  group('TextOverflow', () {
    test('overflow types have correct CSS values', () {
      expect(TextOverflow.clip.css, equals('clip'));
      expect(TextOverflow.ellipsis.css, equals('ellipsis'));
      expect(TextOverflow.visible.css, equals('visible'));
    });
  });

  group('BoxFit', () {
    test('fit types have correct CSS values', () {
      expect(BoxFit.contain.css, equals('contain'));
      expect(BoxFit.cover.css, equals('cover'));
      expect(BoxFit.fill.css, equals('fill'));
      expect(BoxFit.none.css, equals('none'));
      expect(BoxFit.scaleDown.css, equals('scale-down'));
    });
  });

  group('ArcaneStyles', () {
    test('creates empty styles', () {
      final styles = ArcaneStyles();
      expect(styles.css, equals(''));
    });

    test('set adds style property', () {
      final styles = ArcaneStyles().set('color', 'red');
      expect(styles.css, contains('color: red'));
    });

    test('chained methods work', () {
      final styles = ArcaneStyles()
          .displayFlex()
          .gap(16)
          .paddingAll(8);
      expect(styles.css, contains('display: flex'));
      expect(styles.css, contains('gap: 16'));
      expect(styles.css, contains('padding:'));
    });

    test('when conditionally applies styles', () {
      final styles = ArcaneStyles()
          .when(true, (s) => s.displayFlex())
          .when(false, (s) => s.displayGrid());
      expect(styles.css, contains('display: flex'));
      expect(styles.css, isNot(contains('display: grid')));
    });
  });

  group('Styles', () {
    test('creates Styles from raw map', () {
      final styles = Styles(raw: {
        'color': 'red',
        'padding': '10px',
      });
      expect(styles, isNotNull);
    });
  });
}
