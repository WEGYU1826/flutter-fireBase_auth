import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/src/enums.dart';
import 'package:flutter_firebase_auth/src/home.screen.dart';
import 'package:flutter_firebase_auth/src/providers/auth.providers.dart';
import 'package:flutter_firebase_auth/src/routes/routes.dart';
import 'package:flutter_firebase_auth/src/screens/auth.screen.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => AuthProvider(),
        ),
      ],
      builder: (context, snapshot) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Flutter Firebase Authentication',
          home: const WidgetTree(),
          routes: routes,
        );
      },
    );
  }
}

class WidgetTree extends StatelessWidget {
  const WidgetTree({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final AuthProvider authProvider = Provider.of<AuthProvider>(context);
    // if (authProvider.getUser() == null) {
    //   authProvider.handleInitialSetUp();
    // }

    return StreamBuilder(
      stream: authProvider.getAuthState(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const HomeScreen();
        } else {
          return AuthScreen();
        }
      },
    );
  }
}
