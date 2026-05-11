import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/chain_link/chain_link.dart';
import 'package:measurements/pages/expanded_metal/expanded_metal.dart';
import 'package:measurements/pages/hexagonal_wiremesh/hexagonal_wiremesh.dart';
import 'package:measurements/pages/perforated_sheet/open_area_calculation/capsule_center_to_center_hall.dart';
import 'package:measurements/pages/perforated_sheet/open_area_calculation/capsule_staggered_triangular_hole.dart';
import 'package:measurements/pages/perforated_sheet/open_area_calculation/hexagonal_staggered_triangular_hole.dart';
import 'package:measurements/pages/perforated_sheet/open_area_calculation/rectangular_center_to_center_hole.dart';
import 'package:measurements/pages/perforated_sheet/open_area_calculation/rectangular_staggered_triangular_hole.dart';
import 'package:measurements/pages/perforated_sheet/open_area_calculation/round_45_staggered_triangular_hole.dart';
import 'package:measurements/pages/welded_wiremesh/weight_per_role.dart';
import 'package:measurements/utils/app_assets.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/measurement_field.dart';
import 'package:measurements/utils/measurement_unit.dart';

class OpenAreaCalculationProvider with ChangeNotifier {
  bool isGridView = true;
  final TextEditingController searchController = TextEditingController();

  final widthHoleController = TextEditingController();
  MeasureUnit widthHoleUnitController = MeasureUnit.mm;

  final lengthHoleController = TextEditingController();
  MeasureUnit lengthHoleUnitController = MeasureUnit.mm;

  final widthPitchController = TextEditingController();
  MeasureUnit widthPitchUnitController = MeasureUnit.mm;

  final lengthPitchController = TextEditingController();
  MeasureUnit lengthPitchUnitController = MeasureUnit.mm;

  final List<MeshItem> allItems = [
    MeshItem(title: AppString.capsuleCenterToCenterHole, image: AppAssets.capsuleCenterToCenterHole),
    MeshItem(title: AppString.capsuleStaggeredTriangularHole, image: AppAssets.capsuleStaggeredTriangularHole),
    MeshItem(title: AppString.hexagonalStaggeredTriangularHole, image: AppAssets.hexagonalStaggeredTriangularHole),
    MeshItem(title: AppString.rectangularCenterToCenterHole, image: AppAssets.rectangularCenterToCenterHole),
    MeshItem(title: AppString.rectangularStaggeredTriangularHole, image: AppAssets.rectangularStaggeredTriangularHole),
    MeshItem(title: AppString.round45StaggeredTriangularHole, image: AppAssets.round45StaggeredTriangularHole),
    MeshItem(title: AppString.round60StaggeredTriangularHole, image: AppAssets.round60StaggeredTriangularHole),
    MeshItem(title: AppString.round90CenterToCenterHole, image: AppAssets.round90CenterToCenterHole),
    MeshItem(title: AppString.squareCenterToCenterHole, image: AppAssets.squareCenterToCenterHole),
    MeshItem(title: AppString.squareStaggeredTriangularHole, image: AppAssets.squareStaggeredTriangularHole),
  ];

  void changeView() {
    isGridView = !isGridView;
    notifyListeners();
  }

  void setUnit(MeasureUnit u, String s) {
    switch (s) {
      case AppString.widthHole:
        widthHoleUnitController = u;
    }
  }

  void pageChange(MeshItem meshItem, BuildContext context) {
    switch (meshItem.title) {
      case AppString.capsuleCenterToCenterHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => CapsuleCenterToCenterHall(item: meshItem)));
        break;
      case AppString.capsuleStaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => CapsuleStaggeredTriangularHole(item: meshItem)));
        break;
      case AppString.hexagonalStaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => HexagonalStaggeredTriangularHole(item: meshItem)));
        break;
      case AppString.rectangularCenterToCenterHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => RectangularCenterToCenterHole(item: meshItem)));
        break;
      case AppString.rectangularStaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => RectangularStaggeredTriangularHole(item: meshItem)));
        break;
      case AppString.round45StaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => Round45StaggeredTriangularHole(item: meshItem)));
        break;
    }
  }
}
