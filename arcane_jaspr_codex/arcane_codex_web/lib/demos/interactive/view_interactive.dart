import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Interactive tab bar demo
class TabBarDemo extends StatefulComponent {
  const TabBarDemo({super.key});

  @override
  State<TabBarDemo> createState() => _TabBarDemoState();
}

class _TabBarDemoState extends State<TabBarDemo> {
  int _selectedIndex = 0;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneTabBar(
          tabs: const [
            ArcaneTabBarItem(label: 'Overview'),
            ArcaneTabBarItem(label: 'Features'),
            ArcaneTabBarItem(label: 'Pricing'),
          ],
          selectedIndex: _selectedIndex,
          onChanged: (index) => setState(() => _selectedIndex = index),
        ),
        ArcaneDiv(
          styles: const ArcaneStyleData(
            padding: PaddingPreset.md,
            background: Background.surfaceVariant,
          ),
          children: [
            if (_selectedIndex == 0)
              ArcaneText('Overview content goes here...'),
            if (_selectedIndex == 1)
              ArcaneText('Features content goes here...'),
            if (_selectedIndex == 2)
              ArcaneText('Pricing content goes here...'),
          ],
        ),
      ],
    );
  }
}

/// Interactive accordion demo - ArcaneAccordion manages its own state
class AccordionDemo extends StatelessComponent {
  const AccordionDemo({super.key});

  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(widthCustom: '400px'),
      children: [
        ArcaneAccordion(
          items: const [
            ArcaneAccordionItem(
              title: 'What is Arcane UI?',
              content: 'Arcane UI is a modern component library for building web applications with Dart and Jaspr.',
            ),
            ArcaneAccordionItem(
              title: 'How do I get started?',
              content: 'Add arcane_jaspr to your pubspec.yaml and import the package. Check out the documentation for examples.',
            ),
            ArcaneAccordionItem(
              title: 'Is it free to use?',
              content: 'Yes! Arcane UI is open source and free to use in any project.',
            ),
          ],
        ),
      ],
    );
  }
}

/// Interactive tree view demo
class TreeViewDemo extends StatefulComponent {
  const TreeViewDemo({super.key});

  @override
  State<TreeViewDemo> createState() => _TreeViewDemoState();
}

class _TreeViewDemoState extends State<TreeViewDemo> {
  String? _selectedLabel;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '280px'),
          children: [
            ArcaneTreeView(
              nodes: [
                TreeNode(
                  id: 'src',
                  label: 'src',
                  icon: Folder(),
                  children: [
                    TreeNode(id: 'main', label: 'main.dart', icon: File()),
                    TreeNode(id: 'app', label: 'app.dart', icon: File()),
                  ],
                ),
                TreeNode(
                  id: 'lib',
                  label: 'lib',
                  icon: Folder(),
                  children: [
                    TreeNode(id: 'utils', label: 'utils.dart', icon: File()),
                    TreeNode(id: 'models', label: 'models.dart', icon: File()),
                  ],
                ),
                TreeNode(id: 'pubspec', label: 'pubspec.yaml', icon: File()),
              ],
              initiallyExpanded: const {'src', 'lib'},
              onNodeSelect: (node) => setState(() => _selectedLabel = node.label),
            ),
          ],
        ),
        ArcaneText(
          _selectedLabel != null ? 'Selected: $_selectedLabel' : 'Click a file to select',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive meter demo
class MeterDemo extends StatefulComponent {
  const MeterDemo({super.key});

  @override
  State<MeterDemo> createState() => _MeterDemoState();
}

class _MeterDemoState extends State<MeterDemo> {
  double _value = 0.65;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [
            ArcaneMeter(
              value: _value,
              label: 'Progress',
              showValue: true,
            ),
          ],
        ),
        ArcaneRow(
          gapSize: Gap.sm,
          children: [
            ArcaneButton.outline(
              label: '-10%',
              onPressed: () => setState(() => _value = (_value - 0.1).clamp(0, 1)),
            ),
            ArcaneButton.outline(
              label: '+10%',
              onPressed: () => setState(() => _value = (_value + 0.1).clamp(0, 1)),
            ),
          ],
        ),
      ],
    );
  }
}

