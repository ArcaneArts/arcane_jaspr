import 'package:jaspr/jaspr.dart';
import 'package:jaspr/dom.dart' as dom;

import 'package:arcane_jaspr/core/renderers.dart';

// Neon-specific renderer imports
import 'accordion.dart';
import 'alert.dart';
import 'aspect_ratio.dart';
import 'avatar.dart';
import 'breadcrumbs.dart';
import 'button.dart';
import 'button_panel.dart';
import 'calendar.dart';
import 'card.dart';
import 'cta_card.dart';
import 'feature_card.dart';
import 'pricing_card.dart';
import 'gallery.dart';
import 'stat_card.dart';
import 'testimonial_card.dart';
import 'chart.dart';
import 'check_list.dart';
import 'checkbox.dart';
import 'command.dart';
import 'confirm_dialog.dart';
import 'context_menu.dart';
import 'cycle_button.dart';
import 'data_table.dart';
import 'date_picker.dart';
import 'direction.dart';
import 'dialog.dart';
import 'disclosure.dart';
import 'dropdown_menu.dart';
import 'drawer.dart';
import 'empty_state.dart';
import 'field_wrapper.dart';
import 'flexi_cards.dart';
import 'floating.dart';
import 'flow.dart';
import 'form.dart';
import 'gutter.dart';
import 'item.dart';
import 'kbd.dart';
import 'menubar.dart';
import 'native_select.dart';
import 'otp_input.dart';
import 'pagination.dart';
import 'progress.dart';
import 'radio_group.dart';
import 'resizable.dart';
import 'scroll_area.dart';
import 'scroll_rail.dart';
import 'select.dart';
import 'separator.dart';
import 'sidebar.dart';
import 'slider.dart';
import 'slot_counter.dart';
import 'spec_row.dart';
import 'static_table.dart';
import 'status_badge.dart';
import 'tabs.dart';
import 'text_area.dart';
import 'text_input.dart';
import 'time_picker.dart';
import 'toast.dart';
import 'toggle_group.dart';
import 'toggle_switch.dart';
import 'skeleton.dart';
import 'promo/promo.dart';

/// Neon component renderers.
///
/// Implements all components according to the Neon design language:
/// - OLED-first dark mode with pure black backgrounds
/// - Restrained accent emphasis
/// - 1.25x spacing compared to ShadCN
/// - Larger border radius (14px default)
/// - Dark, high-contrast palette
class NeonRenderers extends ComponentRenderers with TextAreaRendererContract {
  const NeonRenderers();

  @override
  Component button(ButtonProps props) => NeonButton(props);

  @override
  Component textInput(TextInputProps props) => NeonTextInput(props);

  @override
  Component textArea(TextAreaProps props) => NeonTextArea(props);

  @override
  Component card(CardProps props) => NeonCard(props);

  @override
  Component gallery(GalleryProps props) => NeonGallery(props);

  @override
  Component statCard(StatCardProps props) => NeonStatCard(props);

  @override
  Component statCardRow(StatCardRowProps props) => NeonStatCardRow(props);

  @override
  Component featureCard(FeatureCardProps props) => NeonFeatureCard(props);

  @override
  Component iconCard(IconCardProps props) => NeonIconCard(props);

  @override
  Component ctaCard(CTACardProps props) => NeonCtaCard(props);

  @override
  Component testimonialCard(TestimonialCardProps props) =>
      NeonTestimonialCard(props);

  @override
  Component ratingStarsSimple(RatingStarsSimpleProps props) =>
      NeonRatingStarsSimple(props);

  @override
  Component pricingCard(PricingCardProps props) => NeonPricingCard(props);

  @override
  Component pricingGrid(PricingGridProps props) => NeonPricingGrid(props);

  @override
  Component chart(ChartProps props) => NeonChart(props);

  @override
  Component alert(AlertProps props) => NeonAlert(props);

  @override
  Component avatar(AvatarProps props) => NeonAvatar(props);

  @override
  Component progress(ProgressProps props) => NeonProgress(props);

  @override
  Component circularProgress(CircularProgressProps props) =>
      NeonCircularProgress(props);

