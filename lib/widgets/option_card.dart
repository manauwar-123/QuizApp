import 'package:flutter/material.dart';
import 'package:quiz_app/models/constants.dart';

class OptionCard extends StatelessWidget {
  const OptionCard({
    Key? key,
    required this.option,
    required this.color,
  }) : super(key: key);
  final String option;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 50,
          width: 400,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            border: Border.all(
              width: 2,
              color: Colors.black,
            ),
          ),
          child: Card(
            color: color,
            child: ListTile(
              title: Text(
                option,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 20.0,
                  // we will decide if the 'color' we are receiving here.
                  // what ratio of the 'red' and 'green' colors are in it.
                  color: color.red != color.green ? neutral : Colors.black,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        )
      ],
    );
  }
}
