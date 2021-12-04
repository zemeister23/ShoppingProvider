import 'package:flutter/material.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/menu/components/news_text_version.dart';
import 'package:smart_farm/size_config.dart';

class FarmNews extends StatelessWidget {
  final String? version;
  const FarmNews({Key? key, this.version}) : super(key: key);

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
            child: version == "init" ? firstVersion() : secondVersion(),
            flex: 7,
          ),
          const Spacer(flex: 1),
          Expanded(
            child: Container(
              height: version == "init"
                  ? null
                  : getProportionateScreenHeight(108.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: kPrimaryColor,
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    offset: const Offset(0.8, 5.0),
                    color: kPrimaryColor.withOpacity(0.2),
                    blurRadius: 6.0,
                  ),
                ],
              ),
              child: Text(
                "55%",
                style: TextStyle(
                  fontSize: getProportionateScreenHeight(18.0),
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
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
