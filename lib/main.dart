import 'package:flutter/material.dart';
import 'package:measurements/pages/splash_screen.dart';
import 'package:measurements/providers/chain_link_provider.dart';
import 'package:measurements/providers/expanded_metal_provider/expanded_metal_provider.dart';
import 'package:measurements/providers/hexagonal_wiremesh_provider/hexagonal_wiremesh_provider.dart';
import 'package:measurements/providers/home_page_provider.dart';
import 'package:measurements/providers/global_view_provider.dart';
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
import 'package:measurements/providers/wire_mesh/dutch_woven_wire_mesh_providers/dutch_woven_wire_mesh_provider.dart';
import 'package:measurements/providers/wire_mesh/dutch_woven_wire_mesh_providers/weight_per_od_provider.dart';
import 'package:measurements/providers/wire_mesh/dutch_woven_wire_mesh_providers/weight_per_roll_provider.dart';
import 'package:measurements/providers/wire_mesh/open_area_calculations_providers/harp_wire_mesh_provider.dart';
import 'package:measurements/providers/wire_mesh/open_area_calculations_providers/rectangular_wire_mesh_provider.dart';
import 'package:measurements/providers/wire_mesh/open_area_calculations_providers/square_wire_mesh_provider.dart';
import 'package:measurements/providers/wire_mesh/open_area_calculations_providers/open_area_calculations_provider.dart';
import 'package:measurements/providers/wire_mesh/weight_calculation_providers/weight_calculation_provider.dart';
import 'package:measurements/providers/wire_mesh/wire_required_provider.dart';
import 'package:measurements/providers/wire_mesh/mesh_opening_pitch_calculations_providers/mesh_calculation_provider.dart';
import 'package:measurements/providers/wire_mesh/mesh_opening_pitch_calculations_providers/mesh_opening_pitch_calculations_provider.dart';
import 'package:measurements/providers/wire_mesh/mesh_opening_pitch_calculations_providers/opening_calculation_provider.dart';
import 'package:measurements/providers/wire_mesh/mesh_opening_pitch_calculations_providers/pitch_calculation_provider.dart';
import 'package:measurements/providers/wire_mesh/dutch_woven_wire_mesh_providers/weight_per_od_less_id_provider.dart';
import 'package:measurements/providers/wire_mesh/wire_mesh_provider.dart';
import 'package:provider/provider.dart';

import 'providers/perforated_sheet_provider/open_area_calculation_provider/open_area_calculation_provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ChainLinkProvider()),
        ChangeNotifierProvider(create: (_) => GlobalViewProvider()),
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
        ChangeNotifierProvider(create: (_) => WeightPerRollProvider()),
        ChangeNotifierProvider(create: (_) => WeightPerOdProvider()),
        ChangeNotifierProvider(create: (_) => WeightPerOdLessIdProvider()),
        ChangeNotifierProvider(create: (_) => OpenAreaCalculationsProvider()),
        ChangeNotifierProvider(create: (_) => HarpWireMeshProvider()),
        ChangeNotifierProvider(create: (_) => RectangularWireMeshProvider()),
        ChangeNotifierProvider(create: (_) => SquareWireMeshProvider()),
        ChangeNotifierProvider(create: (_) => WeightCalculationProvider()),
        ChangeNotifierProvider(create: (_) => WireRequiredProvider()),
        ChangeNotifierProvider(create: (_) => MeshOpeningPitchCalculationsProvider()),
        ChangeNotifierProvider(create: (_) => MeshCalculationProvider()),
        ChangeNotifierProvider(create: (_) => OpeningCalculationProvider()),
        ChangeNotifierProvider(create: (_) => PitchCalculationProvider()),
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
