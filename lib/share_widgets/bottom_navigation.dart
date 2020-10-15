import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';

// ignore: must_be_immutable
class MyBottomNavigation extends StatelessWidget {
  int pageIndex;
  Function onTap;
  MyBottomNavigation({this.pageIndex, this.onTap});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);

    return CupertinoTabBar(
      currentIndex: pageIndex,
      onTap: onTap,
      activeColor: Colors.yellow,
      items: [
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/team.png',
            width: 50,
            height: 50,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/online-order.png',
            width: 50,
            height: 50,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/shopping-cart.png',
            width: 50,
            height: 50,
          ),
        ),
        BottomNavigationBarItem(
          icon: Image.asset(
            'assets/icons/home-office.png',
            width: 50,
            height: 50,
          ),
        ),
      ],
    );
  }
}
