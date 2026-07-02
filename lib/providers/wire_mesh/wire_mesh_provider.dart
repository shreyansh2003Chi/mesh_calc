import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/chain_link/chain_link.dart';
import 'package:measurements/pages/expanded_metal/expanded_metal.dart';
import 'package:measurements/pages/hexagonal_wiremesh/hexagonal_wiremesh.dart';
import 'package:measurements/pages/perforated_sheet/open_area_calculation/capsule_center_to_center_hall.dart';
import 'package:measurements/pages/perforated_sheet/open_area_calculation/open_area_calculation.dart';
import 'package:measurements/pages/welded_wiremesh/weight_per_role.dart';
import 'package:measurements/pages/wire_mesh/dutch_woven_wire_mesh/dutch_woven_wire_mesh.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_string.dart';

class WireMeshProvider with ChangeNotifier {
  final TextEditingController searchController = TextEditingController();
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.dutchWovenWireMesh, image: AppAssets.dutchWovenWireMesh),
    MeshItem(title: AppString.weightPerRole, image: AppAssets.weightPerRole),
  ];
  void pageChange(MeshItem meshItem, BuildContext context) {
    switch (meshItem.title) {
      case AppString.dutchWovenWireMesh:
        Navigator.push(context, MaterialPageRoute(builder: (_) => DutchWovenWireMesh()));
        break;
      case AppString.weightPerRole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WeightPerRole(meshItem: meshItem)));
        break;
    }
  }
}
