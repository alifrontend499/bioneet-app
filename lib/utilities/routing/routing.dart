import 'package:flutter/material.dart';

// -- all routes consts
import 'package:app/utilities/routing/routing_consts.dart';

// -- screens | all
import 'package:app/screens/main_content/main_content_index.dart';

import 'package:app/screens/auth/login/login_index.dart';
import 'package:app/screens/auth/login/screens/otp/otp_index.dart';

Route<dynamic> generatedRoutes(RouteSettings settings) {
  switch(settings.name) {
    case loginScreenRoute:
      return MaterialPageRoute(builder: (context) => const LoginScreen());
    case otpScreenRoute:
      return MaterialPageRoute(builder: (context) => const OTPScreen());

    case mainContentScreenRoute:
      return MaterialPageRoute(builder: (context) => const MainContentScreen());

    default:
      return MaterialPageRoute(builder: (context) => const MainContentScreen());
  }
}