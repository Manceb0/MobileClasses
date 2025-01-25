import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/cart_model.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cart = Provider.of<Cart>(context);
    final shoeList = cart.getShoeList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Sneaker Store'),
        actions: [
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () {
              Navigator.pushNamed(context, '/cart');
            },
          ),
        ],
      ),
      body: ListView.builder(
        itemCount: shoeList.length,
        itemBuilder: (context, index) {
          final shoe = shoeList[index];
          return Card(
            child: ListTile(
              leading: Image.asset(shoe.imagePath),
              title: Text(shoe.name),
              subtitle: Text('\$${shoe.price}'),
              trailing: IconButton(
                icon: const Icon(Icons.add),
                onPressed: () {
                  cart.addItemToCart(shoe);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('${shoe.name} añadido al carrito')),
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
