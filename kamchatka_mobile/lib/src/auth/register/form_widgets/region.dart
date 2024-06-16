import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamchatka/src/auth/register/cubit/register_cubit.dart';
import 'package:kamchatka/src/constants.dart';

class RegionInput extends StatefulWidget {
  const RegionInput({super.key});

  @override
  State<RegionInput> createState() => RegionInputState();
}

class RegionInputState extends State<RegionInput> {
  String value = regions.first;

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
              'Регион проживания',
              style: GoogleFonts.inter().copyWith(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
        DropdownButton(
          isExpanded: true,
          value: value,
          style: Theme.of(context)
              .textTheme
              .bodyMedium!
              .copyWith(color: Colors.black, fontSize: 16),
          items: regions
              .map((e) => DropdownMenuItem(
                    value: e,
                    child: Text(e),
                  ))
              .toList(),
          onChanged: (item) {
            context.read<RegisterCubit>().regionChanged(item ?? value);
            setState(() {
              value = item ?? value;
            });
          },
        ),
      ],
    );
  }
}
