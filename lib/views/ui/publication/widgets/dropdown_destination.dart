import 'package:flutter/material.dart';

import '../../../../business_logic/utils/logicConstants.dart';
class DropDownWidget extends StatelessWidget {
  final double padding;
  final MaterialColor? color;

  const DropDownWidget({super.key, required this.padding, this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: padding,vertical: 8),
      child: DropdownButtonFormField(
        items: destinations
            .map(
              (e) => DropdownMenuItem<String>(
            value: e.city,
            child: Text(
              e.city,
              style: const TextStyle(
                fontSize: 14,
              ),
            ),
          ),
        )
            .toList(),
        itemHeight: 50,
        //buttonHeight: 50,
        iconSize: 24,
        selectedItemBuilder: (context) =>  destinations.map((e) => Row(
          children: [
             Padding(padding: const EdgeInsets.only(top:0,bottom: 4,left: 8,right: 20),child:
            Icon(Icons.villa_rounded,color: color??Colors.black),),
            Text(e.city),
          ],
        )).toList(),
        style: Theme.of(context).textTheme.bodyLarge
            ?.copyWith(fontWeight: FontWeight.bold),
        padding: const EdgeInsets.only(left: 8, right: 10),
        borderRadius: BorderRadius.circular(16),
        decoration: InputDecoration(
          isDense: true,
          contentPadding:
          const EdgeInsets.symmetric(vertical: 10),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
          ),
        ),
        hint: const Text("Selected countries"),
        value: "Casablanca",
        onChanged: (value) {},
      ),
    );
  }
}
