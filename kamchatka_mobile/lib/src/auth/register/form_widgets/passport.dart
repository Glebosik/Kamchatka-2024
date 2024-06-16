import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamchatka/src/auth/register/cubit/register_cubit.dart';

class PassportInput extends StatelessWidget {
  const PassportInput({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return BlocBuilder<RegisterCubit, RegisterState>(
      buildWhen: (previous, current) => previous.passport != current.passport,
      builder: (context, state) {
        return TextField(
          key: const Key(' RegisterForm_PassportInput_textField'),
          maxLength: 10,
          keyboardType: TextInputType.number,
          onChanged: (passport) {
            context.read<RegisterCubit>().passportChanged(passport);
          },
          decoration: InputDecoration(
            labelText: 'Серия и номер паспорта (без пробела)',
            errorText: state.passport.displayError != null
                ? 'Некорректный формат серии и номера паспорта'
                : null,
            contentPadding: EdgeInsets.fromLTRB(
                width * 0.05, height * 0.02, width * 0.05, height * 0.02),
          ),
        );
      },
    );
  }
}
