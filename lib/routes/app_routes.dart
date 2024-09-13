import 'package:chatbot/screens/chat_screen.dart';
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
      GoRoute(
        path: '/chat-screen',
        builder: (context, state) => const ChatScreen(title: 'New Chat'),
      ),
    ],
  );
}
