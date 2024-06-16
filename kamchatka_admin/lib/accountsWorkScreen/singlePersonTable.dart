import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:uni_table/accountsWorkScreen/tableColumns.dart';
import 'package:uni_table/accountsWorkScreen/tableRows.dart';

class SinglePersonTable extends StatefulWidget {
  const SinglePersonTable(
      {super.key,
      required this.number,
      required this.login,
      required this.password,
      required this.owner,
      required this.refreshMainScreen});

  final List<String> number;
  final List<String> login;
  final List<String> password;
  final List<String> owner;
  final Function(int) refreshMainScreen;

  @override
  State<SinglePersonTable> createState() => _SinglePersonTableState();
}

class _SinglePersonTableState extends State<SinglePersonTable> {
  @override
  void initState() {
    columnsGenerate(3);
    rowsGenerate(widget.number.length - 1, widget.number, widget.login,
        widget.password, widget.owner, refresh);
    super.initState();
  }

  refresh(int index) {
    setState(() {
      print('Table $index');
      widget.refreshMainScreen(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        height: MediaQuery.of(context).size.height * 0.75,
        width: MediaQuery.of(context).size.width * 0.45,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.all(Radius.circular(10)),
          boxShadow: [
            BoxShadow(
              color: Color(0x3F000000),
              blurRadius: 4,
              offset: Offset(0, 0),
              spreadRadius: 1,
            )
          ],
        ),
        child: Theme(
          data: ThemeData(
              hoverColor: Colors.grey,
              iconTheme: const IconThemeData(color: Colors.white),
              scrollbarTheme: ScrollbarThemeData(
                  thickness: WidgetStateProperty.all(1),
                  thumbColor: WidgetStateProperty.all<Color>(Colors.white))),
          child: DataTable2(
              headingRowDecoration: const BoxDecoration(
                  border: Border(bottom: BorderSide(color: Colors.black)),
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10))),
              isHorizontalScrollBarVisible: false,
              isVerticalScrollBarVisible: false,
              fixedTopRows: 1,
              showBottomBorder: true,
              headingRowColor:
                  WidgetStateColor.resolveWith((states) => Colors.white),
              headingTextStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.w500),
              dataTextStyle: const TextStyle(
                  color: Colors.black, fontWeight: FontWeight.normal),
              border: const TableBorder(
                  verticalInside: BorderSide(
                      width: 1, color: Color.fromRGBO(151, 151, 151, 0.5)),
                  horizontalInside: BorderSide(
                      width: 1, color: Color.fromRGBO(151, 151, 151, 0.5))),
              smRatio: 0.6,
              lmRatio: 1.3,
              columnSpacing: 0,
              horizontalMargin: 0,
              columns: tableColumns,
              rows: tableRows),
        ));
  }
}
