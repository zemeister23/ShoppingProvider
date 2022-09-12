import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mobile/core/components/input_decoration/form_input_decoration.dart';
import 'package:mobile/core/components/text/text_style.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/constants/images/image_const.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import '../../../core/constants/texts/font_size_const.dart';
import 'package:mask_input_formatter/mask_input_formatter.dart';

class CardWidget extends StatelessWidget {
  CardWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: context.h / 7.5,
      width: context.h * 0.9,
      decoration: BoxDecoration(
        color: ColorConst.instance.kInputColor,
        borderRadius: BorderRadius.circular(context.h * 0.013),
        boxShadow: <BoxShadow>[
          BoxShadow(
            blurRadius: 13,
            color: const Color(0xFF626562).withOpacity(0.12),
            offset: const Offset(0, 0),
            spreadRadius: 0,
          ),
        ],
      ),
      child: Column(
        children: <Widget>[
          const Spacer(),
          Row(
            children: <Widget>[
              const Spacer(),
              SizedBox(
                height: context.h * 0.03,
                width: context.w / 2.7,
                child: SvgPicture.asset(
                  ImageConst.instance.miniLogo,
                  color: ColorConst.instance.kPrimaryColor,
                ),
              ),
              const Spacer(flex: 8),
              //   SvgPicture.asset(
              //    ImageConst.instance.cardLogo,
              //  ),
              const Spacer(),
            ],
          ),
          const Spacer(),
          Form(
            key: context.addCardPr.formKey,
            child: Row(
              children: <Widget>[
                const Spacer(flex: 2),
                Expanded(
                  flex: 25,
                  child: SizedBox(
                    height: context.h * 0.05,
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      controller: context.addCardPr.cardNumberController,
                      onChanged: (v) {
                        context.addCardPr.changeCardNumber(v, context);
                        context.addCardPr.changeOpasity();
                      },
                      inputFormatters: [
                        MaskInputFormatter(mask: '#### #### #### ####'),
                      ],
                      style: TextStyle(
                        fontSize: FontSizeConst.instance.large,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorConst.instance.kBackgroundColor,
                        hintText: "0000 0000 0000 0000",
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        isCollapsed: true,
                        hintStyle: TextStyleCompanents.instance.hineTextStyle,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: context.h * 0.01,
                          horizontal: context.w * 0.03,
                        ),
                        focusedBorder: DecoInput.instance.focusedBorder(
                          context.addCardPrStreem.erorColorState
                              ? ColorConst.instance.kErrorColor
                              : Colors.transparent,
                        ),
                        enabledBorder: DecoInput.instance.enabledBOrder(
                          context.h * 0.01,
                        ),
                      ),
                    ),
                
                
                  ),
                ),
                const Spacer(flex: 2),
                Expanded(
                  flex: 10,
                  child: SizedBox(
                    height: context.h * 0.05,
                    child: TextFormField(
                      focusNode: context.addCardPr.focus,
                      inputFormatters: [
                        MaskInputFormatter(mask: '##/##'),
                      ],
                      keyboardType: TextInputType.number,
                      controller: context.addCardPr.cardExpireController,
                      onChanged: (v) {
                        if (v.length > 4) {
                          context.addCardPr.changeCardExpire(v);
                        }
                        context.addCardPr.changeOpasity();
                      },
                      style: TextStyle(
                        fontSize: FontSizeConst.instance.large,
                        fontWeight: FontWeight.w400,
                      ),
                      decoration: InputDecoration(
                        filled: true,
                        fillColor: ColorConst.instance.kBackgroundColor,
                        hintText: "mm/yy".locale,
                        hintStyle: TextStyleCompanents.instance.hineTextStyle,
                        contentPadding: EdgeInsets.symmetric(
                          vertical: context.h * 0.01,
                          horizontal: context.w * 0.03,
                        ),
                        focusedBorder: DecoInput.instance.focusedBorder(
                          context.addCardPrStreem.erorColorState
                              ? ColorConst.instance.kErrorColor
                              : Colors.transparent,
                        ),
                        enabledBorder: DecoInput.instance.enabledBOrder(
                          context.h * 0.01,
                        ),
                      ),
                    ),
                  ),
                ),
                const Spacer(flex: 2),
              ],
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
