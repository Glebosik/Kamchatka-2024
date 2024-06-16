import 'package:data_table_2/data_table_2.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

List<DataColumn2> tableColumns = [];

void columnsGenerate(index) {
  tableColumns = [];
  tableColumns.add(DataColumn2(label: headerCell('№ п/п'), size: ColumnSize.S));
  tableColumns.add(DataColumn2(label: headerCell('Логин'), size: ColumnSize.M));
  tableColumns
      .add(DataColumn2(label: headerCell('Пароль'), size: ColumnSize.M));
  tableColumns
      .add(DataColumn2(label: headerCell('Владелец'), size: ColumnSize.L));
}

Widget headerCell(inCell) {
  return Padding(
      padding: EdgeInsets.all(0),
      child: Center(
          child: Text(
        inCell,
        textAlign: TextAlign.center,
        style: headerTextStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )));
}

TextStyle headerTextStyle = GoogleFonts.roboto(
  color: Colors.black,
  fontSize: 18,
  fontWeight: FontWeight.w400,
  letterSpacing: 0.40,
);
