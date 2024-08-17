import 'package:flutter/material.dart';
import 'package:mousike/responsive/mobile_scaffold.dart'; 
import 'package:mousike/responsive/tablet_scaffold.dart';
import 'package:mousike/responsive/desktop_scaffold.dart';
import 'package:mousike/responsive/responsive_layout.dart';
import 'package:mousike/themes/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: const ResponsiveLayout(
        mobileScaffold: MobileScaffold(),
        tabletScaffold: TabletScaffold(),
        desktopScaffold: DesktopScaffold(),
      ),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
