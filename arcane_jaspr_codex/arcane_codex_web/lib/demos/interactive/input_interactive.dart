import 'package:arcane_jaspr/arcane_jaspr.dart';

/// Interactive checkbox demo
class CheckboxDemo extends StatefulComponent {
  const CheckboxDemo({super.key});

  @override
  State<CheckboxDemo> createState() => _CheckboxDemoState();
}

class _CheckboxDemoState extends State<CheckboxDemo> {
  bool _checked1 = false;
  bool _checked2 = true;
  bool _checked3 = false;

  @override
  Component build(BuildContext context) {
    return ArcaneRow(
      gapSize: Gap.lg,
      children: [
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneCheckbox(
              checked: _checked1,
              onChanged: (v) => setState(() => _checked1 = v),
            ),
            ArcaneText('Unchecked', size: FontSize.sm, color: TextColor.muted),
          ],
        ),
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneCheckbox(
              checked: _checked2,
              onChanged: (v) => setState(() => _checked2 = v),
            ),
            ArcaneText('Checked', size: FontSize.sm, color: TextColor.muted),
          ],
        ),
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneCheckbox(
              checked: _checked3,
              label: 'With label',
              onChanged: (v) => setState(() => _checked3 = v),
            ),
          ],
        ),
      ],
    );
  }
}

/// Interactive toggle switch demo
class ToggleSwitchDemo extends StatefulComponent {
  const ToggleSwitchDemo({super.key});

  @override
  State<ToggleSwitchDemo> createState() => _ToggleSwitchDemoState();
}

class _ToggleSwitchDemoState extends State<ToggleSwitchDemo> {
  bool _value1 = false;
  bool _value2 = true;

  @override
  Component build(BuildContext context) {
    return ArcaneRow(
      gapSize: Gap.lg,
      children: [
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneToggleSwitch(
              value: _value1,
              onChanged: (v) => setState(() => _value1 = v),
            ),
            ArcaneText(_value1 ? 'On' : 'Off', size: FontSize.sm, color: TextColor.muted),
          ],
        ),
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneToggleSwitch(
              value: _value2,
              onChanged: (v) => setState(() => _value2 = v),
            ),
            ArcaneText(_value2 ? 'On' : 'Off', size: FontSize.sm, color: TextColor.muted),
          ],
        ),
      ],
    );
  }
}

/// Interactive slider demo
class SliderDemo extends StatefulComponent {
  const SliderDemo({super.key});

  @override
  State<SliderDemo> createState() => _SliderDemoState();
}

