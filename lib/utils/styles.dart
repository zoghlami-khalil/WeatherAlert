import 'package:flutter/material.dart';

const TextStyle textStyleSmall = TextStyle(
  fontFamily: 'Inter',
  fontSize: 14,
  color: Colors.white,
);

const BoxDecoration cardDecoration = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(15)),
  color: Color.fromRGBO(255, 255, 255, 0.06),
  boxShadow: [
    BoxShadow(
      color: Color.fromRGBO(0, 0, 0, 0.17),
      offset: Offset(5, 6),
      blurRadius: 6.8,
    ),
  ],
);
