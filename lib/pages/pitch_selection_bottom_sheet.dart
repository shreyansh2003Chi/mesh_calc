import 'package:flutter/material.dart';

class PitchSelectionBottomSheet extends StatefulWidget {
  const PitchSelectionBottomSheet({super.key});

  @override
  State<PitchSelectionBottomSheet> createState() => _PitchSelectionBottomSheetState();
}

class _PitchSelectionBottomSheetState extends State<PitchSelectionBottomSheet> {
  List<double> pitchList = [9.525, 12.7, 15.875, 19.05, 25.4, 31.75, 38.1, 50.8];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: ListView.builder(
        shrinkWrap: true,
        itemCount: pitchList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${pitchList[index]} mm"),
            onTap: () {
              Navigator.pop(context, pitchList[index]);
            },
          );
        },
      ),
    );
  }
}
