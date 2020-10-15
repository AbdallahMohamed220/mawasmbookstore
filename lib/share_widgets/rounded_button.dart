import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class RoundButton extends StatelessWidget {
  final Color color;
  final Function onpress;
  final String text;

  RoundButton({this.color, this.onpress, this.text});

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Material(
        elevation: 1.0,
        color: color,
        borderRadius: BorderRadius.circular(30.0),
        child: MaterialButton(
          onPressed: onpress,
          minWidth: 200.0.w,
          height: 42.0.h,
          textColor: Colors.white,
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline2.copyWith(
                  color: Colors.white,
                  fontSize: ScreenUtil().setSp(35, allowFontScalingSelf: true),
                ),
          ),
        ),
      ),
    );
  }
}
