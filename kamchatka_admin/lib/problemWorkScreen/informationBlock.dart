import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class InformationBlock extends StatefulWidget {
  InformationBlock(
      {super.key,
      required this.emailInfo,
      required this.phoneInfo,
      required this.statusInfo,
      required this.categoryInfo,
      required this.locationInfo,
      required this.aboutInfo,
      required this.numberInfo,
      required this.dateInfo});
  final String numberInfo;
  final String dateInfo;
  final String emailInfo;
  final String phoneInfo;
  final String statusInfo;
  final String categoryInfo;
  final String locationInfo;
  final String aboutInfo;

  @override
  State<InformationBlock> createState() => _InformationBlockState();
}

class _InformationBlockState extends State<InformationBlock> {
  String date = '16.06.2024';

  String email = 'userwantreport@mail.ru';
  String phone = '+79999999999';
  String status = 'на рассмотрении';
  String category = 'незаконное размещение отходов';
  String location = '55.29000966967503, 159.8050888595109';
  String about =
      'Нашел свалку недалеко от маршрута, не думаю, что она законная. Ориентиры: ручей, скопление деревьев.';

  @override
  void initState() {
    super.initState();
  }

  refresh(int index) {
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
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 15),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        'Проблема №${widget.numberInfo}',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 0.03,
                          letterSpacing: 0.40,
                        ),
                      ),
                      Spacer(),
                      Text(
                        'от ${widget.dateInfo}',
                        style: GoogleFonts.roboto(
                          color: Colors.black,
                          fontSize: 20,
                          fontWeight: FontWeight.w500,
                          height: 0.03,
                          letterSpacing: 0.40,
                        ),
                      )
                    ],
                  ),
                ),
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
                            top: 28,
                            child: Text(
                              'Информация о проблеме',
                              style: GoogleFonts.roboto(
                                color: Colors.black,
                                fontSize: 24,
                                fontWeight: FontWeight.w500,
                                height: 0.02,
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
                                        'Отправитель',
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
                                            'Показать на карте',
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
                                      height: 35,
                                    ),
                                    Row(
                                      children: [
                                        Text(
                                          'E-mail:',
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            height: 0.06,
                                            letterSpacing: 0.40,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${widget.emailInfo}',
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            height: 0.06,
                                            letterSpacing: 0.40,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 50,
                                        ),
                                        Text(
                                          'Телефон:',
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w300,
                                            height: 0.06,
                                            letterSpacing: 0.40,
                                          ),
                                        ),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          '${widget.phoneInfo}',
                                          style: GoogleFonts.roboto(
                                            color: Colors.black,
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            height: 0.06,
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
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            'Проблема ',
                                            style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              height: 0.03,
                                              letterSpacing: 0.40,
                                            ),
                                          ),
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(top: 10),
                                          child: Text(
                                            '№${widget.numberInfo}',
                                            style: GoogleFonts.roboto(
                                              color: Colors.black,
                                              fontSize: 20,
                                              fontWeight: FontWeight.w300,
                                              height: 0.03,
                                              letterSpacing: 0.40,
                                            ),
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
                                      height: 20,
                                    ),
                                    Row(children: [
                                      Text(
                                        'Статус:',
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          height: 0.06,
                                          letterSpacing: 0.40,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${widget.statusInfo}',
                                        style: GoogleFonts.roboto(
                                          color: Color(0xFFF2B600),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          height: 0.06,
                                          letterSpacing: 0.40,
                                        ),
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(children: [
                                      Text(
                                        'Категория:',
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          height: 0.06,
                                          letterSpacing: 0.40,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${widget.categoryInfo}',
                                        style: GoogleFonts.roboto(
                                          color: Color(0xFFF2B600),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          height: 0.06,
                                          letterSpacing: 0.40,
                                        ),
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(children: [
                                      Text(
                                        'Местоположение:',
                                        style: GoogleFonts.roboto(
                                          color: Colors.black,
                                          fontSize: 16,
                                          fontWeight: FontWeight.w300,
                                          height: 0.06,
                                          letterSpacing: 0.40,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                        '${widget.locationInfo}',
                                        style: GoogleFonts.roboto(
                                          color: Color(0xFFF2B600),
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          height: 0.06,
                                          letterSpacing: 0.40,
                                        ),
                                      ),
                                    ]),
                                    SizedBox(
                                      height: 60,
                                    ),
                                    Text(
                                      'Описание',
                                      style: GoogleFonts.roboto(
                                        color: Colors.black,
                                        fontSize: 20,
                                        fontWeight: FontWeight.w500,
                                        height: 0.03,
                                        letterSpacing: 0.40,
                                      ),
                                    ),
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Text(
                                      '${widget.aboutInfo}',
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
List<String> about = [
  'нашел свалку недалеко от маршрута, не думаю',
  'нашел свалку недалеко от маршрута, не думаю',
  'нашел свалку недалеко от маршрута, не думаю',
  'нашел свалку недалеко от маршрута, не думаю',
  'нашел свалку недалеко от маршрута, не думаю'
];

List<List<String>> headers = [
  ['№ п/п', 'статус', 'категория', 'описание'],
  ['№ п/п', 'статус', 'категория', 'описание'],
  ['№ п/п', 'статус', 'категория', 'описание'],
];
