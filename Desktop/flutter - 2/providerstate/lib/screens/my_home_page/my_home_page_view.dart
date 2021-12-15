import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerstate/core/widgets/bottom_nav/bottom_navbar.dart';
import 'package:providerstate/models/mock/product_mock.dart';
import 'package:providerstate/provider/cart_provider.dart';
import './my_home_page_view_model.dart';

class MyHomePageView extends MyHomePageViewModel {
  final List<ProductMock> _products = List.generate(
    10,
    (index) => ProductMock(
        name: 'Name: $index',
        imageUrl: 'https://source.unsplash.com/random/$index'),
  );
  @override
  Widget build(BuildContext context) {
    // Replace this with your build function
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "My Home Page",
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, __) => Card(
                child: ListTile(
                  title: Text(_products[__].name.toString()),
                  subtitle: SizedBox(
                    child: Image.network(
                      _products[__].imageUrl.toString(),
                      fit: BoxFit.cover,
                      height: MediaQuery.of(context).size.height * 0.2,
                      width: MediaQuery.of(context).size.width * 0.4,
                    ),
                  ),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: IconButton(
                          icon: const Icon(Icons.add),
                          onPressed: () {
                            context
                                .read<CartProvider>()
                                .addProduct(_products[__]);
                          },
                        ),
                      ),
                      Expanded(
                        child: IconButton(
                          icon: const Icon(Icons.remove),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