class _SliderDemoState extends State<SliderDemo> {
  double _value = 0.5;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '250px'),
          children: [
            ArcaneSlider(
              value: _value,
              onChanged: (v) => setState(() => _value = v),
            ),
          ],
        ),
        ArcaneText(
          'Value: ${(_value * 100).toStringAsFixed(0)}%',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive range slider demo
class RangeSliderDemo extends StatefulComponent {
  const RangeSliderDemo({super.key});

  @override
  State<RangeSliderDemo> createState() => _RangeSliderDemoState();
}

class _RangeSliderDemoState extends State<RangeSliderDemo> {
  double _minValue = 20;
  double _maxValue = 80;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '250px'),
          children: [
            ArcaneRangeSlider(
              minValue: _minValue,
              maxValue: _maxValue,
              min: 0,
              max: 100,
              onChanged: (min, max) => setState(() {
                _minValue = min;
                _maxValue = max;
              }),
            ),
          ],
        ),
        ArcaneText(
          'Range: ${_minValue.toStringAsFixed(0)} - ${_maxValue.toStringAsFixed(0)}',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive radio demo
class RadioDemo extends StatefulComponent {
  const RadioDemo({super.key});

  @override
  State<RadioDemo> createState() => _RadioDemoState();
}

class _RadioDemoState extends State<RadioDemo> {
  String _selected = 'a';

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneRow(
          gapSize: Gap.md,
          children: [
            ArcaneRadio(
              selected: _selected == 'a',
              label: 'Option A',
              onSelected: () => setState(() => _selected = 'a'),
            ),
            ArcaneRadio(
              selected: _selected == 'b',
              label: 'Option B',
              onSelected: () => setState(() => _selected = 'b'),
            ),
            ArcaneRadio(
              selected: _selected == 'c',
              label: 'Option C',
              onSelected: () => setState(() => _selected = 'c'),
            ),
          ],
        ),
        ArcaneText(
          'Selected: Option ${_selected.toUpperCase()}',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive toggle button demo
class ToggleButtonDemo extends StatefulComponent {
  const ToggleButtonDemo({super.key});

  @override
  State<ToggleButtonDemo> createState() => _ToggleButtonDemoState();
}

class _ToggleButtonDemoState extends State<ToggleButtonDemo> {
  bool _value1 = false;
  bool _value2 = true;

  @override
  Component build(BuildContext context) {
    return ArcaneRow(
      gapSize: Gap.md,
      children: [
        ArcaneToggleButton(
          value: _value1,
          label: 'Toggle',
          onChanged: (v) => setState(() => _value1 = v),
        ),
        ArcaneToggleButton(
          value: _value2,
          label: 'Selected',
          onChanged: (v) => setState(() => _value2 = v),
        ),
      ],
    );
  }
}

/// Interactive toggle button group demo
class ToggleButtonGroupDemo extends StatefulComponent {
  const ToggleButtonGroupDemo({super.key});

  @override
  State<ToggleButtonGroupDemo> createState() => _ToggleButtonGroupDemoState();
}

class _ToggleButtonGroupDemoState extends State<ToggleButtonGroupDemo> {
  int _selectedIndex = 0;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneToggleButtonGroup(
          options: const ['One', 'Two', 'Three'],
          selectedIndex: _selectedIndex,
          onChanged: (index) => setState(() => _selectedIndex = index),
        ),
        ArcaneText(
          'Selected: ${['One', 'Two', 'Three'][_selectedIndex]}',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive cycle button demo
class CycleButtonDemo extends StatefulComponent {
  const CycleButtonDemo({super.key});

  @override
  State<CycleButtonDemo> createState() => _CycleButtonDemoState();
}

class _CycleButtonDemoState extends State<CycleButtonDemo> {
  String _value = 'a';

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneCycleButton<String>(
          options: [
            ArcaneCycleOption(value: 'a', label: 'Option A'),
            ArcaneCycleOption(value: 'b', label: 'Option B'),
            ArcaneCycleOption(value: 'c', label: 'Option C'),
          ],
          value: _value,
          onChanged: (v) => setState(() => _value = v),
        ),
        ArcaneText(
          'Current: Option ${_value.toUpperCase()}',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive selector demo
class SelectorDemo extends StatefulComponent {
  const SelectorDemo({super.key});

  @override
  State<SelectorDemo> createState() => _SelectorDemoState();
}

class _SelectorDemoState extends State<SelectorDemo> {
  String _value = 'medium';

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [
            ArcaneSelector<String>(
              options: [
                ArcaneSelectorOption(value: 'small', label: 'Small'),
                ArcaneSelectorOption(value: 'medium', label: 'Medium'),
                ArcaneSelectorOption(value: 'large', label: 'Large'),
              ],
              value: _value,
              onChanged: (v) => setState(() => _value = v),
            ),
          ],
        ),
        ArcaneText(
          'Selected: ${_value[0].toUpperCase()}${_value.substring(1)}',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive select demo
class SelectDemo extends StatefulComponent {
  const SelectDemo({super.key});

  @override
  State<SelectDemo> createState() => _SelectDemoState();
}

class _SelectDemoState extends State<SelectDemo> {
  String? _value;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '200px'),
          children: [
            ArcaneSelect(
              label: 'Choose option',
              value: _value,
              options: const [
                ArcaneSelectOption(label: 'Option 1', value: '1'),
                ArcaneSelectOption(label: 'Option 2', value: '2'),
                ArcaneSelectOption(label: 'Option 3', value: '3'),
              ],
              onChange: (v) => setState(() => _value = v),
            ),
          ],
        ),
        ArcaneText(
          _value != null ? 'Selected: Option $_value' : 'No selection',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive number input demo
class NumberInputDemo extends StatefulComponent {
  const NumberInputDemo({super.key});

  @override
  State<NumberInputDemo> createState() => _NumberInputDemoState();
}

class _NumberInputDemoState extends State<NumberInputDemo> {
  int _value = 5;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '150px'),
          children: [
            ArcaneNumberInput(
              value: _value,
              min: 0,
              max: 10,
              onChanged: (v) => setState(() => _value = v.toInt()),
            ),
          ],
        ),
        ArcaneText(
          'Value: $_value (min: 0, max: 10)',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive tag input demo
class TagInputDemo extends StatefulComponent {
  const TagInputDemo({super.key});

  @override
  State<TagInputDemo> createState() => _TagInputDemoState();
}

class _TagInputDemoState extends State<TagInputDemo> {
  List<String> _tags = ['React', 'Vue', 'Angular'];

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '300px'),
          children: [
            ArcaneTagInput(
              tags: _tags,
              onTagsChanged: (tags) => setState(() => _tags = tags),
              placeholder: 'Add tags...',
            ),
          ],
        ),
        ArcaneText(
          'Tags: ${_tags.join(", ")}',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive color input demo
class ColorInputDemo extends StatefulComponent {
  const ColorInputDemo({super.key});

  @override
  State<ColorInputDemo> createState() => _ColorInputDemoState();
}

class _ColorInputDemoState extends State<ColorInputDemo> {
  String _color = '#10b981';

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '250px'),
          children: [
            ArcaneColorInput(
              value: _color,
              onChanged: (c) => setState(() => _color = c),
              label: 'Primary Color',
            ),
          ],
        ),
        ArcaneRow(
          gapSize: Gap.sm,
          children: [
            ArcaneDiv(
              styles: ArcaneStyleData(
                widthCustom: '24px',
                heightCustom: '24px',
                raw: {'background': _color, 'border-radius': '4px'},
              ),
              children: const [],
            ),
            ArcaneText(
              'Selected: $_color',
              size: FontSize.sm,
              color: TextColor.muted,
            ),
          ],
        ),
      ],
    );
  }
}

/// Interactive search demo
class SearchDemo extends StatefulComponent {
  const SearchDemo({super.key});

  @override
  State<SearchDemo> createState() => _SearchDemoState();
}

class _SearchDemoState extends State<SearchDemo> {
  String _query = '';

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.md,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '300px'),
          children: [
            ArcaneSearch(
              placeholder: 'Search...',
              onChanged: (v) => setState(() => _query = v),
            ),
          ],
        ),
        ArcaneText(
          _query.isEmpty ? 'Type to search...' : 'Query: "$_query"',
          size: FontSize.sm,
          color: TextColor.muted,
        ),
      ],
    );
  }
}

