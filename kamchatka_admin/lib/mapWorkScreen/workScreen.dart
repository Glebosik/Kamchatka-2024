import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uni_table/blocs/oopt/oopt_bloc.dart';
import 'package:uni_table/mapWorkScreen/informationBlock.dart';
import 'package:uni_table/mapWorkScreen/singlePersonTable.dart';

class WorkScreenMap extends StatefulWidget {
  const WorkScreenMap({
    super.key,
  });

  @override
  State<WorkScreenMap> createState() => _WorkScreenMapState();
}

class _WorkScreenMapState extends State<WorkScreenMap> {
  int selectedIndex = 0;
  int selectedPark = 0;
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
    return BlocBuilder<OoptBloc, OoptState>(
      builder: (context, state) {
        switch (state) {
          case OoptsLoaded():
            return Padding(
              padding: EdgeInsets.only(left: 80, right: 80),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SinglePersonTable(
                    refreshMainScreen: refresh,
                    oopts: state.oopts,
                  ),
                  InformationBlock(
                    parkNamesInfo: parkNames,
                    maxLoadInfo: maxLoad,
                    nowLoadInfo: nowLoad,
                    numberPeopleInfo: numberPeople,
                    numberProblemInfo: numberProblem,
                    numberRequestInfo: numberRequest,
                    aboutInfo: about,
                    selectedPark: selectedPark,
                  )
                ],
              ),
            );
          case OoptInitial():
          case OoptsLoading():
            return Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}

List<String> parkNames = [
  'Южно-камчатский парк',
  'Налычево',
  'Ключевской парк',
  'Быстринский парк',
  'Вилючинский парк'
];

List<String> maxLoad = ['41', '52', '44', '25', '67'];
List<String> nowLoad = ['33', '50', '31', '19', '47'];
List<String> numberPeople = ['33', '50', '31', '19', '47'];
List<String> numberProblem = ['0', '0', '2', '0', '3'];
List<String> numberRequest = ['14', '22', '8', '10', '25'];
List<String> about = [
  'Парк работает в обычном режиме.',
  'Парк работает в обычном режиме.',
  'Парк работает в обычном режиме.',
  'Парк работает в обычном режиме.',
  'Парк работает в обычном режиме.'
];
