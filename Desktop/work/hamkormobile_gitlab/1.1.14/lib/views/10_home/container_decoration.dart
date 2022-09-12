import 'package:flutter/material.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/extensions/context_extension.dart';

class ContainerDecorationComp {
  static containerShadow(BuildContext context) {
    return BoxDecoration(
      color: ColorConst.instance.kInputColor,
      borderRadius: BorderRadius.circular(context.h * 0.013),
      boxShadow: <BoxShadow>[
        BoxShadow(
          blurRadius: 13,
          color: ColorConst.instance.kShadowColor.withOpacity(0.12),
          offset: const Offset(0, 0),
          spreadRadius: 0,
        ),
      ],
    );
  }

  static containerShadow2(BuildContext context) {
    return BoxDecoration(
      color: ColorConst.instance.kInputColor,
      borderRadius: BorderRadius.circular(context.h * 0.015),
      boxShadow: <BoxShadow>[
        BoxShadow(
          blurRadius: 7,
          color: ColorConst.instance.kBlackColor.withOpacity(0.25),
          offset: const Offset(0, 0),
          spreadRadius: 0,
        ),
      ],
    );
  }

  static advertisementContainer(BuildContext context, int dataIndex) {
    return BoxDecoration(
      color: ColorConst.instance.kAdvertisementColor,
      borderRadius: BorderRadius.circular(context.h * 0.013),
      boxShadow: <BoxShadow>[
        BoxShadow(
          blurRadius: 13,
          color: ColorConst.instance.kShadowColor.withOpacity(0.12),
          offset: const Offset(0, 0),
          spreadRadius: 0,
        ),
      ],
    );
  }



  static containerWithoutShadow(BuildContext context) {
    return BoxDecoration(
      
      color: ColorConst.instance.kInputColor,
      borderRadius: BorderRadius.circular(context.h * 0.013),
    );
  }

  

}


