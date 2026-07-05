import 'package:flutter/material.dart';

class ListCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const ListCard({super.key, required this.image, required this.title, required this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final imageSize = (width * 0.18).clamp(65.0, 85.0);
    final titleSize = (width * 0.042).clamp(15.0, 17.0);
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 5, offset: Offset(1, 2))],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(14),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                Container(
                  width: imageSize,
                  height: imageSize,
                  padding: const EdgeInsets.all(4),
                  child: Image.asset(image, fit: BoxFit.contain),
                ),

                const SizedBox(width: 16),
                Expanded(
                  child: Text(
                    title.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(fontSize: titleSize, fontWeight: FontWeight.w500, color: const Color(0xff5A2A47)),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Icon(Icons.arrow_forward_ios_rounded, size: 18, color: Colors.grey.shade400),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
