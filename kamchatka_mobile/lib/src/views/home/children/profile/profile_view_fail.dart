import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kamchatka/src/views/bloc/home_navigation_bloc.dart';
import 'package:kamchatka/src/views/widgets/home_bottom_nav_bar.dart';

class ProfileViewFail extends StatelessWidget {
  const ProfileViewFail({super.key, required this.bottomKey});

  final Key bottomKey;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Профиль'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('Не удалось получить данные о профиле'),
            const Text(
              'Проверьте подключение к интернету и попробуйте снова',
              textAlign: TextAlign.center,
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<HomeNavigationBloc>().add(const PageTapped(2));
                },
                child: Text(
                  'Попробовать снова',
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium!
                      .copyWith(color: Colors.white),
                )),
          ],
        )),
      ),
      bottomNavigationBar: HomeBottomNavBar(key: bottomKey),
    );
  }
}
