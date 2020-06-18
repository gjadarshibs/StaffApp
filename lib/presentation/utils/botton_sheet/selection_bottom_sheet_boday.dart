import 'package:flutter/material.dart';
import 'package:ifly_corporate_app/presentation/utils/botton_sheet/selection_bottom_sheet.dart';



class SelctionBottomSheetBody extends StatelessWidget {
  const SelctionBottomSheetBody({@required this.items, this.onSelection});
  final List<SelectionBottomSheetItem> items;
  final Function(SelectionBottomSheetItem, int) onSelection;
  Widget _buildItem(BuildContext context, int index) {
    final item = items[index];
    return GestureDetector(
      onTap: () => onSelection(item, index),
      child: ListTile(
        leading: item.image == null
            ? Container(
                height: 20,
                width: 20,
              )
            : item.showImage ? Container(
              padding: EdgeInsets.only(left: 8.0),
              child: Image(
                  width: 24.0,
                  height: 24.0,
                  image: AssetImage(
                    item.image,
                  ),
                  color: Color(0xFF159697),
                ),
            ) : Container(
                height: 20,
                width: 20,
              ),
        title: Container(
          child: Text(
            item.title,
            style: TextStyle(fontSize: 18),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemBuilder: _buildItem,
        itemCount: items.length,
      ),
    );
  }
}
