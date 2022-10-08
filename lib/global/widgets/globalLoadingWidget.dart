import 'package:flutter/material.dart';

Widget globalLoadingWidget() => const Center(
  child: SizedBox(
    width: 30,
    height: 30,
    child: CircularProgressIndicator(
      color: Colors.white,
    ),
  ),
);