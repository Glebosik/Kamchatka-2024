import 'package:flutter/material.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/src/models/user.dart';

import 'widgets.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({
    super.key,
    required this.user,
    required this.height,
  });

  final User user;
  final double height;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: MediaQuery.of(context).size.width * 0.97,
      child: Container(
        decoration: BoxDecoration(
          color: Color(0x2106E574),
          borderRadius: BorderRadius.circular(20),
        ),
        child: InkWell(
          onTap: null,
          child: Padding(
            padding: const EdgeInsets.fromLTRB(8, 8, 0, 8),
            child: ListTile(
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Row(
                    children: [
                      Avatar(
                        secondName: user.nameSecond,
                        avatarSize: 24,
                      ),
                      const SizedBox(width: 16),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(user.nameSecond,
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.black)),
                          Text('${user.nameFirst} ${user.nameThird}',
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge!
                                  .copyWith(color: Colors.black)),
                        ],
                      )
                    ],
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.02,
                  ),
                  Row(
                    children: [
                      const SizedBox(width: 60),
                      Assets.icons.statusApproved.svg(),
                      const SizedBox(width: 5),
                      Text('учетная запись подтверждена',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 12)),
                    ],
                  )
                ],
              ),
              //trailing: const Icon(
              //  Icons.arrow_forward_ios,
              //  color: ColorName.primary,
              //),
            ),
          ),
        ),
      ),
    );
  }
}
