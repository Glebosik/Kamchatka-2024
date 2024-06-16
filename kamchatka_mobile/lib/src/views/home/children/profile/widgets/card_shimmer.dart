import 'package:flutter/material.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:shimmer/shimmer.dart';

class CardShimmer extends StatelessWidget {
  const CardShimmer({super.key, this.height, this.width, this.radius = 20});

  final double? height, width;
  final double radius;
  //TODO: подобрать цвета
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: ColorName.cardBackground,
      highlightColor: ColorName.primary.withAlpha(100),
      child: SizedBox(
        width: width,
        height: height,
        child: Card(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius)),
          elevation: 2,
        ),
      ),
    );
  }
}
