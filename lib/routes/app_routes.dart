import 'package:chatbot/screens/home_page.dart';
import 'package:go_router/go_router.dart';

GoRouter appRouter(bool isLoggedIn) {
  return GoRouter(
    initialLocation: '/home',
    routes: [
      GoRoute(
        path: '/home',
        builder: (context, state) => const MyHomePage(
          title: 'OnDemand PlayGround',
        ),
      ),
    ],
  );
}
