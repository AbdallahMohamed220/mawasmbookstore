import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawasmbookstore/providers/cart.dart';
import 'package:mawasmbookstore/screens/cart/cart.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class ProductDetailsScreen extends StatelessWidget {
  static const routeName = 'product_details_screen';

  int id;
  String title;
  String imageUrl;
  String price;

  ProductDetailsScreen({
    this.id,
    this.title,
    this.imageUrl,
    this.price,
  });
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<Cart>(context, listen: false);
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);

    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
        elevation: 0,
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            height: 400.h,
            child: Hero(
              tag: imageUrl,
              child: Image.network(
                imageUrl,
                fit: BoxFit.fill,
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          Text(
            title,
            style: Theme.of(context).textTheme.headline2.copyWith(
                  color: Colors.grey[700],
                  fontSize: ScreenUtil().setSp(24, allowFontScalingSelf: true),
                ),
          ),
          SizedBox(
            height: 40.h,
          ),
          Directionality(
            textDirection: TextDirection.rtl,
            child: Text(
              '$price ر.س',
              style: Theme.of(context).textTheme.headline2.copyWith(
                    color: Colors.grey[700],
                    fontSize:
                        ScreenUtil().setSp(20, allowFontScalingSelf: true),
                  ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: () {
              print(id.toString());
              cartItem.addItem(
                  id.toString(), title, double.parse(price), imageUrl);
              _scaffoldkey.currentState.hideCurrentSnackBar();
              _scaffoldkey.currentState.showSnackBar(
                SnackBar(
                  content: Directionality(
                      textDirection: TextDirection.rtl,
                      child: Text(
                        'تم اضافة المنتج الى سلة المشتريات',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              color: Colors.white,
                              fontSize: ScreenUtil()
                                  .setSp(24, allowFontScalingSelf: true),
                            ),
                      )),
                  duration: Duration(seconds: 2),
                  backgroundColor: Theme.of(context).primaryColor,
                ),
              );
            },
            child: Container(
              width: 200.w,
              height: 50.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'أضف الى السلة',
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Colors.white,
                      fontSize:
                          ScreenUtil().setSp(24, allowFontScalingSelf: true),
                    ),
              ),
            ),
          ),
          SizedBox(
            height: 30.h,
          ),
          GestureDetector(
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (_) => CartScreen()),
              );
            },
            child: Container(
              width: 200.w,
              height: 50.h,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: Theme.of(context).primaryColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Text(
                'سلة المشتريات',
                style: Theme.of(context).textTheme.headline2.copyWith(
                      color: Colors.white,
                      fontSize:
                          ScreenUtil().setSp(24, allowFontScalingSelf: true),
                    ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
