import 'package:flutter/material.dart';

class DecoConst {
  InputDecoration inputDecoration(String label) => InputDecoration(
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        label: Text(label),
      );
}
