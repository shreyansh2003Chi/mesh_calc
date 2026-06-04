import 'package:flutter/material.dart';
import 'app_colors.dart';

class ListCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const ListCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    final cardHeight = (width * 0.28).clamp(100.0, 130.0);
    final imageSize = (width * 0.21).clamp(75.0, 95.0);
    final titleSize = (width * 0.045).clamp(15.0, 19.0);

    const cardRadius = BorderRadius.only(
      topLeft: Radius.circular(10),
      bottomLeft: Radius.circular(10),
      topRight: Radius.circular(18),
      bottomRight: Radius.circular(18),
    );

    return Material(
      color: Colors.transparent,
      borderRadius: cardRadius,
      child: InkWell(
        borderRadius: cardRadius,
        onTap: onTap,
        child: ClipRRect(
          borderRadius: cardRadius,
          child: Container(
            height: cardHeight,
            decoration: BoxDecoration(
              color: AppColors().cFFFFFF,
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.03),
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                // Left Accent Strip
                Container(
                  width: 8,
                  decoration: BoxDecoration(
                    color: AppColors().c1F5F8B,
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                  ),
                ),

                SizedBox(width: width * 0.03),

                // Image
                Container(
                  width: imageSize,
                  height: imageSize,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade50,
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),

                SizedBox(width: width * 0.04),

                // Title
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: Text(
                      title.toUpperCase(),
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: titleSize,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xff5A2A47),
                        letterSpacing: 0.4,
                      ),
                    ),
                  ),
                ),

                // Arrow
                Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: width * 0.045,
                    color: Colors.grey.shade500,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}