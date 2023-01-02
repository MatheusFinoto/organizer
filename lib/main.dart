import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:get_it/get_it.dart';
import 'package:mobx/mobx.dart';
import 'package:organizer/src/view/home/home_screen.dart';
import 'package:page_transition/page_transition.dart';
import 'package:responsive_framework/responsive_framework.dart';

import 'src/stores/base_store.dart';

import 'src/utils/theme.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // setUrlStrategy(PathUrlStrategy());
  setupManager();
  runApp(const MyApp());
}

void setupManager() async {
  GetIt.I.registerSingleton(BaseStore());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final BaseStore baseStore = GetIt.I<BaseStore>();

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    reaction((_) => baseStore.themeDark, (bool value) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Organizer',
      theme: darkTheme,
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('pt', 'BR'),
      ],
      builder: (context, widget) => ResponsiveWrapper.builder(
        BouncingScrollWrapper.builder(context, widget!),
        minWidth: 280,
        defaultScale: true,
        breakpoints: const [
          ResponsiveBreakpoint.resize(280, name: MOBILE),
          ResponsiveBreakpoint.resize(800, name: TABLET),
          ResponsiveBreakpoint.resize(1200, name: DESKTOP),
        ],
      ),
      onGenerateRoute: ((settings) {
        switch (settings.name) {
          case '/':
            return PageTransition(
              child: const HomeScreen(),
              type: PageTransitionType.fade,
              settings: settings,
            );

          default:
            return PageTransition(
              child: Container(),
              type: PageTransitionType.fade,
              settings: settings,
            );
        }
      }),
      initialRoute: '/',
    );
  }
}
