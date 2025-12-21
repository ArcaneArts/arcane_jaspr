/// Password validation policy
///
/// Configure password requirements for registration.
///
/// ```dart
/// const PasswordPolicy policy = PasswordPolicy(
///   minLength: 8,
///   requireUppercase: true,
///   requireLowercase: true,
///   requireNumber: true,
///   requireSpecialChar: true,
/// );
///
/// String? error = policy.validate(password);
/// ```
class PasswordPolicy {
  /// Minimum password length
  final int minLength;

  /// Maximum password length
  final int maxLength;

  /// Require at least one uppercase letter
  final bool requireUppercase;

  /// Require at least one lowercase letter
  final bool requireLowercase;

  /// Require at least one number
  final bool requireNumber;

  /// Require at least one special character
  final bool requireSpecialChar;

  const PasswordPolicy({
    this.minLength = 6,
    this.maxLength = 128,
    this.requireUppercase = false,
    this.requireLowercase = false,
    this.requireNumber = false,
    this.requireSpecialChar = false,
  });

  /// Strong password policy preset
  static const PasswordPolicy strong = PasswordPolicy(
    minLength: 8,
    requireUppercase: true,
    requireLowercase: true,
    requireNumber: true,
    requireSpecialChar: true,
  );

  /// Medium password policy preset
  static const PasswordPolicy medium = PasswordPolicy(
    minLength: 8,
    requireUppercase: true,
    requireNumber: true,
  );

  /// Weak password policy preset (just length)
  static const PasswordPolicy weak = PasswordPolicy(
    minLength: 6,
  );

  /// Validate a password against this policy
  ///
  /// Returns null if valid, or an error message if invalid.
  String? validate(String password) {
    if (password.length < minLength) {
      return 'Password must be at least $minLength characters long.';
    }

    if (password.length > maxLength) {
      return 'Password must be no more than $maxLength characters long.';
    }

    if (requireUppercase && !password.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter.';
    }

    if (requireLowercase && !password.contains(RegExp(r'[a-z]'))) {
      return 'Password must contain at least one lowercase letter.';
    }

    if (requireNumber && !password.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number.';
    }

    if (requireSpecialChar &&
        !password.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character.';
    }

    return null; // Valid
  }

  /// Check if a password is valid
  bool isValid(String password) => validate(password) == null;

  /// Get a human-readable description of the policy
  String get description {
    final List<String> requirements = <String>[];

    requirements.add('At least $minLength characters');

    if (requireUppercase) {
      requirements.add('one uppercase letter');
    }
    if (requireLowercase) {
      requirements.add('one lowercase letter');
    }
    if (requireNumber) {
      requirements.add('one number');
    }
    if (requireSpecialChar) {
      requirements.add('one special character');
    }

    if (requirements.length == 1) {
      return requirements.first;
    }

    return requirements.first +
        ', ' +
        requirements.sublist(1).join(', ');
  }
}
