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
        FontWeight,
        FontStyle,
        StyleRule,
        Display,
        Position,
        Overflow,
        Cursor,
        Visibility,
        TextDecoration,
        TextTransform,
        FontFamily,
        WhiteSpace,
        events;

import '../../util/style_types/arcane_style_data.dart';

/// A table component that wraps the HTML `<table>` element.
class ArcaneTable extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final String? classes;
  final String? id;

  const ArcaneTable({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return table(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// A table head component that wraps the HTML `<thead>` element.
class ArcaneTableHead extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final String? classes;
  final String? id;

  const ArcaneTableHead({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return thead(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// A table body component that wraps the HTML `<tbody>` element.
class ArcaneTableBody extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final String? classes;
  final String? id;

  const ArcaneTableBody({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return tbody(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// A table row component that wraps the HTML `<tr>` element.
class ArcaneTableRow extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final String? classes;
  final String? id;

  const ArcaneTableRow({
    required this.children,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  @override
  Component build(BuildContext context) {
    return tr(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// A table header cell component that wraps the HTML `<th>` element.
class ArcaneTableHeader extends StatelessComponent {
  final Component child;
  final ArcaneStyleData? styles;
  final String? classes;
  final String? id;

  const ArcaneTableHeader({
    required this.child,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  const factory ArcaneTableHeader.children({
    required List<Component> children,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) = _ArcaneTableHeaderChildren;

  @override
  Component build(BuildContext context) {
    return th(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      [child],
    );
  }
}

class _ArcaneTableHeaderChildren extends ArcaneTableHeader {
  final List<Component> _children;

  const _ArcaneTableHeaderChildren({
    required List<Component> children,
    super.styles,
    super.classes,
    super.id,
    super.key,
  })  : _children = children,
        super(child: const _Placeholder());

  @override
  Component build(BuildContext context) {
    return th(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      _children,
    );
  }
}

/// A table data cell component that wraps the HTML `<td>` element.
class ArcaneTableCell extends StatelessComponent {
  final Component child;
  final ArcaneStyleData? styles;
  final String? classes;
  final String? id;

  const ArcaneTableCell({
    required this.child,
    this.styles,
    this.classes,
    this.id,
    super.key,
  });

  const factory ArcaneTableCell.children({
    required List<Component> children,
    ArcaneStyleData? styles,
    String? classes,
    String? id,
    Key? key,
  }) = _ArcaneTableCellChildren;

  @override
  Component build(BuildContext context) {
    return td(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      [child],
    );
  }
}

class _ArcaneTableCellChildren extends ArcaneTableCell {
  final List<Component> _children;

  const _ArcaneTableCellChildren({
    required List<Component> children,
    super.styles,
    super.classes,
    super.id,
    super.key,
  })  : _children = children,
        super(child: const _Placeholder());

  @override
  Component build(BuildContext context) {
    return td(
      id: id,
      classes: classes,
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      _children,
    );
  }
}

class _Placeholder extends StatelessComponent {
  const _Placeholder();
  @override
  Component build(BuildContext context) => const Component.text('');
}
