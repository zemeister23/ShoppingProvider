import 'package:dio/dio.dart';
import 'package:expressfluttershopping/constants/const.dart';
import 'package:expressfluttershopping/models/product_model.dart';
import 'package:expressfluttershopping/provider/market_provider.dart';
import 'package:expressfluttershopping/screens/widget/my_app_bar.dart';
import 'package:expressfluttershopping/services/product_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: "Home Page",
        color: Colors.transparent,
      ),
      body: FutureBuilder(
        future: MarketService().getProducts(),
        builder: (context, AsyncSnapshot<List<MarketModel>> snap) {
          if (!snap.hasData) {
            return CircularProgressIndicator();
          } else if (snap.hasError) {
            return Text("ERROR");
          } else {
            return ListView.builder(
              itemBuilder: (context, index) => ListTile(
                title: Text(
                  snap.data![index].name.toString(),
                ),
                trailing: IconButton(
                  icon: const Icon(Icons.delete),
                  onPressed: () async {
                    await Dio().delete(
                      ipAdress + '/market',
                      data: {
                        "oldName": snap.data![index].name.toString(),
                      },
                    );
                  },
                ),
              ),
              itemCount: snap.data?.length,
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return AlertDialog(
                  actions: [
                    ElevatedButton(
                      onPressed: () {
                        context.read<MarketProvider>().senData();
                        context.read<MarketProvider>().clear();
                        Navigator.pop(context);
                      },
                      child: Text("SEND DATA"),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.red),
                      onPressed: () {
                        context.read<MarketProvider>().clear();
                        Navigator.pop(context);
                      },
                      child: const Text("Cancel"),
                    ),
                  ],
                  content: SizedBox(
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: Form(
                      child: Column(
                        children: [
                          TextFormField(
                            controller:
                                context.watch<MarketProvider>().nameController,
                          ),
                          TextFormField(
                            controller:
                                context.watch<MarketProvider>().priceController,
                          ),
                          TextFormField(
                            controller:
                                context.watch<MarketProvider>().imageController,
                          ),
                          TextFormField(
                            controller: context
                                .watch<MarketProvider>()
                                .categoryController,
                          )
                        ],
                      ),
                    ),
                  ),
                );
              });
        },
      ),
    );
  }
}
