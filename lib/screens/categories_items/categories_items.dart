import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:mawasmbookstore/models/product.dart';
import 'package:mawasmbookstore/screens/categories_items/component/categories_items_body.dart';
import 'dart:convert' as convert;
import 'package:http/http.dart' as http;

// ignore: must_be_immutable
class CategoriesItemsScreen extends StatefulWidget {
  static const routeName = 'categories_items_screen';

  String title;
  int id;
  CategoriesItemsScreen({
    this.title,
    this.id,
  });

  @override
  _CategoriesItemsScreenState createState() => _CategoriesItemsScreenState();
}

class _CategoriesItemsScreenState extends State<CategoriesItemsScreen> {
  bool _isloading = true;
  var _loadedInitData = true;
  List<Product> productsList = [];
  getProducts(int id) async {
    print(id);
    var url =
        'https://mawasmbookstore.com/wp-json/wc/v2/products?category=$id&consumer%20key=ck_c804ed805bfa25be8ecd694a27b46978ca64ade3&consumer%20secret=cs_5557320ab49daf46a277d8aeed995988d369f4c5';

    var response = await http.get(url);
    if (response.statusCode == 200) {
      final loadData = json.decode(response.body);
      if (loadData == null) {
        return;
      }

      for (int i = 0; i < loadData.length; i++) {
        productsList.add(Product(
            id: loadData[i]['id'],
            name: loadData[i]['name'],
            price: loadData[i]['price'],
            imageUrl: loadData[i]['images'][0]['src']));
      }
    } else {
      print('Request failed with status: ${response.statusCode}.');
    }

    setState(() {});
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
    double cardWidth = MediaQuery.of(context).size.width / 2.6;
    double cardHeight = MediaQuery.of(context).size.height / 3.6;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
        elevation: 0,
      ),
      body: _isloading
          ? Center(child: CircularProgressIndicator())
          : GridView.builder(
              padding: EdgeInsets.all(5),
              itemCount: productsList.length,
              itemBuilder: (context, index) {
                final product = productsList[index];
                return CategoryProductItems(
                  id: product.id,
                  title: product.name,
                  imageUrl: product.imageUrl,
                  price: product.price,
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: cardWidth / cardHeight,
                mainAxisSpacing: 2,
                crossAxisSpacing: 1,
              ),
            ),
    );
  }
}
