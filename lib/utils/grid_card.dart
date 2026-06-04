import 'package:flutter/material.dart';

class GridCard extends StatelessWidget {
  final String image;
  final String title;
  final VoidCallback onTap;

  const GridCard({
    super.key,
    required this.image,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 5,
              offset: Offset(1, 2),
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
              flex: 7,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Image.asset(
                  image,
                  fit: BoxFit.contain,
                ),
              ),
            ),

            Divider(
              thickness: 1.2,
              color: Colors.grey.shade400,
              height: 1,
            ),

            Expanded(
              flex: 3,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Text(
                    title.toUpperCase(),
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 17,
                      color: Color(0xff5A2A47),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}