/// Interactive mutable text demo (inline editable text)
class MutableTextDemo extends StatefulComponent {
  const MutableTextDemo({super.key});

  @override
  State<MutableTextDemo> createState() => _MutableTextDemoState();
}

class _MutableTextDemoState extends State<MutableTextDemo> {
  String _title = 'Click to edit this title';
  String _subtitle = 'Double-click to edit';
  String _description = 'Hover over this text to edit it';

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Click trigger
        ArcaneColumn(
          gapSize: Gap.xs,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Click Trigger', size: FontSize.sm, color: TextColor.muted),
            ArcaneMutableText(
              value: _title,
              trigger: MutableTextTrigger.click,
              displayStyle: MutableTextStyle.underline,
              textStyles: const {'font-size': '1.25rem', 'font-weight': 'bold'},
              onSave: (value) => setState(() => _title = value),
            ),
          ],
        ),

        // Double-click trigger
        ArcaneColumn(
          gapSize: Gap.xs,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Double-Click Trigger', size: FontSize.sm, color: TextColor.muted),
            ArcaneMutableText(
              value: _subtitle,
              trigger: MutableTextTrigger.doubleClick,
              displayStyle: MutableTextStyle.dashed,
              onSave: (value) => setState(() => _subtitle = value),
            ),
          ],
        ),

        // Hover trigger with validation
        ArcaneColumn(
          gapSize: Gap.xs,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Hover Trigger (with validation)', size: FontSize.sm, color: TextColor.muted),
            ArcaneMutableText(
              value: _description,
              trigger: MutableTextTrigger.hover,
              displayStyle: MutableTextStyle.subtle,
              minLength: 5,
              maxLength: 100,
              showCharCount: true,
              onSave: (value) => setState(() => _description = value),
            ),
          ],
        ),

        // All display styles showcase
        ArcaneText('Display Styles', weight: FontWeight.w600),
        ArcaneRow(
          gapSize: Gap.lg,
          children: [
            ArcaneMutableText(value: 'Inline', displayStyle: MutableTextStyle.inline, onSave: (_) {}),
            ArcaneMutableText(value: 'Subtle', displayStyle: MutableTextStyle.subtle, onSave: (_) {}),
            ArcaneMutableText(value: 'Underline', displayStyle: MutableTextStyle.underline, onSave: (_) {}),
            ArcaneMutableText(value: 'Dashed', displayStyle: MutableTextStyle.dashed, onSave: (_) {}),
          ],
        ),
      ],
    );
  }
}

