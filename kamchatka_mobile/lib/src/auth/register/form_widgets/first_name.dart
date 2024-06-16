import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamchatka/src/auth/register/cubit/register_cubit.dart';

class FirstNameInput extends StatelessWidget {
  const FirstNameInput({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.firstName != current.firstName,
      builder: (context, state) {
        return TextField(
          key: const Key(' RegisterForm_firstNameInput_textField'),
          onChanged: (firstName) =>
              context.read<RegisterCubit>().firstNameChanged(firstName),
          decoration: InputDecoration(
            labelText: 'Имя',
            contentPadding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.02, width * 0.05, height * 0.02),
          ),
        );
      },
    );
  }
}
