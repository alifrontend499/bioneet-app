import 'package:flutter/material.dart';

// styles
import 'package:app/global/dialogs/style.dart';

// routes
import 'package:app/utilities/routing/routing_consts.dart';

// package | firebase
import 'package:firebase_auth/firebase_auth.dart';

// package | load
import 'package:load/load.dart';

Future<void> _signOut(context) async {
  // loading
  showLoadingDialog();

  // loggin user out
  await FirebaseAuth.instance.signOut();

  // loading
  hideLoadingDialog();

  // navigation to login page and remove previous history
  Navigator.pushNamedAndRemoveUntil(context, loginScreenRoute, (Route<dynamic> route) => false);
}

void confirmLogoutDialog(context) => showDialog(
  context: context,
  builder: (context) => AlertDialog(
    titlePadding: const EdgeInsets.only(
        top: 20, bottom: 10, left: 20, right: 20),
    contentPadding: const EdgeInsets.only(
        top: 0, bottom: 0, left: 20, right: 20),
    actionsPadding: const EdgeInsets.only(
        top: 15, bottom: 15, left: 13, right: 13),
    title: const Text(
      "Logout",
      style: logoutDialogTitleStyle
    ),
    content: const Text(
      "Are you sure you want to logout?",
      style: logoutDialogContentStyle,
    ),
    actions: [
      InkWell(
        onTap: () => Navigator.pop(context),
        borderRadius: BorderRadius.circular(5),
        child: const Padding(
          padding: EdgeInsets.all(7),
          child: Text(
            'Cancel',
            style: logoutDialogActionButtonStyle,
          ),
        ),
      ),
      InkWell(
        onTap: () => _signOut(context),
        borderRadius: BorderRadius.circular(5),
        child: const Padding(
          padding: EdgeInsets.all(7),
          child: Text(
            'Confirm',
            style: logoutDialogActionButtonStyle,
          ),
        ),
      ),
    ],
  ),
);