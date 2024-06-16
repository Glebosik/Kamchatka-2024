import 'package:flutter/material.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

/// Displays detailed information about a SampleItem.
class SampleItemDetailsView extends StatelessWidget {
  const SampleItemDetailsView({super.key});

  static const routeName = '/sample_item';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Item Details'),
      ),
      body: const Center(
        child: YandexMap(
          mapObjects: [
            PolygonMapObject(
                mapId: MapObjectId('0'),
                polygon: Polygon(
                    outerRing: LinearRing(points: []),
                    innerRings: [LinearRing(points: [])]))
          ],
        ),
      ),
    );
  }
}
