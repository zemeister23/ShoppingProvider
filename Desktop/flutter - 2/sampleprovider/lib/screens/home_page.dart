import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sampleprovider/model/mock/list.dart';
import 'package:sampleprovider/provider/home_provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: context.watch<HomeProvider>().colorOfAppbar,
        elevation: 0,
        title: const Text(
          "Home Page",
          style: TextStyle(color: Colors.black),
        ),
        leadingWidth: 60,
        leading: Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Visibility(
            visible:
                context.watch<HomeProvider>().myList.isEmpty ? false : true,
            child: CircleAvatar(
              backgroundColor: Colors.white,
              child:
                  Text(context.watch<HomeProvider>().myList.length.toString()),
            ),
          ),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: Form(
              key: context.watch<HomeProvider>().formKey,
              child: Column(
                children: [
                  Card(
                    child: ListTile(
                      leading: DropdownButton(
                        items: const [
                          DropdownMenuItem(
                            child: CircleAvatar(
                              backgroundColor: Colors.redAccent,
                            ),
                            value: 'red',
                          ),
                          DropdownMenuItem(
                            child: CircleAvatar(
                              backgroundColor: Colors.yellow,
                            ),
                            value: 'yellow',
                          ),
                          DropdownMenuItem(
                            child: CircleAvatar(
                              backgroundColor: Colors.green,
                            ),
                            value: 'green',
                          )
                        ],
                        onChanged: (String? color) {
                          context.read<HomeProvider>().changeColor(color!);
                        },
                        value: context.watch<HomeProvider>().valueOfColor,
                      ),
                      title: TextFormField(
                        controller:
                            context.watch<HomeProvider>().textController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          label: Text("Text here...."),
                        ),
                        validator: (v) =>
                            v!.isEmpty ? 'Bosh Qoldirilmasin' : null,
                      ),
                      trailing: InkWell(
                        child: const Icon(
                          Icons.check_circle,
                          color: Colors.green,
                          size: 45.0,
                        ),
                        onTap: () {
                          context.read<HomeProvider>().addToList(
                                MyList(
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .colorOfAppbar,
                                  Provider.of<HomeProvider>(context,
                                          listen: false)
                                      .textController
                                      .text,
                                ),
                              );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
            flex: 9,
            child: ListView.builder(
              itemBuilder: (_, __) => ListTile(
                leading: CircleAvatar(
                  backgroundColor:
                      context.watch<HomeProvider>().myList[__].color,
                ),
                title: Text(context.watch<HomeProvider>().myList[__].title),
              ),
              itemCount: context.watch<HomeProvider>().myList.length,
            ),
          ),
        ],
      ),
    );
  }
}