/// Interactive expander demo
class ExpanderDemo extends StatefulComponent {
  const ExpanderDemo({super.key});

  @override
  State<ExpanderDemo> createState() => _ExpanderDemoState();
}

class _ExpanderDemoState extends State<ExpanderDemo> {
  @override
  Component build(BuildContext context) {
    return ArcaneDiv(
      styles: const ArcaneStyleData(widthCustom: '350px'),
      children: [
        ArcaneExpander(
          header: ArcaneText('Click to expand', weight: FontWeight.w500),
          initiallyExpanded: false,
          child: ArcaneDiv(
            styles: const ArcaneStyleData(padding: PaddingPreset.md),
            children: [
              ArcaneText('This is the expanded content. You can put any content here.'),
            ],
          ),
        ),
      ],
    );
  }
}

/// Interactive toast demo - standalone toasts
class ToastDemo extends StatefulComponent {
  const ToastDemo({super.key});

  @override
  State<ToastDemo> createState() => _ToastDemoState();
}

class _ToastDemoState extends State<ToastDemo> {
  bool _showToast = false;
  ToastVariant _variant = ToastVariant.info;
  bool _requiresAction = false;
  ToastAction? _action;

  String _getMessage() {
    return switch (_variant) {
      ToastVariant.success => 'Action completed successfully!',
      ToastVariant.error => 'Something went wrong. Please try again.',
      ToastVariant.warning => 'Please review before continuing.',
      ToastVariant.info => 'Here is some helpful information.',
      ToastVariant.loading => 'Processing your request...',
    };
  }

  void _showVariantToast(ToastVariant variant) {
    setState(() {
      _variant = variant;
      _showToast = true;
      _requiresAction = false;
      _action = null;
    });
  }

  void _showActionToast({
    required ToastVariant variant,
    required String message,
    required String title,
    required ToastAction action,
    bool requiresAction = false,
  }) {
    setState(() {
      _variant = variant;
      _showToast = true;
      _requiresAction = requiresAction;
      _action = action;
    });
  }

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Auto-dismiss variants
        ArcaneText('Auto-Dismiss Toasts', weight: FontWeight.w600),
        ArcaneRow(
          gapSize: Gap.sm,
          children: [
            ArcaneButton.primary(
              label: 'Info',
              onPressed: () => _showVariantToast(ToastVariant.info),
            ),
            ArcaneButton(
              label: 'Success',
              style: ButtonStyle.success,
              onPressed: () => _showVariantToast(ToastVariant.success),
            ),
            ArcaneButton(
              label: 'Warning',
              style: ButtonStyle.warning,
              onPressed: () => _showVariantToast(ToastVariant.warning),
            ),
            ArcaneButton.destructive(
              label: 'Error',
              onPressed: () => _showVariantToast(ToastVariant.error),
            ),
            ArcaneButton.outline(
              label: 'Loading',
              onPressed: () => _showVariantToast(ToastVariant.loading),
            ),
          ],
        ),

        // Manual dismiss / action required
        ArcaneText('Manual Dismiss Required', weight: FontWeight.w600),
        ArcaneRow(
          gapSize: Gap.sm,
          children: [
            ArcaneButton.secondary(
              label: 'Acknowledge Required',
              onPressed: () => _showActionToast(
                variant: ToastVariant.warning,
                message: 'Your session will expire in 5 minutes.',
                title: 'Session Warning',
                requiresAction: true,
                action: ToastAction(
                  label: 'OK',
                  onPressed: () => setState(() => _showToast = false),
                ),
              ),
            ),
            ArcaneButton.secondary(
              label: 'Confirm Action',
              onPressed: () => _showActionToast(
                variant: ToastVariant.error,
                message: 'This action cannot be undone.',
                title: 'Are you sure?',
                requiresAction: true,
                action: ToastAction(
                  label: 'I Understand',
                  onPressed: () => setState(() => _showToast = false),
                  destructive: true,
                ),
              ),
            ),
            ArcaneButton.secondary(
              label: 'With Undo',
              onPressed: () => _showActionToast(
                variant: ToastVariant.info,
                message: 'Item moved to trash.',
                title: 'Deleted',
                requiresAction: false,
                action: ToastAction(
                  label: 'Undo',
                  onPressed: () => setState(() => _showToast = false),
                ),
              ),
            ),
          ],
        ),

