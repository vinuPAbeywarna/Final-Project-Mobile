import 'package:flutter/material.dart';

import 'package:vinsartisanmarket/models/addcartModel.dart';
import 'package:vinsartisanmarket/models/addwishModel.dart';
import 'package:vinsartisanmarket/models/fetchCartModel.dart';
import 'package:vinsartisanmarket/service/http_handeler/httpClient.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // List<FetchCartModel> list = await httpClient.getCart();

          // print(list.first.id);
          await httpClient.addWishList(WishListModel(userid: 7, productid: 1));
          await httpClient.getWishList();
          // await httpClient.removeCartItem(CartModel(
          //   userid: 7,
          //   productid: 1,
          //   qty: 2,
          // ));
        },
      ),
    );
  }
}
