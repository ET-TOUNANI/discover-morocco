import 'package:discover_morocco/business_logic/utils/logicConstants.dart';

import 'signin_failure.dart';


class SendEmailLinkFailure extends SignInFailure implements Exception {
  const SendEmailLinkFailure([
    String message = 'An unknown exception occurred.',
  ]) : super(message);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  @override
  factory SendEmailLinkFailure.fromCode(
    String code
  ) {
    switch (code) {
      case 'internal-error':
        return SendEmailLinkFailure(
          fails['failureSignInWithEmailLink']!,
        );
      default:
        return SignInFailure.fromCode(code)
            as SendEmailLinkFailure;
    }
  }
}
