import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/wire_mesh/mesh_opening_pitch_calculations/mesh_calculation.dart';
import 'package:measurements/pages/wire_mesh/mesh_opening_pitch_calculations/opening_calculation.dart';
import 'package:measurements/pages/wire_mesh/mesh_opening_pitch_calculations/pitch_calculation.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_string.dart';

class MeshOpeningPitchCalculationsProvider with ChangeNotifier {
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.mesh, image: AppAssets.mesh),
    MeshItem(title: AppString.opening, image: AppAssets.opening),
    MeshItem(title: AppString.pitch, image: AppAssets.pitch),
  ];

  void pageChange(MeshItem meshItem, BuildContext context) {
    switch (meshItem.title) {
      case AppString.mesh:
        Navigator.push(context, MaterialPageRoute(builder: (_) => MeshCalculation(item: meshItem)));
        break;
      case AppString.opening:
        Navigator.push(context, MaterialPageRoute(builder: (_) => OpeningCalculation(item: meshItem)));
        break;
      case AppString.pitch:
        Navigator.push(context, MaterialPageRoute(builder: (_) => PitchCalculation(item: meshItem)));
        break;
    }
  }
}
