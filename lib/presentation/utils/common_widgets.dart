import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:ifly_corporate_app/presentation/utils/color_extensions.dart';
import 'package:ifly_corporate_app/presentation/utils/text_style_extensions.dart';

Widget getIcon(String moduleCode, Color iconColor) {
  switch (moduleCode) {
    case 'DSH':
      return SvgPicture.asset(
        'assets/images/dashboard.svg',
        height: 22,
        width: 22,
        color: iconColor,
      );
      break;
    case 'LTCURBOOK':
      return SvgPicture.asset(
        'assets/images/bookings.svg',
        height: 22,
        width: 22,
        color: iconColor,
      );
      break;
    case 'LTMKBOOK':
      return SvgPicture.asset(
        'assets/images/LT-plane.svg',
        height: 22,
        width: 22,
        color: iconColor,
      );
      break;
    case 'BNFDTL':
      return SvgPicture.asset(
        'assets/images/myID.svg',
        height: 22,
        width: 22,
        color: iconColor,
      );
      break;
    case 'TVENT':
      return SvgPicture.asset(
        'assets/images/taxi.svg',
        height: 22,
        width: 22,
        color: iconColor,
      );
      break;
    case 'BNFNMN':
      return SvgPicture.asset(
        'assets/images/overview.svg',
        height: 22,
        width: 22,
        color: iconColor,
      );
      break;
       case 'LGT':
      return SvgPicture.asset(
        'assets/images/logout.svg',
        height: 22,
        width: 22,
        color: iconColor,
      );
      break;
    default:
      return SvgPicture.asset(
        'assets/images/exclamation.svg',
        height: 22,
        width: 22,
        color: iconColor,
      );
  }
}

String getFormattedDateTime(String dateTime) {
  var dateTimeFormat = DateFormat('dd-MMM-yyyy hh:mm:ss');
  var formattedDateTime = dateTimeFormat.parse(dateTime);
  var convertedDateTimeFormat =
      DateFormat('dd MMM yy, HH:mm').format(formattedDateTime);
  return convertedDateTimeFormat;
}

String getFormattedDate(String date) {
  var dateFormat = DateFormat('dd-MMM-yyyy');
  var formattedDate = dateFormat.parse(date);
  var convertedDateFormat = DateFormat('dd MMM yy').format(formattedDate);
  return convertedDateFormat;
}

String getFormattedDateWithoutYear(String date) {
  var dateFormat = DateFormat('dd-MMM-yyyy');
  var formattedDate = dateFormat.parse(date);
  var convertedDateFormat = DateFormat('dd MMM').format(formattedDate);
  return convertedDateFormat;
}

DateTime getDate(String date) {
  var dateFormat = DateFormat('dd-MMM-yyyy');
  var formattedDate = dateFormat.parse(date);
  return formattedDate;
}

Widget getNotificationBadge(BuildContext context) {
  return Container(
    alignment: Alignment.center,
    padding: EdgeInsets.all(5),
    decoration: ShapeDecoration(
        shape: CircleBorder(),
        color: Theme.of(context).colorScheme.notoficationBadge),
    child: Text(
      '1',
      style: Theme.of(context).textTheme.notificationNumber,
    ),
  );
}
