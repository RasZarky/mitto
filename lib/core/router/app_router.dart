import 'package:go_router/go_router.dart';
import 'package:mitto/presentation/get_started/get_started_page.dart';
import 'package:mitto/presentation/register/choose_country_page.dart';
import 'package:mitto/presentation/register/create_password_page.dart';
import 'package:mitto/presentation/register/sign_up_page.dart';
import 'package:mitto/presentation/register/verification_page.dart';
import 'package:mitto/presentation/splash/splash_page.dart';

class AppRouter {
  static const String splash = '/';
  static const String getStarted = '/get-started';
  static const String signUp = '/sign-up';
  static const String verification = '/verification';
  static const String chooseCountry = '/choose-country';
  static const String createPassword = '/create-password';

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
      GoRoute(
        path: signUp,
        builder: (context, state) => const SignUpPage(),
      ),
      GoRoute(
        path: verification,
        builder: (context, state) => const VerificationPage(),
      ),
      GoRoute(
        path: chooseCountry,
        builder: (context, state) => const ChooseCountryPage(),
      ),
      GoRoute(
        path: createPassword,
        builder: (context, state) => const CreatePasswordPage(),
      ),
    ],
  );
}
