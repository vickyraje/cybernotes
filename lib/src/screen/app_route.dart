import 'package:cybernotes/src/audio_record.dart';
import 'package:cybernotes/src/constants/screen_routes.dart';
import 'package:cybernotes/src/screen/themes/light_theme.dart';
import 'package:cybernotes/src/screen/ui/login/loginPage.dart';
import 'package:cybernotes/src/screen/ui/new_note/new_note_screen.dart';
import 'package:cybernotes/src/screen/ui/notes_details/notes_details_screen.dart';
import 'package:cybernotes/src/screen/ui/open_notes/open_notes_screen.dart';
import 'package:cybernotes/src/screen/ui/signup/signup.dart';
import 'package:cybernotes/src/screen/ui/privacy/privacy_screen.dart';
import 'package:cybernotes/src/screen/ui/suggestions/suggestions_screen.dart';
import 'package:cybernotes/src/screen/ui/welcome/welcomePage.dart';
import 'package:flutter/material.dart';

class AppRoute extends StatefulWidget {
  AppRoute({Key key}) : super(key: key);

  @override
  _AppRouteState createState() => _AppRouteState();
}

class _AppRouteState extends State<AppRoute> {
  void keyboardFocusOut() {
    WidgetsBinding.instance.focusManager.primaryFocus?.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: keyboardFocusOut,
      child: MaterialApp(
        initialRoute: ScreenRoutes.LOGIN,
        // home: Container(),
        onGenerateRoute: onGenerateRoute,
        theme: lightTheme(),
      ),
    );
  }

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case ScreenRoutes.LOGIN:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: ScreenRoutes.SUGGESTIONS),
          builder: (BuildContext context) {
            return LoginPage();
          },
        );
        break;
      case ScreenRoutes.SINGUP:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: ScreenRoutes.SUGGESTIONS),
          builder: (BuildContext context) {
            return SignUpPage();
          },
        );
        break;
      case ScreenRoutes.NEW_NOTE:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: ScreenRoutes.NEW_NOTE),
          builder: (BuildContext context) {
            return NewNoteScreen(arguments: settings.arguments);
          },
        );
        break;
      case ScreenRoutes.OPEN_NOTES:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: ScreenRoutes.OPEN_NOTES),
          builder: (BuildContext context) {
            return OpenNotesScreen();
          },
        );
        break;
      case ScreenRoutes.PRIVACY:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: ScreenRoutes.PRIVACY),
          builder: (BuildContext context) {
            return PrivacyScreen();
          },
        );
        break;
      case ScreenRoutes.NOTES_DETAILS:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: ScreenRoutes.SUGGESTIONS),
          builder: (BuildContext context) {
            return NoteDetailsScreen(settings.arguments);
          },
        );
        break;
      case ScreenRoutes.SUGGESTIONS:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: ScreenRoutes.SUGGESTIONS),
          builder: (BuildContext context) {
            return SuggestionsScreen();
          },
        );
        break;
      default:
        return MaterialPageRoute<dynamic>(
          settings: const RouteSettings(name: ScreenRoutes.NEW_NOTE),
          builder: (BuildContext context) {
            return NewNoteScreen();
          },
        );
    }
  }
}
