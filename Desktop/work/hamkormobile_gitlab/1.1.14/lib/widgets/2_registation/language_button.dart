import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/models/language_model.dart';
import 'package:mobile/provider/1_intro_provider.dart';
import 'package:provider/provider.dart';
import '../../../provider/2_registration_provider.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChangeLanguageBottomSheet extends StatelessWidget {
  ChangeLanguageBottomSheet({Key? key}) : super(key: key);
  final List imageList = [
    ImageConst.instance.uzbFlag,
    ImageConst.instance.rusFlag,
  ];

  final List name = ["O’zbekcha", "Русский"];
  final List miniName = ["Uzb", "Pyc"];
  @override
  Widget build(BuildContext context) {
    late LanguageModel languageData =
        Provider.of<IntroProvider>(context, listen: false).langugage;
    return SizedBox(
      width: double.infinity,
      child: InkWell(
        onTap: () {
          showModalBottomSheet(
            context: context,
            enableDrag: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(context.h * 0.01),
                topLeft: Radius.circular(context.h * 0.01),
              ),
            ),
            builder: (_) {
              return StatefulBuilder(builder: (context, setState) {
                return SafeArea(
                  bottom: true,
                  top: false,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: context.h * 0.01),
                        height: context.h * 0.005,
                        width: context.w * 0.07,
                        decoration: BoxDecoration(
                          color: ColorConst.instance.kElementsColor,
                          borderRadius: BorderRadius.circular(2),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(
                            horizontal: context.w * 0.05,
                            vertical: context.w * 0.05),
                        alignment: Alignment.centerLeft,
                        child: Text("Изменить язык",
                            style: context.theme.headline5),
                      ),
                      ListView.separated(
                        separatorBuilder: (context, index) {
                          return Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: context.w * 0.01),
                            child: const Divider(),
                          );
                        },
                        physics: const NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: languageData.data!.length,
                        padding: EdgeInsets.symmetric(
                            horizontal: 0, vertical: context.h * 0.01),
                        itemBuilder: (BuildContext context, int index) {
                          return Theme(
                            data: ThemeData(
                              unselectedWidgetColor:
                                  ColorConst.instance.kSecondaryTextColor,
                            ),
                            child: RadioListTile(
                              controlAffinity: ListTileControlAffinity.trailing,
                              title: Row(
                                mainAxisSize: MainAxisSize.min,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  SizedBox(
                                    height: 24.h,
                                    width: 24.w,
                                    child: SvgPicture.asset(
                                      imageList[index],
                                    ),
                                  ),
                                  SizedBox(
                                    width: context.w * 0.01,
                                  ),
                                  Text(
                                    languageData.data![index].name.toString(),
                                  ),
                                ],
                              ),
                              groupValue:
                                  context.watch<RegistrationProvider>().value,
                              activeColor: ColorConst.instance.kPrimaryColor,
                              onChanged: (int? value) {
                                Provider.of<RegistrationProvider>(context,
                                        listen: false)
                                    .changeRadioButton(value!, context);
                                Navigator.pop(context);
                              },
                              value: index,
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                );
              });
            },
          );
       
       
       
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              imageList[context.watch<RegistrationProvider>().value],
            ),
            SizedBox(width: context.w * 0.009),
            Text(
              miniName[context.watch<RegistrationProvider>().value],
              style: context.theme.bodyText1,
            ),
            SizedBox(width: context.w * 0.001),
            Icon(
              Icons.arrow_drop_down_outlined,
              color: ColorConst.instance.kSecondaryTextColor,
              size: context.h * 0.03,
            )
          ],
        ),
      ),
    );
  }
}
