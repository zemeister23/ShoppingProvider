import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/constants/sizeconst/size_const.dart';
import 'package:mobile/core/constants/texts/font_size_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/views/11_stories/_widget/_button.dart';

class StoriesScreen extends StatelessWidget {
  const StoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            fit: BoxFit.cover,
            alignment: Alignment.bottomRight,
            image: AssetImage(
              ImageConst.instance.toPng("stories_background"),
            ),
          ),
        ),
        child: SafeArea(
          child: Column(
            children: <Widget>[
              AppBar(
                backgroundColor: Colors.transparent,
                elevation: 0,
                centerTitle: true,
                iconTheme: IconThemeData(
                  color: ColorConst.instance.kMainTextColor,
                ),
                leading: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
              const Spacer(flex: 2),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: context.w * 0.04),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      "free_translations".locale,
                      style: TextStyle(
                        color: ColorConst.instance.kMainTextColor,
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    SizedBox(height: context.h * 0.02),
                    Text(
                      "promotion_app".locale,
                      style: TextStyle(
                        color: ColorConst.instance.kMainTextColor,
                        fontSize: FontSizeConst.instance.extraSmall,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              const Spacer(flex: 11),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: StoriesGradientButton(
        text: "make_translation".locale,
        width: 242.w,
        height: SizeConst.instance.buttonSize,
        onPressed: () {
          NavigationService.instance.pushNamed(routeName: "/11_transactions");
        },
      ),
    );
  }
}
