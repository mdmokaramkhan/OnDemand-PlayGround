import 'package:chatbot/screens/chat_screen.dart';
import 'package:chatbot/screens/home_page.dart';
import 'package:chatbot/screens/login_page.dart';
import 'package:go_router/go_router.dart';

GoRouter appRouter(bool isLoggedIn) {
  return GoRouter(
    initialLocation: isLoggedIn ? '/home' : '/log-in',
    routes: [
      GoRoute(
        path: '/log-in',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/home',
        builder: (context, state) => const MyHomePage(
          title: 'OnDemand PlayGround',
        ),
      ),
      GoRoute(
        path: '/chat-screen',
        name: '/chat-screen',
        builder: (context, state) {
          final String? agentIdsParam = state.uri.queryParameters['agentIds'];
          final List<String>? agentIds = agentIdsParam?.split(',');
          return ChatScreen(
            title: state.uri.queryParameters['title'],
            icon: state.uri.queryParameters['icon'],
            desc: state.uri.queryParameters['desc'],
            agentIds: agentIds,
          );
        },
      ),
    ],
  );
}
