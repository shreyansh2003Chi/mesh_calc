import 'package:flutter/material.dart';
import 'package:measurements/pages/home_page.dart';
import 'package:measurements/providers/chain_link_provider.dart';
import 'package:measurements/providers/home_page_provider.dart';
import 'package:measurements/providers/material_selection_bottom_sheet_provider.dart';
import 'package:measurements/providers/weight_per_role_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChainLinkProvider()),
        ChangeNotifierProvider(create: (_) => MeshHomePageProvider()),
        ChangeNotifierProvider(create: (_) => WeightPerRoleProvider()),
        ChangeNotifierProvider(create: (_) => MaterialSelectionBottomSheetProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MeshHomePage());
  }
}
