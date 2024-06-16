import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/auth/register/cubit/register_cubit.dart';

class GenderInput extends StatefulWidget {
  const GenderInput({super.key});

  @override
  State<GenderInput> createState() => GenderInputState();
}

class GenderInputState extends State<GenderInput> {
  String? gender;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: width * 0.05),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Пол',
              style: GoogleFonts.inter().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Radio<String>(
                  value: 'Мужчина',
                  groupValue: gender,
                  onChanged: (value) {
                    context.read<RegisterCubit>().genderChanged('m');
                    setState(
                      () {
                        gender = value;
                      },
                    );
                  },
                ),
                Text(
                  'Мужчина',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: gender != 'Мужчина'
                          ? Colors.black
                          : ColorName.primary),
                ),
              ],
            ),
            Row(
              children: [
                Radio<String>(
                  value: 'Женщина',
                  groupValue: gender,
                  onChanged: (value) {
                    context.read<RegisterCubit>().genderChanged('f');
                    setState(
                      () {
                        gender = value;
                      },
                    );
                  },
                ),
                Text(
                  'Женщина',
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color: gender != 'Женщина'
                          ? Colors.black
                          : ColorName.primary),
                )
              ],
            ),
          ],
        ),
      ],
    );
  }
}
