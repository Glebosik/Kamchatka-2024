import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamchatka/src/auth/register/cubit/register_cubit.dart';

class SecondNameInput extends StatelessWidget {
  const SecondNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) =>
          previous.password != current.password ||
          previous.confirmedPassword != current.confirmedPassword,
      builder: (context, state) {
        return TextField(
          key: const Key(' RegisterForm_secondNameInput_textField'),
          onChanged: (secondName) =>
              context.read<RegisterCubit>().secondNameChanged(secondName),
          decoration: InputDecoration(
            labelText: 'Фамилия',
            contentPadding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.02, width * 0.05, height * 0.02),
          ),
        );
      },
    );
  }
}
