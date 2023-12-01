import 'package:flutter/material.dart';

class StyledTexts {
  static labelText(String text) => Text(
        text,
        style: const TextStyle(
            fontSize: 20, fontWeight: FontWeight.bold, color: Colors.black),
      );
  static header1(String text) => Text(
        text,
        style: const TextStyle(
            fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),
      );
  static header25(String text) => Text(
        text,
        style: const TextStyle(
            fontSize: 30, fontWeight: FontWeight.w600, color: Colors.black),
      );
  static nameText(String text) => Text(
        text,
        overflow: TextOverflow.ellipsis,
        maxLines: 2,
        style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Color.fromARGB(255, 180, 179, 179)),
      );
  static text15(String text) => Text(
        text,
        style: const TextStyle(
            fontSize: 15, fontWeight: FontWeight.bold, color: Colors.black),
      );
}
