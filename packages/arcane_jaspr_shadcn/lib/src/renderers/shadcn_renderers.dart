import 'package:jaspr/jaspr.dart';

import 'package:arcane_jaspr/core/renderers.dart';
import 'alert.dart';
import 'avatar.dart';
import 'button.dart';
import 'calendar.dart';
import 'card.dart';
import 'chart.dart';
import 'cta_card.dart';
import 'feature_card.dart';
import 'pricing_card.dart';
import 'gallery.dart';
import 'stat_card.dart';
import 'testimonial_card.dart';
import 'checkbox.dart';
import 'command.dart';
import 'context_menu.dart';
import 'data_table.dart';
import 'date_picker.dart';
import 'direction.dart';
import 'dialog.dart';
import 'dropdown_menu.dart';
import 'drawer.dart';
import 'empty_state.dart';
import 'item.dart';
import 'menubar.dart';
import 'native_select.dart';
import 'otp_input.dart';
import 'pagination.dart';
import 'progress.dart';
import 'radio_group.dart';
import 'scroll_area.dart';
import 'select.dart';
import 'separator.dart';
import 'sidebar.dart';
import 'slider.dart';
import 'tabs.dart';
import 'text_area.dart';
import 'text_input.dart';
import 'toast.dart';
import 'toggle_group.dart';
import 'toggle_switch.dart';
import 'accordion.dart';
import 'breadcrumbs.dart';
import 'floating.dart';
import 'cycle_button.dart';
import 'confirm_dialog.dart';
import 'status_badge.dart' as status_badge_renderer;
import 'kbd.dart';
import 'disclosure.dart';
import 'static_table.dart';
import 'check_list.dart';
import 'spec_row.dart';
import 'time_picker.dart';
import 'flexi_cards.dart';
import 'slot_counter.dart';
import 'field_wrapper.dart';
import 'form.dart';
import 'gutter.dart';
import 'flow.dart';
import 'button_panel.dart';
import 'aspect_ratio.dart';
import 'scroll_rail.dart';
import 'resizable.dart';
import 'skeleton.dart';
import 'promo/promo.dart';

/// ShadCN component renderers.
///
/// Implements all components according to the ShadCN/ui design language.
/// Reference: https://ui.shadcn.com
class ShadcnRenderers extends ComponentRenderers with TextAreaRendererContract {
  const ShadcnRenderers();

  @override
  Component button(ButtonProps props) => ShadcnButton(props);

  @override
  Component checkbox(CheckboxProps props) => ShadcnCheckbox(props);

  @override
  Component toggleSwitch(ToggleSwitchProps props) => ShadcnToggleSwitch(props);

  @override
  Component slider(SliderProps props) => ShadcnSlider(props);

  @override
  Component textInput(TextInputProps props) => ShadcnTextInput(props);

  @override
  Component textArea(TextAreaProps props) => ShadcnTextArea(props);

  @override
  Component radioGroup<T>(RadioGroupProps<T> props) =>
      ShadcnRadioGroup<T>(props);

  @override
  Component cycleButton<T>(CycleButtonProps<T> props) =>
      ShadcnCycleButton<T>(props);

  @override
  Component toggleButton(ToggleButtonProps props) => ShadcnToggleButton(props);

  @override
  Component timePicker(TimePickerProps props) => ShadcnTimePicker(props);

  @override
  Component alert(AlertProps props) => ShadcnAlert(props);

  @override
  Component avatar(AvatarProps props) => ShadcnAvatar(props);

  @override
  Component card(CardProps props) => ShadcnCard(props);

  @override
  Component gallery(GalleryProps props) => ShadcnGallery(props);

  @override
  Component statCard(StatCardProps props) => ShadcnStatCard(props);

  @override
  Component statCardRow(StatCardRowProps props) => ShadcnStatCardRow(props);

  @override
  Component featureCard(FeatureCardProps props) => ShadcnFeatureCard(props);

  @override
  Component iconCard(IconCardProps props) => ShadcnIconCard(props);

  @override
  Component ctaCard(CTACardProps props) => ShadcnCtaCard(props);

