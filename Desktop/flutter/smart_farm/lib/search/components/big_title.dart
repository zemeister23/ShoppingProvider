import 'package:flutter/material.dart';
import 'package:smart_farm/size_config.dart';

class BigTitle extends StatelessWidget {
  final String title;
  final bool isAllOpen;
  final VoidCallback? voidCallback;
  const BigTitle({
    Key? key,
    required this.title,
    required this.isAllOpen,
    this.voidCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 20.0,
              fontWeight: FontWeight.w600,
            ),
          ),
          flex: 8,
        ),
        isAllOpen
            ? GestureDetector(
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.black,
                      ),
                    ),
                  ),
                  child: const Text(
                    "Barchasi",
                    style: TextStyle(fontSize: 14.0),
                  ),
                ),
                onTap: voidCallback!)
            : Container(),
      ],
    );
  }
}
