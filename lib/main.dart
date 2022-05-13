import 'package:flutter/material.dart';
import 'package:qr_reader/providers/scan_provider.dart';
import 'package:qr_reader/providers/ui_state.dart';

import 'package:qr_reader/screens/screens.dart';
import 'package:provider/provider.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  MultiProvider(

      providers: [
        ChangeNotifierProvider(create: (_) => UIstate()),
        ChangeNotifierProvider(create: (_) => ScanListProvider())
        
      ],

      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'QR Lector',
        initialRoute: 'home',
        routes: {
          'home'  : (context) => const HomePage(),
          'map'   : (context) => const MapPage(),
        },
        theme: ThemeData(
          primarySwatch: Colors.green,
          floatingActionButtonTheme: const FloatingActionButtonThemeData(
            backgroundColor: Colors.green
          )
        ),
      ),
    );
  }
}