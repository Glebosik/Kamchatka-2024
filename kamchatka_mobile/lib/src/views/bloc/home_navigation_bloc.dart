import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/data/data_repository.dart';
import 'package:kamchatka/src/models/application.dart';
import 'package:kamchatka/src/models/oopt.dart';
import 'package:kamchatka/src/models/user.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

part 'home_navigation_event.dart';
part 'home_navigation_state.dart';

class HomeNavigationBloc
    extends Bloc<HomeNavigationEvent, HomeNavigationState> {
  final DataRepository dataClient;
  int currentIndex = 0;
  User? user;
  List<Application> applications = [];
  List<Oopt> oopts = [];

  @override
  void onChange(Change<HomeNavigationState> change) {
    print('Old - ${change.currentState}');
    print('New - ${change.nextState}');
    super.onChange(change);
  }

  HomeNavigationBloc({required this.dataClient})
      : super(HomeNavigationInitial()) {
    on<HomeNavigationEvent>((event, emit) {});

    on<UpdateApplications>((event, emit) async {
      await dataClient.getOopts();
    });

    on<PageTapped>((event, emit) async {
      currentIndex = event.index;
      if (event.index == 0) {
        oopts = dataClient.getCachedOopts();
        emit(MainPageLoaded(oopts: oopts));
      } else if (event.index == 1) {
        emit(MapPageLoading());
        if (oopts.isNotEmpty) {
          final objects = getMapObjects();
          emit(MapPageLoaded(oopts: oopts, mapObjects: objects));
        } else {
          oopts = await dataClient.getOopts();
          final objects = getMapObjects();
          emit(MapPageLoaded(oopts: oopts, mapObjects: objects));
        }
      } else if (event.index == 2) {
        emit(ProfilePageLoading());
        await Future.delayed(Duration(milliseconds: Random().nextInt(1000)));
        try {
          user = dataClient.getUser();
          applications = await dataClient.getApplications();
          /*if (user == null) {
            user = await firestoreRepository.currentUserData;
            if (user != null) {
              emit(ProfilePageLoaded(user!));
            } else {
              emit(ProfilePageFailed());
            }
          } else {*/
          emit(ProfilePageLoaded(user: user!, applications: applications));
          //}
        } catch (e) {
          emit(ProfilePageFailed());
        }
      }
    });
  }

  List<MapObject<dynamic>> getMapObjects() {
    List<MapObject<dynamic>> objects = [];
    for (int i = 0; i < oopts.length; ++i) {
      final ooptPolygon = PolygonMapObject(
          onTap: (mapObject, point) {
            print(mapObject.mapId);
          },
          strokeColor: ColorName.error,
          fillColor: ColorName.onError,
          mapId: MapObjectId('$i'),
          polygon: Polygon(
              outerRing: LinearRing(
                  points: oopts[i]
                      .border
                      .map((e) =>
                          Point(latitude: e.latitude, longitude: e.longitude))
                      .toList()),
              innerRings: const []));
      objects.add(ooptPolygon);

      for (int j = 0; j < oopts[i].trails.length; ++j) {
        final trailLine = PolylineMapObject(
            strokeColor: ColorName.primary,
            onTap: (mapObject, point) {},
            mapId: MapObjectId('$i $j'),
            polyline: Polyline(
                points: oopts[i]
                    .trails[j]
                    .points
                    .map((e) => Point(
                        latitude: e.coords.latitude,
                        longitude: e.coords.longitude))
                    .toList()));
        objects.add(trailLine);
        final trailPoint = PlacemarkMapObject(
            icon: PlacemarkIcon.single(PlacemarkIconStyle(
                image:
                    BitmapDescriptor.fromAssetImage(Assets.images.flag.path))),
            text: PlacemarkText(
                text: oopts[i].trails[j].name, style: PlacemarkTextStyle()),
            mapId: MapObjectId('$i $j placemark'),
            point: Point(
                latitude: oopts[i].trails[j].points[0].coords.latitude,
                longitude: oopts[i].trails[j].points[0].coords.longitude));
        objects.add(trailPoint);

        /*for (int n = 0; n < oopts[i].trails[j].points.length; ++n) {
          final trailPoint = PlacemarkMapObject(
              icon: PlacemarkIcon.single(PlacemarkIconStyle(
                  image: BitmapDescriptor.fromAssetImage(
                      Assets.images.flag.path))),
              text: PlacemarkText(
                  text: oopts[i].trails[j].points[n].name,
                  style: PlacemarkTextStyle()),
              mapId: MapObjectId('$i $j placemark'),
              point: Point(
                  latitude: oopts[i].trails[j].points[n].coords.latitude,
                  longitude: oopts[i].trails[j].points[n].coords.longitude));
          objects.add(trailPoint);
        }*/
      }
    }
    return objects;
  }

  int getHashCode(DateTime key) {
    return key.day * 1000000 + key.month * 10000 + key.year;
  }
}
