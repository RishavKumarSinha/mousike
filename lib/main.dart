import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mousike/models/playlist_provider.dart';
import 'package:mousike/responsive/mobile_scaffold.dart'; 
import 'package:mousike/responsive/tablet_scaffold.dart';
import 'package:mousike/responsive/desktop_scaffold.dart';
import 'package:mousike/responsive/responsive_layout.dart';
import 'package:mousike/themes/theme_provider.dart';
import 'package:provider/provider.dart';
import 'package:mousike/models/spotify_service.dart';

void main() {
  final spotifyService = SpotifyService(
    clientId: '8b2ade8c1d404e5f9d0e003c2e7c3ab0',
    clientSecret: '1d0863f8adc844d2af2df60634b41dfe',
  );
  
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => PlaylistProvider()),
        Provider(create: (context) => spotifyService),  // Add SpotifyService provider
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: ResponsiveLayout(
        mobileScaffold: const MobileScaffold(),
        tabletScaffold: const TabletScaffold(),
        desktopScaffold: DesktopScaffold(),
      ),
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
