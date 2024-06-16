import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/auth/auth_view.dart';
import 'package:kamchatka/src/auth/login/cubit/login_cubit.dart';
import 'package:kamchatka/src/data/data_repository.dart';
import 'package:kamchatka/src/models/application.dart';
import 'package:kamchatka/src/models/user.dart';
import 'package:kamchatka/src/views/home/children/profile/applications_view.dart';
import 'package:kamchatka/src/views/home/children/profile/widgets/list_card.dart';
import 'package:kamchatka/src/views/home/children/profile/widgets/profile_header.dart';
import 'package:kamchatka/src/views/widgets/home_bottom_nav_bar.dart';

class ProfileView extends StatelessWidget {
  const ProfileView(
      {super.key,
      required this.user,
      required this.bottomKey,
      required this.applications});

  final User user;
  final Key bottomKey;
  final List<Application> applications;
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Stack(
        children: [
          Positioned(
              top: 170, left: -100, child: Assets.icons.backgroundLeft.svg()),
          Positioned(
              top: 80, right: -70, child: Assets.icons.backgroundRight.svg()),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: ProfileHeader(
                  user: user,
                  height: height * 0.2,
                ),
              ),
              const Spacer(),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Assets.images.bgEllipse.svg(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Пройдено маршрутов',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
                width: 60,
                child: Card(
                  color: ColorName.cardBackground,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      '4',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 12),
              Stack(
                alignment: Alignment.centerLeft,
                children: [
                  Assets.images.bgEllipse.svg(height: 24),
                  Padding(
                    padding: const EdgeInsets.only(left: 12),
                    child: Text(
                      'Сообщено о проблемах',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: Colors.black, fontSize: 16),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 40,
                width: 60,
                child: Card(
                  color: ColorName.cardBackground,
                  elevation: 0,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12)),
                  child: Center(
                    child: Text(
                      '12',
                      style: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
              ),
              const Spacer(),
              ListCard(
                title: 'Мои разрешения',
                icon: Assets.icons.profileApplications.svg(),
                height: height * 0.09,
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) =>
                          ApplicationsView(applications: applications),
                    ),
                  );
                },
              ),
              ListCard(
                title: 'Настройка уведомлений',
                icon: Assets.icons.profileNotifications.svg(),
                height: height * 0.09,
              ),
              ListCard(
                title: 'Помощь и поддержка',
                icon: Assets.icons.profileHelp.svg(),
                height: height * 0.09,
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.only(left: 16.0, right: 16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width * 0.43, height * 0.07),
                          backgroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {},
                        child: Text(
                          'О приложении',
                          style: Theme.of(context).textTheme.bodyMedium,
                        )),
                    ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          fixedSize: Size(width * 0.43, height * 0.07),
                          backgroundColor: ColorName.cardBackground,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                        ),
                        onPressed: () {
                          context.read<LoginCubit>().reset();
                          context.read<DataRepository>().logOut();
                          Navigator.of(context).pushReplacement(
                            MaterialPageRoute(
                                builder: (context) => const AuthPage()),
                          );
                        },
                        child: Text(
                          'Выход',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(fontSize: 14),
                        ))
                  ],
                ),
              ),
              Spacer()
            ],
          ),
        ],
      ),
      bottomNavigationBar: HomeBottomNavBar(
        key: bottomKey,
      ),
    );
  }
}
