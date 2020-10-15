import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

// ignore: must_be_immutable
class CategoryItems extends StatelessWidget {
  // String imagePath;
  String title;
  String imagePath;
  Function onTap;
  CategoryItems({this.title, this.imagePath, this.onTap});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return InkWell(
      onTap: onTap,
      child: Card(
        color: Colors.grey[200],
        elevation: 0.5,
        margin: EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15.0),
        ),
        child: Column(
          children: <Widget>[
            SizedBox(height: 30.h),
            CircleAvatar(
              radius: 60.h,
              backgroundImage: AssetImage(imagePath),
            ),
            SizedBox(height: 40.h),
            Text(
              title,
              style: Theme.of(context).textTheme.headline2.copyWith(
                    color: Colors.grey[700],
                    fontSize:
                        ScreenUtil().setSp(25, allowFontScalingSelf: true),
                  ),
            ),
          ],
        ),
      ),
    );
  }
}
