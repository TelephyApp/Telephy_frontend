import 'package:flutter/material.dart';
import 'package:telephy/utils/config.dart';

class DetailTile extends StatelessWidget {
  const DetailTile({
    super.key,
    required this.name,
    required this.detail,
    required this.onclick,
    required this.imagePath,
  });

  final String name;
  final String detail;
  final Function() onclick;
  final String imagePath;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onclick,
      child: Container(
        padding: EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 16,
        ),
        margin: EdgeInsets.symmetric(horizontal: 1),
        decoration: BoxDecoration(
          color: Config.baseColor,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.25),
              spreadRadius: 1,
              blurRadius: 3,
              offset: Offset(0, 2),
            ),
          ],
          borderRadius: BorderRadius.all(Radius.circular(20)),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Config.baseColor,
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Image.asset(
                    imagePath,
                    width: 56,
                    fit: BoxFit.cover,
                  ),
                  margin: EdgeInsets.only(right: 12),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '$name',
                      style: TextStyle(
                        color: Config.darkerToneColor,
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    Text(
                      '$detail',
                      style: TextStyle(
                        color: Colors.grey,
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
