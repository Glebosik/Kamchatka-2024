import 'package:flutter/material.dart';
import 'package:kamchatka/src/models/oopt.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class OoptMap extends StatelessWidget {
  const OoptMap({super.key, required this.oopts});

  final List<Oopt> oopts;

  @override
  Widget build(BuildContext context) {
    return YandexMap(
      mapObjects: [
        PolygonMapObject(
          onTap: (object, point) {
            Navigator.pushNamed(context, '/home');
          },
          fillColor: Colors.red.withAlpha(100),
          mapId: MapObjectId(oopts.first.name),
          polygon: Polygon(
            outerRing: LinearRing(
                points: oopts.first.border
                    .map((e) =>
                        Point(latitude: e.latitude, longitude: e.longitude))
                    .toList()),
            innerRings: const [],
          ),
        )
      ],
    );
  }
}
