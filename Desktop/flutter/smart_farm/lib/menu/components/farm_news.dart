import 'package:flutter/material.dart';
import 'package:liquid_progress_indicator/liquid_progress_indicator.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/menu/components/news_text_version.dart';
import 'package:smart_farm/size_config.dart';

class FarmNews extends StatelessWidget {
  final String? version;
  final String? readiness;
  final String? title;
  final String? description;

  const FarmNews(
      {Key? key, this.version, this.readiness, this.title, this.description})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
          horizontal: getProportionateScreenWidth(14.0),
          vertical:
              getProportionateScreenHeight(version != "init" ? 8.0 : 0.0)),
      padding: version == "init" ? const EdgeInsets.all(8.0) : null,
      decoration: BoxDecoration(
        border: Border.all(
            width: 0.5,
            color:
                version == "init" ? kPrimaryBorderColor : Colors.transparent),
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: Row(
        children: [
          Expanded(
            child: version == "init"
                ? firstVersion(title!, description!)
                : secondVersion(title!, description!, readiness!),
            flex: 7,
          ),
          const Spacer(flex: 1),
          Expanded(
            child: Container(
              height: version == "init"
                  ? null
                  : getProportionateScreenHeight(108.0),
              alignment: Alignment.center,
              child: LiquidLinearProgressIndicator(
                value: double.parse(readiness!) * 0.01, // Defaults to 0.5.
                valueColor: const AlwaysStoppedAnimation(
                    kPrimaryColor), // Defaults to the current Theme's accentColor.
                backgroundColor: Colors
                    .white, // Defaults to the current Theme's backgroundColor.
                borderColor: kPrimaryColor,
                borderWidth: 1.0,
                borderRadius: 10.0,
                direction: Axis
                    .vertical, // The direction the liquid moves (Axis.vertical = bottom to top, Axis.horizontal = left to right). Defaults to Axis.horizontal.
                center: version == "init"
                    ? Text(
                        "$readiness %\nTayyor",
                        textAlign: TextAlign.center,
                      )
                    : Text(
                        "$readiness %\nYegulik",
                        textAlign: TextAlign.center,
                      ),
              ),
            ),
            flex: 3,
          ),
        ],
      ),
    );
  }
}
