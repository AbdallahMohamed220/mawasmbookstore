import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mawasmbookstore/models/product.dart';
import 'package:mawasmbookstore/screens/categories_items/component/categories_items_body.dart';
import 'package:http/http.dart' as http;
import 'package:mawasmbookstore/screens/online_services/online_services_product_details.dart';
import 'package:mawasmbookstore/screens/product_details/product_details.dart';

// ignore: must_be_immutable
class OnlineServiccesCategoriesItemsScreen extends StatefulWidget {
  static const routeName = 'categories_items_screen';

  String title;
  int id;
  OnlineServiccesCategoriesItemsScreen({
    this.title,
    this.id,
  });

  @override
  _OnlineServiccesCategoriesItemsScreenState createState() =>
      _OnlineServiccesCategoriesItemsScreenState();
}

class _OnlineServiccesCategoriesItemsScreenState
    extends State<OnlineServiccesCategoriesItemsScreen> {
  bool _isloading = true;
  var _loadedInitData = true;
  List<Product> productsList = [];
  getProducts(int id) async {
    print(id);
    var url =
        'https://mawasmbookstore.com/wp-json/wc/v2/products/$id/?consumer%20key=ck_c804ed805bfa25be8ecd694a27b46978ca64ade3&consumer%20secret=cs_5557320ab49daf46a277d8aeed995988d369f4c5';

    var response = await http.get(url);
    print(json.decode(response.body));
    if (response.statusCode == 200) {
      final loadData = json.decode(response.body);
      if (loadData == null) {
        return;
      }

      productsList.add(Product(
          id: loadData['id'],
          name: loadData['name'],
          price: loadData['price'],
          imageUrl: loadData['images'][0]['src']));
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }
  }

  @override
  void didChangeDependencies() async {
    if (_loadedInitData) {
      setState(() {
        _isloading = true;
      });
      print(widget.id);
      await getProducts(widget.id).then((_) {
        setState(() {
          _isloading = false;
        });
      });
    }

    _loadedInitData = false;

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0,
      ),
      body: _isloading
          ? Center(child: CircularProgressIndicator())
          : OnlineServicesProductDetailsScreen(
              title: productsList[0].name,
              imageUrl: productsList[0].imageUrl,
              price: productsList[0].price,
            ),
    );
  }
}
