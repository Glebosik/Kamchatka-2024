import 'package:flutter/material.dart';
import 'package:kamchatka/src/map/oopt_map.dart';
import 'package:kamchatka/src/models/oopt.dart';

class OoptSuccessView extends StatelessWidget {
  const OoptSuccessView({super.key, required this.oopts});

  final List<Oopt> oopts;

  @override
  Widget build(BuildContext context) {
    return OoptMap(oopts: oopts);
  }
}
