import 'package:discover_morocco/business_logic/utils/logicConstants.dart';

import 'signin_failure.dart';

class SignInAnonymouslyFailure extends SignInFailure implements Exception {
  const SignInAnonymouslyFailure([
    String message = 'An unknown exception occurred.',
  ]) : super(message);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  @override
  factory SignInAnonymouslyFailure.fromCode(String code) {
    switch (code) {
      case 'operation-not-allowed':
        return SignInAnonymouslyFailure(
          fails['failureAnonymousNotEnabled']!,
        );
      default:
        return SignInFailure.fromCode(code) as SignInAnonymouslyFailure;
    }
  }
}
