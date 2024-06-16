import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/models/oopt.dart';
import 'package:kamchatka/src/views/home/children/check_in/widgets/check_in_body_second.dart';
import 'package:shimmer/shimmer.dart';

class CheckInBodyLoading extends StatelessWidget {
  const CheckInBodyLoading();

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
                  DropDownShimmer(),
                  const SizedBox(height: 16),
                  DropDownShimmer(),
                  const SizedBox(height: 24),
                  Center(
                    child: OutlinedButton(
                        style: ElevatedButton.styleFrom(
                          side: BorderSide(color: Colors.grey),
                        ),
                        onPressed: null,
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
}

class DropDownShimmer extends StatelessWidget {
  const DropDownShimmer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
        baseColor: ColorName.cardBackground,
        highlightColor: ColorName.primary.withAlpha(100),
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: ColorName.cardBackground,
          ),
          child: DropdownButton(
            items: [
              DropdownMenuItem(
                  child: Text(
                '',
                style: Theme.of(context).textTheme.bodyMedium,
                overflow: TextOverflow.ellipsis,
              ))
            ],
            onChanged: null,
            isExpanded: true,
            underline: const SizedBox(),
            icon: const Icon(Icons.expand),
          ),
        ));
  }
}
