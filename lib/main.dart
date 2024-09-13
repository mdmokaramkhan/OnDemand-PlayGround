import 'package:chatbot/providers/theme_provider.dart';
import 'package:chatbot/routes/app_routes.dart';
import 'package:chatbot/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences prefs = await SharedPreferences.getInstance();
  runApp(MyApp(prefs: prefs));
}

class MyApp extends StatefulWidget {
  final SharedPreferences prefs;

  const MyApp({super.key, required this.prefs});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late final GoRouter _router;
  bool isLoggedIn = false;

  @override
  void initState() {
    super.initState();
    isLoggedIn = widget.prefs.getBool('isLogged') ?? false;
    _router = appRouter(isLoggedIn);
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider(widget.prefs)),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp.router(
            title: 'OnDemand PlayGroud',
            theme: AppTheme.lightTheme,
            darkTheme: AppTheme.darkTheme,
            themeMode: themeProvider.themeMode,
            routerConfig: _router,
            debugShowCheckedModeBanner: false,
            builder: (context, child) {
              final mediaQuery = MediaQuery.of(context);
              final scale = mediaQuery.textScaler.clamp(
                minScaleFactor: widget.prefs.getDouble('textScale') ?? 1.0,
                maxScaleFactor: 2,
              );
              return MediaQuery(
                data: mediaQuery.copyWith(textScaler: scale),
                child: child!,
              );
            },
          );
        },
      ),
    );
  }
}
