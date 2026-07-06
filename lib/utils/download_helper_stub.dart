import 'package:flutter/material.dart';

void downloadResume(BuildContext context) {
  ScaffoldMessenger.of(context).showSnackBar(
    const SnackBar(
      content: Text('Downloading resume is only supported on Web currently.'),
    ),
  );
}
