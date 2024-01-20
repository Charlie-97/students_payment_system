class CartItem {
  CartItem({
    required this.variant,
    required this.price,
    required this.qty,
    this.isMarked = false,
    required this.productimage,
    required this.productTitle,
  });
  final bool isMarked;
  final String productimage;
  final String productTitle;
  final String variant;
  final double price;
  final int qty;
}

final List<CartItem> dummyCart = [
  CartItem(variant: 'Grey', price: 1999.99, qty: 1, productimage: 'Assets/images/cart_item_1.svg', productTitle: 'Air pods max by Apple', )
];
