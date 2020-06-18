import 'package:flutter/material.dart';
import 'package:ifly_corporate_app/data/models/remote/user_model.dart';
import 'package:ifly_corporate_app/presentation/pages/current_bookings/current_bookings.dart';
import 'package:ifly_corporate_app/presentation/pages/make_booking/make_booking.dart';
import 'package:ifly_corporate_app/presentation/utils/common_widgets.dart';
import 'package:ifly_corporate_app/presentation/utils/color_extensions.dart';

class ShortcutsMenu extends StatelessWidget {
  final BuildContext context;
  final List<ShortcutModel> shortcuts;
  final double maxHeight;
  final double itemSize;
  final double spaceBetweenItems;
  static double shortcutMenuItemWidthPercentage = 0.8;
  ShortcutsMenu({
    this.context,
    this.shortcuts,
    this.maxHeight,
    this.itemSize,
    this.spaceBetweenItems,
  });
  void navigateToPage(String submoduleCode) {
    switch (submoduleCode) {
      case 'LTCURBOOK':
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return CurrentBookingsPage();
        }));
        break;
      case 'LTMKBOOK':
        Navigator.push(context, MaterialPageRoute(builder: (context) {
          return MakeBookingPage();
        }));
        break;
      default:
        return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    if (shortcuts.isNotEmpty) {
      final maxWidth = calculateMaxWidthForShortCutMenuWithCount(
          shortcuts.length.toDouble(),
          itemWidth: itemSize,
          availableWidthWeCanUse: MediaQuery.of(context).size.width *
              shortcutMenuItemWidthPercentage);
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          getHeaderBackGroundWithAppBarThemeColor(),
          getBottomRoundShadowWith(
            width: maxWidth,
            height: itemSize,
          ),
          getShortCutItemsInWhiteRoundBackGroundWith(
            maxWidth: maxWidth,
            itemSize: itemSize,
            spaceBetweenItems: spaceBetweenItems,
            items: shortcuts,
          ),
        ],
      );
    } else {
      return Stack(
        alignment: Alignment.center,
        children: <Widget>[
          getHeaderBackGroundWithAppBarThemeColor(),
        ],
      );
    }
  }

  /// BackGround with top left and right round border
  Widget getHeaderBackGroundWithAppBarThemeColor() {
    return Container(
      child: Column(
        children: <Widget>[
          Flexible(
            child: Container(
              color: Colors.transparent,
            ),
          ),
          Flexible(
            child: Container(
              decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.bookingDetailsContainer,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(16),
                      topRight: Radius.circular(16))),
            ),
          ),
        ],
      ),
    );
  }

  /// Bottom round shadow with given color , width and height
  Widget getBottomRoundShadowWith({double width, double height}) {
    return Container(
      margin: EdgeInsets.only(top: 4.0),
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.shortcutOrangeShadow,
        borderRadius: BorderRadius.all(Radius.circular(height / 2)),
        boxShadow: [
          BoxShadow(
            color: Theme.of(context)
                .colorScheme
                .shortcutBackgroundShadow
                .withOpacity(0.2),
            spreadRadius: 3,
            blurRadius: 5,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }

  ///  Round white background with given width , height and
  ///  adding array of Shortcut items to it
  Widget getShortCutItemsInWhiteRoundBackGroundWith(
      {double maxWidth,
      double itemSize,
      double spaceBetweenItems,
      List<ShortcutModel> items}) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(itemSize / 2)),
      child: Container(
        width: maxWidth,
        height: itemSize,
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.bookingDetailsContainer,
          borderRadius: BorderRadius.all(
            Radius.circular(itemSize / 2),
          ),
        ),
        child: ListView.builder(
          itemCount: items.length,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return Tooltip(
              message: '${items[i].subModuleName}',
              child: GestureDetector(
                child: Container(
                  padding: EdgeInsets.all(spaceBetweenItems),
                  child: Container(
                    padding: EdgeInsets.all(10),
                    width: itemSize - (2 * spaceBetweenItems),
                    height: itemSize - (2 * spaceBetweenItems),
                    child: getIcon(items[i].subModuleCode,
                        Theme.of(context).colorScheme.shortcutIconColor),
                    decoration: BoxDecoration(
                      color: Theme.of(context)
                          .colorScheme
                          .shortcutBackgroundCircle,
                      borderRadius: BorderRadius.all(Radius.circular(
                          (itemSize - (2 * spaceBetweenItems)) / 2.0)),
                    ),
                  ),
                  width: itemSize,
                  height: itemSize,
                  decoration: BoxDecoration(
                    color:
                        Theme.of(context).colorScheme.bookingDetailsContainer,
                    borderRadius:
                        BorderRadius.all(Radius.circular(itemSize / 2.0)),
                  ),
                ),
                onTap: () {
                  print(items[i].subModuleName);
                  navigateToPage(items[i].subModuleCode);
                },
              ),
            );
          },
        ),
      ),
    );
  }

  static double calculateMaxWidthForShortCutMenuWithCount(double count,
      {double itemWidth, double availableWidthWeCanUse}) {
    if ((itemWidth * count) >= availableWidthWeCanUse) {
      return availableWidthWeCanUse - (availableWidthWeCanUse % itemWidth);
    } else {
      return (itemWidth * count);
    }
  }
}
