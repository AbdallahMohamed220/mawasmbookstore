import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mawasmbookstore/providers/cart.dart';
import 'package:mawasmbookstore/screens/product_details/product_details.dart';
import 'package:provider/provider.dart';

class CategoriesItemsBody extends StatelessWidget {
  const CategoriesItemsBody({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);

    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        shrinkWrap: true,
        physics: BouncingScrollPhysics(),
        padding: const EdgeInsets.all(4.0),
        mainAxisSpacing: 4.0,
        crossAxisSpacing: 4.0,
        childAspectRatio: ScreenUtil().pixelRatio,
        children: <Widget>[],
      ),
    );
  }
}

// ignore: must_be_immutable
class CategoryProductItems extends StatefulWidget {
  int id;
  String imageUrl;
  String title;
  String price;
  CategoryProductItems({this.id, this.title, this.price, this.imageUrl});

  @override
  _CategoryItemsState createState() => _CategoryItemsState();
}

class _CategoryItemsState extends State<CategoryProductItems> {
  final GlobalKey<ScaffoldState> _scaffoldkey = new GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final cartItem = Provider.of<Cart>(context, listen: false);
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return Scaffold(
        key: _scaffoldkey,
        body: Card(
          color: Colors.grey[200],
          elevation: 1,
          margin: EdgeInsets.all(10),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SizedBox(height: 30.h),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProductDetailsScreen(
                        id: widget.id,
                        title: widget.title,
                        price: widget.price,
                        imageUrl: widget.imageUrl,
                      ),
                    ),
                  );
                },
                child: Hero(
                  tag: widget.imageUrl,
                  child: CircleAvatar(
                    radius: 60.h,
                    backgroundImage: NetworkImage(widget.imageUrl),
                  ),
                ),
              ),
              SizedBox(height: 30.h),
              FittedBox(
                child: Padding(
                  padding: EdgeInsets.only(right: 40.h, left: 30.h),
                  child: Text(
                    widget.title,
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          color: Colors.grey[700],
                          fontSize: ScreenUtil()
                              .setSp(30, allowFontScalingSelf: true),
                        ),
                  ),
                ),
              ),
              SizedBox(height: 10.h),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Text(
                  '${widget.price} ر.س',
                  style: TextStyle(
                    fontSize:
                        ScreenUtil().setSp(24, allowFontScalingSelf: true),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              SizedBox(height: 20.h),
              Divider(
                thickness: 1,
              ),
              SizedBox(height: 30.h),
              GestureDetector(
                onTap: () {
                  print(widget.id.toString());
                  cartItem.addItem(
                    widget.id.toString(),
                    widget.title,
                    double.parse(widget.price),
                    widget.imageUrl,
                  );
                  // _scaffoldkey.currentState.hideCurrentSnackBar();
                  // _scaffoldkey.currentState.showSnackBar(
                  //   SnackBar(
                  //     content: Directionality(
                  //         textDirection: TextDirection.rtl,
                  //         child: Text(
                  //           'تم اضافة المنتج الى سلة المشتريات',
                  //           style: Theme.of(context)
                  //               .textTheme
                  //               .headline2
                  //               .copyWith(
                  //                 color: Colors.white,
                  //                 fontSize: ScreenUtil()
                  //                     .setSp(24, allowFontScalingSelf: true),
                  //               ),
                  //         )),
                  //     duration: Duration(seconds: 2),
                  //     backgroundColor: Theme.of(context).primaryColor,
                  //   ),
                  // );
                  Fluttertoast.showToast(
                    msg: "تم اضافة المنتج الى سلة المشتريات",
                    toastLength: Toast.LENGTH_SHORT,
                    gravity: ToastGravity.BOTTOM,
                    timeInSecForIosWeb: 1,
                    backgroundColor: Theme.of(context).primaryColor,
                    textColor: Colors.white,
                    fontSize: 12,
                  );
                },
                child: Text(
                  'إضافة الى السلة',
                  style: Theme.of(context).textTheme.headline2.copyWith(
                        color: Colors.grey[600],
                        fontSize:
                            ScreenUtil().setSp(24, allowFontScalingSelf: true),
                      ),
                ),
              ),
            ],
          ),
        ));
  }
}
