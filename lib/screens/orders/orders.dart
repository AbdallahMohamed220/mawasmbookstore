import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawasmbookstore/providers/order.dart';
import 'package:provider/provider.dart';
import 'package:mawasmbookstore/screens/orders/component/order_item.dart'
    as order;
import 'dart:math';
import 'package:intl/intl.dart' as intl;

class OrdersScreen extends StatefulWidget {
  static const routeName = 'Oders_screen';

  const OrdersScreen({Key key}) : super(key: key);

  @override
  _OrdersScreenState createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isloading = false;
  var _expanded = false;

  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) {
      setState(() {
        _isloading = true;
      });
      // Provider.of<Orders>(
      //   context,
      // ).fetchAndSetOrders();

      setState(() {
        _isloading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final ordersData = Provider.of<Orders>(context);

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          ('طلباتى'),
          style: Theme.of(context).textTheme.headline2.copyWith(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true),
              ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: _isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Directionality(
              textDirection: TextDirection.rtl,
              child: ListView.builder(
                  itemCount: 2,
                  itemBuilder: (context, i) => AnimatedContainer(
                        duration: Duration(milliseconds: 300),
                        height: _expanded ? min(5 * 20.0 + 110, 200) : 95,
                        child: Card(
                          margin: EdgeInsets.all(10),
                          child: Column(
                            children: <Widget>[
                              ListTile(
                                title: Text(
                                  ' 192 ر.س',
                                  // textAlign: TextAlign.left,
                                ),
                                subtitle: Text(
                                  '10/10/2020',
                                ),
                                trailing: IconButton(
                                  icon: Icon(_expanded
                                      ? Icons.expand_less
                                      : Icons.expand_more),
                                  onPressed: () {
                                    setState(() {
                                      _expanded = !_expanded;
                                    });
                                  },
                                ),
                              ),
                              AnimatedContainer(
                                  duration: Duration(milliseconds: 300),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 15, vertical: 4),
                                  height:
                                      _expanded ? min(5 * 20.0 + 10, 100) : 0,
                                  child: ListView(children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'مسطرة',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          'x 11.75',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        Text(
                                          'قلم',
                                          style: TextStyle(
                                            fontSize: 18,
                                          ),
                                        ),
                                        Text(
                                          'x 11.75',
                                          style: TextStyle(
                                            fontSize: 18,
                                            color: Colors.grey,
                                          ),
                                        )
                                      ],
                                    ),
                                  ])),
                            ],
                          ),
                        ),
                      )),
            ),
    );
  }
}