/// Interactive radio group demo with all variants
class RadioGroupDemo extends StatefulComponent {
  const RadioGroupDemo({super.key});

  @override
  State<RadioGroupDemo> createState() => _RadioGroupDemoState();
}

class _RadioGroupDemoState extends State<RadioGroupDemo> {
  String? _standardValue = 'option1';
  String? _cardValue = 'small';
  String? _buttonValue = 'monthly';
  String? _chipValue = 'all';

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.xl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Standard variant
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Standard Variant', weight: FontWeight.w600),
            ArcaneRadioGroup<String>(
              value: _standardValue,
              options: const [
                RadioOption(value: 'option1', label: 'Option 1', description: 'First option with description'),
                RadioOption(value: 'option2', label: 'Option 2', description: 'Second option with description'),
                RadioOption(value: 'option3', label: 'Option 3', disabled: true),
              ],
              onChanged: (v) => setState(() => _standardValue = v),
              label: 'Choose an option',
            ),
          ],
        ),

        // Cards variant
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Cards Variant', weight: FontWeight.w600),
            ArcaneRadioGroup<String>(
              value: _cardValue,
              variant: RadioGroupVariant.cards,
              layout: RadioGroupLayout.grid,
              gridColumns: 3,
              options: const [
                RadioOption(value: 'small', label: 'Small', description: '8GB RAM'),
                RadioOption(value: 'medium', label: 'Medium', description: '16GB RAM'),
                RadioOption(value: 'large', label: 'Large', description: '32GB RAM'),
              ],
              onChanged: (v) => setState(() => _cardValue = v),
            ),
          ],
        ),

        // Buttons variant (segmented control)
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Buttons Variant (Segmented Control)', weight: FontWeight.w600),
            ArcaneRadioGroup<String>(
              value: _buttonValue,
              variant: RadioGroupVariant.buttons,
              layout: RadioGroupLayout.horizontal,
              options: const [
                RadioOption(value: 'monthly', label: 'Monthly'),
                RadioOption(value: 'yearly', label: 'Yearly'),
                RadioOption(value: 'lifetime', label: 'Lifetime'),
              ],
              onChanged: (v) => setState(() => _buttonValue = v),
            ),
          ],
        ),

        // Chips variant
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Chips Variant', weight: FontWeight.w600),
            ArcaneRadioGroup<String>(
              value: _chipValue,
              variant: RadioGroupVariant.chips,
              layout: RadioGroupLayout.horizontal,
              options: const [
                RadioOption(value: 'all', label: 'All'),
                RadioOption(value: 'active', label: 'Active'),
                RadioOption(value: 'completed', label: 'Completed'),
                RadioOption(value: 'archived', label: 'Archived'),
              ],
              onChanged: (v) => setState(() => _chipValue = v),
            ),
          ],
        ),
      ],
    );
  }
}

/// Interactive OTP input demo
class OtpInputDemo extends StatefulComponent {
  const OtpInputDemo({super.key});

  @override
  State<OtpInputDemo> createState() => _OtpInputDemoState();
}

class _OtpInputDemoState extends State<OtpInputDemo> {
  String _value4 = '';
  String _value6 = '';

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.xl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('4-Digit Code', size: FontSize.sm, color: TextColor.muted),
            ArcaneOtpInput(
              length: 4,
              onComplete: (code) => setState(() => _value4 = code),
              onChange: (code) => setState(() => _value4 = code),
            ),
            if (_value4.isNotEmpty)
              ArcaneText('Entered: $_value4', size: FontSize.sm, color: TextColor.accent),
          ],
        ),
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('6-Digit Code', size: FontSize.sm, color: TextColor.muted),
            ArcaneOtpInput(
              length: 6,
              onComplete: (code) => setState(() => _value6 = code),
              onChange: (code) => setState(() => _value6 = code),
            ),
            if (_value6.length == 6)
              ArcaneText('Code complete!', size: FontSize.sm, color: TextColor.success),
          ],
        ),
      ],
    );
  }
}

/// Interactive combobox demo
class ComboboxDemo extends StatefulComponent {
  const ComboboxDemo({super.key});

  @override
  State<ComboboxDemo> createState() => _ComboboxDemoState();
}

class _ComboboxDemoState extends State<ComboboxDemo> {
  String? _selectedFruit;
  String? _selectedFramework;

