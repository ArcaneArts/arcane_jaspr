import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Demo builders for input components
class InputDemos {
  static List<Component> button() => [
        ArcaneButton.primary(label: 'Primary', onPressed: () {}),
        ArcaneButton.secondary(label: 'Secondary', onPressed: () {}),
        ArcaneButton.destructive(label: 'Destructive', onPressed: () {}),
        ArcaneButton.ghost(label: 'Ghost', onPressed: () {}),
        ArcaneButton.outline(label: 'Outline', onPressed: () {}),
        ArcaneButton.link(label: 'Link', onPressed: () {}),
      ];

  static List<Component> iconButton() => [
        ArcaneIconButton(icon: ArcaneIcon.plus(), onPressed: () {}),
        ArcaneIconButton(icon: ArcaneIcon.close(), onPressed: () {}),
        ArcaneIconButton(icon: ArcaneIcon.settings(), onPressed: () {}),
      ];

  static List<Component> closeButton() => [
        ArcaneCloseButton(onPressed: () {}),
      ];

  static List<Component> fab() => [
        ArcaneFAB(icon: ArcaneIcon.plus(size: IconSize.lg), onPressed: () {}),
      ];

  static List<Component> textInput() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '250px'),
          children: [
            ArcaneTextInput(
              label: 'Username',
              placeholder: 'Enter username',
              name: 'demo-username',
            ),
          ],
        ),
      ];

  static List<Component> textArea() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '300px'),
          children: [
            ArcaneTextArea(
              label: 'Message',
              placeholder: 'Enter your message...',
              name: 'demo-message',
              resize: TextAreaResize.both,
              minWidth: '200px',
              minHeight: '80px',
            ),
          ],
        ),
      ];

  static List<Component> search() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '300px'),
          children: [
            ArcaneSearch(
              placeholder: 'Search...',
              onChanged: (_) {},
            ),
          ],
        ),
      ];

  static List<Component> select() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [
            ArcaneSelect(
              label: 'Choose option',
              options: const [
                ArcaneSelectOption(label: 'Option 1', value: '1'),
                ArcaneSelectOption(label: 'Option 2', value: '2'),
                ArcaneSelectOption(label: 'Option 3', value: '3'),
              ],
              onChange: (_) {},
            ),
          ],
        ),
      ];

  static List<Component> checkbox() => [
        ArcaneCheckbox(checked: false, onChanged: (_) {}),
        ArcaneCheckbox(checked: true, onChanged: (_) {}),
      ];

  static List<Component> radio() => [
        ArcaneRow(
          gapSize: Gap.md,
          children: [
            ArcaneRadio(selected: true, label: 'Option A', onSelected: () {}),
            ArcaneRadio(selected: false, label: 'Option B', onSelected: () {}),
          ],
        ),
      ];

  static List<Component> toggleSwitch() => [
        ArcaneToggleSwitch(value: false, onChanged: (_) {}),
        ArcaneToggleSwitch(value: true, onChanged: (_) {}),
      ];

  static List<Component> slider() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [
            ArcaneSlider(value: 0.5, onChanged: (_) {}),
          ],
        ),
      ];

  static List<Component> rangeSlider() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [
            ArcaneRangeSlider(
              minValue: 20,
              maxValue: 80,
              min: 0,
              max: 100,
              onChanged: (_, __) {},
            ),
          ],
        ),
      ];

  static List<Component> toggleButton() => [
        ArcaneToggleButton(
          value: false,
          label: 'Toggle',
          onChanged: (_) {},
        ),
        ArcaneToggleButton(
          value: true,
          label: 'Selected',
          onChanged: (_) {},
        ),
      ];

  static List<Component> toggleButtonGroup() => [
        ArcaneToggleButtonGroup(
          options: const ['One', 'Two', 'Three'],
          selectedIndex: 0,
          onChanged: (_) {},
        ),
      ];

  static List<Component> cycleButton() => [
        ArcaneCycleButton<String>(
          options: [
            ArcaneCycleOption(value: 'a', label: 'Option A'),
            ArcaneCycleOption(value: 'b', label: 'Option B'),
            ArcaneCycleOption(value: 'c', label: 'Option C'),
          ],
          value: 'a',
          onChanged: (_) {},
        ),
      ];

  static List<Component> selector() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [
            ArcaneSelector<String>(
              options: [
                ArcaneSelectorOption(value: 'small', label: 'Small'),
                ArcaneSelectorOption(value: 'medium', label: 'Medium'),
                ArcaneSelectorOption(value: 'large', label: 'Large'),
              ],
              value: 'medium',
              onChanged: (_) {},
            ),
          ],
        ),
      ];

  static List<Component> themeToggle(bool isDark, VoidCallback onToggle) => [
        ArcaneThemeToggle(isDark: isDark, onChanged: (_) => onToggle()),
      ];

  static List<Component> tagInput() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '300px'),
          children: [
            ArcaneTagInput(
              tags: const ['React', 'Vue', 'Angular'],
              onTagsChanged: (_) {},
              placeholder: 'Add tags...',
            ),
          ],
        ),
      ];

  static List<Component> numberInput() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '150px'),
          children: [
            ArcaneNumberInput(
              value: 5,
              min: 0,
              max: 10,
              onChanged: (_) {},
            ),
          ],
        ),
      ];

  static List<Component> fileUpload() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '300px'),
          children: [
            ArcaneFileUpload(
              onFilesSelected: (_) {},
              label: 'Upload files',
              helperText: 'PNG, JPG up to 10MB',
            ),
          ],
        ),
      ];

  static List<Component> colorInput() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '250px'),
          children: [
            ArcaneColorInput(
              value: '#10b981',
              onChanged: (_) {},
              label: 'Primary Color',
            ),
          ],
        ),
      ];

  static List<Component> searchBar() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '400px'),
          children: [
            ArcaneSearchBar(
              id: 'demo-search',
              resultsId: 'demo-results',
              placeholder: 'Search documentation...',
            ),
          ],
        ),
      ];

  static List<Component> ctaLink() => [
        ArcaneRow(
          gapSize: Gap.md,
          children: [
            ArcaneCtaLink.primary(
              label: 'Get Started',
              href: '#',
              showArrow: true,
            ),
            ArcaneCtaLink.secondary(
              label: 'Learn More',
              href: '#',
            ),
            ArcaneCtaLink.ghost(
              label: 'View Docs',
              href: '#',
            ),
            ArcaneCtaLink.accent(
              label: 'Try Now',
              href: '#',
              showArrow: true,
            ),
          ],
        ),
        ArcaneDiv(
          styles: const ArcaneStyleData(margin: MarginPreset.topMd),
          children: [
            ArcaneRow(
              gapSize: Gap.md,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ArcaneCtaLink.primary(
                  label: 'Small',
                  href: '#',
                  size: CtaLinkSize.sm,
                ),
                ArcaneCtaLink.primary(
                  label: 'Medium',
                  href: '#',
                  size: CtaLinkSize.md,
                ),
                ArcaneCtaLink.primary(
                  label: 'Large',
                  href: '#',
                  size: CtaLinkSize.lg,
                ),
              ],
            ),
          ],
        ),
      ];

  static List<Component> timePicker() => [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [
            ArcaneTimePicker(
              value: TimeOfDay(hour: 14, minute: 30),
              label: 'Start Time',
              onChanged: (_) {},
            ),
          ],
        ),
      ];

  static List<Component> formattedInput() => [
        ArcaneColumn(
          gapSize: Gap.lg,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneFormattedInput.date(
              initialMonth: '01',
              initialDay: '15',
              initialYear: '2024',
              onChanged: (_) {},
            ),
            ArcaneFormattedInput.phone(
              initialAreaCode: '555',
              initialPrefix: '123',
              initialLine: '4567',
              onChanged: (_) {},
            ),
            ArcaneFormattedInput.creditCard(
              onChanged: (_) {},
            ),
          ],
        ),
      ];
}
