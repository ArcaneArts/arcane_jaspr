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
                  icon: ArcaneIcon.folder(),
                  children: [
                    TreeNode(id: 'main', label: 'main.dart', icon: ArcaneIcon.file()),
                    TreeNode(id: 'app', label: 'app.dart', icon: ArcaneIcon.file()),
                  ],
                ),
                TreeNode(
                  id: 'lib',
                  label: 'lib',
                  icon: ArcaneIcon.folder(),
                  children: [
                    TreeNode(id: 'utils', label: 'utils.dart', icon: ArcaneIcon.file()),
                    TreeNode(id: 'models', label: 'models.dart', icon: ArcaneIcon.file()),
                  ],
                ),
                TreeNode(id: 'pubspec', label: 'pubspec.yaml', icon: ArcaneIcon.file()),
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

/// Interactive toast demo
class ToastDemo extends StatefulComponent {
  const ToastDemo({super.key});

  @override
  State<ToastDemo> createState() => _ToastDemoState();
}

class _ToastDemoState extends State<ToastDemo> {
  bool _showToast = false;
  ToastVariant _variant = ToastVariant.info;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneRow(
          gapSize: Gap.sm,
          children: [
            ArcaneButton.primary(
              label: 'Info',
              onPressed: () => setState(() {
                _variant = ToastVariant.info;
                _showToast = true;
              }),
            ),
            ArcaneButton(
              label: 'Success',
              style: ButtonStyle.success,
              onPressed: () => setState(() {
                _variant = ToastVariant.success;
                _showToast = true;
              }),
            ),
            ArcaneButton(
              label: 'Warning',
              style: ButtonStyle.warning,
              onPressed: () => setState(() {
                _variant = ToastVariant.warning;
                _showToast = true;
              }),
            ),
            ArcaneButton.destructive(
              label: 'Error',
              onPressed: () => setState(() {
                _variant = ToastVariant.error;
                _showToast = true;
              }),
            ),
          ],
        ),
        if (_showToast)
          ArcaneToast(
            message: 'This is a ${_variant.name} message!',
            variant: _variant,
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
