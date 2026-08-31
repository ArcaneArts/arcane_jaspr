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

import '../../util/classes.dart';
import '../../util/style_types/arcane_style_data.dart';

/// Styled table wrapper.
class ArcaneTable extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final List<String>? classes;
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
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// Styled thead wrapper.
class ArcaneTableHead extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final List<String>? classes;
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
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// Styled tbody wrapper.
class ArcaneTableBody extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final List<String>? classes;
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
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// Styled table row wrapper.
class ArcaneTableRow extends StatelessComponent {
  final List<Component> children;
  final ArcaneStyleData? styles;
  final List<String>? classes;
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
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      children,
    );
  }
}

/// Styled table header cell wrapper.
class ArcaneTableHeader extends StatelessComponent {
  final Component child;
  final ArcaneStyleData? styles;
  final List<String>? classes;
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
    List<String>? classes,
    String? id,
    Key? key,
  }) = _ArcaneTableHeaderChildren;

  @override
  Component build(BuildContext context) {
    return th(
      id: id,
      classes: classes == null ? null : cx(classes!),
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
  }) : _children = children,
       super(child: const _Placeholder());

  @override
  Component build(BuildContext context) {
    return th(
      id: id,
      classes: classes == null ? null : cx(classes!),
      styles: styles?.toStyles() ?? const Styles(raw: {}),
      _children,
    );
  }
}

/// Styled table data cell wrapper.
class ArcaneTableCell extends StatelessComponent {
  final Component child;
  final ArcaneStyleData? styles;
  final List<String>? classes;
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
    List<String>? classes,
    String? id,
    Key? key,
  }) = _ArcaneTableCellChildren;

  @override
  Component build(BuildContext context) {
    return td(
      id: id,
      classes: classes == null ? null : cx(classes!),
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
  }) : _children = children,
       super(child: const _Placeholder());

  @override
  Component build(BuildContext context) {
    return td(
      id: id,
      classes: classes == null ? null : cx(classes!),
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
