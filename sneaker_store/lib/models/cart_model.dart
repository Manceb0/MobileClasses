import 'package:flutter/material.dart';
import 'shoe_model.dart';

class Cart extends ChangeNotifier {
  final List<Shoe> shoeShop = [
    Shoe(
      name: 'Zoom FREAK',
      price: '236',
      imagePath: 'assets/images/sneakers-1.png',
      description: 'The forward-thinking design of the latest signature shoe',
    ),
    Shoe(
      name: 'Air Jordan',
      price: '220',
      imagePath: 'assets/images/sneakers-2.jpg',
      description: 'Enhanced hops and speed in every jump.',
    ),
    Shoe(
      name: 'KD Treys',
      price: '240',
      imagePath: 'assets/images/sneakers-3.png',
      description: 'Comfort and style combined for the best performance.',
    ),
    Shoe(
      name: 'Kyrie 6',
      price: '190',
      imagePath: 'assets/images/sneakers-4.png',
      description: 'Responsive cushioning paired with supportive foam.',
    ),
  ];

  final List<Shoe> userCart = [];

  List<Shoe> getShoeList() => shoeShop;

  List<Shoe> getUserCart() => userCart;

  void addItemToCart(Shoe shoe) {
    userCart.add(shoe);
    notifyListeners();
  }

  void removeItemFromCart(Shoe shoe) {
    userCart.remove(shoe);
    notifyListeners();
  }
}
