import 'package:flutter/material.dart';
import 'package:data_table_2/data_table_2.dart';
import 'package:google_fonts/google_fonts.dart';

List<DataRow2> tableRows = [];

void rowsGenerate(
    lenghtPerson, list1, list2, list3, list4, Function(int) refresh) {
  tableRows = [];
  for (int i = 0; i < lenghtPerson; i++) {
    rowGenerate(i, list1, list2, list3, list4);
    tableRows.add(DataRow2(
        onTap: () {
          rowsGenerate(lenghtPerson, list1, list2, list3, list4, refresh);
          tableRows[i] = selectRow(i, refresh, list2[i]);
          print(i);
          refresh(i);
        },
        cells: tableRow,
        decoration: rowDecoration(list2[i])));
    tableRow = [];
  }
}

void rowGenerate(i, list1, list2, list3, list4) {
  tableRow.add(DataCell(cell(list1[i])));
  tableRow.add(DataCell(cell(list2[i])));
  tableRow.add(DataCell(cell(list3[i])));
  tableRow.add(DataCell(cell(list4[i])));
}

List<DataCell> tableRow = [];

Widget cell(inCell) {
  return Padding(
      padding: EdgeInsets.all(5),
      child: Center(
          child: Text(
        inCell,
        textAlign: TextAlign.center,
        style: rowTextStyle,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      )));
}

TextStyle rowTextStyle = GoogleFonts.roboto(
  color: Colors.black,
  fontSize: 16,
  fontWeight: FontWeight.w300,
  letterSpacing: 0.40,
);

BoxDecoration rowDecoration(value) {
  if (value == 'на рассмотрении' || value == 'отказано') {
    return BoxDecoration(color: Color.fromRGBO(242, 182, 0, 0.7));
  } else if (value == 'на обработке' || value == 'выясняется')
    return BoxDecoration(color: Color.fromRGBO(255, 239, 191, 0.8));
  else if (value == 'в процессе')
    return BoxDecoration(color: Color.fromRGBO(178, 253, 207, 0.8));
  else if (value == 'решена' || value == 'разрешено')
    return BoxDecoration(color: Color.fromRGBO(13, 182, 94, 0.8));
  else
    return BoxDecoration(color: Colors.white);
}

DataRow2 selectRow(i, refresh, selectValue) {
  DataRow2 row = DataRow2(
      onTap: () {
        tableRows[i] = selectRow(i, refresh, selectValue);
        print(tableRows[i].cells[2].child);
        refresh();
      },
      cells: tableRows[i].cells,
      decoration: rowDecorationOnSelect(rowDecoration(selectValue)));
  return row;
}

BoxDecoration rowDecorationOnSelect(BoxDecoration decoration) {
  return decoration.copyWith(
      border: Border.all(color: Colors.black, width: 1.5));
}
