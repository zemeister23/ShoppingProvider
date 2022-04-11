import 'package:animation/services/get_service.dart';
import 'package:flutter/material.dart';

class MyFloatingActionButton extends StatelessWidget {
  const MyFloatingActionButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      backgroundColor: Colors.red,
      child: const Icon(Icons.delete),
      onPressed: () {
        GetService.box.write('isDone', false);
        debugPrint("IsDone: false");
      },
    );
  }
}
