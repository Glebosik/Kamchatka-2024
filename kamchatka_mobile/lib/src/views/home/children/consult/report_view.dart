import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/data/data_repository.dart';
import 'package:latlong2/latlong.dart';
import 'package:path/path.dart';
import 'package:yandex_mapkit/yandex_mapkit.dart';

class ReportView extends StatefulWidget {
  const ReportView({
    super.key,
  });

  @override
  State<ReportView> createState() => _ReportViewState();
}

class _ReportViewState extends State<ReportView> {
  String? _selectedCategory;
  String? _description;
  List<String?> _files = [];
  LatLng? _coords;
  String? _selectedPlace;
  String? _selectedEmail;
  String? _selectedPhone;

  final List<String> categories = [
    'Незаконное размещение отходов',
    'Сброс сточных вод, нарушение использования и охраны водных объектов',
    'Природа, Экология/Иное',
    'Загрязнение атмосферного воздух',
    'Нарушение законодательства о животном мире',
    'Нарушение режима особой охраны природной территории',
    'Нарушение при эксплуатации очистных сооружений',
    'Незаконное ограничение доступа к водным объектам',
  ];

  @override
  Widget build(BuildContext context) {
    final dataRepository = context.read<DataRepository>();
    final user = dataRepository.getUser();
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Сообщить о проблеме',
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: IgnorePointer(
              child: Assets.auth.background.svg(
                width: MediaQuery.of(context).size.width * 0.9,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0, right: 16.0),
            child: Column(
              children: [
                dropdownCategoryInput(width, context, 'Выберите категорию',
                    categories, _selectedCategory),
                problemInput(width, context),
                const SizedBox(height: 24),
                cardButton(
                  context,
                  width,
                  'Прикрепить документы',
                  _files.isEmpty
                      ? null
                      : Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: _files
                              .map((e) => Text(basename(e ?? '')))
                              .toList(),
                        ),
                  Assets.icons.addDoc.svg(),
                  () async {
                    FilePickerResult? result = await FilePicker.platform
                        .pickFiles(allowMultiple: true);
                    if (result != null) {
                      setState(() {
                        _files = result.paths;
                      });
                    } else {}
                  },
                ),
                const SizedBox(height: 24),
                cardButton(
                  context,
                  width,
                  'Указать место проблемы',
                  _coords == null ? null : Text(_coords!.toSexagesimal()),
                  Assets.icons.setPos.svg(),
                  () async {
                    final coords = await showDialog<LatLng>(
                      context: context,
                      builder: (context) {
                        return PickLocationMap(width: width);
                      },
                    );
                    setState(() {
                      _coords = coords;
                    });
                  },
                ),
                const SizedBox(height: 24),
                emailInput(width, context,
                    Assets.icons.applicationFormMail.svg(width: 35)),
                numberInput(width, context,
                    Assets.icons.applicationFormPhone.svg(width: 25)),
                Spacer(),
                OutlinedButton(
                  style: ElevatedButton.styleFrom(
                    side: BorderSide(
                        color: isValid() ? ColorName.primary : Colors.black54),
                  ),
                  onPressed: !isValid()
                      ? null
                      : () async {
                          await dataRepository.sendReport(
                              comment: _description!,
                              type: _selectedCategory!,
                              paths: _files,
                              location: _coords!,
                              email: _selectedEmail!,
                              number: _selectedPhone!);
                          await showDialog(
                            barrierDismissible: false,
                            useRootNavigator: false,
                            context: context,
                            builder: (context) {
                              Future.delayed(const Duration(seconds: 3), () {
                                final nav = Navigator.of(context);
                                nav.pop(true);
                                nav.pop(true);
                              });
                              return AlertDialog(
                                content: SizedBox(
                                  height: 175,
                                  width:
                                      MediaQuery.of(context).size.width * 0.9,
                                  child: Center(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Assets.icons.statusApproved
                                          .svg(height: 64),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Благодарим за ваше обращение!',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: 16,
                                                color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                      const SizedBox(height: 10),
                                      Text(
                                        'Ваше сообщение будет рассмотрено в ближайшее время.',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyMedium!
                                            .copyWith(
                                                fontSize: 14,
                                                color: Colors.black),
                                        textAlign: TextAlign.center,
                                      ),
                                    ],
                                  )),
                                ),
                              );
                            },
                          );
                        },
                  child: const Center(
                    child: Text('Сообщить о проблеме'),
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget cardButton(BuildContext context, double width, String title,
      Widget? subtitle, SvgPicture icon, Function()? onTap) {
    return Container(
      decoration: BoxDecoration(
          boxShadow: const [
            BoxShadow(
              color: Color(0x0C000000),
              blurRadius: 4,
              offset: Offset(0, 1),
              spreadRadius: 1,
            )
          ],
          gradient: LinearGradient(
            stops: const [0, 0.4, 0.7, 1],
            colors: [
              Colors.white,
              ColorName.cardBackground.withOpacity(.5),
              ColorName.cardBackground.withOpacity(.7),
              ColorName.cardBackground,
            ],
          ),
          borderRadius: const BorderRadius.all(Radius.circular(32))),
      width: width * 0.9,
      child: ListTile(
        subtitleTextStyle: Theme.of(context)
            .textTheme
            .bodySmall!
            .copyWith(color: Colors.black),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        title: Text(title),
        subtitle: subtitle,
        trailing: icon,
        onTap: onTap,
      ),
    );
  }

  Widget dropdownCategoryInput(
    double width,
    BuildContext context,
    String label,
    List<String> options,
    String? value,
  ) {
    return SizedBox(
      width: width * 0.9,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Center(
            child: DropdownButton<String>(
              itemHeight: 50,
              hint: Text(
                label,
                style: Theme.of(context)
                    .textTheme
                    .bodyMedium!
                    .copyWith(color: Colors.grey.withAlpha(200)),
                overflow: TextOverflow.ellipsis,
              ),
              value: _selectedCategory,
              selectedItemBuilder: (context) {
                return options.map<Widget>((type) {
                  return Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      type,
                      style: Theme.of(context).textTheme.bodyMedium,
                      overflow: TextOverflow.ellipsis,
                    ),
                  );
                }).toList();
              },
              items: options.map<DropdownMenuItem<String>>((type) {
                return DropdownMenuItem<String>(
                  value: type,
                  child: Text(
                    type,
                    style: Theme.of(context).textTheme.bodyMedium,
                    overflow: TextOverflow.fade,
                  ),
                );
              }).toList(),
              onChanged: (String? type) {
                setState(() {
                  if (_selectedCategory != type) {
                    //_selectedType = null;
                    _selectedCategory = type;
                  }
                });
              },
              isExpanded: true,
              underline: const SizedBox(),
              icon: const Icon(Icons.expand_more),
            ),
          ),
        ),
      ),
    );
  }

  Widget problemInput(double width, BuildContext context) {
    return SizedBox(
      width: width * 0.9,
      child: Card(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              maxLength: 200,
              maxLines: 3,
              onChanged: (value) => _description = value,
              keyboardType: TextInputType.text,
              decoration: const InputDecoration(
                border: InputBorder.none,
                labelText: 'Опишите проблему...',
                contentPadding: EdgeInsets.fromLTRB(
                  16,
                  5,
                  5,
                  16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Row numberInput(double width, BuildContext context, SvgPicture icon) {
    return Row(
      children: [
        SizedBox(width: width * 0.1, child: icon),
        SizedBox(
          width: width * 0.025,
        ),
        SizedBox(
          width: width * 0.775,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Center(
              child: TextField(
                onChanged: (value) => _selectedPhone = value,
                keyboardType: TextInputType.phone,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Контактный номер',
                  contentPadding: EdgeInsets.fromLTRB(
                    16,
                    5,
                    5,
                    16,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row emailInput(double width, BuildContext context, SvgPicture icon) {
    return Row(
      children: [
        SizedBox(width: width * 0.1, child: icon),
        SizedBox(
          width: width * 0.025,
        ),
        SizedBox(
          width: width * 0.775,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: Center(
              child: TextField(
                onChanged: (value) => _selectedEmail = value,
                keyboardType: TextInputType.emailAddress,
                decoration: const InputDecoration(
                  border: InputBorder.none,
                  labelText: 'Адрес электронной почты',
                  contentPadding: EdgeInsets.fromLTRB(
                    16,
                    5,
                    5,
                    16,
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }

  Row stringRow(double width, BuildContext context, String fieldName,
      String content, SvgPicture icon) {
    return Row(
      children: [
        SizedBox(width: 30, child: icon),
        const SizedBox(
          width: 20,
        ),
        SizedBox(
          width: width * 0.7,
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
            child: ListTile(
              dense: true,
              title: Text(
                content,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 16,
                    ),
              ),
              subtitle: Text(
                fieldName,
                style: Theme.of(context)
                    .textTheme
                    .bodySmall!
                    .copyWith(color: Colors.grey),
              ),
              trailing: Assets.icons.applicationFormGoal.svg(),
            ),
          ),
        )
      ],
    );
  }

  bool isValid() =>
      _description != null &&
      _files.isNotEmpty &&
      _coords != null &&
      _selectedCategory != null &&
      _selectedEmail != null &&
      _selectedPhone != null;
}

class PickLocationMap extends StatefulWidget {
  const PickLocationMap({
    super.key,
    required this.width,
  });

  final double width;

  @override
  State<PickLocationMap> createState() => _PickLocationMapState();
}

class _PickLocationMapState extends State<PickLocationMap> {
  final MapObjectId cameraMapObjectId = const MapObjectId('camera_placemark');
  late YandexMapController controller;
  late final List<MapObject> mapObjects = [
    PlacemarkMapObject(
      mapId: cameraMapObjectId,
      point: const Point(latitude: 53.03, longitude: 158.64),
      icon: PlacemarkIcon.single(PlacemarkIconStyle(
          image: BitmapDescriptor.fromAssetImage(Assets.images.routeStart.path),
          scale: 0.75)),
      opacity: 0.5,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        YandexMap(
          nightModeEnabled: true,
          onMapCreated: (YandexMapController yandexMapController) async {
            final placemarkMapObject =
                mapObjects.firstWhere((el) => el.mapId == cameraMapObjectId)
                    as PlacemarkMapObject;

            controller = yandexMapController;

            await controller.moveCamera(CameraUpdate.newCameraPosition(
                CameraPosition(target: placemarkMapObject.point, zoom: 10)));
          },
          mapObjects: mapObjects,
          onCameraPositionChanged: (CameraPosition cameraPosition,
              CameraUpdateReason _, bool __) async {
            final placemarkMapObject =
                mapObjects.firstWhere((el) => el.mapId == cameraMapObjectId)
                    as PlacemarkMapObject;

            setState(() {
              mapObjects[mapObjects.indexOf(placemarkMapObject)] =
                  placemarkMapObject.copyWith(point: cameraPosition.target);
            });
          },
        ),
        Positioned(
          left: widget.width * 0.05,
          bottom: 25,
          child: SizedBox(
            width: widget.width * 0.9,
            child: OutlinedButton(
                onPressed: () async {
                  final cameraPosition = await controller.getCameraPosition();
                  Navigator.pop(
                      context,
                      LatLng(cameraPosition.target.latitude,
                          cameraPosition.target.longitude));
                },
                child: Text('Выбрать')),
          ),
        ),
      ],
    );
  }
}
