import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:meta/meta.dart';

class Para {
  List<dynamic> PARA = [];
  int cartItemsCount;

  Cart({@required this.productsInCart, @required this.cartItemsCount});

  Para.fromDocument(DocumentSnapshot document)
      : productsInCart = document[PRODUCTS_IN_CART],
        cartItemsCount = document[CART_ITEMS_COUNT];

  Para.fromMap(Map map)
      : productsInCart = map[PRODUCTS_IN_CART],
        cartItemsCount = map[CART_ITEMS_COUNT];

  Map<String, dynamic> toMap() {
    return {
      PRODUCTS_IN_CART: productsInCart,
      CART_ITEMS_COUNT: cartItemsCount,
    };
  }
}