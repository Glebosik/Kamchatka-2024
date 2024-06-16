import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:uni_table/data/models/oopt.dart';
import 'package:uni_table/mapWorkScreen/buttonBuilder.dart';

class SinglePersonTable extends StatefulWidget {
  SinglePersonTable(
      {super.key, required this.refreshMainScreen, required this.oopts});

  final Function(int) refreshMainScreen;
  final List<Oopt> oopts;

  @override
  State<SinglePersonTable> createState() => _SinglePersonTableState();
}

class _SinglePersonTableState extends State<SinglePersonTable> {
  Oopt? _selectedOopt;
  List<Polygon> polygons = [];
  List<Marker> markers = [];
  Map<Oopt, List<Polyline>> polylinesForOopt = {};
  Map<Oopt, List<Marker>> markersForOopts = {};

  @override
  void initState() {
    for (var oopt in widget.oopts) {
      polygons.add(
        Polygon(
          strokeColor: Colors.green,
          fillColor: Colors.green.withAlpha(100),
          polygonId: PolygonId(oopt.name),
          points: oopt.border
              .map((element) => LatLng(element.latitude, element.longitude))
              .toList(),
          onTap: () {
            setState(() {
              _selectedOopt = oopt;
            });
          },
        ),
      );
      /*for (var trail in oopt.trails) {
        Polyline(
            polylineId: PolylineId(trail.name),
            points: trail.points.map((element) =>
                LatLng(element.coords.latitude, element.coords.longitude)));
      }*/
    }
    super.initState();
  }

  refresh(int index) {
    setState(() {});
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
            child: Column(
              children: [
                Container(
                  height: 120,
                  width: double.infinity,
                  decoration: const ShapeDecoration(
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        topRight: Radius.circular(10),
                      ),
                    ),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Показать на карте:',
                          style: GoogleFonts.roboto(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            letterSpacing: 0.40,
                          ),
                        ),
                        Container(
                            width: double.infinity,
                            height: 65,
                            child: ButtonBuilder()),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                      decoration: const BoxDecoration(
                        color: Color(0xFFE7FFF0),
                      ),
                      child: Center(
                        child: GoogleMap(
                          polygons: polygons.toSet(),
                          mapType: MapType.normal,
                          initialCameraPosition: const CameraPosition(
                              target: LatLng(53.03, 158.64), zoom: 8),
                        ),
                      )),
                ),
              ],
            )));
  }
}
