import 'package:flutter/material.dart';
import 'package:telephy/utils/config.dart';
import 'package:telephy/widgets/card_appointment/detail_tile.dart';
import 'package:telephy/widgets/card_appointment/upcoming_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 64,
        left: 32,
        right: 32,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'สวัสดีตอนบ่าย!\nDr.barbie',
                style: TextStyle(
                  color: Config.darkerToneColor,
                  fontSize: 24,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Icon(
                Icons.image,
                color: Colors.grey[400],
                size: 64,
              ),
            ],
          ),
          SizedBox(height: 30),
          UpcomingCard(
            name: 'Malee Wang',
            detail: 'konnichiwa, watashino namaewa',
            dateTime: '12 ส.ค. 2023, 8:00 - 9:00',
          ),
          SizedBox(
            height: 30,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'การนัดหมายทั้งหมด',
                  style: TextStyle(
                    color: Config.darkerToneColor,
                    fontSize: 18,
                  ),
                ),
                Icon(Icons.sort),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              children: [
                DetailTile(
                  name: 'มาลี หวัง',
                  dateTime: '12 ส.ค. 2023, 8:00 - 9:00',
                ),
                SizedBox(height: 20),
                DetailTile(
                  name: 'มาลี หวัง',
                  dateTime: '12 ส.ค. 2023, 8:00 - 9:00',
                ),
                SizedBox(height: 20),
                DetailTile(
                  name: 'มาลี หวัง',
                  dateTime: '12 ส.ค. 2023, 8:00 - 9:00',
                ),
                SizedBox(height: 20),
                DetailTile(
                  name: 'มาลี หวัง',
                  dateTime: '12 ส.ค. 2023, 8:00 - 9:00',
                ),
                SizedBox(height: 20),
                DetailTile(
                  name: 'มาลี หวัง',
                  dateTime: '12 ส.ค. 2023, 8:00 - 9:00',
                ),
                SizedBox(height: 20),
                DetailTile(
                  name: 'มาลี หวัง',
                  dateTime: '12 ส.ค. 2023, 8:00 - 9:00',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
