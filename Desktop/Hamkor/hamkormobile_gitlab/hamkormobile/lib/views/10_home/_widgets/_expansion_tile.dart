import 'package:flutter/material.dart';
import 'package:mobile/widgets/swipeinGoBack/swipe_in_go_back.dart';
import 'package:mobile/core/constants/colors/color_constants.dart';
import 'package:mobile/core/extensions/context_extension.dart';
import 'package:mobile/core/extensions/string_extension_locale.dart';
import 'package:mobile/views/10_home/container_decoration.dart';

class ExpansionTileW extends StatefulWidget {
  final String title;
  final double height, padding;
  final Widget child;
  final bool isCardsAndAccounts;
  final int dataLength;
  final bool isExpanded;
  final VoidCallback onTab;
  final bool? isNotBorder;
  final bool? isCardsContainer;
  ExpansionTileW(
      {Key? key,
      required this.title,
      required this.height,
      required this.padding,
      required this.child,
      required this.dataLength,
      required this.isCardsAndAccounts,
      required this.isExpanded,
      required this.onTab,
      this.isNotBorder = true,
      this.isCardsContainer = false})
      : super(key: key) {}

  @override
  State<ExpansionTileW> createState() => _ExpansionTileWState();
}

class _ExpansionTileWState extends State<ExpansionTileW> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: widget.padding),
            title: Row(
              children: <Widget>[
                Text(
                  widget.title,
                  style: context.theme.caption,
                ),
                Visibility(
                  visible: widget.dataLength > 3,
                  child: widget.isExpanded
                      ? Icon(
                          Icons.keyboard_arrow_up_rounded,
                          color: ColorConst.instance.kMainTextColor,
                          size: context.h * 0.03,
                        )
                      : Icon(
                          Icons.keyboard_arrow_down_rounded,
                          color: ColorConst.instance.kMainTextColor,
                          size: context.h * 0.03,
                        ),
                ),
              ],
            ),
            onTap: widget.onTab,
          ),
          AnimatedContainer(
            duration: const Duration(milliseconds: 0),
            height: widget.isExpanded
                ? widget.height
                : widget.isCardsAndAccounts
                    ? widget.dataLength > 3
                        ? context.h * 0.3
                        : context.h * (widget.dataLength / 10)
                    : context.h * (widget.dataLength / 10),
            margin: EdgeInsets.symmetric(horizontal: widget.padding),
            decoration: decoration(widget.isNotBorder!, widget.isExpanded),
            child: widget.child,
          ),
        ],
      ),
    );
  }

  Decoration decoration(bool isNotBorder, bool isExpanded) {
    if (widget.isCardsAndAccounts) {
      if (widget.isNotBorder!) {
        return ContainerDecorationComp.containerShadow(
          context,
        );
      } else {
        return context.homePrStreem.isExpanded
            ? ContainerDecorationComp.containerIsNotBottomBorder(context)
            : ContainerDecorationComp.containerShadow(
                context,
              );
      }
    } else {
      
      return ContainerDecorationComp.containerShadow(
        context,
      );
    }
  }
}
