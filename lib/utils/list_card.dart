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

    final imageSize = (width * 0.18).clamp(65.0, 85.0);
    final titleSize = (width * 0.042).clamp(15.0, 17.0);

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: AppColors().cFFFFFF,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
            child: Row(
              children: [
                // Image Container
                Container(
                  width: imageSize,
                  height: imageSize,
                  padding: const EdgeInsets.all(8),
                  child: Image.asset(
                    image,
                    fit: BoxFit.contain,
                  ),
                ),
                
                const SizedBox(width: 16),
                
                // Title
                Expanded(
                  child: Text(
                    title.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: titleSize,
                      fontWeight: FontWeight.w600,
                      color: const Color(0xff5A2A47),
                      letterSpacing: 0.3,
                    ),
                  ),
                ),
                
                // Arrow
                Container(
                  padding: const EdgeInsets.all(6),
                  decoration: BoxDecoration(
                    color: AppColors().c1F5F8B.withOpacity(0.06),
                    shape: BoxShape.circle,
                  ),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 16,
                    color: AppColors().c1F5F8B,
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