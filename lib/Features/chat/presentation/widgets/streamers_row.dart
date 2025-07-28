import 'package:flutter/material.dart';
import 'package:vibe_zo/core/utils/helper.dart';

class StreamersRow extends StatelessWidget {
  const StreamersRow({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: const EdgeInsets.all(0),
      shrinkWrap: true,
      itemCount: 10,
      separatorBuilder: (context, index) {
        return SizedBox(width: 10);
      },
      scrollDirection: Axis.horizontal,
      itemBuilder: (context, index) {
        return CircleAvatar(
          radius: context.screenWidth * .07,
          backgroundImage: NetworkImage("https://i.pravatar.cc/${index * 100}"),
        );
      },
    );
  }
}
