import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawasmbookstore/providers/cart.dart';
import 'package:mawasmbookstore/share_widgets/cart_item.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatefulWidget {
  @override
  _CartScreenState createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  @override
  Widget build(BuildContext context) {
    final cartData = Provider.of<Cart>(context);
    ScreenUtil.init(context,
        designSize: Size(750, 1334), allowFontScaling: true);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          ('سلة المشتريات'),
          style: Theme.of(context).textTheme.headline2.copyWith(
                color: Colors.white,
                fontSize: ScreenUtil().setSp(30, allowFontScalingSelf: true),
              ),
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: Column(
        children: <Widget>[
          SizedBox(height: 20.h),
          Card(
            elevation: 0,
            color: Theme.of(context).primaryColor,
            margin: EdgeInsets.all(8),
            child: Padding(
              padding: EdgeInsets.all(8),
              child: Directionality(
                textDirection: TextDirection.rtl,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.only(right: 8.h),
                      child: Text(
                        'الاجمالى',
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              color: Colors.white,
                              fontSize: ScreenUtil()
                                  .setSp(30, allowFontScalingSelf: true),
                            ),
                      ),
                    ),
                    Chip(
                      label: Text(
                        '${cartData.totalAmount.toStringAsFixed(2)} ر.س' ?? '',
                        style: TextStyle(
                          color: Theme.of(context).accentColor,
                        ),
                      ),
                      backgroundColor: Colors.white,
                    ),
                    OrderButton(
                      cart: cartData,
                    )
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: ListView.builder(
              itemCount: cartData.items.length,
              itemBuilder: (ctx, i) => CartItemWidget(
                id: cartData.items.values.toList()[i].id,
                productId: cartData.items.keys.toList()[i],
                title: cartData.items.values.toList()[i].title,
                price: cartData.items.values.toList()[i].price,
                quantity: cartData.items.values.toList()[i].quantity,
                imgUrl: cartData.items.values.toList()[i].imgUrl,
              ),
            ),
          )
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key key,
    @required this.cart,
  }) : super(key: key);

  final Cart cart;

  @override
  _OrderButtonState createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var _isLoading = false;

  @override
  Widget build(BuildContext context) {
    // final email = Provider.of<Auth>(context).userEmail;
    // final userName = Provider.of<Auth>(context).userName;
    // final address = Provider.of<Auth>(context).userAddress;
    // final phoneNumber = Provider.of<Auth>(context).userPhoneNumber;
    return FlatButton(
      color: Colors.white,
      shape: new RoundedRectangleBorder(
          borderRadius: new BorderRadius.circular(30.0)),
      child: _isLoading
          ? CircularProgressIndicator()
          : Text(
              'اطلب الان',
              style: Theme.of(context).textTheme.headline2.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontSize: ScreenUtil().setSp(
                      30,
                      allowFontScalingSelf: true,
                    ),
                  ),
            ),
      onPressed: (widget.cart.totalAmount <= 0 || _isLoading)
          ? null
          : () async {
              try {
                setState(() {
                  _isLoading = true;
                });
                // await Provider.of<Orders>(context, listen: false).addOrder(
                //     cartProducts: widget.cart.items.values.toList(),
                //     total: widget.cart.totalAmount,
                //     address: address,
                //     email: email,
                //     name: userName,
                //     phone: phoneNumber);
                setState(() {
                  _isLoading = false;
                });
                widget.cart.clear();
              } catch (error) {
                widget.cart.clear();
                setState(() {
                  _isLoading = false;
                });
              }
            },
    );
  }
}
