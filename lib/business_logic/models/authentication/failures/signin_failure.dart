import 'package:discover_morocco/business_logic/utils/logicConstants.dart';

class SignInFailure implements Exception {
  const SignInFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SignInFailure.fromCode(
    String code,
  ) {
    // LogInWithGoogleFailure
    switch (code) {
      case 'account-exists-with-different-credential':
        return SignInFailure(
          fails['failureDifferentCredentials']!,
        );
      case 'too-many-requests':
        return SignInFailure(
          fails['failureTooManyRequests']!,
        );
      case 'invalid-credential':
        return SignInFailure(
          fails['failureExpiredMalformedCredential']!,
        );
      case 'operation-not-allowed':
        return SignInFailure(
          fails['failureOperationNotAllowed']!,
        );
      case 'user-disabled':
        return SignInFailure(
          fails['failureUserDisabled']!,
        );
      case 'user-not-found':
        return SignInFailure(
          fails['failureEmailNotFound']!,
        );
      case 'wrong-password':
        return SignInFailure(
          fails['failureIncorrectPassword']!,
        );
      case 'invalid-verification-code':
        return SignInFailure(
          fails['failureInvalidVerificationCode']!,
        );
      case 'invalid-verification-id':
        return SignInFailure(
          fails['failureInvalidVerificationId']!,
        );
      // SignInWithEmailAndPasswordFailure
      case 'invalid-email':
        return SignInFailure(
          fails['failureEmailBadlyFormatted']!,
        );
      // SignInWithEmailLinkFailure
      case 'expired-action-code':
        return SignInFailure(
          fails['failureOtpExpired']!,
        );
      case 'quota-exceeded':
        return SignInFailure(
          fails['failureQuotaExceeded']!,
        );
      case 'email-already-in-use':
        return SignInFailure(
          fails['failureEmailAccountExists']!,
        );
      case 'weak-password':
        return SignInFailure(
          fails['failureStrongerPassword']!,
        );
      default:
        return SignInFailure(
          fails['failureUnknown']!,
        );
    }
  }

  /// The associated error message.
  final String message;
}
