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
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(18),
      child: InkWell(
        borderRadius: BorderRadius.circular(18),
        onTap: onTap,
        child: Container(
          height: 120,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(18),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 12,
                spreadRadius: 1,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            children: [
              Container(
                width: 8,
                decoration: BoxDecoration(
                  color: AppColors().c1F5F8B,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(18),
                    bottomLeft: Radius.circular(18),
                  ),
                ),
              ),

              const SizedBox(width: 12),

              Container(
                width: 90,
                height: 90,
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

              const SizedBox(width: 16),

              Expanded(
                child: Padding(
                  padding: const EdgeInsets.only(right: 12),
                  child: Text(
                    title.toUpperCase(),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 19,
                      fontWeight: FontWeight.w600,
                      color: Color(0xff5A2A47),
                      letterSpacing: 0.4,
                    ),
                  ),
                ),
              ),

              Padding(
                padding: const EdgeInsets.only(right: 12),
                child: Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 18,
                  color: Colors.grey.shade500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}