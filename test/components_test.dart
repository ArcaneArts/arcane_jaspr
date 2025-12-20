import 'package:arcane_jaspr/arcane_jaspr.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
  group('Button Components', () {
    test('ArcaneButton.primary creates button with correct variant', () {
      final button = ArcaneButton.primary(
        label: 'Test Button',
        onPressed: () {},
      );
      expect(button.label, equals('Test Button'));
      expect(button.variant, equals(ButtonVariant.primary));
    });

    test('ArcaneButton.secondary creates button with correct variant', () {
      final button = ArcaneButton.secondary(
        label: 'Secondary',
        onPressed: () {},
      );
      expect(button.variant, equals(ButtonVariant.secondary));
    });

    test('ArcaneButton.outline creates button with correct variant', () {
      final button = ArcaneButton.outline(
        label: 'Outline',
        onPressed: () {},
      );
      expect(button.variant, equals(ButtonVariant.outline));
    });

    test('ArcaneButton.ghost creates button with correct variant', () {
      final button = ArcaneButton.ghost(
        label: 'Ghost',
        onPressed: () {},
      );
      expect(button.variant, equals(ButtonVariant.ghost));
    });

    test('ArcaneButton.destructive creates button with correct variant', () {
      final button = ArcaneButton.destructive(
        label: 'Delete',
        onPressed: () {},
      );
      expect(button.variant, equals(ButtonVariant.destructive));
    });

    test('ArcaneButton loading state', () {
      final button = ArcaneButton.primary(
        label: 'Loading',
        loading: true,
        onPressed: () {},
      );
      expect(button.loading, isTrue);
    });

    test('ArcaneButton disabled state', () {
      final button = ArcaneButton.primary(
        label: 'Disabled',
        disabled: true,
        onPressed: () {},
      );
      expect(button.disabled, isTrue);
    });

    test('ArcaneIconButton creates with icon', () {
      final button = ArcaneIconButton(
        icon: const span([Component.text('X')]),
        tooltip: 'Close',
        onPressed: () {},
      );
      expect(button.tooltip, equals('Close'));
    });
  });

  group('Card Components', () {
    test('ArcaneCard creates with child', () {
      final card = const ArcaneCard(
        child: Component.text('Content'),
      );
      expect(card.child, isNotNull);
    });

    test('ArcaneCard creates with padding', () {
      final card = const ArcaneCard(
        padding: EdgeInsets.all(24),
        child: Component.text('Content'),
      );
      expect(card.padding?.left, equals(24));
    });

    test('ArcaneCard clickable state', () {
      var tapped = false;
      final card = ArcaneCard(
        onTap: () => tapped = true,
        child: const Component.text('Content'),
      );
      expect(card.onTap, isNotNull);
    });
  });

  group('Layout Components', () {
    test('Section creates with header', () {
      final section = const Section(
        header: 'Test Section',
        children: [Component.text('Content')],
      );
      expect(section.header, equals('Test Section'));
    });

    test('Gutter.small creates small spacing', () {
      final gutter = const Gutter.small();
      expect(gutter, isNotNull);
    });

    test('Gutter.medium creates medium spacing', () {
      final gutter = const Gutter.medium();
      expect(gutter, isNotNull);
    });

    test('Gutter.large creates large spacing', () {
      final gutter = const Gutter.large();
      expect(gutter, isNotNull);
    });

    test('Flow creates with gap', () {
      final flow = const Flow(
        gap: 16,
        children: [Component.text('Item')],
      );
      expect(flow.gap, equals(16));
    });

    test('ButtonPanel creates with children', () {
      final panel = ButtonPanel(
        children: [
          ArcaneButton.primary(label: 'Save', onPressed: () {}),
        ],
      );
      expect(panel.children, isNotEmpty);
    });
  });

  group('View Components', () {
    test('Bar creates with title', () {
      final bar = const Bar(titleText: 'Test Title');
      expect(bar.titleText, equals('Test Title'));
    });

    test('Bar creates with leading and trailing', () {
      final bar = const Bar(
        titleText: 'Title',
        leading: [Component.text('L')],
        trailing: [Component.text('R')],
      );
      expect(bar.leading, isNotEmpty);
      expect(bar.trailing, isNotEmpty);
    });

    test('Glass creates with blur', () {
      final glass = const Glass(
        blur: 10,
        child: Component.text('Content'),
      );
      expect(glass.blur, equals(10));
    });

    test('Glass creates with opacity', () {
      final glass = const Glass(
        blur: 10,
        opacity: 0.8,
        child: Component.text('Content'),
      );
      expect(glass.opacity, equals(0.8));
    });

    test('Expander creates with header', () {
      final expander = const Expander(
        header: Component.text('Title'),
        child: Component.text('Content'),
      );
      expect(expander.header, isNotNull);
    });

    test('Expander initiallyExpanded state', () {
      final expander = const Expander(
        header: Component.text('Title'),
        child: Component.text('Content'),
        initiallyExpanded: true,
      );
      expect(expander.initiallyExpanded, isTrue);
    });

    test('CenterBody creates with child', () {
      final center = const CenterBody(
        child: Component.text('Centered'),
      );
      expect(center.child, isNotNull);
    });
  });

  group('Navigation Components', () {
    test('Sidebar creates with children', () {
      final sidebar = Sidebar(
        children: [
          SidebarItem(label: 'Home', onTap: () {}),
        ],
      );
      expect(sidebar.children, isNotEmpty);
    });

    test('SidebarItem creates with label', () {
      final item = SidebarItem(
        label: 'Home',
        selected: true,
        onTap: () {},
      );
      expect(item.label, equals('Home'));
      expect(item.selected, isTrue);
    });

    test('BottomNavigationBar creates with items', () {
      final nav = BottomNavigationBar(
        selectedIndex: 0,
        onChanged: (_) {},
        items: [
          const BottomNavItem(icon: span([Component.text('H')]), label: 'Home'),
        ],
      );
      expect(nav.items, isNotEmpty);
      expect(nav.selectedIndex, equals(0));
    });

    test('BottomNavItem creates with label and icon', () {
      final item = const BottomNavItem(
        icon: span([Component.text('H')]),
        label: 'Home',
      );
      expect(item.label, equals('Home'));
    });
  });

  group('Dialog Components', () {
    test('ArcaneDialog creates with title', () {
      final dialog = ArcaneDialog(
        title: 'Test Dialog',
        child: const Component.text('Content'),
        onClose: () {},
      );
      expect(dialog.title, equals('Test Dialog'));
    });

    test('ArcaneDialog creates with actions', () {
      final dialog = ArcaneDialog(
        title: 'Dialog',
        child: const Component.text('Content'),
        onClose: () {},
        actions: [
          ArcaneButton.primary(label: 'OK', onPressed: () {}),
        ],
      );
      expect(dialog.actions, isNotEmpty);
    });

    test('ConfirmDialog creates with message', () {
      final dialog = ConfirmDialog(
        title: 'Confirm',
        message: 'Are you sure?',
        onConfirm: () {},
        onCancel: () {},
      );
      expect(dialog.title, equals('Confirm'));
      expect(dialog.message, equals('Are you sure?'));
    });

    test('ConfirmDialog destructive flag', () {
      final dialog = ConfirmDialog(
        title: 'Delete',
        message: 'Delete this?',
        destructive: true,
        onConfirm: () {},
        onCancel: () {},
      );
      expect(dialog.destructive, isTrue);
    });

    test('AlertDialog creates with message', () {
      final dialog = AlertDialog(
        title: 'Alert',
        message: 'Something happened',
        onDismiss: () {},
      );
      expect(dialog.title, equals('Alert'));
      expect(dialog.message, equals('Something happened'));
    });

    test('Toast creates with message', () {
      final toast = Toast(
        message: 'Success!',
        variant: ToastVariant.success,
        onClose: () {},
      );
      expect(toast.message, equals('Success!'));
      expect(toast.variant, equals(ToastVariant.success));
    });

    test('Toast variants', () {
      expect(ToastVariant.success, isNotNull);
      expect(ToastVariant.error, isNotNull);
      expect(ToastVariant.warning, isNotNull);
      expect(ToastVariant.info, isNotNull);
    });
  });

  group('Table Components', () {
    test('StaticTable creates with headers and rows', () {
      final table = const StaticTable(
        headers: ['Name', 'Age'],
        rows: [
          [Component.text('Alice'), Component.text('25')],
        ],
      );
      expect(table.headers, hasLength(2));
      expect(table.rows, hasLength(1));
    });
  });

  group('Collection Components', () {
    test('Collection creates with children', () {
      final collection = const Collection(
        gap: 8,
        children: [Component.text('Item')],
      );
      expect(collection.gap, equals(8));
      expect(collection.children, isNotEmpty);
    });

    test('Collection.builder creates with builder', () {
      final collection = Collection.builder(
        builder: (context, index) => Component.text('Item $index'),
        childCount: 5,
      );
      expect(collection.childCount, equals(5));
    });

    test('ListView creates with gap', () {
      final list = const ListView(
        gap: 8,
        children: [Component.text('Item')],
      );
      expect(list.gap, equals(8));
    });

    test('GridView creates with crossAxisCount', () {
      final grid = const GridView(
        crossAxisCount: 3,
        children: [Component.text('Item')],
      );
      expect(grid.crossAxisCount, equals(3));
    });

    test('MasonryGrid creates with columns', () {
      final masonry = const MasonryGrid(
        columns: 2,
        children: [Component.text('Item')],
      );
      expect(masonry.columns, equals(2));
    });
  });

  group('Screen Components', () {
    test('Screen creates with child', () {
      final screen = const Screen(
        child: Component.text('Content'),
      );
      expect(screen.child, isNotNull);
    });

    test('Screen creates with header', () {
      final screen = const Screen(
        header: Bar(titleText: 'Title'),
        child: Component.text('Content'),
      );
      expect(screen.header, isNotNull);
    });

    test('FillScreen creates with child', () {
      final screen = const FillScreen(
        child: Component.text('Content'),
      );
      expect(screen.child, isNotNull);
    });
  });
}