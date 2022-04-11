import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cubitapp/bloc/home/cats_cubit.dart';
import 'package:cubitapp/bloc/home/cats_repository.dart';
import 'package:cubitapp/bloc/home/cats_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CatsBlocView extends StatefulWidget {
  const CatsBlocView({Key? key}) : super(key: key);

  @override
  _CatBlocViewState createState() => _CatBlocViewState();
}

class _CatBlocViewState extends State<CatsBlocView> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CatsCubit(SampleCatRepository()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text("BLOC HOME PAGE"),
        ),
        body: Column(
          children: [
            Expanded(
              child: BlocConsumer<CatsCubit, CatsState>(
                listener: (context, state) {
                  // ! SETSTATE BOLGANDA ISHLATISHIMIZ MUMKIN
                  if (state is CatsError) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          state.errorMessage.toString(),
                        ),
                      ),
                    );
                  }
                },
                builder: (context, state) {
                  if (state is CatsInitial) {
                    return Center(
                        child: Platform.isAndroid
                            ? const CircularProgressIndicator()
                            : const CupertinoActivityIndicator());
                  } else if (state is CatsLoading) {
                    return Center(
                      child: Platform.isAndroid
                          ? const CircularProgressIndicator()
                          : const CupertinoActivityIndicator(),
                    );
                  } else if (state is CatsCompleted) {
                    return dataListViewBuilder(state);
                  } else {
                    final error = state as CatsError;
                    return Center(
                      child: Text(error.errorMessage),
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  ListView dataListViewBuilder(CatsCompleted state) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
            title: Text(state.response[index].statusCode.toString()),
            subtitle: CachedNetworkImage(
              imageUrl: state.response[index].imageUrl.toString(),
            ),
          ),
        );
      },
      itemCount: state.response.length,
    );
  }
}
