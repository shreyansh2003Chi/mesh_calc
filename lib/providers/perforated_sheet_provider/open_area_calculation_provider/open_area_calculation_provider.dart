import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/chain_link/chain_link.dart';
import 'package:measurements/pages/expanded_metal/expanded_metal.dart';
import 'package:measurements/pages/hexagonal_wiremesh/hexagonal_wiremesh.dart';
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

  Widget dynamicWidget() {
    return Column(
      children: [
        Column(
          children: [
            Image.asset(AppAssets.capsuleCenterToCenterHole, height: 200, fit: BoxFit.contain),
            const SizedBox(height: 12),
            const Text(
              AppString.capsuleCenterToCenterHole,
              style: TextStyle(fontSize: 15, fontWeight: FontWeight.w600, color: Colors.black87),
            ),
            const SizedBox(height: 15),
            MeasurementField(
              controller: widthHoleController,
              label: AppString.openingOpgMm,
              unit: widthHoleUnitController,
              onUnitChanged: (value) => setUnit(value, AppString.widthHole),
            ),
            const SizedBox(height: 18),

            MeasurementField(
              controller: lengthHoleController,
              label: AppString.openingOpgMm,
              unit: lengthHoleUnitController,
              onUnitChanged: (value) => setUnit(value, AppString.lengthHole),
            ),
            const SizedBox(height: 18),

            MeasurementField(
              controller: widthPitchController,
              label: AppString.openingOpgMm,
              unit: widthPitchUnitController,
              onUnitChanged: (value) => setUnit(value, AppString.widthPitch),
            ),
            const SizedBox(height: 18),

            MeasurementField(
              controller: lengthPitchController,
              label: AppString.openingOpgMm,
              unit: lengthPitchUnitController,
              onUnitChanged: (value) => setUnit(value, AppString.lengthPitch),
            ),
            const SizedBox(height: 18),
          ],
        ),
      ],
    );
  }

  void pageChange(MeshItem meshItem, BuildContext context) {
    switch (meshItem.title) {
      case AppString.chainLink:
        Navigator.push(context, MaterialPageRoute(builder: (_) => ChainLinkScreen(item: meshItem)));
        break;
      case AppString.weightPerRole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => WeightPerRole(meshItem: meshItem)));
        break;
      case AppString.expandedMetal:
        Navigator.push(context, MaterialPageRoute(builder: (_) => ExpandedMetal(item: meshItem)));
        break;
      case AppString.hexagonalWiremesh:
        Navigator.push(context, MaterialPageRoute(builder: (_) => HexagonalWiremesh(item: meshItem)));
        break;

      case AppString.capsuleCenterToCenterHole:
        break;
    }
  }
}
