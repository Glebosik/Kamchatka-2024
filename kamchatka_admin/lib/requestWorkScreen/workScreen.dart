import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:uni_table/requestWorkScreen/informationBlock.dart';
import 'package:uni_table/requestWorkScreen/singlePersonTable.dart';

class WorkScreenRequest extends StatefulWidget {
  const WorkScreenRequest({
    super.key,
  });

  @override
  State<WorkScreenRequest> createState() => _WorkScreenRequestState();
}

class _WorkScreenRequestState extends State<WorkScreenRequest> {
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
              number: number,
              status: status,
              date: date,
              park: park,
              refreshMainScreen: refresh),
          InformationBlock(
            dateInfo: date[selectedIndex],
            numberInfo: number[selectedIndex],
            typeInfo: type[selectedIndex],
            emailInfo: email[selectedIndex],
            phoneInfo: phone[selectedIndex],
            statusInfo: status[selectedIndex],
            parkInfo: park[selectedIndex],
            fnameInfo: fname[selectedIndex],
            inameInfo: iname[selectedIndex],
            onameInfo: oname[selectedIndex],
            sexInfo: sex[selectedIndex],
            bdateInfo: bdate[selectedIndex],
            regionInfo: region[selectedIndex],
            passInfo: pass[selectedIndex],
            grajdInfo: grajd[selectedIndex],
            formatInfo: format[selectedIndex],
            targetInfo: target[selectedIndex],
            photoInfo: photo[selectedIndex],
            maxInfo: max[selectedIndex],
            nowInfo: now[selectedIndex],
            requestloadInfo: requestload[selectedIndex],
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

List<String> type = [
  'Индивидуальное',
  'Групповое',
  'Индивидуальное',
  'Индивидуальное',
  'Групповое',
  'Групповое'
];
List<String> status = [
  'на рассмотрении',
  'отказано',
  'разрешено',
  'разрешено',
  'разрешено',
];
List<String> iname = ['Иван', 'Никита', 'Степан', 'Максим', 'Алексей'];

List<String> oname = [
  'Сергеевич',
  'Алексеевич',
  'Анатольевич',
  'Иванович',
  'Сергеевич'
];
List<String> fname = ['Ванифатьев', 'Черный', 'Кирюхин', 'Зачтольный', 'Чума'];

List<String> park = [
  'Южно-камчатский',
  'Налычево',
  'Ключевской',
  'Быстринский',
  'Вилюченский'
];
List<String> bdate = [
  '21.02.1991',
  '26.04.1993',
  '28.05.1994',
  '30.06.1998',
  '01.08.1984',
];
List<String> sex = [
  'мужской',
  'мужской',
  'мужской',
  'мужской',
  'мужской',
];

List<String> grajd = [
  'Российсая Федерация',
  'Российсая Федерация',
  'Российсая Федерация',
  'Российсая Федерация',
  'Российсая Федерация',
];
List<String> format = [
  'один день',
  'один день',
  'один день',
  'один день',
  'один день',
];
List<String> target = [
  'изучение',
  'обучение',
  'изучение',
  'обучение',
  'изучение',
];

List<String> photo = ['нет', 'нет', 'фотосъемка', 'фотосъемка', 'видеосъемка'];
List<String> max = ['84', '55', '52', '28', '36'];

List<String> now = ['50', '33', '25', '10', '21'];

List<String> requestload = ['1', '2', '1', '3', '5'];

List<String> phone = [
  '+79999999999',
  '+79999999999',
  '+79999999999',
  '+79999999999',
  '+79999999999'
];
List<String> region = [
  'Российсая Федерация',
  'Российсая Федерация',
  'Российсая Федерация',
  'Российсая Федерация',
  'Российсая Федерация',
];

List<String> date = [
  '16.06.2024',
  '17.06.2024',
  '18.06.2024',
  '19.06.2024',
  '20.06.2024'
];
List<String> pass = [
  '99999999',
  '99999999',
  '99999999',
  '99999999',
  '99999999',
];

List<String> email = [
  'userwantreport@mail.ru',
  'userwantreport@mail.ru',
  'userwantreport@mail.ru',
  'userwantreport@mail.ru',
  'userwantreport@mail.ru'
];
