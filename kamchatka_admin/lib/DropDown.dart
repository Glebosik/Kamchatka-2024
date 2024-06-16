import 'package:flexible_dropdown/flexible_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';

// ignore: must_be_immutable
class DropDown extends StatefulWidget {
  DropDown({
    super.key,
    required this.titleButton,
    required this.parkNames,
    required this.selectItem,
    required this.refresh,
  });
  Function(int) refresh;
  List<String> parkNames;
  String titleButton;
  int selectItem;

  @override
  State<DropDown> createState() => _DropDownState();
}

class _DropDownState extends State<DropDown> {
  @override
  void initState() {
    buttonList(widget.parkNames, refresh, widget.titleButton);
    print(_buttonList.length);
    super.initState();
  }

  refresh(int selectedItem) {
    print(widget.selectItem);
    widget.refresh(selectedItem);
    setState(() {
      Navigator.of(context).pop();
    });
  }

  @override
  Widget build(BuildContext context) {
    return _buildFlexibleDropdown();
  }

  Widget _buildTextBtn(String title) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          style: GoogleFonts.roboto(
            color: Colors.black,
            fontSize: 20,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.40,
          ),
        ),
        Spacer(),
        Icon(
          Icons.keyboard_arrow_down,
          color: Colors.black,
          size: 30,
        ),
        SizedBox(
          width: 20,
        ),
      ],
    );
  }

  Widget _buildFlexibleDropdown() {
    return FlexibleDropdown(
      overlayChild: Container(
          height: MediaQuery.of(context).size.height * 0.62,
          width: MediaQuery.of(context).size.width * 0.4,
          decoration: BoxDecoration(
            color: Color(0xFFE7FFF0),
            borderRadius: BorderRadius.circular(12.0),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 1,
                blurRadius: 4,
              ),
            ],
          ),
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buttonList)),
      barrierColor: Colors.black38.withOpacity(0),
      textDirection: TextDirection.ltr,
      duration: const Duration(milliseconds: 300),
      animationType: AnimationType.scaleY,
      animationAlignment: Alignment.topCenter,
      offset: Offset(0, MediaQuery.of(context).size.height * 0.08),
      child: _buildTextBtn(widget.titleButton),
    );
  }
}

List<Widget> buttonList(List<String> nameList, refresh, String selectedName) {
  print(nameList[0]);
  print('create');
  _buttonList = [];
  for (int i = 0; nameList.length > i; i++) {
    _buttonList.add(Padding(
      padding: EdgeInsets.only(top: 10, left: 20, right: 20),
      child: Container(
          height: 40,
          width: double.infinity,
          child: OutlinedButton(
            style: OutlinedButton.styleFrom(
              overlayColor: Color(0xFF00A551),
              side: BorderSide(width: 1, color: Color(0xFF00A551)),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
            ),
            onPressed: () {
              selectedName = nameList[i];
              refresh(i);
            },
            child: Padding(
              padding: EdgeInsets.all(7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    nameList[i],
                    style: GoogleFonts.roboto(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      letterSpacing: 0.40,
                    ),
                  ),
                ],
              ),
            ),
          )),
    ));
  }
  return _buttonList;
}

List<Widget> _buttonList = [];
