import 'package:discover_morocco/business_logic/utils/logicConstants.dart';

class AddFailure implements Exception {
  const AddFailure([
    this.message = 'An unknown exception occurred.',
  ]);

  factory AddFailure.fromCode(
    String code,
  ) {
    // LogInWithGoogleFailure
    switch (code) {
      default:
        return AddFailure(
          fails['failureUnknown']!,
        );
    }
  }

  /// The associated error message.
  final String message;
}
