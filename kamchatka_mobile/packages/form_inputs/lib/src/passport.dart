import 'package:formz/formz.dart';

/// Validation errors for the [passport] [FormzInput].
enum PassportValidationError {
  /// Generic invalid error.
  invalid
}

/// {@template passport}
/// Form input for an passport input.
/// {@endtemplate}
class Passport extends FormzInput<String, PassportValidationError> {
  /// {@macro passport}
  const Passport.pure() : super.pure('');

  /// {@macro passport}
  const Passport.dirty([super.value = '']) : super.dirty();

  static final _passportRegExp = RegExp(r'^[0-9]{4}[0-9]{6}');

  @override
  PassportValidationError? validator(String? value) {
    print('$value - ${_passportRegExp.hasMatch(value ?? '')}');
    return _passportRegExp.hasMatch(value ?? '')
        ? null
        : PassportValidationError.invalid;
  }
}
