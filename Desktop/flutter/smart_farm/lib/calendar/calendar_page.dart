import 'package:flutter/material.dart';
import 'package:smart_farm/constants.dart';
import 'package:smart_farm/size_config.dart';

import 'package:syncfusion_flutter_calendar/calendar.dart';

class CalendarPage extends StatelessWidget {
  const CalendarPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Theme(
          data: ThemeData(
            // ignore: deprecated_member_use
            accentColor: kPrimaryExtraColor,
          ),
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: getProportionateScreenWidth(14.0),
              vertical: getProportionateScreenHeight(12.0),
            ),
            child: Column(
              children: [
                Expanded(
                  child: SfCalendar(
                    view: CalendarView.month,
                    headerStyle: const CalendarHeaderStyle(
                      textStyle: TextStyle(
                        fontSize: 24.0,
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    blackoutDatesTextStyle: const TextStyle(
                      fontSize: 16.0,
                      color: Colors.green,
                    ),
                    initialDisplayDate: DateTime.now(),
                    cellBorderColor: Colors.transparent,
                  ),
                  flex: 6,
                ),
                const Divider(color: kPrimaryBorderColor, height: 0.2),
                Expanded(
                  child: Container(
                    alignment: Alignment.topLeft,
                    padding: const EdgeInsets.all(12.0),
                    child: const Text(
                      "Bu yerda sizning eslatmangiz bo'ladi",
                      style: TextStyle(
                        color: kPrimaryBorderColor,
                        fontSize: 16.0,
                      ),
                    ),
                  ),
                  flex: 4,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
