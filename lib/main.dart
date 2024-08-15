import 'package:flutter/material.dart';
import 'package:mousike/responsive/mobile_scaffold.dart'; 
import 'package:mousike/responsive/tablet_scaffold.dart';
import 'package:mousike/responsive/desktop_scaffold.dart';
import 'package:mousike/responsive/responsive_layout.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveLayout(
        mobileScaffold: MobileScaffold(),
        tabletScaffold: TabletScaffold(),
        desktopScaffold: DesktopScaffold(),
      ),
    );
  }
}
