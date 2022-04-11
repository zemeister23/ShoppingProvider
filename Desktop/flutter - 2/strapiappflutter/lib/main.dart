import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:strapiappflutter/models/product_models.dart';
import 'package:strapiappflutter/service/product_service.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Material App',
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Product App'),
        ),
        body: FutureBuilder(
            future: ServiceProduct.getProducts(),
            builder: (context, AsyncSnapshot<List<ProductModel>> snap) {
              if (!snap.hasData) {
                return const Center(
                  child: CupertinoActivityIndicator(),
                );
              } else if (snap.hasError) {
                return const Center(
                  child: Text("Internet Muammo  !"),
                );
              } else {
                var data = snap.data;
                return Column(
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
                          itemBuilder: (ctx, index) {
                            return Text("${data![index].title}");
                          },
                          itemCount: data!.length,
                        ),
                      ),
                    ),
                  ],
                );
              }
            }),
        floatingActionButton: FloatingActionButton(
          child: const Icon(Icons.add),
          onPressed: () async {
            await ServiceProduct.postToProduct();
          },
        ),
      ),
    );
  }
}
