import 'package:flutter/material.dart';
import 'package:measurements/models/mesh_item.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od/capsule_center_to_center_hole_wpo.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od/capsule_staggered_triangular_hole_wpo.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od/hexagonal_staggered_triangular_hole_wpo.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od/rectangular_center_to_center_hole_wpo.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od/rectangular_staggered_triangular_hole_wpo.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od/round_45_staggered_triangular_hole_wpo.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od/round_60_staggered_triangular_hole_wpo.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od/round_90_center_to_center_hole_wpo.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od/square_center_to_center_hole_wpo.dart';
import 'package:measurements/pages/perforated_sheet/weight_per_od/square_staggered_triangular_hole_wpo.dart';
import 'package:measurements/providers/global_view_provider.dart';
import 'package:measurements/utils/app_colors.dart';
import 'package:measurements/utils/app_string.dart';
import 'package:measurements/utils/grid_card.dart';
import 'package:measurements/utils/list_card.dart';
import 'package:provider/provider.dart';

class WeightPerOd extends StatefulWidget {
  const WeightPerOd({super.key});

  @override
  State<WeightPerOd> createState() => _WeightPerOdState();
}

class _WeightPerOdState extends State<WeightPerOd> {
  final List<MeshItem> allItems = [
    MeshItem(title: AppString.capsuleCenterToCenterHole, image: "assets/WPO/capsule_center_to_center_hole_wpo.jpeg"),
    MeshItem(title: AppString.capsuleStaggeredTriangularHole, image: "assets/WPO/capsule_staggered_triangular_hole_wpo.jpeg"),
    MeshItem(title: AppString.hexagonalStaggeredTriangularHole, image: "assets/WPO/hexagonal_staggered_triangular_hole_wpo.jpeg"),
    MeshItem(title: AppString.rectangularCenterToCenterHole, image: "assets/WPO/rectangular_centar_to_center_hole_wpo.jpeg"),
    MeshItem(title: AppString.rectangularStaggeredTriangularHole, image: "assets/WPO/rectangular_staggered_trianglular_hole_wpo.jpeg"),
    MeshItem(title: AppString.round45StaggeredTriangularHole, image: "assets/WPO/round_45_staggered_triangular_hole_wpo.jpeg"),
    MeshItem(title: AppString.round60StaggeredTriangularHole, image: "assets/WPO/round_60_staggered_triangular_hole_wpo.jpeg"),
    MeshItem(title: AppString.round90CenterToCenterHole, image: "assets/WPO/round_90_center_to_center_hole_wpo.jpeg"),
    MeshItem(title: AppString.squareCenterToCenterHole, image: "assets/WPO/square_center_to_center_hole_wpo.jpeg"),
    MeshItem(title: AppString.squareStaggeredTriangularHole, image: "assets/WPO/square_staggered_triangular_hole_wpo.jpeg"),
  ];

  void pageChange(MeshItem meshItem) {
    switch (meshItem.title) {
      case AppString.capsuleCenterToCenterHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => CapsuleCenterToCenterHoleWpo(item: meshItem)));
        break;
      case AppString.capsuleStaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => CapsuleStaggeredTriangularHoleWpo(item: meshItem)));
        break;
      case AppString.hexagonalStaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => HexagonalStaggeredTriangularHoleWpo(item: meshItem)));
        break;
      case AppString.rectangularCenterToCenterHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => RectangularCenterToCenterHoleWpo(item: meshItem)));
        break;
      case AppString.rectangularStaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => RectangularStaggeredTriangularHoleWpo(item: meshItem)));
        break;
      case AppString.round45StaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => Round45StaggeredTriangularHoleWpo(item: meshItem)));
        break;
      case AppString.round60StaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => Round60StaggeredTriangularHoleWpo(item: meshItem)));
        break;
      case AppString.round90CenterToCenterHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => Round90CenterToCenterHoleWpo(item: meshItem)));
        break;
      case AppString.squareCenterToCenterHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => SquareCenterToCenterHoleWpo(item: meshItem)));
        break;
      case AppString.squareStaggeredTriangularHole:
        Navigator.push(context, MaterialPageRoute(builder: (_) => SquareStaggeredTriangularHoleWpo(item: meshItem)));
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
          "Weight Per OD",
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
