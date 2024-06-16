import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/views/home/children/check_in/bloc/check_in_bloc.dart';
import 'package:kamchatka/src/views/home/children/check_in/check_in_view.dart';

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
                boxShadow: const [
                  BoxShadow(
                    color: Color(0x0C000000),
                    blurRadius: 4,
                    offset: Offset(0, 1),
                    spreadRadius: 1,
                  )
                ],
                gradient: LinearGradient(
                  stops: const [0, 0.4, 0.7, 1],
                  colors: [
                    Colors.white,
                    ColorName.cardBackground.withOpacity(.5),
                    ColorName.cardBackground.withOpacity(.7),
                    ColorName.cardBackground,
                  ],
                ),
                borderRadius: const BorderRadius.all(Radius.circular(12))),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent),
              onPressed: () {
                context.read<CheckInBloc>().add(CheckInFetchOopt());
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const CheckInView()),
                );
              },
              child: SizedBox(
                width: width * 0.95,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(14, 14, 0, 14),
                  child: Row(children: [
                    Expanded(
                      child: Text(
                        'Составить заявку на посещение',
                        style: Theme.of(context).textTheme.titleMedium!,
                      ),
                    ),
                  ]),
                ),
              ),
            ),
          ),
          Positioned(
              top: -25,
              right: 10,
              child: IgnorePointer(child: Assets.images.arrows.svg())),
        ],
      ),
    );
  }
}
