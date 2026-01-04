/// Edit trigger mode for mutable text
enum MutableTextTrigger {
  /// Click on text to edit
  click,

  /// Double-click on text to edit
  doubleClick,

  /// Hover shows edit icon, click to edit
  hover,

  /// Always in edit mode
  always,
}

/// Input type for mutable text
enum MutableTextInputType {
  /// Single line text input
  text,

  /// Multi-line textarea
  multiline,

  /// Number input
  number,

  /// Email input
  email,

  /// URL input
  url,
}

/// Display style when not editing
enum MutableTextStyle {
  /// Inline text with no decoration
  inline,

  /// Shows subtle border/background on hover
  subtle,

  /// Shows underline indicating editability
  underline,

  /// Shows dashed underline
  dashed,

  /// Looks like a text input (with border)
  input,
}
