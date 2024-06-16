import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:uni_table/accountsWorkScreen/informationBlock.dart';
import 'package:uni_table/accountsWorkScreen/singlePersonTable.dart';

class WorkScreenAccount extends StatefulWidget {
  const WorkScreenAccount({
    super.key,
  });

  @override
  State<WorkScreenAccount> createState() => _WorkScreenAccountState();
}

class _WorkScreenAccountState extends State<WorkScreenAccount> {
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
              login: login,
              password: password,
              owner: owner,
              refreshMainScreen: refresh),
          InformationBlock(
            numberInfo: number[selectedIndex],
            loginInfo: login[selectedIndex],
            passwordInfo: password[selectedIndex],
            roleInfo: role[selectedIndex],
            ownerInfo: owner[selectedIndex],
          )
        ],
      ),
    );
  }
}

List<String> number = ['01', '02', '03', '04', '05', '06'];
List<String> role = [
  'Администратор',
  'Ответственный (разрешения)',
  'Ответственный (проблемы)',
  'Администратор',
  'Администратор',
];
List<String> login = [
  'administrator01',
  'administrator02',
  'administrator03',
  'administrator04',
  'administrator05'
];
List<String> password = [
  '************',
  '************',
  '************',
  '************',
  '************'
];
List<String> owner = [
  'Иванов Иван Иванович',
  'Сергеенков Сергей Сергеевич',
  'Степанов Степан Степанович',
  'Никитин Никита Никитович',
  'Иванов Иван Иванович'
];
