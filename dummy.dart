Cart cart = Cart.fromMap(snapshot.data);

List productsInCart = [];
for (String productId in cart.productsInCart) {
productsInCart.add(productId);
}

productsInCart.add(“NEW_PRODUCT_ID_TO_BE_ADDED”);

// Update product
final TransactionHandler transactionHandler = (Transaction transaction) async {
  await transaction.update(snapshot.reference, cart.toMap());
}


Cart.dart

class Cart {
  List<dynamic> productsInCart = [];
  int cartItemsCount;

  Cart({@required this.productsInCart, @required this.cartItemsCount});

  Cart.fromDocument(DocumentSnapshot document)
      : productsInCart = document[PRODUCTS_IN_CART],
        cartItemsCount = document[CART_ITEMS_COUNT];

  Cart.fromMap(Map map)
      : productsInCart = map[PRODUCTS_IN_CART],
        cartItemsCount = map[CART_ITEMS_COUNT];

  Map<String, dynamic> toMap() {
    return {
      PRODUCTS_IN_CART: productsInCart,
      CART_ITEMS_COUNT: cartItemsCount,
    };
  }
}

Where,
PRODUCTS_IN_CART - productsInCart,
CART_ITEMS_COUNT - cartItemsCount