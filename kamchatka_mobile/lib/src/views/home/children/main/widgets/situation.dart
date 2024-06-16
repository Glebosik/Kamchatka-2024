import 'package:flutter/material.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/views/home/children/main/widgets/my_radio_tile.dart';

enum SingingCharacter { air, radiation }

class SituationWidget extends StatefulWidget {
  const SituationWidget({super.key});

  @override
  State<SituationWidget> createState() => _SituationWidgetState();
}

class _SituationWidgetState extends State<SituationWidget> {
  SingingCharacter? _character = SingingCharacter.air;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: width * 0.40,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Stack(
                  alignment: Alignment.centerLeft,
                  children: [
                    Assets.images.bgEllipse.svg(height: 32),
                    Padding(
                      padding: const EdgeInsets.only(left: 16),
                      child: Text(
                        'Обстановка',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: Colors.black, fontSize: 20),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                radioTile(context,
                    width: width,
                    value: SingingCharacter.air,
                    text: 'Атмосферный воздух'),
                const SizedBox(height: 16),
                radioTile(
                  context,
                  width: width,
                  value: SingingCharacter.radiation,
                  text: 'Радиационный фон',
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Color(0x0C000000),
                  blurRadius: 4,
                  offset: Offset(0, 1),
                  spreadRadius: 1,
                )
              ],
            ),
            child: SizedBox(
                width: width * 0.5,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      children: _character == SingingCharacter.air
                          ? [
                              genRow(context, 'Взвешенные вещества', '< 1'),
                              genRow(context, 'Диоксид азота', '< 1'),
                              genRow(context, 'Диоксид серы', '< 1'),
                              genRow(context, 'Формальдегид', '< 1'),
                              genRow(context, 'Оксид углерода', '< 1'),
                            ]
                          : [
                              genRow(context, 'Петропаловск-Камчатский', '< 1'),
                              genRow(
                                context,
                                'п. Пионерский',
                                '1.2',
                                cardBackground: const Color(0xFFFFEFBF),
                                cardText: const Color(0xFFF2B600),
                              ),
                              genRow(
                                context,
                                'с. Начики',
                                'Н/д',
                                cardBackground: const Color(0xFFD0D0D0),
                                cardText: const Color(0xFFA2A2A2),
                              ),
                              genRow(context, 'Елизово', '< 1'),
                              genRow(context, 'с. Сосновка', '< 1'),
                            ],
                    ),
                  ),
                )),
          )
        ],
      ),
    );
  }

  Container radioTile(BuildContext context,
      {required width, required SingingCharacter value, required String text}) {
    return Container(
      width: _character == value ? width * 0.40 : width * 0.35,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: ColorName.primary),
      ),
      child: MyRadioListTile<SingingCharacter>(
        contentPadding: EdgeInsets.zero,
        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        visualDensity: const VisualDensity(
            vertical: VisualDensity.minimumDensity,
            horizontal: VisualDensity.minimumDensity),
        dense: true,
        title: Center(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(child: Assets.images.dot.svg(height: 20)),
              Expanded(
                child: Text(
                  text,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(color: Colors.black, fontSize: 14),
                ),
              ),
            ],
          ),
        ),
        selectedTileColor: ColorName.cardBackground,
        value: value,
        groupValue: _character,
        selected: _character == value,
        onChanged: (SingingCharacter? value) {
          setState(() {
            _character = value;
          });
        },
      ),
    );
  }

  Row genRow(
    BuildContext context,
    String text,
    String value, {
    Color? cardBackground = ColorName.cardBackground,
    Color? cardText = ColorName.primary,
  }) {
    final width = MediaQuery.of(context).size.width;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        SizedBox(
          width: width * 0.3,
          child: Text(
            text,
            style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: 12,
                  color: Colors.black,
                ),
          ),
        ),
        SizedBox(
          width: 35,
          height: 25,
          child: Card(
            elevation: 0,
            color: cardBackground,
            child: Center(
              child: Text(value,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: cardText)),
            ),
          ),
        ),
      ],
    );
  }
}
