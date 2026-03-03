import 'package:flutter/material.dart';
import 'package:measurements/pages/splash_screen.dart';
import 'package:measurements/providers/chain_link_provider.dart';
import 'package:measurements/providers/expanded_metal_provider/expanded_metal_provider.dart';
import 'package:measurements/providers/home_page_provider.dart';
import 'package:measurements/providers/material_selection_bottom_sheet_provider.dart';
import 'package:measurements/providers/welded_wire_mesh_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChainLinkProvider()),
        ChangeNotifierProvider(create: (_) => HomePageProvider()),
        ChangeNotifierProvider(create: (_) => WeldedWireMeshProvider()),
        ChangeNotifierProvider(create: (_) => MaterialSelectionBottomSheetProvider()),
        ChangeNotifierProvider(create: (_) => ExpandedMetalProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
