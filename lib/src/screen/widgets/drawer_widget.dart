import 'package:cybernotes/src/constants/screen_routes.dart';
import 'package:cybernotes/src/screen/widgets/app_widget_size.dart';
import 'package:flutter/material.dart';

class DrawerWidget extends StatelessWidget {
  List<DrawerMenuModel> menuList = [
    DrawerMenuModel('NEW NOTES', ScreenRoutes.NEW_NOTE),
    DrawerMenuModel('OPEN NOTES ', ScreenRoutes.OPEN_NOTES),
    //DrawerMenuModel('REFERRAL CODE', ''),
    DrawerMenuModel('SUGGESTION', ScreenRoutes.SUGGESTIONS),
    DrawerMenuModel('PRIVACY & TERMS', ScreenRoutes.PRIVACY),
    DrawerMenuModel('RATING', ''),
    DrawerMenuModel('HOW TO USE?', ''),
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: double.infinity,
      width: MediaQuery.of(context).size.width * 0.67,
      padding: EdgeInsets.only(
        left: 18,
        top: kToolbarHeight,
        bottom: AppWidgetSize.dimen_20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: List.generate(
          menuList.length,
          (int index) {
            return buildMenuItem(menuList[index], context);
          },
        ),
      ),
    );
  }

  GestureDetector buildMenuItem(
      DrawerMenuModel drawerMenuItem, BuildContext context) {
    return GestureDetector(
      onTap: () => drawerMenuItem.lableName != ''
          ? Navigator.of(context).pushReplacementNamed(drawerMenuItem.routing)
          : null,
      child: Container(
        padding: EdgeInsets.only(top: 30),
        child: Text(
          drawerMenuItem.lableName,
          style: Theme.of(context).textTheme.headline2,
        ),
      ),
    );
  }
}

class DrawerMenuModel {
  String lableName;
  String routing;
  DrawerMenuModel(this.lableName, this.routing);
}
