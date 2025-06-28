import 'package:flutter/material.dart';
import 'package:flutter_rebuildable/flutter_rebuildable.dart';

bool isDark = false;

void main() {
  runApp(const TestApp());
}

class TestApp extends StatelessWidget {
  const TestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RebuildableApp(
      child: Builder(
        builder: (context) {
          return MaterialApp(
            theme: isDark ? ThemeData.dark() : ThemeData.light(),
            home: Scaffold(body: TestPage()),
          );
        },
      ),
    );
  }
}

class TestPage extends StatelessWidget {
  const TestPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Wrap(
        children: [
          TextButton(
            onPressed: () {
              isDark = false;
              RebuildableApp.rebuild(); // like this
            },
            child: Text("Light"),
          ),
          TextButton(
            onPressed: () {
              isDark = true;
              RebuildableApp.rebuild(); // like this
            },
            child: Text("Dark"),
          ),
        ],
      ),
    );
  }
}
