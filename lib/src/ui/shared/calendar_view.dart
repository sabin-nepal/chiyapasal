import 'package:flutter/material.dart';
import 'package:syncfusion_flutter_calendar/calendar.dart';

import '../../core/res/route.dart';
import '../../core/res/styles.dart';

class CustomCalendarView extends StatelessWidget {
  final String userId;
  const CustomCalendarView({Key? key, required this.userId}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SfCalendar(
      headerStyle: const CalendarHeaderStyle(
          textAlign: TextAlign.center, textStyle: boldText),
      showNavigationArrow: true,
      view: CalendarView.month,
      monthViewSettings: const MonthViewSettings(dayFormat: 'EEE'),
      onTap: (val) {
        Navigator.pushNamed(context, AppRoutes.auctionHistory,
            arguments: {'date': val.date, 'userId': userId});
      },
    );
  }
}
