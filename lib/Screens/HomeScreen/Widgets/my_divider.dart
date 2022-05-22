import 'package:flutter/material.dart';

import '../../../Utils/Constants/constants.dart';

class MyDivider extends StatelessWidget {
  final String dividerTitle;
  final Color dividerColor;
  const MyDivider(
      {Key? key, required this.dividerTitle, required this.dividerColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Divider(
          color: dividerColor,
          height: 20,
          thickness: 2,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Text(
            dividerTitle,
            style: TextStyle(
                color: dividerColor,
                fontSize: 24,
                fontStyle: FontStyle.italic,
                fontWeight: FontWeight.w400),
          ),
        ),
      ],
    );
  }
}
