import 'package:flutter/material.dart';
import 'package:measurements/pages/home_screen.dart';
import 'package:measurements/providers/chain_link_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(create: (_) => ChainLinkProvider(), child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: const ChainLinkScreen());
  }
}
