import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:formz/formz.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/auth/login/cubit/login_cubit.dart';
import 'package:kamchatka/src/auth/register/register_view.dart';
import 'package:kamchatka/src/views/bloc/home_navigation_bloc.dart';
import 'package:kamchatka/src/views/home/view/home_view.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  static Page<void> page() => const MaterialPage<void>(child: LoginPage());

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Авторизация'),
      ),
      body: BlocListener<LoginCubit, LoginState>(
        listenWhen: (previous, current) =>
            !(previous.status.isFailure && current.status.isFailure),
        listener: (context, state) {
          if (state.status.isFailure) {
            ScaffoldMessenger.of(context)
              ..hideCurrentSnackBar()
              ..showSnackBar(
                const SnackBar(
                  content: Text('Ошибка авторизации'),
                ),
              );
          } else if (state.status.isSuccess) {
            context.read<HomeNavigationBloc>().add(const PageTapped(0));
            Navigator.of(context).pushAndRemoveUntil(
              MaterialPageRoute(builder: (context) => const HomeView()),
              (Route<dynamic> route) => false,
            );
          }
        },
        child: SafeArea(
          child: Center(
            child: Column(
              children: [
                const Spacer(),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Экотропы',
                            style: Theme.of(context).textTheme.headlineMedium),
                        Text(
                          'Камчатского края',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(fontSize: 26),
                        ),
                      ],
                    ),
                    Assets.auth.ski.svg(),
                  ],
                ),
                const Spacer(),
                Card(
                  margin: EdgeInsets.all(width * 0.08),
                  color: ColorName.cardBackground,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Center(
                          child:
                              Assets.auth.background.svg(height: height * 0.4)),
                      Column(
                        children: [
                          SizedBox(height: height * 0.05),
                          _EmailInput(),
                          SizedBox(height: height * 0.02),
                          _PasswordInput(),
                          SizedBox(height: height * 0.08),
                          const Padding(
                            padding: EdgeInsets.only(left: 32, right: 32),
                            child: _LoginButton(),
                          ),
                          SizedBox(height: height * 0.02),
                          const Padding(
                            padding: EdgeInsets.only(left: 32, right: 32),
                            child: _ForgotPasswordButton(),
                          ),
                          SizedBox(height: height * 0.02),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: height * 0.02),
                const _SignUpButton(),
                const Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SignUpButton extends StatelessWidget {
  const _SignUpButton();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: () => Navigator.of(context).push(
        MaterialPageRoute(builder: (context) => const RegisterPage()),
      ),
      style: TextButton.styleFrom(fixedSize: Size(width * 0.9, height * 0.05)),
      child: const Text('Зарегистрироваться'),
    );
  }
}

class _EmailInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(100)),
      height: height * 0.07,
      width: width * 0.75,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<LoginCubit, LoginState>(
          buildWhen: (previous, current) => previous.email != current.email,
          builder: (context, state) {
            return TextField(
              key: const Key('loginForm_emailInput_textField'),
              onChanged: (email) =>
                  context.read<LoginCubit>().emailChanged(email),
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                isDense: true,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(
                    width * 0.05, height * 0.02, width * 0.05, height * 0.02),
                labelText: 'Email',
              ),
            );
          },
        ),
      ),
    );
  }
}

class _PasswordInput extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
          color: Colors.white, borderRadius: BorderRadius.circular(100)),
      height: height * 0.07,
      width: width * 0.75,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocBuilder<LoginCubit, LoginState>(
          buildWhen: ((previous, current) =>
              previous.password != current.password),
          builder: (context, state) {
            return TextField(
              key: const Key('loginForm_passwordInput_textField'),
              onChanged: (password) =>
                  context.read<LoginCubit>().passwordChanged(password),
              obscureText: true,
              decoration: InputDecoration(
                isDense: true,
                floatingLabelAlignment: FloatingLabelAlignment.start,
                floatingLabelBehavior: FloatingLabelBehavior.never,
                border: InputBorder.none,
                contentPadding: EdgeInsets.fromLTRB(
                    width * 0.05, height * 0.02, width * 0.05, height * 0.02),
                labelText: 'Пароль',
              ),
            );
          },
        ),
      ),
    );
  }
}

class _LoginButton extends StatelessWidget {
  const _LoginButton();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return BlocBuilder<LoginCubit, LoginState>(
      builder: (context, state) {
        return state.status.isInProgress
            ? const CircularProgressIndicator()
            : OutlinedButton(
                key: const Key('loginForm_continue_raisedButton'),
                style: TextButton.styleFrom(
                    fixedSize: Size(width * 0.7, height * 0.05)),
                onPressed: () =>
                    context.read<LoginCubit>().logInWithCredentials(),
                child: const Text(
                  'Войти',
                ),
              );
      },
    );
  }
}

class _ForgotPasswordButton extends StatelessWidget {
  const _ForgotPasswordButton();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return TextButton(
      onPressed: () {},
      style: TextButton.styleFrom(fixedSize: Size(width * 0.7, height * 0.05)),
      child: const Text('Не удается войти?'),
    );
  }
}
