import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/auth/register/cubit/register_cubit.dart';

class CheckBox extends StatefulWidget {
  const CheckBox({super.key});

  @override
  State<CheckBox> createState() => CheckBoxState();
}

class CheckBoxState extends State<CheckBox> {
  bool check = false;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      children: [
        Checkbox(
          activeColor: ColorName.primary,
          value: check,
          onChanged: (bool? value) {
            setState(() {
              check = value!;
            });
            context.read<RegisterCubit>().checkBoxChanged(value!);
          },
        ),
        SizedBox(
          width: width * 0.75,
          child: RichText(
            text: TextSpan(
              style: DefaultTextStyle.of(context).style,
              children: [
                const TextSpan(text: 'Я принимаю условия '),
                TextSpan(
                  text: 'пользовательского соглашения',
                  style: GoogleFonts.inter().copyWith(
                      color: ColorName.secondary.withBlue(150).withRed(150)),
                  recognizer: TapGestureRecognizer()..onTap = () {},
                ),
              ],
            ),
          ),
        )
      ],
    );
  }
}
