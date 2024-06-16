import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/models/oopt.dart';
import 'package:kamchatka/src/views/home/children/main/widgets/search_bar.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class MapViewLoaded extends StatefulWidget {
  const MapViewLoaded(
      {super.key, required this.oopts, required this.mapObjects});

  final List<Oopt> oopts;
  final List<MapObject<dynamic>> mapObjects;

  @override
  State<MapViewLoaded> createState() => _MapViewLoadedState();
}

class _MapViewLoadedState extends State<MapViewLoaded> {
  List<MapObject<dynamic>> mapOopts = [];
  Map<Oopt, List<MapObject<dynamic>>> trailsForOopt = {};
  List<MapObject<dynamic>> toShow = [];
  late YandexMapController mapController;

  @override
  void initState() {
    trailsForOopt = getTrailsForOopt();
    mapOopts = getOoptBorders();
    toShow = mapOopts;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    //Positioned(top: 10, child: MySearchBar()),
    //Positioned(
    //    child: IconButton(onPressed: () {}, icon: Assets.icons.report.svg())),
    return Stack(
      children: [
        YandexMap(
          rotateGesturesEnabled: false,
          onMapCreated: (controller) async {
            mapController = controller;
            await controller.moveCamera(CameraUpdate.newCameraPosition(
                const CameraPosition(
                    target: Point(latitude: 53.03, longitude: 158.64),
                    zoom: 10)));
          },
          nightModeEnabled: true,
          mapObjects: mapOopts + toShow,
        ),
        Positioned(
          left: width * 0.05,
          top: 50,
          child: SizedBox(
            width: width * 0.9,
            child: searchBar(),
          ),
        ),
      ],
    );
  }

  Widget searchBar() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SearchAnchor(
        builder: (BuildContext context, SearchController controller) {
          return SearchBar(
            hintText: 'Южно-камчатский природный парк',
            hintStyle: MaterialStatePropertyAll(Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: ColorName.textHint)),
            elevation: const MaterialStatePropertyAll(0),
            backgroundColor:
                const MaterialStatePropertyAll(ColorName.cardBackground),
            controller: controller,
            padding: const MaterialStatePropertyAll<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 16.0)),
            onTap: () {
              controller.openView();
            },
            onChanged: (_) {
              controller.openView();
            },
            trailing: [Assets.icons.search.svg()],
          );
        },
        suggestionsBuilder:
            (BuildContext context, SearchController controller) {
          List<ListTile> suggestions = [];
          for (var oopt in widget.oopts) {
            String name = '${oopt.name} природный парк';
            suggestions.add(ListTile(
              title: Text(name),
              onTap: () async {
                setState(
                  () {
                    setState(() {
                      controller.closeView(name);
                      toShow = trailsForOopt[oopt]!;
                    });
                  },
                );
                await mapController.moveCamera(
                  CameraUpdate.newCameraPosition(
                    CameraPosition(
                        target: Point(
                            latitude: oopt.border.first.latitude,
                            longitude: oopt.border.first.longitude),
                        zoom: 8),
                  ),
                  animation: const MapAnimation(),
                );
              },
            ));
          }
          for (int i = 0; i < widget.oopts.length; ++i) {
            for (var trail in widget.oopts[i].trails) {
              String name = 'Маршрут "${trail.name}"';
              suggestions.add(ListTile(
                title: Text(name),
                onTap: () async {
                  setState(
                    () {
                      controller.closeView(name);
                    },
                  );
                  await mapController.moveCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                          target: Point(
                              latitude: trail.points.first.coords.latitude,
                              longitude: trail.points.first.coords.longitude),
                          zoom: 10),
                    ),
                    animation: const MapAnimation(),
                  );
                },
              ));
            }
          }
          return suggestions;
        },
      ),
    );
  }

  List<MapObject<dynamic>> getOoptBorders() {
    List<MapObject<dynamic>> objects = [];
    for (int i = 0; i < widget.oopts.length; ++i) {
      final ooptPolygon = PolygonMapObject(
          onTap: (mapObject, point) {
            setState(() {
              toShow = trailsForOopt[widget.oopts[i]]!;
            });
          },
          strokeColor: ColorName.primary.withAlpha(150),
          fillColor: ColorName.cardBackground.withAlpha(100),
          mapId: MapObjectId('$i'),
          polygon: Polygon(
              outerRing: LinearRing(
                  points: widget.oopts[i].border
                      .map((e) =>
                          Point(latitude: e.latitude, longitude: e.longitude))
                      .toList()),
              innerRings: const []));
      objects.add(ooptPolygon);

      double longitude = 0, latitude = 0;
      int count = widget.oopts[i].border.length;
      for (var point in widget.oopts[i].border) {
        latitude += point.latitude;
        longitude += point.longitude;
      }
      final ooptCenter = PlacemarkMapObject(
          opacity: 1,
          icon: PlacemarkIcon.single(PlacemarkIconStyle(
              image:
                  BitmapDescriptor.fromAssetImage(Assets.images.parkPin.path))),
          text: PlacemarkText(
              text: widget.oopts[i].name == 'Налычево'
                  ? 'Природный парк ${widget.oopts[i].name}'
                  : '${widget.oopts[i].name} природный парк',
              style: PlacemarkTextStyle(
                  color: ColorName.primary,
                  placement: TextStylePlacement.bottom)),
          mapId: MapObjectId('$i placemark'),
          point:
              Point(latitude: latitude / count, longitude: longitude / count));
      objects.add(ooptCenter);
    }
    return objects;
  }

  Map<Oopt, List<MapObject<dynamic>>> getTrailsForOopt() {
    Map<Oopt, List<MapObject<dynamic>>> map = {};
    for (int i = 0; i < widget.oopts.length; ++i) {
      List<MapObject<dynamic>> objects = [];
      for (var trail in widget.oopts[i].trails) {
        final trailLine = PolylineMapObject(
            strokeWidth: 2,
            strokeColor: Color((Random().nextDouble() * 0xFFFFFF).toInt())
                .withAlpha(150),
            onTap: (mapObject, point) {},
            mapId: MapObjectId('$i ${trail.name}'),
            polyline: Polyline(
                points: trail.points
                    .map((e) => Point(
                        latitude: e.coords.latitude,
                        longitude: e.coords.longitude))
                    .toList()));
        objects.add(trailLine);
        objects.add(
          PlacemarkMapObject(
            opacity: 0.8,
            icon: PlacemarkIcon.single(PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                    Assets.images.routeStart.path))),
            text: PlacemarkText(
                text: ('Начало маршрута "${trail.name}"'),
                style:
                    PlacemarkTextStyle(placement: TextStylePlacement.bottom)),
            mapId: MapObjectId('${trail.name} start'),
            point: Point(
              latitude: trail.points.first.coords.latitude,
              longitude: trail.points.first.coords.longitude,
            ),
          ),
        );
        objects.add(
          PlacemarkMapObject(
            opacity: 0.8,
            icon: PlacemarkIcon.single(PlacemarkIconStyle(
                image: BitmapDescriptor.fromAssetImage(
                    Assets.images.routeEnd.path))),
            text: PlacemarkText(
                text: ('Конец маршрута "${trail.name}"'),
                style:
                    PlacemarkTextStyle(placement: TextStylePlacement.bottom)),
            mapId: MapObjectId('${trail.name} end'),
            point: Point(
              latitude: trail.points.last.coords.latitude,
              longitude: trail.points.last.coords.longitude,
            ),
          ),
        );
      }
      map[widget.oopts[i]] = objects;
    }
    return map;
  }
}
