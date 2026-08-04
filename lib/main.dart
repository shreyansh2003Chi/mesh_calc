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
import 'package:measurements/providers/wire_mesh/mesh_opening_pitch_calculations_providers/mesh_calculation_provider.dart';
import 'package:measurements/providers/wire_mesh/mesh_opening_pitch_calculations_providers/mesh_opening_pitch_calculations_provider.dart';
import 'package:measurements/providers/wire_mesh/mesh_opening_pitch_calculations_providers/opening_calculation_provider.dart';
import 'package:measurements/providers/wire_mesh/mesh_opening_pitch_calculations_providers/pitch_calculation_provider.dart';
import 'package:measurements/providers/wire_mesh/dutch_woven_wire_mesh_providers/weight_per_od_less_id_provider.dart';
import 'package:measurements/providers/wire_mesh/wire_mesh_provider.dart';
import 'package:measurements/providers/wire/wire_provider.dart';
import 'package:measurements/providers/wire/hexagonal_wire_provider.dart';
import 'package:measurements/providers/wire/octagonal_wire_provider.dart';
import 'package:measurements/providers/wire/re_enforced_bar_provider.dart';
import 'package:measurements/providers/wire/rectangle_wire_provider.dart';
import 'package:measurements/providers/wire/round_wire_provider.dart';
import 'package:measurements/providers/wire/square_wire_provider.dart';
import 'package:measurements/providers/wire/swg_to_mm_provider.dart';
import 'package:measurements/providers/unit_calculator/unit_calculator_provider.dart';
import 'package:measurements/providers/unit_calculator/area_converter_provider.dart';
import 'package:measurements/providers/unit_calculator/length_converter_provider.dart';
import 'package:measurements/providers/unit_calculator/weight_converter_provider.dart';
import 'package:measurements/providers/unit_calculator/price_hub_provider.dart';
import 'package:measurements/providers/unit_calculator/area_to_area_provider.dart';
import 'package:measurements/providers/unit_calculator/area_to_running_provider.dart';
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
        ChangeNotifierProvider(create: (_) => MeshOpeningPitchCalculationsProvider()),
        ChangeNotifierProvider(create: (_) => MeshCalculationProvider()),
        ChangeNotifierProvider(create: (_) => OpeningCalculationProvider()),
        ChangeNotifierProvider(create: (_) => PitchCalculationProvider()),
        ChangeNotifierProvider(create: (_) => WireProvider()),
        ChangeNotifierProvider(create: (_) => HexagonalWireProvider()),
        ChangeNotifierProvider(create: (_) => OctagonalWireProvider()),
        ChangeNotifierProvider(create: (_) => ReEnforcedBarProvider()),
        ChangeNotifierProvider(create: (_) => RectangleWireProvider()),
        ChangeNotifierProvider(create: (_) => RoundWireProvider()),
        ChangeNotifierProvider(create: (_) => SquareWireProvider()),
        ChangeNotifierProvider(create: (_) => SwgToMmProvider()),
        ChangeNotifierProvider(create: (_) => UnitCalculatorProvider()),
        ChangeNotifierProvider(create: (_) => AreaConverterProvider()),
        ChangeNotifierProvider(create: (_) => LengthConverterProvider()),
        ChangeNotifierProvider(create: (_) => WeightConverterProvider()),
        ChangeNotifierProvider(create: (_) => PriceHubProvider()),
        ChangeNotifierProvider(create: (_) => AreaToAreaProvider()),
        ChangeNotifierProvider(create: (_) => AreaToRunningProvider()),
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
