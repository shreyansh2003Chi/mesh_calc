import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/welded_wiremesh/weight_per_role.dart';
import 'package:measurements/pages/wire_mesh/dutch_woven_wire_mesh/dutch_woven_wire_mesh.dart';
import 'package:measurements/pages/image_viewer_screen.dart';
import 'package:measurements/pages/wire_mesh/open_area_calculations/open_area_calculations.dart';
import 'package:measurements/pages/wire_mesh/mesh_opening_pitch_calculations/mesh_opening_pitch_calculations.dart';
import 'package:measurements/pages/wire_mesh/weight_calculation/weight_per_roll.dart';
import 'package:measurements/pages/wire_mesh/wire_required.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_string.dart';

class WireMeshProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.dutchWovenWireMesh, image: AppAssets.dutchWovenWireMesh),
    MeshItem(title: AppString.weightPerRole, image: AppAssets.weightPerRole),
    MeshItem(title: AppString.micron, image: AppAssets.dutchMeshPdf),
    MeshItem(title: AppString.openAreaCalculation, image: AppAssets.openAreaCalculationWiremesh),
    MeshItem(title: AppString.meshOpeningPitchCalculations, image: AppAssets.meshOpeningPitchCalculations),
    MeshItem(title: AppString.weightCalculation, image: AppAssets.weightPerRollWiremesh),
    MeshItem(title: AppString.wireRequired, image: AppAssets.weightPerRollWiremesh),
  ];

  void pageChange(MeshItem meshItem, BuildContext context) {
    switch (meshItem.title) {
      case AppString.dutchWovenWireMesh:
        Navigator.push(context, MaterialPageRoute(builder: (_) => DutchWovenWireMesh()));
        break;
      case AppString.weightPerRole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WeightPerRole(meshItem: meshItem)));
        break;
      case AppString.micron:
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => ImageViewerScreen(imagePath: meshItem.image, title: meshItem.title),
          ),
        );
        break;
      case AppString.weightCalculation:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WireMeshWeightPerRoll(meshItem: meshItem)));
        break;
      case AppString.openAreaCalculation:
        Navigator.push(context, MaterialPageRoute(builder: (_) => OpenAreaCalculations()));
      case AppString.meshOpeningPitchCalculations:
        Navigator.push(context, MaterialPageRoute(builder: (_) => MeshOpeningPitchCalculations()));
        break;
      case AppString.wireRequired:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WireRequired()));
        break;
    }
  }
}
