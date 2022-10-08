import 'package:flutter/material.dart';

// global dialogs
import 'package:app/global/dialogs/confirmLogoutDialog.dart';

// screen app bar
SliverAppBar silverAppBarComponent(context) {
  return SliverAppBar(
    floating: true,
    leadingWidth: 120,
    leading: Padding(
      padding: const EdgeInsets.only(left: 15),
      child: Image.asset(
        'assets/images/app_logo.jpg',
      ),
    ),
    backgroundColor: Colors.white,
    actions: [
      Padding(
        padding: const EdgeInsets.only(right: 5),
        child: IconButton(
            onPressed: () => confirmLogoutDialog(context),
            splashRadius: 27,
            icon: const Icon(
              Icons.logout_sharp,
              color: Colors.black,
              size: 23,
            )),
      ),
    ],
  );
}
