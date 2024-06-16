import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_animated_button/flutter_animated_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_table/requestWorkScreen/informationBlock.dart';
import 'package:uni_table/requestWorkScreen/singlePersonTable.dart';

class NavigationButtons extends StatefulWidget {
  const NavigationButtons({
    super.key,
    required this.tabController,
  });

  final TabController tabController;
  @override
  State<NavigationButtons> createState() => _NavigationButtonsState();
}

class _NavigationButtonsState extends State<NavigationButtons> {
  int isSelect = 0;
  @override
  void initState() {
    super.initState();
  }

  refresh() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(width: 260),
        AnimatedButton(
          selectedBackgroundColor: const Color.fromRGBO(231, 255, 240, 1),
          backgroundColor: Color.fromRGBO(254, 254, 254, 1),
          borderRadius: 10,
          isReverse: false,
          isSelected: isSelect == 0 ? true : false,
          width: 210,
          height: 35,
          text: 'Назначение ролей',
          selectedTextColor: Color(0xFF00A551),
          transitionType: TransitionType.LEFT_TO_RIGHT,
          textStyle: GoogleFonts.roboto(
            color: Color(0xFF00A551),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.40,
          ),
          onPress: () {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => widget.tabController.index = 0);
            isSelect = 0;
            refresh();
          },
        ),
        const SizedBox(width: 10),
        AnimatedButton(
          selectedBackgroundColor: const Color.fromRGBO(231, 255, 240, 1),
          backgroundColor: Color.fromRGBO(254, 254, 254, 1),
          borderRadius: 10,
          isReverse: false,
          isSelected: isSelect == 1 ? true : false,
          width: 80,
          height: 35,
          text: 'Парки',
          selectedTextColor: Color(0xFF00A551),
          transitionType: TransitionType.LEFT_TO_RIGHT,
          textStyle: GoogleFonts.roboto(
            color: Color(0xFF00A551),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.40,
          ),
          onPress: () {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => widget.tabController.index = 1);
            isSelect = 1;
            refresh();
          },
        ),
        const SizedBox(width: 10),
        AnimatedButton(
          selectedBackgroundColor: const Color.fromRGBO(231, 255, 240, 1),
          backgroundColor: Color.fromRGBO(254, 254, 254, 1),
          borderRadius: 10,
          isReverse: false,
          isSelected: isSelect == 2 ? true : false,
          width: 120,
          height: 35,
          text: 'Проблемы',
          selectedTextColor: Color(0xFF00A551),
          transitionType: TransitionType.LEFT_TO_RIGHT,
          textStyle: GoogleFonts.roboto(
            color: Color(0xFF00A551),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.40,
          ),
          onPress: () {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => widget.tabController.index = 2);
            isSelect = 2;
            refresh();
          },
        ),
        const SizedBox(width: 10),
        AnimatedButton(
          selectedBackgroundColor: const Color.fromRGBO(231, 255, 240, 1),
          backgroundColor: Color.fromRGBO(254, 254, 254, 1),
          borderRadius: 10,
          isReverse: false,
          isSelected: isSelect == 3 ? true : false,
          width: 140,
          height: 35,
          text: 'Разрешения',
          selectedTextColor: Color(0xFF00A551),
          transitionType: TransitionType.LEFT_TO_RIGHT,
          textStyle: GoogleFonts.roboto(
            color: Color(0xFF00A551),
            fontSize: 20,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.40,
          ),
          onPress: () {
            WidgetsBinding.instance
                .addPostFrameCallback((_) => widget.tabController.index = 3);
            isSelect = 3;
            refresh();
          },
        ),
        const SizedBox(width: 20),
      ],
    ));
  }
}
