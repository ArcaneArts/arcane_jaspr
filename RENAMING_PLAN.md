# Arcane Jaspr Component Renaming Plan

## Goal
Rename ALL components to `Arcane*` prefix with `A*` shorthand aliases.

## Phases
1. **arcane_jaspr** - Rename all components, ensure zero errors
2. **Aliases** - Add `A*` shorthand typedefs
3. **QualityNode** - Fix broken imports file-by-file
4. **Docs** - Update CHANGELOG, pubspec, design refs

---

## Critical Rules

```dart
// Class + constructor MUST match
class ArcaneFoo extends StatelessComponent {
  const ArcaneFoo(...);           // Main
  const ArcaneFoo.variant(...);   // Named
}

// State generics must update
class _ArcaneFooState extends State<ArcaneFoo> { }

// Type refs must update
final List<ArcaneFoo> items;

// Internal usage must update
ArcaneSkeleton(width: '48px')  // not Skeleton()
```

---

## Component List by File

### Screen (lib/component/screen/)
| File | Classes to Rename |
|------|-------------------|
| screen.dart | Screen |
| fill_screen.dart | FillScreen, FullScreen |
| navigation_screen.dart | NavigationScreen, NavigationDestination |

### Navigation (lib/component/navigation/)
| File | Classes to Rename |
|------|-------------------|
| sidebar.dart | Sidebar, SidebarGroup, SidebarItem |
| header.dart | Header, NavItem, NavLink |
| bottom_nav.dart | BottomNavigationBar, BottomNavItem, BottomBar |
| dropdown_menu.dart | DropdownMenu, DropdownItem, MegaMenu, MegaMenuSection |
| mobile_menu.dart | MobileMenu, MobileNavItem, HamburgerButton |

### View (lib/component/view/)
| File | Classes to Rename |
|------|-------------------|
| badge.dart | Badge |
| tile.dart | Tile, NavTile |
| glass.dart | Glass, GlassCard |
| card.dart | StructuredCard, ImageCard |
| card_section.dart | CardSection |
| bar.dart | Bar, DialogBar |
| expander.dart | Expander, Accordion |
| center_body.dart | CenterBody, PageBody, EmptyState, LoadingState, ErrorState |
| data_table.dart | DataTable, DataColumn |
| static_table.dart | StaticTable |
| feature_card.dart | FeatureCard |
| pricing_card.dart | PricingCard, PricingTier, PricingGrid |
| testimonial_card.dart | TestimonialCard |
| integration_card.dart | IntegrationCard, IntegrationGrid |
| game_tile.dart | GameTile |
| code_snippet.dart | CodeSnippet |
| progress_bar.dart | ProgressBar, CircularProgress, LoadingSpinner |
| rating_stars.dart | RatingStars |
| stat_card.dart | StatCard |
| timeline.dart | Timeline, TimelineItem |
| stepper.dart | Stepper, StepItem, VerticalStepper |
| skeleton.dart | Skeleton, SkeletonCard, SkeletonText |
| status_indicator.dart | StatusIndicator, StatusBadge |
| animated_counter.dart | AnimatedCounter, CounterRow, MetricDisplay |
| gradient_text.dart | GradientText, AnimatedGradientText, GlowText, OutlineText |
| social_icons.dart | SocialIcons, SocialIcon, SocialLinks |
| settings_section.dart | SettingsSection, SettingsItem |
| avatar_group.dart | AvatarGroup |

### Layout (lib/component/layout/)
| File | Classes to Rename |
|------|-------------------|
| gutter.dart | Gutter, Gap, Box, Stack, Positioned |
| flow.dart | Flow, Row, Column, Spacer, Center, Expanded, Padding, SizedBox, Container, Border |
| section.dart | Section, SliverSection |
| carpet.dart | Carpet, Surface, Divider |
| button_panel.dart | ButtonPanel |
| toolbar.dart | Toolbar |
| button_group.dart | ButtonGroup |
| radio_cards.dart | RadioCards, RadioCardItem, ChipGroup, Chip |
| tabs.dart | Tabs, TabItem, TabBar, TabBarItem |
| hero_section.dart | HeroSection, CtaGroup |
| footer.dart | Footer, FooterLink, FooterLinkGroup, SocialIcon |
| logo_carousel.dart | LogoCarousel, LogoGrid, LogoItem |
| cta_banner.dart | CtaBanner |
| auth_layout.dart | AuthLayout |
| dashboard_layout.dart | DashboardNavItem, DashboardNavGroup |

