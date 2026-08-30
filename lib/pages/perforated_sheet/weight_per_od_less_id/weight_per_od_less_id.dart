import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od_less_id/capsule_center_to_center_hole_wpoli.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od_less_id/capsule_staggered_triangular_hole_wpoli.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od_less_id/hexagonal_staggered_triangular_hole_wpoli.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od_less_id/rectangular_center_to_center_hole_wpoli.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od_less_id/rectangular_staggered_triangular_hole_wpoli.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od_less_id/round_45_staggered_triangular_hole_wpoli.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od_less_id/round_60_staggered_triangular_hole_wpoli.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od_less_id/round_90_center_to_center_hole_wpoli.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od_less_id/square_center_to_center_hole_wpoli.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od_less_id/square_staggered_triangular_hole_wpoli.dart';
import 'package:measurements/providers/global_view_provider.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/grid_card.dart';
import 'package:measurements/utils/list_card.dart';
import 'package:provider/provider.dart';

class WeightPerOdLessId extends StatefulWidget {
  const WeightPerOdLessId({super.key});

  @override
  State<WeightPerOdLessId> createState() => _WeightPerOdLessIdState();
}

class _WeightPerOdLessIdState extends State<WeightPerOdLessId> {
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.capsuleCenterToCenterHole, image: "assets/WPOLI/capsule_center_to_center_hole_wpoli.jpeg"),
    MeshItem(title: AppString.capsuleStaggeredTriangularHole, image: "assets/WPOLI/capsule_staggered_triangular_hole_wpoli.jpeg"),
    MeshItem(title: AppString.hexagonalStaggeredTriangularHole, image: "assets/WPOLI/hexagonal_staggered_triangular_hole_wpoli.jpeg"),
    MeshItem(title: AppString.rectangularCenterToCenterHole, image: "assets/WPOLI/rectangular_center_to_center_hole_wpoli.jpeg"),
    MeshItem(title: AppString.rectangularStaggeredTriangularHole, image: "assets/WPOLI/rectangular_staggered_triangular_hole_wpoli.jpeg"),
    MeshItem(title: AppString.round45StaggeredTriangularHole, image: "assets/WPOLI/round_45_staggered_triangular_hole_wpoli.jpeg"),
    MeshItem(title: AppString.round60StaggeredTriangularHole, image: "assets/WPOLI/round_60_staggered_triaangular_hole_wpoli.jpeg"),
    MeshItem(title: AppString.round90CenterToCenterHole, image: "assets/WPOLI/round_90_center_to_center_hole_wpoli.jpeg"),
    MeshItem(title: AppString.squareCenterToCenterHole, image: "assets/WPOLI/square_center_to_center_hole_wpoli.jpeg"),
    MeshItem(title: AppString.squareStaggeredTriangularHole, image: "assets/WPOLI/square_staggered_triangular_hole_wpoli.jpeg"),
  ];

  void pageChange(MeshItem meshItem) {
    switch (meshItem.title) {
      case AppString.capsuleCenterToCenterHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => CapsuleCenterToCenterHoleWpoli(item: meshItem)));
        break;
      case AppString.capsuleStaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => CapsuleStaggeredTriangularHoleWpoli(item: meshItem)));
        break;
      case AppString.hexagonalStaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => HexagonalStaggeredTriangularHoleWpoli(item: meshItem)));
        break;
      case AppString.rectangularCenterToCenterHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => RectangularCenterToCenterHoleWpoli(item: meshItem)));
        break;
      case AppString.rectangularStaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => RectangularStaggeredTriangularHoleWpoli(item: meshItem)));
        break;
      case AppString.round45StaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => Round45StaggeredTriangularHoleWpoli(item: meshItem)));
        break;
      case AppString.round60StaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => Round60StaggeredTriangularHoleWpoli(item: meshItem)));
        break;
      case AppString.round90CenterToCenterHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => Round90CenterToCenterHoleWpoli(item: meshItem)));
        break;
      case AppString.squareCenterToCenterHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => SquareCenterToCenterHoleWpoli(item: meshItem)));
        break;
      case AppString.squareStaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => SquareStaggeredTriangularHoleWpoli(item: meshItem)));
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    final globalView = Provider.of<GlobalViewProvider>(context);
    return Scaffold(
      backgroundColor: AppColors().cFaFaFa,
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: AppColors().c1F5F8B,
        title: const Text(
          "Weight Per OD Less ID",
          style: TextStyle(fontWeight: FontWeight.w600, color: Colors.white),
        ),
        iconTheme: const IconThemeData(color: Colors.white),
        actions: [
          IconButton(
            color: Colors.white,
            onPressed: () {
              globalView.changeView();
            },
            icon: globalView.isGridView
                ? const Icon(Icons.format_list_bulleted_outlined)
                : const Icon(Icons.grid_view_rounded),
          ),
        ],
      ),
      body: AnimatedSwitcher(
        duration: const Duration(milliseconds: 400),
        switchInCurve: Curves.easeOutCubic,
        switchOutCurve: Curves.easeInCubic,
        transitionBuilder: (child, animation) {
          return FadeTransition(
            opacity: animation,
            child: ScaleTransition(
              scale: Tween<double>(begin: 0.95, end: 1).animate(animation),
              child: child,
            ),
          );
        },
        child: globalView.isGridView == false
            ? ListView.separated(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
                itemCount: allItems.length,
                separatorBuilder: (_, _) => const SizedBox(height: 20),
                itemBuilder: (context, index) {
                  final item = allItems[index];
                  return ListCard(
                    image: item.image,
                    title: item.title,
                    onTap: () {
                      pageChange(item);
                    },
                  );
                },
              )
            : GridView.builder(
                physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
                itemCount: allItems.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.78,
                ),
                itemBuilder: (context, index) {
                  final item = allItems[index];
                  return GridCard(
                    image: item.image,
                    title: item.title,
                    onTap: () {
                      pageChange(item);
                    },
                  );
                },
              ),
      ),
    );
  }
}
