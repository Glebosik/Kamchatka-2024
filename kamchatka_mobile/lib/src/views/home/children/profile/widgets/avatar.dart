import 'package:flutter/material.dart';
import 'package:kamchatka/gen/colors.gen.dart';

class Avatar extends StatelessWidget {
  const Avatar({super.key, required this.secondName, this.avatarSize = 24.0});

  final String secondName;
  final double? avatarSize;

  @override
  Widget build(BuildContext context) {
    return CircleAvatar(
      radius: avatarSize,
      backgroundColor: ColorName.primary,
      child: secondName.isNotEmpty
          ? Text(
              secondName[0],
              style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                  fontSize: avatarSize ?? 24 * 0.5, color: Colors.white),
            )
          : Icon(Icons.person_outline, size: avatarSize),
    );
  }
}