  @override
  Component testimonialCard(TestimonialCardProps props) =>
      ShadcnTestimonialCard(props);

  @override
  Component ratingStarsSimple(RatingStarsSimpleProps props) =>
      ShadcnRatingStarsSimple(props);

  @override
  Component pricingCard(PricingCardProps props) => ShadcnPricingCard(props);

  @override
  Component pricingGrid(PricingGridProps props) => ShadcnPricingGrid(props);

  @override
  Component chart(ChartProps props) => ShadcnChart(props);

  @override
  Component progress(ProgressProps props) => ShadcnProgress(props);

  @override
  Component circularProgress(CircularProgressProps props) =>
      ShadcnCircularProgress(props);

  @override
  Component loadingSpinner(LoadingSpinnerProps props) =>
      ShadcnLoadingSpinner(props);

  @override
  Component skeleton(SkeletonProps props) => ShadcnSkeleton(props);

  @override
  Component separator(SeparatorProps props) => ShadcnSeparator(props);

  @override
  Component emptyState(EmptyStateProps props) => ShadcnEmptyState(props);

  @override
  Component scrollArea(ScrollAreaProps props) => ShadcnScrollArea(props);

  @override
  Component virtualScroll<T>(VirtualScrollProps<T> props) =>
      ShadcnVirtualScroll<T>(props);

  @override
  Component kbd(KbdProps props) => ShadcnKbd(props);

  @override
  Component disclosure(DisclosureProps props) => ShadcnDisclosure(props);

  @override
  Component disclosureGroup(DisclosureGroupProps props) =>
      ShadcnDisclosureGroup(props);

  @override
  Component staticTable(StaticTableProps props) => ShadcnStaticTable(props);

  @override
  Component keyValueTable(KeyValueTableProps props) =>
      ShadcnKeyValueTable(props);

  @override
  Component statusBadge(StatusBadgeProps props) =>
      status_badge_renderer.ShadcnStatusBadge(props);

  @override
  Component checkItem(CheckItemProps props) => ShadcnCheckItem(props);

  @override
  Component checkList(CheckListProps props) => ShadcnCheckList(props);

  @override
  Component featureRow(FeatureRowProps props) => ShadcnFeatureRow(props);

  @override
  Component specRow(SpecRowProps props) => ShadcnSpecRow(props);

  @override
  Component tabs(TabsProps props) => ShadcnTabs(props);

  @override
  Component tabBar(TabBarProps props) => ShadcnTabBar(props);

  @override
  Component accordion(AccordionProps props) => ShadcnAccordion(props);

  @override
  Component floating(FloatingProps props) => ShadcnFloating(props);

  @override
  Component dropdownMenu(DropdownMenuProps props) => ShadcnDropdownMenu(props);

  @override
  Component dialog(DialogProps props) => ShadcnDialog(props);

  @override
  Component sheet(SheetProps props) => ShadcnSheet(props);

  @override
  Component drawer(DrawerProps props) => ShadcnDrawer(props);

  @override
  Component gutter(GutterProps props) => renderGutter(props);

  @override
  Component gap(GapProps props) => renderGap(props);

  @override
  Component flow(FlowProps props) => renderFlow(props);

  @override
  Component direction(DirectionProps props) => ShadcnDirection(props);

  @override
  Component row(RowProps props) => renderRow(props);

  @override
  Component column(ColumnProps props) => renderColumn(props);

  @override
  Component center(CenterProps props) => renderCenter(props);

  @override
  Component spacer(SpacerProps props) => renderSpacer(props);

  @override
  Component expanded(ExpandedProps props) => renderExpanded(props);

  @override
  Component sizedBox(SizedBoxProps props) => renderSizedBox(props);

  @override
  Component paddingWrapper(PaddingWrapperProps props) =>
      renderPaddingWrapper(props);

  @override
  Component buttonPanel(ButtonPanelProps props) => renderButtonPanel(props);

  @override
  Component toolbar(ToolbarProps props) => renderToolbar(props);