  @override
  Component loadingSpinner(LoadingSpinnerProps props) =>
      NeonLoadingSpinner(props);

  @override
  Component skeleton(SkeletonProps props) => NeonSkeleton(props);

  @override
  Component checkbox(CheckboxProps props) => NeonCheckbox(props);

  @override
  Component toggleSwitch(ToggleSwitchProps props) => NeonToggleSwitch(props);

  @override
  Component slider(SliderProps props) => NeonSlider(props);

  @override
  Component tabs(TabsProps props) => NeonTabs(props);

  @override
  Component tabBar(TabBarProps props) => NeonTabBar(props);

  @override
  Component breadcrumbs(BreadcrumbsProps props) => NeonBreadcrumbs(props);

  @override
  Component sidebar(SidebarProps props) => NeonSidebar(props);

  @override
  Component sidebarItem(SidebarItemProps props) => NeonSidebarItem(props);

  @override
  Component sidebarGroup(SidebarGroupProps props) => NeonSidebarGroup(props);

  @override
  Component sidebarSubMenu(SidebarSubMenuProps props) =>
      NeonSidebarSubMenu(props);

  @override
  Component sidebarSection(SidebarSectionProps props) =>
      NeonSidebarSection(props);

  @override
  Component sidebarExpanded(List<Component> children) => dom.div(
    classes: 'neon-sidebar-expanded-only',
    styles: const dom.Styles(
      raw: <String, String>{
        'display': 'var(--sidebar-expanded-display, block)',
      },
    ),
    children,
  );

  @override
  Component sidebarCollapsed(List<Component> children) => dom.div(
    classes: 'neon-sidebar-collapsed-only',
    styles: const dom.Styles(
      raw: <String, String>{
        'display': 'var(--sidebar-collapsed-display, none)',
      },
    ),
    children,
  );

  @override
  Component sidebarSeparator() => const NeonSidebarSeparator();

  @override
  Component dialog(DialogProps props) => NeonDialog(props);

  @override
  Component sheet(SheetProps props) => NeonSheet(props);

  @override
  Component drawer(DrawerProps props) => NeonDrawer(props);

  @override
  Component toast(ToastProps props) => NeonToast(props);

  @override
  Component toastContainer(ToastContainerProps props) =>
      NeonToastContainer(props);

  @override
  Component floating(FloatingProps props) => NeonFloating(props);

  @override
  Component radioGroup<T>(RadioGroupProps<T> props) => NeonRadioGroup<T>(props);

  @override
  Component select<T>(SelectProps<T> props) => NeonSelect<T>(props);

  @override
  Component separator(SeparatorProps props) => NeonSeparator(props);

  @override
  Component accordion(AccordionProps props) => NeonAccordion(props);

  @override
  Component pagination(PaginationProps props) => NeonPagination(props);

  @override
  Component emptyState(EmptyStateProps props) => NeonEmptyState(props);

  @override
  Component statusBadge(StatusBadgeProps props) => NeonStatusBadge(props);

  @override
  Component row(RowProps props) => NeonRow(props);

  @override
  Component column(ColumnProps props) => NeonColumn(props);

  @override
  Component center(CenterProps props) => NeonCenter(props);

  @override
  Component spacer(SpacerProps props) => NeonSpacer(props);

  @override
  Component expanded(ExpandedProps props) => NeonExpanded(props);

  @override
  Component sizedBox(SizedBoxProps props) => NeonSizedBox(props);

  @override
  Component flow(FlowProps props) => NeonFlow(props);

  @override
  Component direction(DirectionProps props) => NeonDirection(props);

  @override
  Component gap(GapProps props) => NeonGap(props);

  @override
  Component buttonPanel(ButtonPanelProps props) => NeonButtonPanel(props);

  @override
  Component toolbar(ToolbarProps props) => NeonToolbar(props);

  @override
  Component buttonGroup(ButtonGroupProps props) => NeonButtonGroup(props);

  @override
  Component aspectRatio(AspectRatioProps props) => NeonAspectRatio(props);

