import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:get_storage/get_storage.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/core/init/cache/get_storege.dart';
import 'package:mobile/models/offerta_model.dart';
import 'package:mobile/provider/4_oferta_provider.dart';
import 'package:mobile/routes/router/router.dart';
import 'package:mobile/widgets/gradient_button_widget.dart';
import 'package:provider/provider.dart';

class OffertaData extends StatelessWidget {
  OffertaData({Key? key}) : super(key: key);

  String offertaNull = """
Высокий уровень вовлечения представителей целевой аудитории является четким доказательством простого факта: разбавленное изрядной долей эмпатии, рациональное мышление создаёт необходимость включения в производственный план целого ряда внеочередных мероприятий с учётом комплекса форм воздействия. С учётом сложившейся международной обстановки, высококачественный прототип будущего проекта предполагает независимые способы реализации новых предложений.

Мы вынуждены отталкиваться от того, что курс на социально-ориентированный национальный проект, а также свежий взгляд на привычные вещи - безусловно открывает новые горизонты для распределения внутренних резервов и ресурсов. Ясность нашей позиции очевидна: сплочённость команды профессионалов обеспечивает актуальность стандартных подходов. С учётом сложившейся международной обстановки, выбранный нами инновационный путь не оставляет шанса для стандартных подходов. Повседневная практика показывает, что перспективное планирование влечет за собой процесс внедрения и модернизации кластеризации усилий.

В частности, выбранный нами инновационный путь влечет за собой процесс внедрения и модернизации распределения внутренних резервов и ресурсов. Есть над чем задуматься: непосредственные участники технического прогресса могут быть объявлены нарушающими общечеловеческие нормы этики и морали. Безусловно, реализация намеченных плановых заданий создаёт предпосылки для соответствующих условий активизации. Приятно, граждане, наблюдать, как диаграммы связей лишь добавляют фракционных разногласий и своевременно верифицированы. Социально-экономическое развитие однозначно определяет каждого участника как способного принимать собственные решения касаемо распределения внутренних резервов и ресурсов. С другой стороны, повышение уровня гражданского сознания выявляет срочную потребность соответствующих условий активизации.""";

  @override
  Widget build(BuildContext context) {
    OfertaProvider _myProvider = context.watch<OfertaProvider>();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
            flex: 4,
            child: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "oferta".locale,
                      style: context.theme.headline1,
                      //textAlign: TextAlign.center,
                    ),
                    SizedBox(
                      height: context.h * 0.02,
                    ),
                    Text(
                      GetStorageService.instance.box
                              .read(GetStorageService.instance.ofertaText) ??
                          offertaNull,
                      style: context.theme.bodyText1,
                    ),
                  ],
                ),
              ),
            )),
        Expanded(
            child: SizedBox(
          child: Column(
            children: [
              Row(
                children: [
                  Checkbox(
                    activeColor: ColorConst.instance.kPrimaryColor,
                    checkColor: ColorConst.instance.kInputColor,
                    value: context.watch<OfertaProvider>().checkbox,
                    onChanged: (v) {
                      Provider.of<OfertaProvider>(context, listen: false)
                          .changeCheckBox(v!);
                    },
                  ),
                  InkWell(
                    onTap: () {
                      Provider.of<OfertaProvider>(context, listen: false)
                          .changeCheckBox(true);
                    },
                    child: SizedBox(
                      width: context.w / 1.2,
                      child: AutoSizeText(
                        "accept_oferta".locale,
                        style: context.theme.subtitle2,
                        //   maxFontSize: 17,
                        //   minFontSize: 12,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: context.w * 0.02),
                  child: GradientButton(
                    height: context.h * 0.07,
                    width: double.infinity,
                    onPressed: () {
                      if (_myProvider.checkbox) {
                        NavigationService.instance
                            .pushNamed(routeName: "/6_pincode");
                      }
                    },
                    colorOpacity: _myProvider.checkbox,
                    text: "accept".locale,
                  )),
            ],
          ),
        ))
      ],
    );
  }
}
