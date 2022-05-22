import 'package:expansion_tile_card/expansion_tile_card.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_provider_todo/Utils/Constants/constants.dart';

class GroupCard extends StatelessWidget {
  final Color? baseColor;
  final String? titleText;
  final int compStatCount;
  final int allStatCount;
  final List<Widget> children;

  const GroupCard(
      {Key? key,
      this.baseColor,
      this.titleText,
      required this.compStatCount,
      required this.allStatCount,
      required this.children})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ExpansionTileCard(
        borderRadius: BorderRadius.circular(10),
        elevation: 5,
        expandedTextColor: Colors.white,
        expandedColor: baseColor ?? GROUP_CARD_COLOR,
        baseColor: baseColor ?? GROUP_CARD_COLOR,
        shadowColor: Colors.black,
        trailing: children.isNotEmpty
            ? const Icon(
                CupertinoIcons.sort_down,
                size: 30,
              )
            : const SizedBox(),
        animateTrailing: true,
        subtitle: Text(
          "Status: $compStatCount / $allStatCount",
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        title: Text(
          titleText ?? "New Group",
          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
        ),
        children: children);
  }
}
