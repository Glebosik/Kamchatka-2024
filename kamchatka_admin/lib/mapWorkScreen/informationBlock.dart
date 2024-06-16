import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:uni_table/DropDown.dart';

class InformationBlock extends StatefulWidget {
  InformationBlock({
    super.key,
    required this.parkNamesInfo,
    required this.maxLoadInfo,
    required this.nowLoadInfo,
    required this.numberProblemInfo,
    required this.numberRequestInfo,
    required this.numberPeopleInfo,
    required this.aboutInfo,
    required this.selectedPark,
  });
  int selectedPark;
  final List<String> parkNamesInfo;
  final List<String> maxLoadInfo;
  final List<String> nowLoadInfo;
  final List<String> numberProblemInfo;
  final List<String> numberRequestInfo;
  final List<String> numberPeopleInfo;
  final List<String> aboutInfo;

  @override
  State<InformationBlock> createState() => _InformationBlockState();
}

class _InformationBlockState extends State<InformationBlock> {
  @override
  void initState() {
    super.initState();
  }

  refresh(int selectedPark) {
    widget.selectedPark = selectedPark;
    print(widget.selectedPark);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: MediaQuery.of(context).size.height * 0.75,
          width: MediaQuery.of(context).size.width * 0.4,
          child: Column(
            children: [
              Container(
                height: 50,
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
                child: Padding(
                    padding: const EdgeInsets.only(left: 0, right: 0, top: 0),
                    child: DropDown(
                      titleButton: widget.parkNamesInfo[widget.selectedPark],
                      parkNames: widget.parkNamesInfo,
                      selectItem: widget.selectedPark,
                      refresh: refresh,
                    )),
              ),
              Container(
                height: MediaQuery.of(context).size.height * 0.08,
                width: MediaQuery.of(context).size.width * 0.4,
                child: Column(
                  children: [
                    Spacer(),
                    Container(
                      height: 40,
                      width: MediaQuery.of(context).size.width * 0.4,
                      child: Stack(
                        children: <Widget>[
                          Positioned(
                            left: 0,
                            child: Container(
                              width: 39.98,
                              height: 39.04,
                              decoration: const ShapeDecoration(
                                color: Color(0xFFFFEFBF),
                                shape: OvalBorder(),
                              ),
                            ),
                          ),
                          Positioned(
                            left: 22,
                            top: 7,
                            child: Text(
                              'Информация о парке',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                letterSpacing: 0.20,
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    Spacer(),
                  ],
                ),
              ),
              Expanded(
                child: Container(
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
                    child: Stack(
                      children: [
                        Positioned(
                            bottom: 0,
                            child: SvgPicture.asset(
                              'lib/asset/infoBackground.svg',
                              width: MediaQuery.of(context).size.width * 0.4,
                            )),
                        Container(
                            child: Padding(
                                padding: EdgeInsets.only(
                                    top: 20, left: 20, right: 20, bottom: 20),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(children: [
                                      Text(
                                        'Нагрузка',
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.40,
                                        ),
                                      ),
                                      Spacer(),
                                      OutlinedButton(
                                        style: OutlinedButton.styleFrom(
                                          overlayColor: Color(0xFF00A551),
                                          side: BorderSide(
                                              width: 1,
                                              color: Color(0xFF00A551)),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                        ),
                                        onPressed: () {},
                                        child: Padding(
                                          padding: EdgeInsets.all(7),
                                          child: Text(
                                            'Пересчитать максимальную нагрузку',
                                            style: GoogleFonts.roboto(
                                              color: Color(0xFF00A551),
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.20,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'Максимальная нагрузка:',
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: 0.40,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${widget.maxLoadInfo[widget.selectedPark]}',
                                          style: GoogleFonts.roboto(
                                            color: Color(0xFF00A551),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.40,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                          'Текущая нагрузка:',
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            letterSpacing: 0.40,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${widget.nowLoadInfo[widget.selectedPark]}',
                                          style: GoogleFonts.roboto(
                                            color: Color(0xFF00A551),
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.40,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Обстановка ',
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.40,
                                          ),
                                        ),
                                        Spacer()
                                      ],
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(children: [
                                      Text(
                                        'Людей на маршрутах:',
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 0.40,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${widget.numberPeopleInfo[widget.selectedPark]}',
                                        style: GoogleFonts.roboto(
                                          color: Color(0xFF00A551),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.40,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 50,
                                      ),
                                      Text(
                                        'Количество разрешений:',
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 0.40,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${widget.numberRequestInfo[widget.selectedPark]}',
                                        style: GoogleFonts.roboto(
                                          color: Color(0xFF00A551),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.40,
                                        ),
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(children: [
                                      Text(
                                        'Количество проблем:',
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          letterSpacing: 0.40,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${widget.numberProblemInfo[widget.selectedPark]}',
                                        style: GoogleFonts.roboto(
                                          color: Color(0xFF00A551),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          letterSpacing: 0.40,
                                        ),
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 40,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Text(
                                          'Пояснение ',
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w500,
                                            letterSpacing: 0.40,
                                          ),
                                        ),
                                        Spacer(),
                                        IconButton(
                                            onPressed: () {},
                                            icon: Icon(
                                              Icons.edit,
                                              color:
                                                  Color.fromRGBO(0, 165, 81, 1),
                                            ))
                                      ],
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Text(
                                      '${widget.aboutInfo[widget.selectedPark]}',
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 16,
                                        fontWeight: FontWeight.w300,
                                        letterSpacing: 0.40,
                                      ),
                                    ),
                                  ],
                                ))),
                      ],
                    )),
              ),
            ],
          ),
        )
      ],
    );
  }
}
