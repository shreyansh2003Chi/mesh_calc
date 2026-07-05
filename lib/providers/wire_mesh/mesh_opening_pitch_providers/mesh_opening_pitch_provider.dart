import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/wire_mesh/open_area_calculations/harp_wire_mesh.dart';
import 'package:measurements/pages/wire_mesh/open_area_calculations/rectangular_wire_mesh.dart';
import 'package:measurements/pages/wire_mesh/open_area_calculations/square_wire_mesh.dart';
import 'package:measurements/pages/wire_mesh/dutch_woven_wire_mesh/weight_per_od.dart';
import 'package:measurements/pages/wire_mesh/dutch_woven_wire_mesh/weight_per_od_less_id.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_string.dart';

class MeshOpeningPitchProvider with ChangeNotifier {
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.mesh, image: AppAssets.mesh),
    MeshItem(title: AppString.opening, image: AppAssets.opening),
    MeshItem(title: AppString.pitch, image: AppAssets.pitch),
  ];

  void pageChange(MeshItem meshItem, BuildContext context) {
    switch (meshItem.title) {
      case AppString.harpWireMesh:
        Navigator.push(context, MaterialPageRoute(builder: (_) => HarpWireMesh(item: meshItem)));
        break;
      case AppString.rectangularWireMesh:
        Navigator.push(context, MaterialPageRoute(builder: (_) => RectangularWireMesh(item: meshItem)));
        break;
      case AppString.squareWireMesh:
        Navigator.push(context, MaterialPageRoute(builder: (_) => SquareWireMesh(item: meshItem)));
        break;
    }
  }
}
