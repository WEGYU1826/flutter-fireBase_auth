import 'package:flutter/material.dart';

class Helpers {
  static void showErrorDialog(String? message, BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text(
          'Error',
          textAlign: TextAlign.center,
          style: TextStyle(color: Colors.red),
        ),
        content: Text(
          message ?? 'Some Error!',
          textAlign: TextAlign.center,
        ),
        actions: [
          Align(
            alignment: Alignment.center,
            child: ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all(Colors.transparent),
                elevation: MaterialStateProperty.all(0.0),
              ),
              child: Text(
                'Ok',
                style: TextStyle(color: Theme.of(context).primaryColor),
              ),
              onPressed: () {
                Navigator.of(ctx).pop();
              },
            ),
          )
        ],
      ),
    );
  }
}
