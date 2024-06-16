import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:group_button/group_button.dart';

class ButtonBuilder extends StatefulWidget {
  ButtonBuilder({Key? key}) : super(key: key);

  @override
  State<ButtonBuilder> createState() => _ButtonBuilderState();
}

class _ButtonBuilderState extends State<ButtonBuilder> {
  late GroupButtonController _checkboxesController;
  late GroupButtonController _checkboxesControllerSecond;

  final _checkboxButtons = [
    '',
    'Маршруты',
    'Нагрузка',
  ];

  final _checkboxButtonsSecond = [
    'Все объекты',
    'Парки',
    'Проблемы',
  ];

  @override
  void initState() {
    _checkboxesController = GroupButtonController(
      selectedIndexes: [],
      disabledIndexes: [],
    );
    _checkboxesControllerSecond = GroupButtonController(
      selectedIndexes: [],
      disabledIndexes: [],
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 450,
          child: GroupButton(
            controller: _checkboxesControllerSecond,
            isRadio: false,
            options: GroupButtonOptions(
              groupingType: GroupingType.row,
              spacing: 0,
              runSpacing: 0,
            ),
            buttons: _checkboxButtonsSecond,
            buttonIndexedBuilder: (selected, index, context) {
              return CheckBoxTile(
                title: _checkboxButtonsSecond[index],
                selected: selected,
                onTap: () {
                  if (!selected) {
                    _checkboxesControllerSecond.selectIndex(index);
                    return;
                  }
                  _checkboxesControllerSecond.unselectIndex(index);
                },
              );
            },
            onSelected: (val, i, selected) =>
                debugPrint('Button: $val index: $i $selected'),
          ),
        ),
        Container(
            width: 450,
            child: GroupButton(
              controller: _checkboxesController,
              isRadio: false,
              options: GroupButtonOptions(
                groupingType: GroupingType.row,
                spacing: 5,
                runSpacing: 5,
              ),
              buttons: _checkboxButtons,
              buttonIndexedBuilder: (selected, index, context) {
                return CheckBoxTile(
                  title: _checkboxButtons[index],
                  selected: selected,
                  onTap: () {
                    if (!selected) {
                      _checkboxesController.selectIndex(index);
                      return;
                    }
                    _checkboxesController.unselectIndex(index);
                  },
                );
              },
              onSelected: (val, i, selected) =>
                  debugPrint('Button: $val index: $i $selected'),
            ))
      ],
    );
  }
}

class CheckBoxTile extends StatelessWidget {
  const CheckBoxTile({
    Key? key,
    required this.selected,
    required this.onTap,
    required this.title,
  }) : super(key: key);

  final String title;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
        height: 25,
        width: 150,
        child: ListTile(
          contentPadding: EdgeInsets.all(0),
          horizontalTitleGap: 5,
          title: Text(
            title,
            style: GoogleFonts.roboto(
              color: Colors.black,
              fontSize: 16,
              fontWeight: FontWeight.w300,
              letterSpacing: 0.40,
            ),
          ),
          onTap: onTap,
          leading: title != ''
              ? Checkbox(
                  checkColor: Color(0xFF00A551),
                  side: BorderSide(width: 1, color: Color(0xFF00A551)),
                  fillColor: WidgetStateProperty.all(Color(0xFFE7FFF0)),
                  splashRadius: 1,
                  value: selected,
                  onChanged: (val) {
                    onTap();
                  },
                )
              : null,
        ));
  }
}
