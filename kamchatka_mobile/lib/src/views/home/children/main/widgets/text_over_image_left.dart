import 'package:flutter/material.dart';
import 'package:kamchatka/gen/colors.gen.dart';

class TextOverImageLeft extends StatelessWidget {
  const TextOverImageLeft({
    super.key,
    required this.image,
    this.onTap,
    required this.title,
    required this.subtitle,
  });

  final Image image;
  final String title;
  final String subtitle;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    return Padding(
      padding: const EdgeInsets.only(left: 16, right: 16),
      child: GestureDetector(
        onTap: onTap,
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                color: ColorName.cardBackground,
                height: 100,
                alignment: Alignment.centerLeft,
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Align(
                alignment: Alignment.centerRight,
                child: SizedBox(
                  height: 100,
                  child: image,
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(16),
              child: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(colors: [
                    ColorName.cardBackground,
                    ColorName.cardBackground.withOpacity(.66),
                    ColorName.cardBackground.withOpacity(.33),
                    Colors.transparent
                  ], stops: const [
                    0.1,
                    0.4,
                    0.7,
                    1
                  ], begin: Alignment.center, end: Alignment.centerRight),
                ),
                height: 100,
                alignment: Alignment.center,
              ),
            ),
            SizedBox(
              height: 100,
              width: width * 0.6,
              child: ListTile(
                title: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .bodyLarge!
                      .copyWith(fontSize: 16),
                ),
                subtitle: Text(
                  subtitle,
                  style: Theme.of(context)
                      .textTheme
                      .bodySmall!
                      .copyWith(color: Colors.black),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