### Input (lib/component/input/)
| File | Classes to Rename |
|------|-------------------|
| checkbox.dart | Checkbox, Radio |
| slider.dart | Slider, RangeSlider |
| toggle_switch.dart | ToggleSwitch, ToggleButtonGroup |
| search.dart | Search |
| selector.dart | Selector, SelectorOption |
| cycle_button.dart | CycleButton, CycleOption, ToggleButton |
| fab.dart | FAB |
| theme_toggle.dart | ThemeToggle, ThemeToggleSimple |
| icon_button.dart | CloseButton |
| text_input.dart | SelectOption |

### Dialog (lib/component/dialog/)
| File | Classes to Rename |
|------|-------------------|
| confirm.dart | ConfirmDialog, AlertDialog |
| text.dart | TextInputDialog |
| toast.dart | Toast, ToastContainer |
| dialog.dart | Sheet |

### Feedback (lib/component/feedback/)
| File | Classes to Rename |
|------|-------------------|
| alert_banner.dart | AlertBanner, ProgressBar |
| loader.dart | Loader, LoadingSpinner, DotsLoader, PulseLoader, LoadingOverlay, LoaderStyles |
| tooltip.dart | Tooltip, TooltipCustom, InfoTooltip |

### Collection (lib/component/collection/)
| File | Classes to Rename |
|------|-------------------|
| collection.dart | Collection, ListView, GridView, MasonryGrid, Repeater |
| card_carousel.dart | CardCarousel, InfiniteCarousel, NavigableCarousel, HeroCarousel |

### Form (lib/component/form/)
| File | Classes to Rename |
|------|-------------------|
| field_wrapper.dart | FormSection, InputGroup |
| newsletter_form.dart | NewsletterForm, WaitlistForm |

### HTML (lib/component/html/)
| File | Classes to Rename |
|------|-------------------|
| div.dart | Div |
| aside.dart | Aside |
| blockquote.dart | Blockquote |
| heading.dart | Heading |
| paragraph.dart | Paragraph |
| pre.dart | Pre |
| nav.dart | Nav |
| main_element.dart | MainElement, Main |
| main.dart | Main, Header |
| header.dart | Header |
| section.dart | HtmlSection |
| footer.dart | HtmlFooter |
| list.dart | UL, OL, LI, UnorderedList, OrderedList, ListItem |
| table.dart | TableHead, TableBody, TableRow, TableHeader, TableCell |
| arcane_button.dart | RawButton |
| arcane_input.dart | RawInput |

### Typography (lib/component/typography/)
| File | Classes to Rename |
|------|-------------------|
| text.dart | Text |

---

## Execution Order

1. **typography/** - text.dart (no deps)
2. **html/** - all files (no deps)
3. **view/** - all files
4. **layout/** - gutter.dart, flow.dart first, then rest
5. **input/** - all files
6. **feedback/** - all files
7. **dialog/** - all files
8. **collection/** - all files
9. **form/** - all files
10. **navigation/** - all files
11. **screen/** - all files
12. **Update exports** in arcane_jaspr.dart
13. **Create aliases.dart** with A* typedefs

---

## QualityNode Files to Fix (Phase 3)
```
lib/components/*.dart (6 files)
lib/sections/*.dart (11 files)
lib/screens/public/*.dart (14 files)
lib/screens/auth/*.dart (3 files)
lib/screens/client/*.dart (6 files)
lib/screens/admin/*.dart (6 files)
lib/routes/app_router.dart
lib/app.dart
```
