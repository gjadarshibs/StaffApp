import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ifly_corporate_app/data/models/remote/user_model.dart';
import 'package:ifly_corporate_app/presentation/utils/common_widgets.dart';
import 'package:ifly_corporate_app/presentation/utils/text_style_extensions.dart';
import 'package:ifly_corporate_app/presentation/utils/color_extensions.dart';

class SideDrawer extends StatefulWidget {

  SideDrawer({
    Key key,
    this.selectedItem,
    this.onSelection,
    this.userInfo,
  }) : super(key: key);

  final String selectedItem;
  final Function(String) onSelection;
  final UserInfoModel userInfo;

  @override
  _SideDrawerState createState() => _SideDrawerState();
}

class _SideDrawerState extends State<SideDrawer> {



  final ScrollController _scrollController = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Scrollbar(
        controller: _scrollController,
        child: ListView(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.bottomLeft,
                  end: Alignment(-1.0, -1.0),
                  colors: [
                    Theme.of(context).colorScheme.bookingDetailGradientBottom,
                    Theme.of(context).colorScheme.bookingDetailGradientMiddle,
                    Theme.of(context).colorScheme.bookingDetailGradientTop,
                  ],
                ),
              ),
              child: Container(
                padding: EdgeInsets.fromLTRB(23, 21, 75, 29),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    SvgPicture.asset(
                      'assets/images/user.svg',
                      height: 47,
                      width: 47,
                      color: Theme.of(context).colorScheme.appBarIconColor,
                    ),
                    SizedBox(
                      width: 25,
                    ),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Text(
                            '${widget.userInfo.firstName} ${widget.userInfo.middleName} ${widget.userInfo.surname}',
                            style:
                                Theme.of(context).textTheme.slideMenuUserTitle,
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                              'Staff ID: ${widget.userInfo.empCode}',
                              style: Theme.of(context)
                                  .textTheme
                                  .slideMenuUserSubTitle),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Container(
              color: Theme.of(context).colorScheme.slideMenuContainer,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount:
                    widget.userInfo.roles[0].modules.length,
                itemBuilder: (context, moduleIndex) {

                  return (widget.userInfo.roles[0]
                          .modules[moduleIndex].subModules.isNotEmpty)
                      ? Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Container(
                              padding: EdgeInsets.fromLTRB(20, 8, 0, 8),
                              width: double.infinity,
                              color: Theme.of(context)
                                  .colorScheme
                                  .slideMenuHeadFill,
                              child: Text(
                                widget.userInfo.roles[0]
                                    .modules[moduleIndex].moduleName
                                    .toUpperCase(),
                                style:
                                    Theme.of(context).textTheme.slideMenuHead,
                              ),
                            ),
                            ListView.builder(
                              physics: NeverScrollableScrollPhysics(),
                              shrinkWrap: true,
                              itemCount: widget
                                  .userInfo
                                  .roles[0]
                                  .modules[moduleIndex]
                                  .subModules
                                  .length,
                              itemBuilder: (context, subModuleIndex) {
                                return ListTileTheme(
                                  selectedColor: Colors.red,
                                  child: ListTile(
                                    selected: widget.selectedItem ==
                                        widget
                                            .userInfo
                                            .roles[0]
                                            .modules[moduleIndex]
                                            .subModules[subModuleIndex]
                                            .subModuleCode,
                                    leading: getIcon(
                                        widget
                                            .userInfo
                                            .roles[0]
                                            .modules[moduleIndex]
                                            .subModules[subModuleIndex]
                                            .subModuleCode,
                                        Theme.of(context)
                                            .colorScheme
                                            .slideMenuIconColor),
                                    title: Text(
                                        widget
                                            .userInfo
                                            .roles[0]
                                            .modules[moduleIndex]
                                            .subModules[subModuleIndex]
                                            .subModuleName,
                                        style: Theme.of(context)
                                            .textTheme
                                            .slideMenuModules),
                                    onTap: () {
                                      widget.onSelection(widget
                                          .userInfo
                                          .roles[0]
                                          .modules[moduleIndex]
                                          .subModules[subModuleIndex]
                                          .subModuleCode);
                                    },
                                  ),
                                );
                              },
                            ),
                            Divider(
                              height: 0,
                              color:
                                  Theme.of(context).colorScheme.sldeMenuDivider,
                            )
                          ],
                        )
                      : ListTileTheme(
                          selectedColor: Colors.red,
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                selected: widget.selectedItem ==
                                    widget.userInfo.roles[0]
                                        .modules[moduleIndex].moduleCode,
                                leading: getIcon(
                                    widget.userInfo.roles[0]
                                        .modules[moduleIndex].moduleCode,
                                    Theme.of(context)
                                        .colorScheme
                                        .slideMenuIconColor),
                                title: Text(
                                    widget.userInfo.roles[0]
                                        .modules[moduleIndex].moduleName,
                                    style: Theme.of(context)
                                        .textTheme
                                        .slideMenuModules),
                                onTap: () {
                                  widget.onSelection(widget
                                      .userInfo
                                      .roles[0]
                                      .modules[moduleIndex]
                                      .moduleCode);
                                },
                              ),
                              Divider(
                                height: 0,
                                color: Colors.black,
                              )
                            ],
                          ),
                        );
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
