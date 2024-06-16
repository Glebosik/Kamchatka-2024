import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:uni_table/problemWorkScreen/informationBlock.dart';
import 'package:uni_table/problemWorkScreen/singlePersonTable.dart';

class WorkScreenProblem extends StatefulWidget {
  const WorkScreenProblem({
    super.key,
  });

  @override
  State<WorkScreenProblem> createState() => _WorkScreenProblemState();
}

class _WorkScreenProblemState extends State<WorkScreenProblem> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
  }

  refresh(int index) {
    setState(() {
      selectedIndex = index;
      print('Main $index');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 80, right: 80),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SinglePersonTable(
              headers: headers[0],
              number: number,
              status: status,
              category: category,
              about: about,
              refreshMainScreen: refresh),
          InformationBlock(
            numberInfo: number[selectedIndex],
            emailInfo: email[selectedIndex],
            phoneInfo: phone[selectedIndex],
            statusInfo: status[selectedIndex],
            categoryInfo: category[selectedIndex],
            locationInfo: location[selectedIndex],
            aboutInfo: about[selectedIndex],
            dateInfo: date[selectedIndex],
          )
        ],
      ),
    );
  }
}

List<String> number = [
  '217444',
  '217443',
  '217442',
  '217441',
  '217440',
  '217439'
];
List<String> status = [
  'на рассмотрении',
  'выясняется',
  'в процессе',
  'решена',
  'решена',
];
List<String> category = [
  'незаконное размещение мусорной свалки',
  'незаконное размещение мусорной свалки',
  'незаконное размещение мусорной свалки',
  'незаконное размещение мусорной свалки',
  'незаконное размещение мусорной свалки'
];
List<String> phone = [
  '+79999999999',
  '+79999999999',
  '+79999999999',
  '+79999999999',
  '+79999999999'
];
List<String> location = [
  '55.29000966967503, 159.8050888595109',
  '55.29000966967503, 159.8050888595109',
  '55.29000966967503, 159.8050888595109',
  '55.29000966967503, 159.8050888595109',
  '55.29000966967503, 159.8050888595109'
];
List<String> date = [
  '16.06.2024',
  '17.06.2024',
  '18.06.2024',
  '19.06.2024',
  '20.06.2024'
];
List<String> about = [
  'Нашел свалку недалеко от маршрута, не думаю, что она законная. Ориентиры: ручей, скопление деревьев.',
  'Нашел свалку недалеко от маршрута, не думаю, что она законная. Ориентиры: ручей, скопление деревьев.',
  'Нашел свалку недалеко от маршрута, не думаю, что она законная. Ориентиры: ручей, скопление деревьев.',
  'Нашел свалку недалеко от маршрута, не думаю, что она законная. Ориентиры: ручей, скопление деревьев.',
  'Нашел свалку недалеко от маршрута, не думаю, что она законная. Ориентиры: ручей, скопление деревьев.'
];

List<String> email = [
  'userwantreport@mail.ru',
  'userwantreport@mail.ru',
  'userwantreport@mail.ru',
  'userwantreport@mail.ru',
  'userwantreport@mail.ru'
];

List<List<String>> headers = [
  ['№ п/п', 'статус', 'категория', 'описание'],
];