  @override
  Component build(BuildContext context) {
    return ArcaneRow(
      gapSize: Gap.xl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneDiv(
              styles: const ArcaneStyleData(widthCustom: '200px'),
              children: [
                ArcaneCombobox<String>(
                  label: 'Select Fruit',
                  placeholder: 'Choose a fruit...',
                  options: const [
                    ComboboxOption(value: 'apple', label: 'Apple'),
                    ComboboxOption(value: 'banana', label: 'Banana'),
                    ComboboxOption(value: 'cherry', label: 'Cherry'),
                    ComboboxOption(value: 'grape', label: 'Grape'),
                    ComboboxOption(value: 'orange', label: 'Orange'),
                  ],
                  value: _selectedFruit,
                  onChanged: (v) => setState(() => _selectedFruit = v),
                ),
              ],
            ),
            if (_selectedFruit != null)
              ArcaneText('Selected: $_selectedFruit', size: FontSize.sm, color: TextColor.muted),
          ],
        ),
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneDiv(
              styles: const ArcaneStyleData(widthCustom: '250px'),
              children: [
                ArcaneCombobox<String>(
                  label: 'Framework',
                  placeholder: 'Search frameworks...',
                  searchPlaceholder: 'Type to filter...',
                  options: const [
                    ComboboxOption(value: 'react', label: 'React', description: 'A JavaScript library'),
                    ComboboxOption(value: 'vue', label: 'Vue', description: 'Progressive framework'),
                    ComboboxOption(value: 'angular', label: 'Angular', description: 'Platform for web apps'),
                    ComboboxOption(value: 'svelte', label: 'Svelte', description: 'Compile-time framework'),
                  ],
                  value: _selectedFramework,
                  onChanged: (v) => setState(() => _selectedFramework = v),
                ),
              ],
            ),
            if (_selectedFramework != null)
              ArcaneText('Selected: $_selectedFramework', size: FontSize.sm, color: TextColor.muted),
          ],
        ),
      ],
    );
  }
}

/// Interactive calendar demo
class CalendarDemo extends StatefulComponent {
  const CalendarDemo({super.key});

  @override
  State<CalendarDemo> createState() => _CalendarDemoState();
}

class _CalendarDemoState extends State<CalendarDemo> {
  DateTime? _selectedDate;
  DateRange? _selectedRange;

  @override
  Component build(BuildContext context) {
    return ArcaneRow(
      gapSize: Gap.xl,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Single Date', weight: FontWeight.w600),
            ArcaneCalendar(
              mode: CalendarMode.single,
              selected: _selectedDate,
              onSelect: (date) => setState(() => _selectedDate = date),
            ),
            if (_selectedDate != null)
              ArcaneText(
                'Selected: ${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}',
                size: FontSize.sm,
                color: TextColor.muted,
              ),
          ],
        ),
        ArcaneColumn(
          gapSize: Gap.sm,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ArcaneText('Date Range', weight: FontWeight.w600),
            ArcaneCalendar(
              mode: CalendarMode.range,
              selectedRange: _selectedRange,
              onRangeSelect: (range) => setState(() => _selectedRange = range),
            ),
            if (_selectedRange != null)
              ArcaneText(
                'Range: ${_selectedRange!.start.month}/${_selectedRange!.start.day} - ${_selectedRange!.end.month}/${_selectedRange!.end.day}',
                size: FontSize.sm,
                color: TextColor.muted,
              ),
          ],
        ),
      ],
    );
  }
}

/// Interactive date picker demo
class DatePickerDemo extends StatefulComponent {
  const DatePickerDemo({super.key});

  @override
  State<DatePickerDemo> createState() => _DatePickerDemoState();
}

class _DatePickerDemoState extends State<DatePickerDemo> {
  DateTime? _selectedDate;

  @override
  Component build(BuildContext context) {
    return ArcaneColumn(
      gapSize: Gap.lg,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ArcaneDiv(
          styles: const ArcaneStyleData(widthCustom: '280px'),
          children: [
            ArcaneDatePicker(
              label: 'Select Date',
              value: _selectedDate,
              onChanged: (date) => setState(() => _selectedDate = date),
              placeholder: 'Pick a date...',
            ),
          ],
        ),
        if (_selectedDate != null)
          ArcaneText(
            'Selected: ${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}',
            size: FontSize.sm,
            color: TextColor.accent,
          ),
      ],
    );
  }
}
