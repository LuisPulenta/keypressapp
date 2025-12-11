import 'package:flutter/material.dart';

import '../models/models.dart';

Widget getImage({required User user, double? width, double? height}) {
  return Image.asset(
    'assets/logo.png',
    width: width ?? 300,
    height: height ?? 200,
  );
}
