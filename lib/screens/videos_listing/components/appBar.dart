import 'package:flutter/material.dart';

// global dialogs
import 'package:app/global/dialogs/confirmLogoutDialog.dart';

// screen app bar
AppBar appBarComponent(context) {
  return AppBar(
    title: InkWell(
      onTap: () {},
      child: Image.asset(
        'assets/images/app_logo.jpg',
        width: 110,
      ),
    ),
    elevation: .5,
    backgroundColor: Colors.white,
    actions: [
      IconButton(
          onPressed: () => confirmLogoutDialog(context),
          splashColor: Colors.transparent,
          splashRadius: 27,
          icon: const Icon(
            Icons.logout_sharp,
            color: Colors.black,
            size: 23,
          ))
    ],
  );
}
