import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:providerstate/core/constants/colors.dart';
import 'package:providerstate/core/widgets/bottom_nav/bottom_navbar.dart';
import 'package:providerstate/provider/cart_provider.dart';
import './my_cart_page_view_model.dart';

class MyCartPageView extends MyCartPageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: const Text(
          "Shopping Page",
          style: TextStyle(color: myPrimaryColor),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemBuilder: (_, __) => ListTile(
                title: Text(context
                    .watch<CartProvider>()
                    .listProduct[__]
                    .name
                    .toString()),
                subtitle: SizedBox(
                  child: Image.network(
                    context
                        .watch<CartProvider>()
                        .listProduct[__]
                        .imageUrl
                        .toString(),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: MediaQuery.of(context).size.width * 0.4,
                  ),
                ),
              ),
              itemCount: context.watch<CartProvider>().listProduct.length,
            ),
          ),
        ],
      ),
    );
  }
}
