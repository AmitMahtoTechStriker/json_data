import 'dart:convert';

import 'package:fetch_json_data/grid_container.dart';
import 'package:fetch_json_data/models/ItemsModel.dart';
import 'package:fetch_json_data/models/UserModel.dart';
import 'package:fetch_json_data/utils/CallBackInterface.dart';
import 'package:fetch_json_data/utils/CallBackTitle.dart';
import 'package:fetch_json_data/utils/Constrant.dart';
import 'package:fetch_json_data/utils/Global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> implements CallBackInterface {
  late ItemModel itemModel;
  UserModel userModel = UserModel();

  @override
  void initState() {
    // Global.readJson(Strings.items, Constrant.ITEM_JSON, context, this);
    Global.readJson(Strings.user_list, Constrant.USER_JSON, context, this);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return userModel.user != null
        ? Container(
            margin: const EdgeInsets.all(10),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 10.0,
              children: List.generate(userModel.user!.length, (index) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(5),
                          child: Image.network(
                            userModel.user![index].imageUrl.toString(),
                            fit: BoxFit.cover,
                          ),
                        ),
                        Container(
                          padding: EdgeInsets.all(10),
                          child: Text(
                            userModel.user![index].name.toString(),
                            style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize: 15),
                          ),
                        )
                      ],
                    ),
                  ],
                );
              }),
            ),
          )
        : Center(child: CircularProgressIndicator());
  }

  @override
  callback(String title, String value, BuildContext context) {
    switch (title) {
      case Strings.items:
        itemModel = ItemModel.fromJson(jsonDecode(value));
        setState(() {});
        break;

      case Strings.user_list:
        userModel = UserModel.fromJson(jsonDecode(value));
        setState(() {});
        break;
    }
  }
}
