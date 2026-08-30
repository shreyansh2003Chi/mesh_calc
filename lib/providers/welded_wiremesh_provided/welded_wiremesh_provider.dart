import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/pages/welded_wiremesh_ww/mesh_opening_pitch_calculations_ww.dart';
import 'package:measurements/pages/welded_wiremesh_ww/weight_per_roll_ww.dart';
import 'package:measurements/pages/welded_wiremesh_ww/weight_per_od_ww.dart';
import 'package:measurements/pages/welded_wiremesh_ww/weight_per_od_less_id_ww.dart';
import 'package:measurements/pages/welded_wiremesh_ww/wires_required_ww.dart';

class WeldedWiremeshProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.meshOpeningPitchCalculations, image: AppAssets.meshOpeningPitchCalculations),
    MeshItem(title: AppString.weightPerRoll, image: AppAssets.weightPerRollWw),
    MeshItem(title: AppString.weightPerOd, image: AppAssets.weightPerOdWw),
    MeshItem(title: AppString.weightPerOdLessId, image: AppAssets.weightPerOdLessIdWw),
    MeshItem(title: AppString.wireRequired, image: AppAssets.wiresRequiredWw),

  ];

  void pageChange(MeshItem meshItem, BuildContext context) {
    switch (meshItem.title) {
      case AppString.meshOpeningPitchCalculations:
        Navigator.push(context, MaterialPageRoute(builder: (_) => const MeshOpeningPitchCalculationsWw()));
        break;
      case AppString.weightPerRoll:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WeightPerRollWw(meshItem: meshItem)));
        break;
      case AppString.weightPerOd:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WeightPerOdWw(meshItem: meshItem)));
        break;
      case AppString.weightPerOdLessId:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WeightPerOdLessIdWw(meshItem: meshItem)));
        break;
      case AppString.wireRequired:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WiresRequiredWw(meshItem: meshItem)));
        break;
    }
  }
}
