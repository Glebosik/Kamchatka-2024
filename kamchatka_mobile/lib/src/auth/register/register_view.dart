import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/auth/login/login_view.dart';
import 'package:kamchatka/src/auth/register/cubit/register_cubit.dart';
import 'package:kamchatka/src/auth/register/form_widgets/form_widgets.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state.status.isSuccess) {
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (context) => const LoginPage()),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Регистрация'),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(20, 16, 20, 16),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(left: width * 0.05),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Личные данные',
                      style: GoogleFonts.inter().copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.04),
                const SecondNameInput(),
                SizedBox(height: height * 0.02),
                const FirstNameInput(),
                SizedBox(height: height * 0.02),
                const ThirdNameInput(),
                SizedBox(height: height * 0.02),
                const BirthdayInput(),
                SizedBox(height: height * 0.02),
                const PassportInput(),
                SizedBox(height: height * 0.02),
                const GenderInput(),
                SizedBox(height: height * 0.02),
                const CitizenshipInput(),
                SizedBox(height: height * 0.02),
                const RegionInput(),
                SizedBox(height: height * 0.04),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.05),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Контактная информация',
                      style: GoogleFonts.inter().copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: width * 0.04),
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'На указанный адрес электронной почты буде отправлен код подтверждения регистрации',
                      style: GoogleFonts.inter().copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.04),
                const EmailInput(),
                SizedBox(height: height * 0.04),
                Padding(
                  padding: EdgeInsets.only(left: width * 0.05),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Безопасность',
                      style: GoogleFonts.inter().copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: width * 0.04),
                Padding(
                  padding:
                      EdgeInsets.only(left: width * 0.05, right: width * 0.05),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      'Придумайте пароль, контрольный вопрос и ответ на него для получения и восстановления доступа к личному кабинету',
                      style: GoogleFonts.inter().copyWith(
                        fontSize: 14,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: height * 0.04),
                const PasswordInput(),
                SizedBox(height: height * 0.02),
                const ConfirmPasswordInput(),
                SizedBox(height: height * 0.02),
                const QuestionInput(),
                SizedBox(height: height * 0.02),
                const AnswerInput(),
                SizedBox(height: height * 0.04),
                const CheckBox(),
                SizedBox(height: height * 0.04),
                _RegisterButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RegisterButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<RegisterCubit, RegisterState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : ElevatedButton(
                key: const Key(' RegisterForm_continue_raisedButton'),
                style: ElevatedButton.styleFrom(
                  fixedSize: Size(width * 0.7, height * 0.06),
                  backgroundColor: state.isValid && state.check
                      ? ColorName.primary
                      : Colors.grey,
                  splashFactory: state.isValid && state.check
                      ? InkRipple.splashFactory
                      : NoSplash.splashFactory,
                ),
                onPressed: state.isValid && state.check
                    ? () =>
                        context.read<RegisterCubit>().registerFormSubmitted()
                    : () {},
                child: Text(
                  'Зарегистрироваться',
                  style: GoogleFonts.inter()
                      .copyWith(color: Colors.white, fontSize: 16),
                ),
              );
      },
    );
  }
}