        // Toast display
        if (_showToast)
          ArcaneToast(
            message: _action != null
                ? (_variant == ToastVariant.warning
                    ? 'Your session will expire in 5 minutes.'
                    : _variant == ToastVariant.error
                        ? 'This action cannot be undone.'
                        : 'Item moved to trash.')
                : _getMessage(),
            title: _action != null
                ? (_variant == ToastVariant.warning
                    ? 'Session Warning'
                    : _variant == ToastVariant.error
                        ? 'Are you sure?'
                        : 'Deleted')
                : _variant.name[0].toUpperCase() + _variant.name.substring(1),
            variant: _variant,
            duration: _requiresAction || _variant == ToastVariant.loading ? 0 : 4000,
            dismissible: !_requiresAction && _variant != ToastVariant.loading,
            action: _action,
            onClose: () => setState(() => _showToast = false),
          ),
      ],
    );
  }
}

/// Interactive progress bar demo
class ProgressBarDemo extends StatefulComponent {
  const ProgressBarDemo({super.key});

  @override
  State<ProgressBarDemo> createState() => _ProgressBarDemoState();
}

class _ProgressBarDemoState extends State<ProgressBarDemo> {
  double _value = 0.45;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '300px'),
          children: [
            ArcaneProgressBar(value: _value),
          ],
        ),
        ArcaneRow(
          gapSize: Gap.sm,
          children: [
            ArcaneButton.outline(
              label: '0%',
              onPressed: () => setState(() => _value = 0),
            ),
            ArcaneButton.outline(
              label: '50%',
              onPressed: () => setState(() => _value = 0.5),
            ),
            ArcaneButton.outline(
              label: '100%',
              onPressed: () => setState(() => _value = 1.0),
            ),
          ],
        ),
        ArcaneText(
          'Progress: ${(_value * 100).toStringAsFixed(0)}%',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive popover demo
class PopoverDemo extends StatefulComponent {
  const PopoverDemo({super.key});

  @override
  State<PopoverDemo> createState() => _PopoverDemoState();
}

class _PopoverDemoState extends State<PopoverDemo> {
  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Click trigger popover
        ArcaneRow(
          gapSize: Gap.md,
          children: [
            ArcanePopover(
              trigger: ArcaneButton.secondary(
                label: 'Click Me',
                onPressed: () {},
              ),
              content: ArcaneDiv(
                styles: const ArcaneStyleData(
                  padding: PaddingPreset.md,
                  minWidth: '200px',
                ),
                children: [
                  ArcaneColumn(
                    gapSize: Gap.sm,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ArcaneText('Popover Content', weight: FontWeight.w600),
                      ArcaneText(
                        'Click anywhere outside to close.',
                        color: TextColor.muted,
                        size: FontSize.sm,
                      ),
                    ],
                  ),
                ],
              ),
              position: PopoverPosition.bottom,
              triggerType: PopoverTrigger.click,
            ),
            ArcanePopover(
              trigger: ArcaneButton.outline(
                label: 'Hover Me',
                onPressed: () {},
              ),
              content: ArcaneDiv(
                styles: const ArcaneStyleData(
                  padding: PaddingPreset.md,
                ),
                children: [
                  ArcaneText('Hover popover!', color: TextColor.muted),
                ],
              ),
              position: PopoverPosition.top,
              triggerType: PopoverTrigger.hover,
            ),
          ],
        ),
        ArcaneText(
          'Click or hover the buttons above to see popovers.',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive hovercard demo
class HovercardDemo extends StatefulComponent {
  const HovercardDemo({super.key});

  @override
  State<HovercardDemo> createState() => _HovercardDemoState();
}

class _HovercardDemoState extends State<HovercardDemo> {
  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneRow(
          gapSize: Gap.lg,
          children: [
            ArcaneHovercard(
              trigger: ArcaneDiv(
                styles: const ArcaneStyleData(
                  padding: PaddingPreset.sm,
                  background: Background.surface,
                  borderRadius: Radius.md,
                  cursor: Cursor.pointer,
                ),
                children: [
                  ArcaneRow(
                    gapSize: Gap.sm,
                    children: [
                      ArcaneAvatar(initials: 'JD', size: AvatarSize.sm),
                      ArcaneText('@johndoe'),
                    ],
                  ),
                ],
              ),
              content: ArcaneColumn(
                gapSize: Gap.sm,
                children: [
                  ArcaneRow(
                    gapSize: Gap.sm,
                    children: [
                      ArcaneAvatar(initials: 'JD', size: AvatarSize.lg),
                      ArcaneColumn(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ArcaneText('John Doe', weight: FontWeight.bold),
                          ArcaneText('Software Engineer', color: TextColor.muted, size: FontSize.sm),
                        ],
                      ),
                    ],
                  ),
                  ArcaneDivider(),
                  ArcaneText(
                    'Building amazing web apps with Dart and Jaspr.',
                    color: TextColor.muted,
                    size: FontSize.sm,
                  ),
                ],
              ),
              position: HovercardPosition.bottom,
            ),
            ArcaneHovercard(
              trigger: ArcaneText(
                'Hover for info',
                color: TextColor.accent,
              ),
              content: ArcaneDiv(
                styles: const ArcaneStyleData(maxWidthCustom: '250px'),
                children: [
                  ArcaneText(
                    'This is additional information that appears on hover.',
                    color: TextColor.muted,
                    size: FontSize.sm,
                  ),
                ],
              ),
              position: HovercardPosition.right,
            ),
          ],
        ),
        ArcaneText(
          'Hover over the elements above to see hovercards.',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive tooltip demo
class TooltipDemo extends StatelessComponent {
  const TooltipDemo({super.key});

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneText('Positions', weight: FontWeight.w600),
        ArcaneRow(
          gapSize: Gap.lg,
          children: [
            ArcaneTooltip(
              content: 'Tooltip on top',
              position: TooltipPosition.top,
              child: ArcaneButton.secondary(label: 'Top', onPressed: () {}),
            ),
            ArcaneTooltip(
              content: 'Tooltip on bottom',
              position: TooltipPosition.bottom,
              child: ArcaneButton.secondary(label: 'Bottom', onPressed: () {}),
            ),
            ArcaneTooltip(
              content: 'Tooltip on left',
              position: TooltipPosition.left,
              child: ArcaneButton.secondary(label: 'Left', onPressed: () {}),
            ),
            ArcaneTooltip(
              content: 'Tooltip on right',
              position: TooltipPosition.right,
              child: ArcaneButton.secondary(label: 'Right', onPressed: () {}),
            ),
          ],
        ),
        ArcaneText('Usage Examples', weight: FontWeight.w600),
        ArcaneRow(
          gapSize: Gap.lg,
          children: [
            ArcaneTooltip(
              content: 'Click to copy to clipboard',
              child: ArcaneIconButton(
                icon: Copy(),
                onPressed: () {},
              ),
            ),
            ArcaneTooltip(
              content: 'View settings',
              child: ArcaneIconButton(
                icon: Settings(),
                onPressed: () {},
              ),
            ),
            ArcaneInfoTooltip(
              content: 'This field is required for form submission',
            ),
          ],
        ),
      ],
    );
  }
}

