import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AppConstant {
  static List<Map<String, dynamic>> defaultQues = [
    {
      "title": "Most Popular",
      "ques": [
        {
          "icon": Icons.ac_unit,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "question": "What is AI?",
        },
        {
          "icon": CupertinoIcons.smiley,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "question": "Tell me a joke",
        },
        {
          "icon": Icons.bubble_chart,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "question": "Explain the concept of machine learning",
        },
        {
          "icon": CupertinoIcons.cloud_bolt_rain,
          "color":
              Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "question": "How does climate change works?",
        },
      ],
    },

    {
      "title": "Trending",
      "ques": [
        {
          "icon": CupertinoIcons.heart,
          "color":
          Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "question": "What is meaning of life?",
        },
        {
          "icon": CupertinoIcons.smiley,
          "color":
          Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "question": "Tell me a joke",
        }
      ],
    },

    {
      "title": "Youtube",
      "ques": [
        {
          "icon": Icons.star,
          "color":
          Colors.primaries[Random().nextInt(Colors.primaries.length - 1)],
          "question": "Who is free fire india's best rusher?",
        },
      ],
    },

  ];
}
