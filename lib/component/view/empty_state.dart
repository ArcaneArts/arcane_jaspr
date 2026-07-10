import 'package:arcane_jaspr/flutter.dart';

import '../../core/decoration/arcane_decoration.dart';
import '../../core/theme_provider.dart';
import '../../util/style_types/arcane_style_data.dart';
import 'icon.dart';

export '../../core/props/empty_state_props.dart'
    show EmptyStateStyleVariant, EmptyStateSizeVariant, EmptyStateProps;

typedef EmptyStateStyle = EmptyStateStyleVariant;
typedef EmptyStateSize = EmptyStateSizeVariant;

/// Empty state placeholder component displaying a message when there's no content.
class ArcaneEmptyState extends StatelessWidget {
  final Widget? icon;
  final String title;
  final String? description;
  final Widget? action;
  final Widget? secondaryAction;
  final EmptyStateStyle style;
  final EmptyStateSize size;

  /// Literal, theme-permeable style override (always applied, wins over theme).
  final ArcaneStyleData? styles;

  /// Semantic, theme-interpreted decoration (elevation + theme-specific fields).
  final ArcaneDecoration? decoration;

  const ArcaneEmptyState({
    required this.title,
    this.icon,
    this.description,
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyle.centered,
    this.size = EmptyStateSize.md,
    this.styles,
    this.decoration,
    super.key,
  });

  ArcaneEmptyState.noResults({
    this.title = 'No results found',
    this.description = 'Try adjusting your search or filter criteria.',
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyle.centered,
    this.size = EmptyStateSize.md,
    this.styles,
    this.decoration,
    super.key,
  }) : icon = ArcaneIcon.search(size: IconSize.lg);

  ArcaneEmptyState.noData({
    this.title = 'No data yet',
    this.description = 'Start by adding your first item.',
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyle.centered,
    this.size = EmptyStateSize.md,
    this.styles,
    this.decoration,
    super.key,
  }) : icon = ArcaneIcon.database(size: IconSize.lg);

  ArcaneEmptyState.error({
    this.title = 'Something went wrong',
    this.description = 'An error occurred while loading the content.',
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyle.centered,
    this.size = EmptyStateSize.md,
    this.styles,
    this.decoration,
    super.key,
  }) : icon = ArcaneIcon.triangleAlert(size: IconSize.lg);

  ArcaneEmptyState.offline({
    this.title = 'You\'re offline',
    this.description = 'Check your internet connection and try again.',
    this.action,
    this.secondaryAction,
    this.style = EmptyStateStyle.centered,
    this.size = EmptyStateSize.md,
    this.styles,
    this.decoration,
    super.key,
  }) : icon = ArcaneIcon.wifiOff(size: IconSize.lg);

  EmptyStateStyleVariant get _propsStyle => switch (style) {
        EmptyStateStyle.centered => EmptyStateStyleVariant.centered,
        EmptyStateStyle.compact => EmptyStateStyleVariant.compact,
        EmptyStateStyle.card => EmptyStateStyleVariant.card,
      };

  EmptyStateSizeVariant get _propsSize => switch (size) {
        EmptyStateSize.sm => EmptyStateSizeVariant.sm,
        EmptyStateSize.md => EmptyStateSizeVariant.md,
        EmptyStateSize.lg => EmptyStateSizeVariant.lg,
      };

  @override
  Widget build(BuildContext context) {
    return context.renderers.emptyState(EmptyStateProps(
      icon: icon,
      title: title,
      description: description,
      action: action,
      secondaryAction: secondaryAction,
      style: _propsStyle,
      size: _propsSize,
      styles: styles,
      decoration: decoration,
    ));
  }
}
