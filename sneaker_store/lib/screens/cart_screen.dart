import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/cart_model.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Accede al modelo Cart usando Provider
    final cart = Provider.of<Cart>(context);
    final userCart = cart.getUserCart();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Carrito de Compras'),
      ),
      body: userCart.isEmpty
          ? const Center(
        child: Text(
          'El carrito está vacío.',
          style: TextStyle(fontSize: 18),
        ),
      )
          : ListView.builder(
        itemCount: userCart.length,
        itemBuilder: (context, index) {
          final shoe = userCart[index];
          return Card(
            margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            child: ListTile(
              leading: Image.asset(
                shoe.imagePath,
                width: 50,
                height: 50,
                fit: BoxFit.cover,
              ),
              title: Text(shoe.name),
              subtitle: Text('\$${shoe.price}'),
              trailing: IconButton(
                icon: const Icon(Icons.remove_circle),
                color: Colors.red,
                onPressed: () {
                  cart.removeItemFromCart(shoe);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${shoe.name} eliminado del carrito')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