/// Separator demo (visual divider with multiple styles)
class SeparatorDemo extends StatelessComponent {
  const SeparatorDemo({super.key});

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Horizontal separators
        ArcaneText('Horizontal Styles', weight: FontWeight.w600),
        ArcaneColumn(
          gapSize: Gap.md,
          children: [
            ArcaneRow(
              gapSize: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ArcaneText('Solid', size: FontSize.sm, color: TextColor.muted),
                ArcaneExpanded(child: ArcaneSeparator()),
              ],
            ),
            ArcaneRow(
              gapSize: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ArcaneText('Dashed', size: FontSize.sm, color: TextColor.muted),
                ArcaneExpanded(child: ArcaneSeparator(style: SeparatorStyle.dashed)),
              ],
            ),
            ArcaneRow(
              gapSize: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ArcaneText('Dotted', size: FontSize.sm, color: TextColor.muted),
                ArcaneExpanded(child: ArcaneSeparator(style: SeparatorStyle.dotted)),
              ],
            ),
            ArcaneRow(
              gapSize: Gap.sm,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ArcaneText('Gradient', size: FontSize.sm, color: TextColor.muted),
                ArcaneExpanded(child: ArcaneSeparator(style: SeparatorStyle.gradient)),
              ],
            ),
          ],
        ),

        // With label
        ArcaneText('With Label', weight: FontWeight.w600),
        ArcaneSeparator.withLabel(label: 'OR'),
        ArcaneSeparator.withLabel(label: 'Section'),

        // Vertical separator
        ArcaneText('Vertical', weight: FontWeight.w600),
        ArcaneRow(
          gapSize: Gap.md,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            ArcaneText('Left'),
            ArcaneDiv(
              styles: const ArcaneStyleData(heightCustom: '40px'),
              children: [ArcaneSeparator.vertical()],
            ),
            ArcaneText('Right'),
          ],
        ),
      ],
    );
  }
}

