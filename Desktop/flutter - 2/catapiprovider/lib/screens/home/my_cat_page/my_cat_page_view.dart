import 'package:catapiprovider/constants/appbar.dart';
import 'package:catapiprovider/models/cats_model.dart';
import 'package:catapiprovider/models/users_model.dart';
import 'package:catapiprovider/services/dio_service.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import './my_cat_page_view_model.dart';

class MyCatPageView extends MyCatPageViewModel {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Constants.myAppBar("My Cat Api", Colors.transparent),
      body: futureBuilderForCat(),
    );
  }

  FutureBuilder<List> futureBuilderForCat() {
    return FutureBuilder(
      future: Future.wait([
        DioService().getCats(),
        DioService().getUsers(),
      ]),
      builder: (context, AsyncSnapshot<List> snap) {
        if (!snap.hasData) {
          return const Center(
            child: CupertinoActivityIndicator(),
          );
        } else if (snap.hasError) {
          return const Center(
            child: Text("Error Snap"),
          );
        } else {
          List<Cat> _snapCat = snap.data![0];
          List<User> _snapUser = snap.data![1];
          return ListView.separated(
            separatorBuilder: (context, index) {
              return ListTile(
                title: Image.network(_snapCat[index].imageUrl.toString()),
              );
            },
            itemBuilder: (_, __) => Card(
              child: ListTile(
                title: Text(_snapUser[__].username.toString()),
              ),
            ),
            itemCount: 10,
          );
        }
      },
    );
  }
}
