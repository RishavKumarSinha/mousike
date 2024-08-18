import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mousike/responsive/desktop_scaffold.dart';
import 'package:mousike/responsive/mobile_scaffold.dart';
import 'package:mousike/responsive/responsive_layout.dart';
import 'package:mousike/responsive/tablet_scaffold.dart';
import 'package:mousike/themes/theme_provider.dart';
import 'package:provider/provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.inversePrimary),
          onPressed: () {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                builder: (context) => ResponsiveLayout(
                  mobileScaffold: MobileScaffold(),
                  tabletScaffold: TabletScaffold(),
                  desktopScaffold: DesktopScaffold(),
                ),
              ),
            );
          },
        ),
        title: Text('S E T T I N G S', style: TextStyle(color: Theme.of(context).colorScheme.inversePrimary)),
      ),
      body: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(12),
        ),
        padding: const EdgeInsets.all(16),
        margin: const EdgeInsets.all(25),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Dark Mode',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
            ),
            CupertinoSwitch(value: Provider.of<ThemeProvider>(context, listen: false).isDarkMode, onChanged: (value) => Provider.of<ThemeProvider>(context, listen: false).toggleTheme()),
          ],
        ),
      ),
    );
  }
}