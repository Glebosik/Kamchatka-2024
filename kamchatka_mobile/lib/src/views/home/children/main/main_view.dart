import 'package:flutter/material.dart';
import 'package:kamchatka/gen/assets.gen.dart';
import 'package:kamchatka/src/models/oopt.dart';
import 'package:kamchatka/src/views/home/children/main/widgets/gradient_button.dart';
import 'package:kamchatka/src/views/home/children/main/widgets/search_bar.dart';
import 'package:kamchatka/src/views/home/children/main/widgets/text_over_image_side.dart';
import 'package:kamchatka/src/views/widgets/home_bottom_nav_bar.dart';

import 'widgets/widgets.dart';

class MainView extends StatelessWidget {
  const MainView({
    super.key,
    required this.bottomKey,
    required this.oopts,
  });

  final List<Oopt> oopts;
  final Key bottomKey;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Scaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            MySearchBar(
              oopts: oopts,
            ),
            Spacer(),
            SizedBox(height: height * 0.18, child: const ResourcesListView()),
            const SituationWidget(),
            Spacer(),
            TextOverImageSide(
              image: Assets.images.bear.image(),
              title: 'Какой парк посетить?',
              subtitle:
                  'Камчатский край богат заповедниками и природными охраняемыми объектами, каждый любитель природы найдет свой.',
            ),
            const SizedBox(height: 12),
            TextOverImageSide(
              image: Assets.images.bear2.image(),
              title: 'Где остановиться?',
              subtitle:
                  'Подберем для вас подходящее жилье, чтобы  Вы могли не отвлекаться на лишнее и наслаждаться своим путешесвием в полной мере.',
              fromRight: false,
            ),
            const Spacer(),
            const GradientButton(),
            const SizedBox(height: 12),
          ],
        ),
      ),
      bottomNavigationBar: HomeBottomNavBar(key: bottomKey),
    );
  }
}
