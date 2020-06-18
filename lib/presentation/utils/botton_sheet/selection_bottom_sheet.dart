import 'package:flutter/material.dart';
import 'package:ifly_corporate_app/presentation/utils/botton_sheet/selection_bottom_sheet_boday.dart';
import 'package:ifly_corporate_app/presentation/utils/botton_sheet/selection_botton_sheet_header.dart';

class SelectionBottomSheetItem {
  SelectionBottomSheetItem({@required this.title, this.image, this.showImage = false});
  final String title;
  final String image;
  final bool showImage; 

  static List<SelectionBottomSheetItem> basicLoginBottonSheetItems({bool showImage = true}) {
    return [
      SelectionBottomSheetItem(title: 'Password Information', image: 'assets/images/icn-key.png', showImage: showImage),
      SelectionBottomSheetItem(title: 'Not You? Switch User', image: 'assets/images/icn-switch-user.png', showImage: showImage),
      SelectionBottomSheetItem(title: 'Goto Desktop Website', image: 'assets/images/icn-desktop.png', showImage: showImage)
    ];
  }
}

class SelectionBottomSheet extends StatelessWidget {
  SelectionBottomSheet({@required this.title, @required this.sheetItems, this.aspectRatio = 1.5 ,this.onSelection});
  final String title;
  final double aspectRatio;
  final List<SelectionBottomSheetItem> sheetItems;
  final Function(SelectionBottomSheetItem, int) onSelection;
  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      child: Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.6),
              spreadRadius: 10,
              blurRadius: 20,
              offset: Offset(0, 4),
            ),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(22.0),
            topRight: const Radius.circular(22.0),
          ),
        ),
        child: Column(
          verticalDirection: VerticalDirection.down,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            SelectionBottomSheetHeader(title: title,),
            SelctionBottomSheetBody(items: sheetItems, onSelection: onSelection,),
          ],
        ),
      ),
    );
  }
}
