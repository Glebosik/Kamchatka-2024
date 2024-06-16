import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/auth/auth_view.dart';
import 'package:kamchatka/src/auth/login/cubit/login_cubit.dart';
import 'package:kamchatka/src/data/data_repository.dart';
import 'package:kamchatka/src/views/home/children/profile/widgets/card_shimmer.dart';
import 'package:kamchatka/src/views/home/children/profile/widgets/list_card.dart';
import 'package:kamchatka/src/views/widgets/home_bottom_nav_bar.dart';

class ProfileViewLoading extends StatelessWidget {
  const ProfileViewLoading({super.key, required this.bottomKey});

  final Key bottomKey;
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
                child: CardShimmer(width: width * 0.97, height: height * 0.2),
              ),
              const SizedBox(height: 12),
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
              const CardShimmer(
                width: 60,
                height: 40,
                radius: 12,
              ),
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
              const CardShimmer(
                width: 60,
                height: 40,
                radius: 12,
              ),
              const SizedBox(height: 16),
              Expanded(
                child: Column(
                  children: [
                    ListCard(
                      title: 'Мои разрешения',
                      icon: Assets.icons.profileApplications.svg(),
                      height: height * 0.09,
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
                      padding: const EdgeInsets.only(left: 16, right: 16),
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
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium!
                                  .copyWith(fontSize: 14),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              fixedSize: Size(width * 0.43, height * 0.07),
                              //TODO: цвет
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
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                  ],
                ),
              )
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