  @override
  Component buttonGroup(ButtonGroupProps props) => renderButtonGroup(props);

  @override
  Component aspectRatio(AspectRatioProps props) => renderAspectRatio(props);

  @override
  Component confirmDialog(ConfirmDialogProps props) =>
      ShadcnConfirmDialog(props);

  @override
  Component alertDialog(AlertDialogProps props) => ShadcnAlertDialog(props);

  @override
  Component toast(ToastProps props) => ShadcnToast(props);

  @override
  Component toastContainer(ToastContainerProps props) =>
      ShadcnToastContainer(props);

  @override
  Component command(CommandProps props) => ShadcnCommand(props);

  @override
  Component dataTable<T>(DataTableProps<T> props) => ShadcnDataTable<T>(props);

  @override
  Component sidebar(SidebarProps props) => ShadcnSidebar(props);

  @override
  Component sidebarItem(SidebarItemProps props) => ShadcnSidebarItem(props);

  @override
  Component sidebarGroup(SidebarGroupProps props) => ShadcnSidebarGroup(props);

  @override
  Component sidebarSubMenu(SidebarSubMenuProps props) =>
      ShadcnSidebarSubMenu(props);

  @override
  Component sidebarSection(SidebarSectionProps props) =>
      ShadcnSidebarSection(props);

  @override
  Component sidebarExpanded(List<Component> children) =>
      ShadcnSidebarExpanded(children);

  @override
  Component sidebarCollapsed(List<Component> children) =>
      ShadcnSidebarCollapsed(children);

  @override
  Component sidebarSeparator() => const ShadcnSidebarSeparator();

  @override
  Component breadcrumbs(BreadcrumbsProps props) => ShadcnBreadcrumbs(props);

  @override
  Component pagination(PaginationProps props) => ShadcnPagination(props);

  @override
  Component select<T>(SelectProps<T> props) => ShadcnSelect<T>(props);

  @override
  Component nativeSelect(NativeSelectProps props) => ShadcnNativeSelect(props);

  @override
  Component contextMenu(ContextMenuProps props) => ShadcnContextMenu(props);

  @override
  Component toggleGroup(ToggleGroupProps props) => ShadcnToggleGroup(props);

  @override
  Component menubar(MenubarProps props) => ShadcnMenubar(props);

  @override
  Component calendar(CalendarProps props) => ShadcnCalendar(props);

  @override
  Component datePicker(DatePickerProps props) => ShadcnDatePicker(props);

  @override
  Component otpInput(OtpInputProps props) => ShadcnOtpInput(props);

  @override
  Component flexiCards(FlexiCardsProps props) => ShadcnFlexiCards(props);

  @override
  Component flexiCardsSimple(FlexiCardsSimpleProps props) =>
      ShadcnFlexiCardsSimple(props);

  @override
  Component slotCounter(SlotCounterProps props) => ShadcnSlotCounter(props);

  @override
  Component slotCounterRow(SlotCounterRowProps props) =>
      ShadcnSlotCounterRow(props);

  @override
  Component slotCounterCard(SlotCounterCardProps props) =>
      ShadcnSlotCounterCard(props);

  @override
  Component fieldWrapper(FieldWrapperProps props) => ShadcnFieldWrapper(props);

  @override
  Component item(ItemProps props) => ShadcnItem(props);

  @override
  Component formSection(FormSectionProps props) => ShadcnFormSection(props);

  @override
  Component form(FormProps props) => ShadcnForm(props);

  @override
  Component inputGroup(InputGroupProps props) => ShadcnInputGroup(props);

  @override
  Component scrollRail(ScrollRailProps props) => renderScrollRail(props);

  @override
  Component scrollRailLayout(ScrollRailLayoutProps props) =>
      renderScrollRailLayout(props);

  @override
  Component resizable(ResizableProps props) => renderResizable(props);

  @override
  Component topAnnouncementBar(TopAnnouncementBarProps props) =>
      ShadcnTopAnnouncementBar(props);

  @override
  Component inlineHeroBanner(InlineHeroBannerProps props) =>
      ShadcnInlineHeroBanner(props);
}
