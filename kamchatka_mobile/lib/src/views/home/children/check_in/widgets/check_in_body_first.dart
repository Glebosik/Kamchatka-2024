import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/models/oopt.dart';
import 'package:kamchatka/src/views/home/children/check_in/widgets/check_in_body_second.dart';

class CheckInBodyFirst extends StatefulWidget {
  CheckInBodyFirst({
    required this.oopts,
    super.key,
  });
  final List<Oopt> oopts;
  final List<String> types = ['Индивидуальное', 'Групповое'];

  @override
  State<CheckInBodyFirst> createState() => _CheckInBodyFirstState();
}

class _CheckInBodyFirstState extends State<CheckInBodyFirst> {
  Oopt? _selectedOopt;
  String? _selectedType;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Разрешение на посещение',
        ),
      ),
      body: Stack(
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),
                  ooptDropDown(),
                  const SizedBox(height: 16),
                  typeDropDown(),
                  const SizedBox(height: 24),
                  Center(
                    child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(
                              color: (_selectedOopt != null &&
                                      _selectedType != null)
                                  ? ColorName.primary
                                  : Colors.grey),
                        ),
                        onPressed: (_selectedOopt != null &&
                                _selectedType != null)
                            ? () {
                                Navigator.of(context).push(MaterialPageRoute(
                                  builder: (context) => CheckInBodySecond(
                                    selectedOopt: _selectedOopt!,
                                    selectedType: _selectedType!,
                                  ),
                                ));
                              }
                            : null,
                        child: Text(
                          'Далее',
                          style: GoogleFonts.inter().copyWith(fontSize: 16),
                        )),
                  ),
                  const Spacer(),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            child: IgnorePointer(
              child: Assets.icons.backgroundMountains.svg(
                width: MediaQuery.of(context).size.width,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget ooptDropDown() {
    return Card(
      color: _selectedOopt != null ? ColorName.cardBackground : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: DropdownButton(
          itemHeight: 50,
          hint: Text(
            'Выберите парк',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
          value: _selectedOopt,
          selectedItemBuilder: (context) {
            return widget.oopts.map<Widget>((oopt) {
              return Center(
                child: Text(
                  oopt.name == 'Налычево'
                      ? 'Природный парк ${oopt.name}'
                      : '${oopt.name} природный парк',
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList();
          },
          items: widget.oopts.map<DropdownMenuItem<Oopt>>((oopt) {
            return DropdownMenuItem<Oopt>(
              value: oopt,
              child: Text(
                oopt.name == 'Налычево'
                    ? 'Природный парк ${oopt.name}'
                    : '${oopt.name} природный парк',
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.fade,
              ),
            );
          }).toList(),
          onChanged: (Oopt? oopt) {
            setState(() {
              if (_selectedOopt != oopt) {
                //_selectedType = null;
                _selectedOopt = oopt;
              }
            });
          },
          isExpanded: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.expand_more),
        ),
      ),
    );
  }

  Widget typeDropDown() {
    return Card(
      color: _selectedType != null ? ColorName.cardBackground : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(32)),
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: DropdownButton<String>(
          itemHeight: 50,
          hint: Text(
            'Выберите необходимый тип разрешения',
            style: Theme.of(context)
                .textTheme
                .bodyMedium!
                .copyWith(color: Colors.grey),
            overflow: TextOverflow.ellipsis,
          ),
          value: _selectedType,
          selectedItemBuilder: (context) {
            return widget.types.map<Widget>((type) {
              return Center(
                child: Text(
                  type,
                  style: Theme.of(context).textTheme.bodyMedium,
                  overflow: TextOverflow.ellipsis,
                ),
              );
            }).toList();
          },
          items: widget.types.map<DropdownMenuItem<String>>((type) {
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
              if (_selectedType != type) {
                //_selectedType = null;
                _selectedType = type;
              }
            });
          },
          isExpanded: true,
          underline: const SizedBox(),
          icon: const Icon(Icons.expand_more),
        ),
      ),
    );
  }
}
