import 'dart:html' as html;
import 'package:flutter/material.dart';

void downloadResume(BuildContext context) {
  html.AnchorElement(href: 'assets/assets/Devashish_Singh_Resume.pdf')
    ..setAttribute('download', 'Devashish_Singh_Resume.pdf')
    ..click();
}