/// Interactive timeline demo with layout switching
class TimelineDemo extends StatefulComponent {
  const TimelineDemo({super.key});

  @override
  State<TimelineDemo> createState() => _TimelineDemoState();
}

class _TimelineDemoState extends State<TimelineDemo> {
  TimelineLayout _layout = TimelineLayout.vertical;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Layout selector
        ArcaneText('Layout', weight: FontWeight.w600),
        ArcaneRow(
          gapSize: Gap.sm,
          children: [
            ArcaneButton(
              label: 'Vertical',
              style: _layout == TimelineLayout.vertical
                  ? ButtonStyle.primary
                  : ButtonStyle.secondary,
              onPressed: () => setState(() => _layout = TimelineLayout.vertical),
            ),
            ArcaneButton(
              label: 'Horizontal',
              style: _layout == TimelineLayout.horizontal
                  ? ButtonStyle.primary
                  : ButtonStyle.secondary,
              onPressed: () => setState(() => _layout = TimelineLayout.horizontal),
            ),
            ArcaneButton(
              label: 'Alternating',
              style: _layout == TimelineLayout.alternating
                  ? ButtonStyle.primary
                  : ButtonStyle.secondary,
              onPressed: () => setState(() => _layout = TimelineLayout.alternating),
            ),
          ],
        ),

