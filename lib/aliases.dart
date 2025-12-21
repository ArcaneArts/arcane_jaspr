/// Shorthand A* aliases for all Arcane* components.
///
/// Import this file to use shorter component names:
/// ```dart
/// import 'package:arcane_jaspr/aliases.dart';
///
/// // Now you can use:
/// AButton(...)     // instead of ArcaneButton(...)
/// ACard(...)       // instead of ArcaneCard(...)
/// AText(...)       // instead of ArcaneText(...)
/// ```

// Re-export everything from the main library
export 'arcane_jaspr.dart';

// Import for typedefs
import 'arcane_jaspr.dart';

// ============================================================================
// Component Aliases (A* → Arcane*)
// ============================================================================

// Interactive
typedef AAccordion = ArcaneAccordion;
typedef AAccordionItem = ArcaneAccordionItem;
typedef AFaqAccordion = ArcaneFaqAccordion;
typedef ABackToTop = ArcaneBackToTop;
typedef AScrollProgress = ArcaneScrollProgress;
typedef AFloatingActionButton = ArcaneFloatingActionButton;

// Support
typedef AApp = ArcaneApp;

// HTML Elements
typedef AAside = ArcaneAside;
typedef ABlockquote = ArcaneBlockquote;
typedef ADiv = ArcaneDiv;
typedef AHeading = ArcaneHeading;
typedef AHtmlFooter = ArcaneHtmlFooter;
typedef AImage = ArcaneImage;
typedef AInput = ArcaneInput;
typedef ALabel = ArcaneLabel;
typedef ALink = ArcaneLink;
typedef AListItem = ArcaneListItem;
typedef AMain = ArcaneMain;
typedef ANav = ArcaneNav;
typedef AOrderedList = ArcaneOrderedList;
typedef AParagraph = ArcaneParagraph;
typedef APre = ArcanePre;
typedef ARawButton = ArcaneRawButton;
typedef ARawInput = ArcaneRawInput;
typedef ASection = ArcaneSection;
typedef ASpan = ArcaneSpan;
typedef ATable = ArcaneTable;
typedef ATableBody = ArcaneTableBody;
typedef ATableCell = ArcaneTableCell;
typedef ATableHead = ArcaneTableHead;
typedef ATableHeader = ArcaneTableHeader;
typedef ATableRow = ArcaneTableRow;
typedef AUnorderedList = ArcaneUnorderedList;

// Layout
typedef AAuthBackLink = ArcaneAuthBackLink;
typedef AAuthLayout = ArcaneAuthLayout;
typedef ABorder = ArcaneBorder;
typedef ABox = ArcaneBox;
typedef ABoxDecoration = ArcaneBoxDecoration;
typedef AButtonGroup = ArcaneButtonGroup;
typedef AButtonPanel = ArcaneButtonPanel;
typedef ACarouselSection = ArcaneCarouselSection;
typedef ACarpet = ArcaneCarpet;
typedef ACenter = ArcaneCenter;
typedef AChip = ArcaneChip;
typedef AChipGroup = ArcaneChipGroup;
typedef AColumn = ArcaneColumn;
typedef AContainer = ArcaneContainer;
typedef ACtaBanner = ArcaneCtaBanner;
typedef ACtaGroup = ArcaneCtaGroup;
typedef ADashboardLayout = ArcaneDashboardLayout;
typedef ADashboardTopBar = ArcaneDashboardTopBar;
typedef ADashboardUserMenu = ArcaneDashboardUserMenu;
typedef ADivider = ArcaneDivider;
typedef AExpanded = ArcaneExpanded;
typedef AFlow = ArcaneFlow;
typedef AFooter = ArcaneFooter;
typedef AFooterLink = ArcaneFooterLink;
typedef AFooterLinkGroup = ArcaneFooterLinkGroup;
typedef AGap = ArcaneGap;
typedef AGutter = ArcaneGutter;
typedef AHeroSection = ArcaneHeroSection;
typedef ALogoCarousel = ArcaneLogoCarousel;
typedef ALogoGrid = ArcaneLogoGrid;
typedef ALogoItem = ArcaneLogoItem;
typedef APadding = ArcanePadding;
typedef APositioned = ArcanePositioned;
typedef ARadioCardItem = ArcaneRadioCardItem;
typedef ARadioCards = ArcaneRadioCards;
typedef ARow = ArcaneRow;
typedef ASizedBox = ArcaneSizedBox;
typedef ASliverSection = ArcaneSliverSection;
typedef ASpacer = ArcaneSpacer;
typedef AStack = ArcaneStack;
typedef ASurface = ArcaneSurface;
typedef ATabItem = ArcaneTabItem;
typedef ATabs = ArcaneTabs;
typedef AToolbar = ArcaneToolbar;
typedef AVerticalDivider = ArcaneVerticalDivider;

// Navigation
typedef ABottomBar = ArcaneBottomBar;
typedef ABottomNavigationBar = ArcaneBottomNavigationBar;
typedef ABottomNavItem = ArcaneBottomNavItem;
typedef ADropdownItem = ArcaneDropdownItem;
typedef ADropdownMenu = ArcaneDropdownMenu;
typedef AHamburgerButton = ArcaneHamburgerButton;
typedef AHeader = ArcaneHeader;
typedef AMegaMenu = ArcaneMegaMenu;
typedef AMegaMenuSection = ArcaneMegaMenuSection;
typedef AMobileMenu = ArcaneMobileMenu;
typedef AMobileNavItem = ArcaneMobileNavItem;
typedef ANavItem = ArcaneNavItem;
typedef ANavLink = ArcaneNavLink;
typedef ASidebar = ArcaneSidebar;
typedef ASidebarGroup = ArcaneSidebarGroup;
typedef ASidebarItem = ArcaneSidebarItem;

