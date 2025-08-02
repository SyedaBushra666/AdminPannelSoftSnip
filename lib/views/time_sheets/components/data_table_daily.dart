import 'package:admin_pannel_monotor/helpers/widgets/my_table.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';

class DataTableDaily extends StatelessWidget {
  const DataTableDaily({super.key});

  @override
  Widget build(BuildContext context) {
    return  SizedBox(
                height: 300,
                 child: MyCustomTable(
                       stringHeaders: ["Project", "Activity", "Idle", "Manual","Duration","Time"],
                       rows: [
                         [
                           MyText.bodySmall("SoftSnip Project"),
                           MyText.bodySmall("69%"),
                           MyText.bodySmall("0%"),
                           MyText.bodySmall("0%"),
                           MyText.bodySmall("0:47:56",color: Colors.blue,),
                           MyText.bodySmall("12:00 am - 12:47 am",color: Colors.blue,),

                         ],


                          [
                           MyText.bodySmall("SoftSnip Project"),
                           MyText.bodySmall("69%"),
                           MyText.bodySmall("0%"),
                           MyText.bodySmall("0%"),
                           MyText.bodySmall("0:47:56",color: Colors.blue,),
                           MyText.bodySmall("12:00 am - 12:47 am",color: Colors.blue,),

                         ],


                          [
                           MyText.bodySmall("SoftSnip Project"),
                           MyText.bodySmall("69%"),
                           MyText.bodySmall("0%"),
                           MyText.bodySmall("0%"),
                           MyText.bodySmall("0:47:56",color: Colors.blue,),
                           MyText.bodySmall("12:00 am - 12:47 am",color: Colors.blue,),

                         ],

                          [
                           MyText.bodySmall("SoftSnip Project"),
                           MyText.bodySmall("69%"),
                           MyText.bodySmall("0%"),
                           MyText.bodySmall("0%"),
                           MyText.bodySmall("0:47:56",color: Colors.blue,),
                           MyText.bodySmall("12:00 am - 12:47 am",color: Colors.blue,),

                         ],
                         
                         // Add more rows
                       ],
                     ),
               );
  }
}