        // Timeline
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '100%',
            maxWidthCustom: '600px',
          ),
          children: [
            ArcaneTimeline(
              layout: _layout,
              items: const [
                ArcaneTimelineItem(
                  title: 'Order Placed',
                  description: 'Your order #12345 has been received',
                  date: 'Jan 15, 2024',
                  status: TimelineStatus.complete,
                ),
                ArcaneTimelineItem(
                  title: 'Processing',
                  description: 'Items are being prepared for shipping',
                  date: 'Jan 16, 2024',
                  status: TimelineStatus.complete,
                ),
                ArcaneTimelineItem(
                  title: 'Shipped',
                  description: 'Your package is on its way',
                  date: 'Jan 17, 2024',
                  status: TimelineStatus.current,
                ),
                ArcaneTimelineItem(
                  title: 'Delivered',
                  description: 'Expected delivery',
                  date: 'Jan 19, 2024',
                  status: TimelineStatus.pending,
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

/// Interactive steps demo with layout switching and step navigation
class StepsDemo extends StatefulComponent {
  const StepsDemo({super.key});

  @override
  State<StepsDemo> createState() => _StepsDemoState();
}

class _StepsDemoState extends State<StepsDemo> {
  StepsLayout _layout = StepsLayout.horizontal;
  int _currentStep = 1;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Layout selector
        ArcaneText('Layout', weight: FontWeight.w600),
        ArcaneRow(
          gapSize: Gap.sm,
          children: [
            ArcaneButton(
              label: 'Horizontal',
              style: _layout == StepsLayout.horizontal
                  ? ButtonStyle.primary
                  : ButtonStyle.secondary,
              onPressed: () => setState(() => _layout = StepsLayout.horizontal),
            ),
            ArcaneButton(
              label: 'Vertical',
              style: _layout == StepsLayout.vertical
                  ? ButtonStyle.primary
                  : ButtonStyle.secondary,
              onPressed: () => setState(() => _layout = StepsLayout.vertical),
            ),
          ],
        ),

        // Steps
        ArcaneDiv(
          styles: const ArcaneStyleData(
            widthCustom: '100%',
            maxWidthCustom: '600px',
          ),
          children: [
            ArcaneSteps(
              layout: _layout,
              currentStep: _currentStep,
              onStepTap: (index) => setState(() => _currentStep = index),
              items: const [
                ArcaneStepItem(
                  title: 'Account',
                  description: 'Create your account',
                ),
                ArcaneStepItem(
                  title: 'Profile',
                  description: 'Set up your profile',
                ),
                ArcaneStepItem(
                  title: 'Preferences',
                  description: 'Configure settings',
                ),
                ArcaneStepItem(
                  title: 'Complete',
                  description: 'Start using the app',
                ),
              ],
            ),
          ],
        ),

        // Navigation controls
        ArcaneText('Navigation', weight: FontWeight.w600),
        ArcaneRow(
          gapSize: Gap.sm,
          children: [
            ArcaneButton.outline(
              label: 'Previous',
              disabled: _currentStep <= 0,
              onPressed: () => setState(() => _currentStep--),
            ),
            ArcaneButton.primary(
              label: _currentStep >= 3 ? 'Complete' : 'Next',
              onPressed: () {
                if (_currentStep < 3) {
                  setState(() => _currentStep++);
                }
              },
            ),
            ArcaneButton.secondary(
              label: 'Reset',
              onPressed: () => setState(() => _currentStep = 0),
            ),
          ],
        ),

        ArcaneText(
          'Current step: ${_currentStep + 1} of 4',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Scroll area demo
class ScrollAreaDemo extends StatelessComponent {
  const ScrollAreaDemo({super.key});

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneText('Vertical Scroll', weight: FontWeight.w600),
        ArcaneScrollArea.vertical(
          height: '200px',
          child: ArcaneColumn(
            gapSize: Gap.sm,
            children: [
              for (var i = 1; i <= 20; i++)
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    padding: PaddingPreset.sm,
                    background: Background.surfaceVariant,
                    borderRadius: Radius.sm,
                  ),
                  children: [ArcaneText('Item $i')],
                ),
            ],
          ),
        ),
        ArcaneText('Horizontal Scroll', weight: FontWeight.w600),
        ArcaneScrollArea.horizontal(
          width: '100%',
          child: ArcaneRow(
            gapSize: Gap.sm,
            children: [
              for (var i = 1; i <= 15; i++)
                ArcaneDiv(
                  styles: const ArcaneStyleData(
                    padding: PaddingPreset.md,
                    background: Background.surfaceVariant,
                    borderRadius: Radius.sm,
                    minWidth: '100px',
                  ),
                  children: [ArcaneText('Card $i')],
                ),
            ],
          ),
        ),
      ],
    );
  }
}