// Screen
typedef AFillScreen = ArcaneFillScreen;
typedef AFullScreen = ArcaneFullScreen;
typedef ANavigationDestination = ArcaneNavigationDestination;
typedef ANavigationScreen = ArcaneNavigationScreen;
typedef AScreen = ArcaneScreen;
typedef AWindow = ArcaneWindow;

// Input
typedef AButton = ArcaneButton;
typedef ACheckbox = ArcaneCheckbox;
typedef ACloseButton = ArcaneCloseButton;
typedef ACycleButton = ArcaneCycleButton;
typedef ACycleOption = ArcaneCycleOption;
typedef AFAB = ArcaneFAB;
typedef AIconButton = ArcaneIconButton;
typedef ARadio = ArcaneRadio;
typedef ARangeSlider = ArcaneRangeSlider;
typedef ASearch = ArcaneSearch;
typedef ASearchBar = ArcaneSearchBar;
typedef ASearchResult = ArcaneSearchResult;
typedef ASelect = ArcaneSelect;
typedef ASelectOption = ArcaneSelectOption;
typedef ASelector = ArcaneSelector;
typedef ASelectorOption = ArcaneSelectorOption;
typedef ASlider = ArcaneSlider;
typedef ATextArea = ArcaneTextArea;
typedef ATextInput = ArcaneTextInput;
typedef AThemeToggle = ArcaneThemeToggle;
typedef AThemeToggleSimple = ArcaneThemeToggleSimple;
typedef AToggleButton = ArcaneToggleButton;
typedef AToggleButtonGroup = ArcaneToggleButtonGroup;
typedef AToggleSwitch = ArcaneToggleSwitch;

// View
typedef AAvatar = ArcaneAvatar;
typedef ABadge = ArcaneBadge;
typedef ABar = ArcaneBar;
typedef ACard = ArcaneCard;
typedef ACardSection = ArcaneCardSection;
typedef ACenterBody = ArcaneCenterBody;
typedef ACodeSnippet = ArcaneCodeSnippet;
typedef ADataColumn = ArcaneDataColumn;
typedef ADataTable = ArcaneDataTable;
typedef ADialogBar = ArcaneDialogBar;
typedef AEmptyState = ArcaneEmptyState;
typedef AErrorState = ArcaneErrorState;
typedef AExpander = ArcaneExpander;
typedef AFeatureCard = ArcaneFeatureCard;
typedef AGameTile = ArcaneGameTile;
typedef AGlass = ArcaneGlass;
typedef AGlassCard = ArcaneGlassCard;
typedef AIconCard = ArcaneIconCard;
typedef AImageCard = ArcaneImageCard;
typedef AIntegrationCard = ArcaneIntegrationCard;
typedef AIntegrationGrid = ArcaneIntegrationGrid;
typedef ALoadingState = ArcaneLoadingState;
typedef ANavTile = ArcaneNavTile;
typedef APageBody = ArcanePageBody;
typedef APricingCard = ArcanePricingCard;
typedef APricingGrid = ArcanePricingGrid;
typedef APricingTier = ArcanePricingTier;
typedef AProgressBar = ArcaneProgressBar;
typedef ARatingStars = ArcaneRatingStars;
typedef ASettingsInfoRow = ArcaneSettingsInfoRow;
typedef ASettingsNote = ArcaneSettingsNote;
typedef ASettingsSection = ArcaneSettingsSection;
typedef ASettingsSubheader = ArcaneSettingsSubheader;
typedef ASettingsToggleRow = ArcaneSettingsToggleRow;
typedef ASkeleton = ArcaneSkeleton;
typedef ASkeletonCard = ArcaneSkeletonCard;
typedef ASkeletonText = ArcaneSkeletonText;
typedef ASocialIcon = ArcaneSocialIcon;
typedef AIcon = ArcaneIcon;
typedef AIconPath = ArcaneIconPath;
typedef ASocialIconGroup = ArcaneSocialIconGroup;
typedef AStatCard = ArcaneStatCard;
typedef AStatCardRow = ArcaneStatCardRow;
typedef AStaticTable = ArcaneStaticTable;
typedef AStepItem = ArcaneStepItem;
typedef AStepper = ArcaneStepper;
typedef AStructuredCard = ArcaneStructuredCard;
typedef ATestimonialCard = ArcaneTestimonialCard;
typedef ATile = ArcaneTile;
typedef ATimeline = ArcaneTimeline;
typedef ATimelineItem = ArcaneTimelineItem;
typedef AVerticalStepper = ArcaneVerticalStepper;

// Typography
typedef ABodyText = ArcaneBodyText;
typedef AHeadline = ArcaneHeadline;
typedef ARichText = ArcaneRichText;
typedef ASubheadline = ArcaneSubheadline;
typedef AText = ArcaneText;
typedef ATextSpan = ArcaneTextSpan;

// Dialog
typedef ADialog = ArcaneDialog;

// Feedback
typedef ALoader = ArcaneLoader;

// Form
typedef AField = ArcaneField;
typedef AFieldDirectProvider = ArcaneFieldDirectProvider;
typedef AFieldMapProvider = ArcaneFieldMapProvider;
typedef AFieldMetadata = ArcaneFieldMetadata;
typedef AFieldProvider = ArcaneFieldProvider;
typedef AFieldStyles = ArcaneFieldStyles;
typedef AFieldWrapper = ArcaneFieldWrapper;
typedef AForm = ArcaneForm;
typedef AFormContext = ArcaneFormContext;
typedef AFormProvider = ArcaneFormProvider;
typedef AFormScope = ArcaneFormScope;

// Collection
typedef AInfiniteCarousel = ArcaneInfiniteCarousel;
