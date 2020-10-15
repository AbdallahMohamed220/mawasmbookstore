import 'dart:core';
import 'package:flutter/material.dart';
import 'package:mawasmbookstore/providers/cart.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class OrderItem {
  final String id;
  final double amount;
  final List<CartItem> products;
  final DateTime dateTime;

  OrderItem(
      {@required this.id,
      @required this.amount,
      @required this.dateTime,
      @required this.products});
}

class Orders with ChangeNotifier {
  List<OrderItem> _orders = [];

  // final String _tokenOrder;
  // final String userId;

  //Orders(this._tokenOrder, this.userId, this._orders);

  List<OrderItem> get orders {
    return [..._orders];
  }

  Future<void> fetchAndSetOrders() async {
    final url = '';
    final responce = await http.get(url);
    final extractDate = json.decode(responce.body) as Map<String, dynamic>;
    if (extractDate == null) {
      return;
    }
    final List<OrderItem> loadData = [];
    extractDate.forEach((prodid, ordrDate) {
      loadData.add(OrderItem(
          id: prodid,
          amount: ordrDate['amount'],
          dateTime: DateTime.parse(ordrDate['dateTime']),
          products: (ordrDate['products'] as List<dynamic>)
              .map((item) => CartItem(
                    id: item['id'],
                    price: item['price'],
                    title: item['title'],
                    quantity: item['quantity'],
                  ))
              .toList()));
    });

    _orders = loadData.reversed.toList();
    notifyListeners();
  }

  Future<void> addOrders(List<CartItem> cartProduct, double total) async {
    final url = '';
    final timeStamp = DateTime.now();
    final responce = await http.post(url,
        body: json.encode({
          'amount': total,
          'dateTime': timeStamp.toIso8601String(),
          'products': cartProduct
              .map((cp) => {
                    'id': cp.id,
                    'title': cp.title,
                    'price': cp.price,
                    'quantity': cp.quantity,
                  })
              .toList()
        }));
    _orders.insert(
        0,
        OrderItem(
            id: json.decode(responce.body)['name'],
            dateTime: timeStamp,
            amount: total,
            products: cartProduct));
    notifyListeners();
  }
}
