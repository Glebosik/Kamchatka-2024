part of 'register_cubit.dart';

enum ConfirmPasswordValidationError { invalid }

final class RegisterState extends Equatable {
  const RegisterState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmedPassword = const ConfirmedPassword.pure(),
    this.question = const Question.pure(),
    this.answer = const Answer.pure(),
    this.firstName = const Name.pure(),
    this.secondName = const Name.pure(),
    this.thirdName,
    this.passport = const Passport.pure(),
    this.check = false,
    this.status = FormzSubmissionStatus.initial,
    this.isValid = false,
    this.errorMessage,
    this.birthday,
    this.citizenship = const Name.dirty('Россия'),
    this.gender = 'o',
    this.region = const Name.dirty('Камчатский край'),
  });

  final Email email;
  final Password password;
  final ConfirmedPassword confirmedPassword;
  final Question question;
  final Answer answer;
  final Name firstName;
  final Name secondName;
  final Name? thirdName;
  final Passport passport;
  final DateTime? birthday;
  final String gender;
  final Name citizenship;
  final Name region;
  final bool check;
  final FormzSubmissionStatus status;
  final bool isValid;
  final String? errorMessage;

  @override
  List<Object?> get props => [
        firstName,
        secondName,
        thirdName,
        email,
        password,
        confirmedPassword,
        question,
        answer,
        check,
        status,
        isValid,
        errorMessage,
        birthday,
        citizenship,
        region,
        gender,
        passport,
      ];

  RegisterState copyWith({
    Email? email,
    Password? password,
    ConfirmedPassword? confirmedPassword,
    Question? question,
    Answer? answer,
    Name? firstName,
    Name? secondName,
    Name? thirdName,
    Passport? passport,
    DateTime? birthday,
    bool? check,
    FormzSubmissionStatus? status,
    bool? isValid,
    String? errorMessage,
    Name? citizenship,
    String? gender,
    Name? region,
  }) {
    return RegisterState(
      email: email ?? this.email,
      password: password ?? this.password,
      confirmedPassword: confirmedPassword ?? this.confirmedPassword,
      question: question ?? this.question,
      answer: answer ?? this.answer,
      firstName: firstName ?? this.firstName,
      secondName: secondName ?? this.secondName,
      thirdName: thirdName ?? this.thirdName,
      passport: passport ?? this.passport,
      birthday: birthday ?? this.birthday,
      check: check ?? this.check,
      status: status ?? this.status,
      isValid: isValid ?? this.isValid,
      errorMessage: errorMessage ?? this.errorMessage,
      citizenship: citizenship ?? this.citizenship,
      gender: gender ?? this.gender,
      region: region ?? this.region,
    );
  }
}
