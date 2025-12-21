// These tests only cover auth models that don't require web platform.
// Provider and guard tests require web runtime and are tested separately.

import 'package:arcane_jaspr/service/auth_state.dart';
import 'package:arcane_jaspr/util/auth/password_policy.dart';
import 'package:jaspr_test/jaspr_test.dart';

void main() {
  group('PasswordPolicy', () {
    group('weak policy', () {
      test('has minimum length of 6', () {
        expect(PasswordPolicy.weak.minLength, equals(6));
      });

      test('does not require uppercase', () {
        expect(PasswordPolicy.weak.requireUppercase, isFalse);
      });

      test('does not require lowercase', () {
        expect(PasswordPolicy.weak.requireLowercase, isFalse);
      });

      test('does not require number', () {
        expect(PasswordPolicy.weak.requireNumber, isFalse);
      });

      test('does not require special character', () {
        expect(PasswordPolicy.weak.requireSpecialChar, isFalse);
      });

      test('validates password meeting minimum length', () {
        expect(PasswordPolicy.weak.isValid('123456'), isTrue);
        expect(PasswordPolicy.weak.isValid('12345'), isFalse);
      });

      test('validate returns null for valid password', () {
        expect(PasswordPolicy.weak.validate('123456'), isNull);
      });

      test('validate returns error for short password', () {
        expect(PasswordPolicy.weak.validate('12345'), isNotNull);
      });

      test('has description', () {
        expect(PasswordPolicy.weak.description, isNotEmpty);
      });
    });

    group('medium policy', () {
      test('has minimum length of 8', () {
        expect(PasswordPolicy.medium.minLength, equals(8));
      });

      test('requires uppercase', () {
        expect(PasswordPolicy.medium.requireUppercase, isTrue);
      });

      test('requires number', () {
        expect(PasswordPolicy.medium.requireNumber, isTrue);
      });

      test('validates password meeting all requirements', () {
        expect(PasswordPolicy.medium.isValid('Password1'), isTrue);
        expect(PasswordPolicy.medium.isValid('password1'), isFalse); // no uppercase
        expect(PasswordPolicy.medium.isValid('PASSWORD1'), isTrue); // medium doesn't require lowercase
        expect(PasswordPolicy.medium.isValid('Password'), isFalse); // no number
      });

      test('has description', () {
        expect(PasswordPolicy.medium.description, isNotEmpty);
      });
    });

    group('strong policy', () {
      test('has minimum length of 8', () {
        expect(PasswordPolicy.strong.minLength, equals(8));
      });

      test('requires uppercase', () {
        expect(PasswordPolicy.strong.requireUppercase, isTrue);
      });

      test('requires lowercase', () {
        expect(PasswordPolicy.strong.requireLowercase, isTrue);
      });

      test('requires number', () {
        expect(PasswordPolicy.strong.requireNumber, isTrue);
      });

      test('requires special character', () {
        expect(PasswordPolicy.strong.requireSpecialChar, isTrue);
      });

      test('validates password meeting all requirements', () {
        expect(PasswordPolicy.strong.isValid('Password1!'), isTrue);
        expect(PasswordPolicy.strong.isValid('Password1'), isFalse); // no special char
        expect(PasswordPolicy.strong.isValid('Pass1!'), isFalse); // too short
      });

      test('has description', () {
        expect(PasswordPolicy.strong.description, isNotEmpty);
      });
    });

    group('custom policy', () {
      test('accepts custom configuration', () {
        final policy = const PasswordPolicy(
          minLength: 10,
          requireUppercase: true,
          requireLowercase: false,
          requireNumber: true,
          requireSpecialChar: false,
        );
        expect(policy.minLength, equals(10));
        expect(policy.requireUppercase, isTrue);
        expect(policy.requireLowercase, isFalse);
      });

      test('validates against custom rules', () {
        final policy = const PasswordPolicy(
          minLength: 4,
          requireUppercase: true,
          requireLowercase: false,
          requireNumber: false,
          requireSpecialChar: false,
        );
        expect(policy.isValid('ABCD'), isTrue);
        expect(policy.isValid('abcd'), isFalse);
      });

      test('respects maxLength', () {
        final policy = const PasswordPolicy(
          minLength: 4,
          maxLength: 8,
        );
        expect(policy.isValid('12345'), isTrue);
        expect(policy.isValid('123456789'), isFalse);
      });
    });
  });

  group('AuthMethod', () {
    test('email method exists', () {
      expect(AuthMethod.email, isNotNull);
    });

    test('github method exists', () {
      expect(AuthMethod.github, isNotNull);
    });

    test('google method exists', () {
      expect(AuthMethod.google, isNotNull);
    });

    test('apple method exists', () {
      expect(AuthMethod.apple, isNotNull);
    });

    test('anonymous method exists', () {
      expect(AuthMethod.anonymous, isNotNull);
    });
  });

  group('AuthStatus', () {
    test('unknown status exists', () {
      expect(AuthStatus.unknown, isNotNull);
    });

    test('loading status exists', () {
      expect(AuthStatus.loading, isNotNull);
    });

    test('authenticated status exists', () {
      expect(AuthStatus.authenticated, isNotNull);
    });

    test('unauthenticated status exists', () {
      expect(AuthStatus.unauthenticated, isNotNull);
    });

    test('error status exists', () {
      expect(AuthStatus.error, isNotNull);
    });
  });

  group('AuthUser', () {
    test('creates user with required fields', () {
      final user = const AuthUser(
        uid: 'test-uid',
        email: 'test@example.com',
      );
      expect(user.uid, equals('test-uid'));
      expect(user.email, equals('test@example.com'));
    });

    test('creates user with optional fields', () {
      final user = const AuthUser(
        uid: 'test-uid',
        email: 'test@example.com',
        displayName: 'Test User',
        photoURL: 'https://example.com/photo.jpg',
        emailVerified: true,
      );
      expect(user.displayName, equals('Test User'));
      expect(user.photoURL, equals('https://example.com/photo.jpg'));
      expect(user.emailVerified, isTrue);
    });

    test('defaults emailVerified to false', () {
      final user = const AuthUser(
        uid: 'test-uid',
        email: 'test@example.com',
      );
      expect(user.emailVerified, isFalse);
    });

    test('defaults isAnonymous to false', () {
      final user = const AuthUser(
        uid: 'test-uid',
        email: 'test@example.com',
      );
      expect(user.isAnonymous, isFalse);
    });

    test('copyWith preserves values', () {
      final user = const AuthUser(
        uid: 'test-uid',
        email: 'test@example.com',
        displayName: 'Test User',
      );
      final copied = user.copyWith(displayName: 'New Name');
      expect(copied.uid, equals('test-uid'));
      expect(copied.email, equals('test@example.com'));
      expect(copied.displayName, equals('New Name'));
    });

    test('toString returns meaningful string', () {
      final user = const AuthUser(uid: 'uid', email: 'test@example.com');
      expect(user.toString(), contains('uid'));
      expect(user.toString(), contains('test@example.com'));
    });
  });

  group('AuthState', () {
    test('default state is unknown', () {
      final state = const AuthState();
      expect(state.status, equals(AuthStatus.unknown));
      expect(state.user, isNull);
      expect(state.error, isNull);
    });

    test('loading state has correct status', () {
      final state = const AuthState.loading();
      expect(state.status, equals(AuthStatus.loading));
      expect(state.isLoading, isTrue);
    });

    test('authenticated state includes user', () {
      final user = const AuthUser(uid: 'uid', email: 'test@example.com');
      final state = AuthState.authenticated(user);
      expect(state.status, equals(AuthStatus.authenticated));
      expect(state.user, equals(user));
      expect(state.isAuthenticated, isTrue);
    });

    test('unauthenticated state has no user', () {
      final state = const AuthState.unauthenticated();
      expect(state.status, equals(AuthStatus.unauthenticated));
      expect(state.user, isNull);
      expect(state.isAuthenticated, isFalse);
    });

    test('error state includes message', () {
      final state = AuthState.withError('Something went wrong');
      expect(state.status, equals(AuthStatus.error));
      expect(state.error, equals('Something went wrong'));
      expect(state.hasError, isTrue);
    });

    test('isUnknown returns true for unknown state', () {
      final state = const AuthState();
      expect(state.isUnknown, isTrue);
    });

    test('copyWith updates specified fields', () {
      final state = const AuthState();
      final updated = state.copyWith(status: AuthStatus.loading);
      expect(updated.status, equals(AuthStatus.loading));
    });

    test('toString returns meaningful string', () {
      final state = const AuthState.loading();
      expect(state.toString(), contains('loading'));
    });
  });
}
