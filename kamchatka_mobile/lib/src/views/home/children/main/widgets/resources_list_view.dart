import 'package:flutter/material.dart';
import 'package:kamchatka/gen/assets.gen.dart';

import 'widgets.dart';

class ResourcesListView extends StatelessWidget {
  const ResourcesListView({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return ListView(
      shrinkWrap: true,
      scrollDirection: Axis.horizontal,
      children: [
        SizedBox(width: width * 0.05),
        TextOverImage(
          image: Assets.images.image1
              .image(width: width, height: height, fit: BoxFit.cover),
          text:
              'Сохранить природную составляющую при благоустройстве сквера на Войцешека призвал глава Камчатки',
          link:
              'https://eco.kamgov.ru/news/sohranit-prirodnuu-sostavlausuu-pri-blagoustrojstve-skvera-na-vojceseka-prizval-glava-kamcatki-14469/',
        ),
        SizedBox(width: width * 0.02),
        TextOverImage(
          image: Assets.images.image2
              .image(width: width, height: height, fit: BoxFit.cover),
          text:
              'Международный день эколога отметили в Петропавловске-Камчатском',
          link:
              'https://eco.kamgov.ru/news/mezdunarodnyj-den-ekologa-otmetili-v-petropavlovske-kamcatskom-14468/',
        ),
        SizedBox(width: width * 0.02),
        TextOverImage(
          image: Assets.images.image3
              .image(width: width, height: height, fit: BoxFit.cover),
          text: 'На Камчатке стартовал турнир по «Чистым Играм»',
          link:
              'https://eco.kamgov.ru/news/na-kamcatke-startoval-turnir-po-cistym-igram-14467/',
        ),
        SizedBox(width: width * 0.02),
        TextOverImage(
          image: Assets.images.image4
              .image(width: width, height: height, fit: BoxFit.cover),
          text:
              'Порядка сотни человек стали дипломированными специалистами заповедного дела',
          link:
              'https://eco.kamgov.ru/news/poradka-sotni-celovek-stali-diplomirovannymi-specialistami-zapovednogo-dela-14466/',
        ),
        SizedBox(width: width * 0.02),
        TextOverImage(
          image: Assets.images.image5
              .image(width: width, height: height, fit: BoxFit.cover),
          text:
              'Камчатский водоканал выпустил в ручей Зеленовский почти 7 тысяч мальков кеты',
          link:
              'https://eco.kamgov.ru/news/kamcatskij-vodokanal-vypustil-v-rucej-zelenovskij-pocti-7-tysac-malkov-kety-14465/',
        ),
        SizedBox(width: width * 0.05),
      ],
    );
  }
}
