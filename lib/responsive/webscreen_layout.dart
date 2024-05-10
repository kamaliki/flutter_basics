import 'package:flutter/material.dart';

class WebScreenLayout extends StatelessWidget {
  const WebScreenLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Web Screen Layout'),
      ),
      body: const Center(
        child: Text(
          'This is a web screen layout',
          style: TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}
