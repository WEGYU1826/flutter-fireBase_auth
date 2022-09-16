import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase_auth/src/providers/auth.providers.dart';
import 'package:flutter_firebase_auth/src/utils/helpers.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);
  static const routeName = '/home_screen';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  AuthProvider? _authProvider;
  bool _onInit = true;

  Future signOut() async {
    try {
      // debugPrint("Current User ${_authProvider!.getUser()}");

      await _authProvider!.signOut();
    } on FirebaseAuthException catch (e) {
      Helpers.showErrorDialog(e.message, context);
    } catch (e) {
      Helpers.showErrorDialog("Unable to Sign out", context);
    }
  }

  Future resetPassword() async {
    try {
      // debugPrint("Current User ${_authProvider!.getUser()}");
      final user = _authProvider!.user;
      await _authProvider!.resetPassword(email: user.email);
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: const Text("Reset Password"),
        content: const Text("Please check your email!"),
        actions: [
          TextButton(
              onPressed: () {
                // some logic!
                Navigator.of(context).pop();
              },
              child: const Text('Ok'))
        ],
      );

      // show the dialog
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } on FirebaseAuthException catch (e) {
      Helpers.showErrorDialog(e.message, context);
    } catch (e) {
      Helpers.showErrorDialog("Unable to Sign out", context);
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    if (_onInit) {
      _authProvider = Provider.of<AuthProvider>(context);
    }
    _onInit = false;
  }

  @override
  Widget build(BuildContext context) {
    // UserModel? user = _authProvider!.getUser();
    // debugPrint("User Currentlly: ${user}");

    debugPrint("User Now ${FirebaseAuth.instance.currentUser}");
    final user = _authProvider!.user;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text('User Info: '),
            const Text(
              'User Id: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('${user!.uid.substring(0, 6)}'),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'Email: ',
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            Text('${user.email}'),
            const SizedBox(
              height: 50,
            ),
            const Divider(),
            TextButton(
              onPressed: signOut,
              child: const Text('Sign Out'),
            ),
            const Divider(),
            SizedBox(
              child: TextButton(
                onPressed: resetPassword,
                child: const Text('Change Password'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