  @override
  Component gutter(GutterProps props) => NeonGutter(props);

  @override
  Component paddingWrapper(PaddingWrapperProps props) =>
      NeonPaddingWrapper(props);

  @override
  Component fieldWrapper(FieldWrapperProps props) => NeonFieldWrapper(props);

  @override
  Component formSection(FormSectionProps props) => NeonFormSection(props);

  @override
  Component form(FormProps props) => NeonForm(props);

  @override
  Component inputGroup(InputGroupProps props) => NeonInputGroup(props);

  @override
  Component resizable(ResizableProps props) => NeonResizable(props);

  @override
  Component item(ItemProps props) => NeonItem(props);

  @override
  Component flexiCards(FlexiCardsProps props) => NeonFlexiCards(props);

  @override
  Component flexiCardsSimple(FlexiCardsSimpleProps props) =>
      NeonFlexiCardsSimple(props);

  @override
  Component checkItem(CheckItemProps props) => NeonCheckItem(props);

  @override
  Component checkList(CheckListProps props) => NeonCheckList(props);

  @override
  Component featureRow(FeatureRowProps props) => NeonFeatureRow(props);

  @override
  Component specRow(SpecRowProps props) => NeonSpecRow(props);

  @override
  Component calendar(CalendarProps props) => NeonCalendar(props);

  @override
  Component command(CommandProps props) => NeonCommand(props);

  @override
  Component confirmDialog(ConfirmDialogProps props) => NeonConfirmDialog(props);

  @override
  Component alertDialog(AlertDialogProps props) => NeonAlertDialog(props);

  @override
  Component contextMenu(ContextMenuProps props) => NeonContextMenu(props);

  @override
  Component cycleButton<T>(CycleButtonProps<T> props) =>
      NeonCycleButton<T>(props);

  @override
  Component toggleButton(ToggleButtonProps props) => NeonToggleButton(props);

  @override
  Component dataTable<T>(DataTableProps<T> props) => NeonDataTable<T>(props);

  @override
  Component datePicker(DatePickerProps props) => NeonDatePicker(props);

  @override
  Component disclosure(DisclosureProps props) => NeonDisclosure(props);

  @override
  Component disclosureGroup(DisclosureGroupProps props) =>
      NeonDisclosureGroup(props);

  @override
  Component dropdownMenu(DropdownMenuProps props) => NeonDropdownMenu(props);

  @override
  Component kbd(KbdProps props) => NeonKbd(props);

  @override
  Component menubar(MenubarProps props) => NeonMenubar(props);

  @override
  Component nativeSelect(NativeSelectProps props) => NeonNativeSelect(props);

  @override
  Component otpInput(OtpInputProps props) => NeonOtpInput(props);

  @override
  Component scrollArea(ScrollAreaProps props) => NeonScrollArea(props);

  @override
  Component scrollRail(ScrollRailProps props) => NeonScrollRail(props);

  @override
  Component scrollRailLayout(ScrollRailLayoutProps props) =>
      NeonScrollRailLayout(props);

  @override
  Component virtualScroll<T>(VirtualScrollProps<T> props) =>
      NeonVirtualScroll<T>(props);

  @override
  Component slotCounter(SlotCounterProps props) => NeonSlotCounter(props);

  @override
  Component slotCounterRow(SlotCounterRowProps props) =>
      NeonSlotCounterRow(props);

  @override
  Component slotCounterCard(SlotCounterCardProps props) =>
      NeonSlotCounterCard(props);

  @override
  Component staticTable(StaticTableProps props) => NeonStaticTable(props);

  @override
  Component keyValueTable(KeyValueTableProps props) => NeonKeyValueTable(props);

  @override
  Component timePicker(TimePickerProps props) => NeonTimePicker(props);

  @override
  Component toggleGroup(ToggleGroupProps props) => NeonToggleGroup(props);

  @override
  Component topAnnouncementBar(TopAnnouncementBarProps props) =>
      NeonTopAnnouncementBar(props);

  @override
  Component inlineHeroBanner(InlineHeroBannerProps props) =>
      NeonInlineHeroBanner(props);
}
