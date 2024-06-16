import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:form_inputs/form_inputs.dart';
import 'package:formz/formz.dart';
import 'package:kamchatka/src/data/data_repository.dart';

part 'register_state.dart';

class RegisterCubit extends Cubit<RegisterState> {
  RegisterCubit(this._dioClient) : super(const RegisterState());

  final DataRepository _dioClient;

  @override
  void onChange(Change<RegisterState> change) {
    super.onChange(change);
  }

  void firstNameChanged(String value) {
    final firstName = Name.dirty(value);
    emit(
      state.copyWith(
        firstName: firstName,
        isValid: Formz.validate([
          firstName,
          state.secondName,
          state.email,
          state.password,
          state.confirmedPassword,
          state.question,
          state.answer,
          state.passport,
          state.region,
          state.citizenship,
        ]),
      ),
    );
  }

  void secondNameChanged(String value) {
    final secondName = Name.dirty(value);
    emit(
      state.copyWith(
        secondName: secondName,
        isValid: Formz.validate([
          state.firstName,
          secondName,
          state.email,
          state.password,
          state.confirmedPassword,
          state.question,
          state.answer,
          state.passport,
          state.region,
          state.citizenship,
        ]),
      ),
    );
  }

  void thirdNameChanged(String value) {
    final thirdName = Name.dirty(value);
    emit(
      state.copyWith(
        thirdName: thirdName,
        isValid: Formz.validate([
          state.firstName,
          state.secondName,
          thirdName,
          state.email,
          state.password,
          state.confirmedPassword,
          state.question,
          state.answer,
          state.passport,
          state.region,
          state.citizenship,
        ]),
      ),
    );
  }

  void emailChanged(String value) {
    final email = Email.dirty(value);
    emit(
      state.copyWith(
        email: email,
        isValid: Formz.validate([
          email,
          state.firstName,
          state.secondName,
          state.password,
          state.confirmedPassword,
          state.question,
          state.answer,
          state.passport,
          state.region,
          state.citizenship,
        ]),
      ),
    );
  }

  void passwordChanged(String value) {
    final password = Password.dirty(value);
    final confirmedPassword = ConfirmedPassword.dirty(
      password: password.value,
      value: state.confirmedPassword.value,
    );
    emit(
      state.copyWith(
        password: password,
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.email,
          state.firstName,
          state.secondName,
          password,
          confirmedPassword,
          state.question,
          state.answer,
          state.passport,
          state.region,
          state.citizenship,
        ]),
      ),
    );
  }

  void confirmedPasswordChanged(String value) {
    final confirmedPassword = ConfirmedPassword.dirty(
      password: state.password.value,
      value: value,
    );
    emit(
      state.copyWith(
        confirmedPassword: confirmedPassword,
        isValid: Formz.validate([
          state.email,
          state.firstName,
          state.secondName,
          state.password,
          confirmedPassword,
          state.question,
          state.answer,
          state.passport,
          state.region,
          state.citizenship,
        ]),
      ),
    );
  }

  void questionChanged(String value) {
    final question = Question.dirty(value);
    emit(
      state.copyWith(
        question: question,
        isValid: Formz.validate([
          state.email,
          state.firstName,
          state.secondName,
          state.password,
          state.confirmedPassword,
          question,
          state.answer,
          state.passport,
          state.region,
          state.citizenship,
        ]),
      ),
    );
  }

  void answerChanged(String value) {
    final answer = Answer.dirty(value);
    emit(
      state.copyWith(
        answer: answer,
        isValid: Formz.validate([
          state.email,
          state.firstName,
          state.secondName,
          state.password,
          state.confirmedPassword,
          state.question,
          answer,
          state.passport,
          state.region,
          state.citizenship,
        ]),
      ),
    );
  }

  void checkBoxChanged(bool check) {
    emit(
      state.copyWith(
        check: check,
        isValid: Formz.validate([
          state.email,
          state.firstName,
          state.secondName,
          state.password,
          state.confirmedPassword,
          state.question,
          state.answer,
          state.passport,
          state.region,
          state.citizenship,
        ]),
      ),
    );
  }

  void birthdayChanged(DateTime birthday) {
    emit(
      state.copyWith(
        birthday: birthday,
        isValid: Formz.validate([
          state.email,
          state.firstName,
          state.secondName,
          state.password,
          state.confirmedPassword,
          state.question,
          state.answer,
          state.passport,
          state.region,
          state.citizenship,
        ]),
      ),
    );
  }

  void citizenshipChanged(String value) {
    final citizenship = Name.dirty(value);
    emit(
      state.copyWith(
        citizenship: citizenship,
        isValid: Formz.validate([
          state.email,
          state.firstName,
          state.secondName,
          state.password,
          state.confirmedPassword,
          state.question,
          state.answer,
          state.passport,
          state.region,
          citizenship,
        ]),
      ),
    );
  }

  void genderChanged(String gender) {
    emit(
      state.copyWith(
        gender: gender,
        isValid: Formz.validate([
          state.email,
          state.firstName,
          state.secondName,
          state.password,
          state.confirmedPassword,
          state.question,
          state.answer,
          state.passport,
          state.region,
          state.citizenship,
        ]),
      ),
    );
  }

  void regionChanged(String value) {
    final region = Name.dirty(value);
    emit(
      state.copyWith(
        region: region,
        isValid: Formz.validate([
          state.email,
          state.firstName,
          state.secondName,
          state.password,
          state.confirmedPassword,
          state.question,
          state.answer,
          state.passport,
          region,
          state.citizenship,
        ]),
      ),
    );
  }

  void passportChanged(String value) {
    final passport = Passport.dirty(value);
    emit(
      state.copyWith(
        passport: passport,
        isValid: Formz.validate([
          state.email,
          state.firstName,
          state.secondName,
          state.password,
          state.confirmedPassword,
          state.question,
          state.answer,
          passport,
          state.region,
          state.citizenship,
        ]),
      ),
    );
  }

  Future<void> registerFormSubmitted() async {
    if (!state.isValid || !state.check) return;
    emit(state.copyWith(status: FormzSubmissionStatus.inProgress));
    try {
      await _dioClient.register(
        email: state.email.value,
        password: state.password.value,
        firstName: state.firstName.value,
        secondName: state.secondName.value,
        thirdName: state.thirdName?.value ?? '',
        gender: state.gender,
        birthday: state.birthday ?? DateTime.now(),
        citizenship: state.citizenship.value,
        passport: state.passport.value,
        region: state.region.value,
      );
      emit(state.copyWith(status: FormzSubmissionStatus.success));
    } on Exception catch (e) {
      emit(
        state.copyWith(
          errorMessage: e.toString(),
          status: FormzSubmissionStatus.failure,
        ),
      );
    } catch (_) {
      emit(state.copyWith(status: FormzSubmissionStatus.failure));
    }
  }
}
