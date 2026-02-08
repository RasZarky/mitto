import 'package:go_router/go_router.dart';
import 'package:mitto/presentation/get_started/get_started_page.dart';
import 'package:mitto/presentation/splash/splash_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String getStarted = '/get-started';

  static final router = GoRouter(
    debugLogDiagnostics: true,
    initialLocation: splash,
    routes: [
      GoRoute(
        path: splash,
        builder: (context, state) => const SplashPage(),
      ),
      GoRoute(
        path: getStarted,
        builder: (context, state) => const GetStartedPage(),
      ),
    ],
  );
}
