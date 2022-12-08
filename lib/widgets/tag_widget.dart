import 'package:flutter/material.dart';

import '../models/tag.dart';


class TagWidget extends StatelessWidget {
  const TagWidget({
    Key? key,
    required this.tag
  }) : super(key: key);

  final Tag tag;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 3),
          decoration: BoxDecoration(
            color: tag.color,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Text(tag.name,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: tag.color.computeLuminance() < 0.5
                ? Colors.white 
                : Colors.black
            )
          )
        ),
      ],
    );
  }
}