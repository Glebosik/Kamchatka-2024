import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamchatka/src/auth/register/cubit/register_cubit.dart';
import 'package:kamchatka/src/constants.dart';

class CitizenshipInput extends StatefulWidget {
  const CitizenshipInput({super.key});

  @override
  State<CitizenshipInput> createState() => CitizenshipInputState();
}

class CitizenshipInputState extends State<CitizenshipInput> {
  String value = citinezships.first;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: width * 0.05),
          child: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              'Гражданство',
              style: GoogleFonts.inter().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DropdownButton(
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black, fontSize: 16),
          isExpanded: true,
          value: value,
          items: citinezships
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (item) {
            context.read<RegisterCubit>().citizenshipChanged(item ?? value);
            setState(() {
              value = item ?? value;
            });
          },
        ),
      ],
    );
  }
}
