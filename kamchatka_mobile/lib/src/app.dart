import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:kamchatka/gen/colors.gen.dart';
import 'package:kamchatka/src/auth/auth_view.dart';
import 'package:kamchatka/src/auth/login/cubit/login_cubit.dart';
import 'package:kamchatka/src/auth/register/cubit/register_cubit.dart';
import 'package:kamchatka/src/data/data_repository.dart';
import 'package:kamchatka/src/views/bloc/home_navigation_bloc.dart';
import 'package:kamchatka/src/views/home/children/check_in/bloc/check_in_bloc.dart';
import 'package:kamchatka/src/views/home/view/home_view.dart';
import 'package:kamchatka/src/views/oopt/bloc/oopt_bloc.dart';
import 'settings/settings_controller.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    super.key,
    required this.settingsController,
    required this.homeNavigationBloc,
    required this.ooptBloc,
    required this.loginCubit,
    required this.registerCubit,
    required this.isLoggedIn,
    required this.dataClient,
    required this.checkInBloc,
  });

  final SettingsController settingsController;
  final HomeNavigationBloc homeNavigationBloc;
  final OoptBloc ooptBloc;
  final CheckInBloc checkInBloc;
  final LoginCubit loginCubit;
  final RegisterCubit registerCubit;
  final DataRepository dataClient;
  final bool isLoggedIn;

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;
    return RepositoryProvider(
      create: (context) => dataClient,
      child: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => homeNavigationBloc),
          BlocProvider(create: (context) => ooptBloc),
          BlocProvider(create: (context) => loginCubit),
          BlocProvider(create: (context) => registerCubit),
          BlocProvider(create: (context) => checkInBloc),
        ],
        child: ListenableBuilder(
          listenable: settingsController,
          builder: (BuildContext context, Widget? child) {
            return MaterialApp(
              localizationsDelegates: const [
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: const [
                Locale('ru', 'RU'),
              ],
              debugShowCheckedModeBanner: false,
              restorationScopeId: 'app',
              title: 'Камчатка',
              theme: lightTheme(width, height),
              darkTheme: darkTheme(width, height),
              themeMode: settingsController.themeMode,
              home: isLoggedIn ? const HomeView() : const AuthPage(),
            );
          },
        ),
      ),
    );
  }

  ThemeData lightTheme(double width, double height) {
    const baseStyle = TextStyle(color: ColorName.primary, fontFamily: 'Roboto');
    return ThemeData.from(
      useMaterial3: false,
      colorScheme: const ColorScheme(
        brightness: Brightness.light,
        primary: ColorName.primary,
        onPrimary: ColorName.onPrimary,
        secondary: ColorName.secondary,
        onSecondary: ColorName.onSecondary,
        error: Colors.red,
        onError: Colors.red,
        surface: Colors.white,
        onSurface: Colors.black,
      ),
    ).copyWith(
      disabledColor: Colors.black54,
      textTheme: const TextTheme(
        displayLarge: baseStyle,
        displayMedium: baseStyle,
        displaySmall: baseStyle,
        headlineLarge: baseStyle,
        headlineMedium: baseStyle,
        headlineSmall: baseStyle,
        bodyLarge: baseStyle,
        bodyMedium: baseStyle,
        bodySmall: baseStyle,
        titleLarge: baseStyle,
        titleMedium: baseStyle,
        titleSmall: baseStyle,
        labelLarge: baseStyle,
        labelMedium: baseStyle,
        labelSmall: baseStyle,
      ),
      inputDecorationTheme: InputDecorationTheme(
          labelStyle: baseStyle.copyWith(
        color: Colors.black.withAlpha(80),
        fontSize: 14,
      )),
      appBarTheme: const AppBarTheme(
          titleTextStyle: TextStyle(
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            color: Colors.black,
            fontSize: 18,
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          foregroundColor: Colors.black),
      elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
        textStyle: baseStyle.copyWith(color: Colors.white),
      )),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
            fixedSize: Size(width * 0.9, height * 0.05),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            fixedSize: Size(width * 0.9, height * 0.07),
            side: const BorderSide(color: Colors.green),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12))),
      ),
    );
  }

  ThemeData darkTheme(double width, double height) {
    return ThemeData.from(
      useMaterial3: false,
      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary: Colors.green,
          onPrimary: Colors.blue,
          secondary: Colors.black,
          onSecondary: Colors.black,
          error: Colors.black,
          onError: Colors.black,
          background: Colors.black,
          onBackground: Colors.black,
          surface: Colors.black,
          onSurface: Colors.black),
    ).copyWith(
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
            fixedSize: Size(width * 0.9, height * 0.07),
            side: const BorderSide(color: Colors.green),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16))),
      ),
    );
  }
}
