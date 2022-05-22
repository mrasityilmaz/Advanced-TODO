import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvvm_provider_todo/Utils/Constants/constants.dart';

class MissionCardWidget extends StatelessWidget {
  const MissionCardWidget({
    Key? key,
    required this.queryData,
  }) : super(key: key);

  final MediaQueryData queryData;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: PhysicalModel(
        color: Colors.transparent,
        elevation: 10,
        child: Container(
          height: 200,
          width: queryData.size.width * .95,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: const Color.fromRGBO(20, 69, 82, 1)),
          padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          child: Row(
            children: [
              SizedBox(
                width: queryData.size.width * .7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                        flex: 3,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: const [
                            Expanded(
                              child: Text(
                                "Titsadasdasdasdasdasdle",
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 22,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            Text(
                              "10 / 3",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        )),
                    Expanded(
                      flex: 6,
                      child: Center(
                        child: ListView.builder(
                          itemCount: 10,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(vertical: 2),
                              child: Container(
                                height: 30,
                                decoration: BoxDecoration(
                                    color: index < 4
                                        ? const Color.fromRGBO(0, 100, 102, 1)
                                        : Colors.red.withOpacity(.5),
                                    borderRadius: BorderRadius.circular(15)),
                                padding: const EdgeInsets.only(left: 10),
                                child: Row(
                                  children: [
                                    Icon(
                                      index < 4
                                          ? Icons.check
                                          : Icons.circle_rounded,
                                      size: index < 4 ? 20 : 12,
                                      color: Colors.grey,
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                    SizedBox(
                                      width: queryData.size.width * .6,
                                      child: Text(
                                        "Missionasdasdasdasdsadasdsadasd $index",
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                            decoration: index < 4
                                                ? TextDecoration.lineThrough
                                                : null,
                                            fontStyle: index < 4
                                                ? FontStyle.italic
                                                : FontStyle.normal,
                                            color: Colors.white70,
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 2,
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Container(
                              height: 25,
                              decoration: BoxDecoration(
                                  color: PRIMARY_COLOR.withOpacity(.8),
                                  borderRadius: BorderRadius.circular(14)),
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 6, vertical: 2),
                              child: const Text(
                                "Tag",
                                style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500),
                              ),
                            ),
                            const Spacer(),
                            Row(
                              children: const [
                                Text(
                                  "Priority:",
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                ),
                                SizedBox(
                                  width: 4,
                                ),
                                Icon(
                                  CupertinoIcons.flag_circle,
                                  color: Colors.red,
                                )
                              ],
                            )
                          ],
                        )),
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    const Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(
                          CupertinoIcons.check_mark_circled,
                          size: 45,
                        )),
                    const Spacer(),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
