import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';
import 'core/theme/app_theme.dart';
import 'core/theme/theme_cubit.dart';
import 'core/language/language_cubit.dart';
import 'features/tasks/presentation/cubit/task_cubit.dart';
import 'features/tasks/presentation/pages/home_page.dart';
import 'features/weather/presentation/cubit/weather_cubit.dart';
import 'injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await EasyLocalization.ensureInitialized();

  final injectionContainer = InjectionContainer();
  await injectionContainer.init();

  runApp(
    EasyLocalization(
      supportedLocales: const [Locale('en'), Locale('ar')],
      path: 'assets/translations',
      fallbackLocale: const Locale('en'),
      child: TaskFlowApp(injectionContainer: injectionContainer),
    ),
  );
}

class TaskFlowApp extends StatelessWidget {
  final InjectionContainer injectionContainer;

  const TaskFlowApp({super.key, required this.injectionContainer});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ThemeCubit>(create: (_) => injectionContainer.themeCubit),
        BlocProvider<LanguageCubit>(
          create: (_) => injectionContainer.languageCubit,
        ),
        BlocProvider<TaskCubit>(create: (_) => injectionContainer.taskCubit),
        BlocProvider<WeatherCubit>(
          create: (_) => injectionContainer.weatherCubit,
        ),
      ],
      child: BlocBuilder<LanguageCubit, Locale>(
        builder: (context, locale) {
          return BlocBuilder<ThemeCubit, ThemeMode>(
            builder: (context, themeMode) {
              return MaterialApp(
                title: 'TaskFlow',
                debugShowCheckedModeBanner: false,
                theme: AppTheme.lightTheme(),
                darkTheme: AppTheme.darkTheme(),
                themeMode: themeMode,
                localizationsDelegates: context.localizationDelegates,
                supportedLocales: context.supportedLocales,
                locale: locale,
                home: const HomePage(),
              );
            },
          );
        },
      ),
    );
  }
}
