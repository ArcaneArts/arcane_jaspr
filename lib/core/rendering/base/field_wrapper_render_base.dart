import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/props/field_wrapper_props.dart';

/// Shared structural base for themed field-wrapper renderers.
///
/// Factors the identical scaffold shared by every theme's field wrapper — the
/// `hasError` computation, the root container, and the fixed child ordering
/// (label row, description, field content, error) — into one place. The label
/// row, description, field content and error nodes diverge structurally between
/// themes (ShadCN supports an icon, classed label, a content wrapper and an
/// error indicator span; the neon/neubrutalism themes use a leaner structure),
/// so each is supplied by an abstract sub-builder the subclass overrides.
///
/// This base lives in core and depends only on core props; it must never depend
/// on a theme package.
abstract class FieldWrapperRenderBase extends StatelessComponent {
  const FieldWrapperRenderBase(this.props, {super.key});

  final FieldWrapperProps props;

  /// CSS class applied to the root wrapper element.
  String get cssClass;

  /// Inline styles for the root wrapper element.
  Map<String, String> get wrapperStyles;

  /// Builds the label row, or returns `null` when no label row is rendered.
  Component? buildLabelRow(FieldWrapperProps props, bool hasError);

  /// Builds the description block, or returns `null` when absent.
  Component? buildDescription(FieldWrapperProps props);

  /// Builds the field content node (some themes wrap the field, some do not).
  Component buildFieldContent(FieldWrapperProps props);

  /// Builds the error message, or returns `null` when not shown.
  Component? buildError(FieldWrapperProps props, bool hasError);

  @override
  Component build(BuildContext context) {
    final bool hasError = props.error != null && props.error!.isNotEmpty;

    final Component? labelRow = buildLabelRow(props, hasError);
    final Component? description = buildDescription(props);
    final Component? error = buildError(props, hasError);

    return dom.div(
      classes: cssClass,
      styles: dom.Styles(raw: wrapperStyles),
      <Component>[
        ?labelRow,
        ?description,
        buildFieldContent(props),
        ?error,
      ],
    );
  }
}

/// Shared structural base for themed form-section renderers.
///
/// The header skeleton (the outer header container, the title/description
/// conditionals and the trailing children) is identical across themes, while
/// the root element (ShadCN uses a `div`, the others a `fieldset`), the title
/// element and the description element diverge structurally. Those divergent
/// nodes are supplied by abstract sub-builders.
abstract class FormSectionRenderBase extends StatelessComponent {
  const FormSectionRenderBase(this.props, {super.key});

  final FormSectionProps props;

  /// CSS class applied to the header container.
  String get headerClass;

  /// Builds the root element wrapping the assembled [children].
  Component buildRoot(List<Component> children);

  /// Builds the section title element.
  Component buildTitle(FormSectionProps props);

  /// Builds the section description element.
  Component buildDescription(FormSectionProps props);

  @override
  Component build(BuildContext context) {
    return buildRoot(<Component>[
      if (props.title != null || props.description != null)
        dom.div(
          classes: headerClass,
          styles: const dom.Styles(raw: {'margin-bottom': '0.5rem'}),
          <Component>[
            if (props.title != null) buildTitle(props),
            if (props.description != null) buildDescription(props),
          ],
        ),
      ...props.children,
    ]);
  }
}

/// Shared structural base for themed input-group renderers.
///
/// Every theme produces the identical markup; only the group/item CSS class
/// names differ, so those are the only abstract members.
abstract class InputGroupRenderBase extends StatelessComponent {
  const InputGroupRenderBase(this.props, {super.key});

  final InputGroupProps props;

  /// CSS class applied to the outer group container.
  String get groupClass;

  /// CSS class applied to each wrapped item.
  String get itemClass;

  @override
  Component build(BuildContext context) {
    final List<Component> children = <Component>[];
    for (final Component child in props.children) {
      children.add(
        dom.div(
          classes: itemClass,
          styles: const dom.Styles(
            raw: {'display': 'flex', 'align-items': 'stretch'},
          ),
          [child],
        ),
      );
    }

    return dom.div(
      classes: groupClass,
      styles: dom.Styles(
        raw: {
          'display': 'flex',
          'align-items': 'stretch',
          'gap': '${props.gap}px',
        },
      ),
      children,
    );
  }
}
