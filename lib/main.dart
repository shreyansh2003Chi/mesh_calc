import 'package:flutter/material.dart';
import 'package:measurements/pages/splash_screen.dart';
import 'package:measurements/providers/chain_link_provider.dart';
import 'package:measurements/providers/expanded_metal_provider/expanded_metal_provider.dart';
import 'package:measurements/providers/hexagonal_wiremesh_provider/hexagonal_wiremesh_provider.dart';
import 'package:measurements/providers/home_page_provider.dart';
import 'package:measurements/providers/material_selection_bottom_sheet_provider.dart';
import 'package:measurements/providers/perforated_sheet_provider/open_area_calculation_provider/capsule_center_to_center_hole_provider.dart';
import 'package:measurements/providers/perforated_sheet_provider/open_area_calculation_provider/capsule_staggered_triangular_hole_provider.dart';
import 'package:measurements/providers/perforated_sheet_provider/open_area_calculation_provider/hexagonal_staggered_triangular_hole_provider.dart';
import 'package:measurements/providers/perforated_sheet_provider/open_area_calculation_provider/rectangular_center_to_center_hole_provider.dart';
import 'package:measurements/providers/perforated_sheet_provider/open_area_calculation_provider/rectangular_staggered_triangular_hole_provider.dart';
import 'package:measurements/providers/perforated_sheet_provider/open_area_calculation_provider/round_45_staggered_triangular_hole_provider.dart';
import 'package:measurements/providers/perforated_sheet_provider/open_area_calculation_provider/round_60_staggered_triangular_hole_provider.dart';
import 'package:measurements/providers/perforated_sheet_provider/open_area_calculation_provider/round_90_center_to_center_hole_provider.dart';
import 'package:measurements/providers/perforated_sheet_provider/open_area_calculation_provider/square_center_to_center__hole_provider.dart';
import 'package:measurements/providers/perforated_sheet_provider/open_area_calculation_provider/square_staggered_triangular_hole_provider.dart';
import 'package:measurements/providers/perforated_sheet_provider/perforated_sheet_provider.dart';
import 'package:measurements/providers/welded_wire_mesh_provider.dart';
import 'package:measurements/providers/wire_mesh/dutch_woven_wire_mesh_provider.dart';
import 'package:measurements/providers/wire_mesh/wire_mesh_provider.dart';
import 'package:provider/provider.dart';

import 'providers/perforated_sheet_provider/open_area_calculation_provider/open_area_calculation_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChainLinkProvider()),
        ChangeNotifierProvider(create: (_) => HomePageProvider()),
        ChangeNotifierProvider(create: (_) => WeldedWireMeshProvider()),
        ChangeNotifierProvider(create: (_) => MaterialSelectionBottomSheetProvider()),
        ChangeNotifierProvider(create: (_) => ExpandedMetalProvider()),
        ChangeNotifierProvider(create: (_) => HexagonalWiremeshProvider()),
        ChangeNotifierProvider(create: (_) => PerforatedSheetProvider()),
        ChangeNotifierProvider(create: (_) => OpenAreaCalculationProvider()),
        ChangeNotifierProvider(create: (_) => CapsuleCenterToCenterHoleProvider()),
        ChangeNotifierProvider(create: (_) => CapsuleStaggeredTriangularHoleProvider()),
        ChangeNotifierProvider(create: (_) => HexagonalStaggeredTriangularHoleProvider()),
        ChangeNotifierProvider(create: (_) => RectangularCenterToCenterHoleProvider()),
        ChangeNotifierProvider(create: (_) => RectangularStaggeredTriangularHoleProvider()),
        ChangeNotifierProvider(create: (_) => Round45StaggeredTriangularHoleProvider()),
        ChangeNotifierProvider(create: (_) => Round60StaggeredTriangularHoleProvider()),
        ChangeNotifierProvider(create: (_) => Round90CenterToCenterHoleProvider()),
        ChangeNotifierProvider(create: (_) => SquareCenterToCenterHoleProvider()),
        ChangeNotifierProvider(create: (_) => SquareStaggeredTriangularHoleProvider()),
        ChangeNotifierProvider(create: (_) => WireMeshProvider()),
        ChangeNotifierProvider(create: (_) => DutchWovenWireMeshProvider()),
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
