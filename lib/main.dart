import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

// routing
import 'package:app/utilities/routing/routing_consts.dart';

// -- routing
import 'package:app/utilities/routing/routing.dart' as router;

// package | firebase
import 'package:firebase_core/firebase_core.dart';
import 'package:app/firebase_options.dart';

// firebase auth
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// google fonts
import 'package:google_fonts/google_fonts.dart';

// package | load
import 'package:load/load.dart';

// global widget
import 'package:app/global/widgets/globalLoadingWidget.dart';

// package | riverpod
import 'package:riverpod/riverpod.dart';

void main() async {
  // initializing firebase
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(LoadingProvider(
    themeData: LoadingThemeData(
      loadingBackgroundColor: Colors.transparent,
    ),
    loadingWidgetBuilder: ((context, data) {
      return globalLoadingWidget();
    }),
    child: const ProviderScope(
      child: MyApp(),
    ),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations(
        [DeviceOrientation.portraitUp]); // setting default orientation

    return MaterialApp(
        title: 'Video Player',
        theme: ThemeData(
            // brightness: Brightness.dark,
            splashColor: Colors.transparent,
            textTheme:
                GoogleFonts.poppinsTextTheme(Theme.of(context).textTheme)),
        onGenerateRoute: router.generatedRoutes,
        initialRoute: FirebaseAuth.instance.currentUser == null
            ? loginScreenRoute
            : mainContentScreenRoute);
  }
}
