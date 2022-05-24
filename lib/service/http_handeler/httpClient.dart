import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:vinsartisanmarket/models/addcartModel.dart';
import 'package:vinsartisanmarket/models/addwishModel.dart';
import 'package:vinsartisanmarket/models/fetchCartModel.dart';
import 'package:vinsartisanmarket/models/fetchWishModel.dart';
import 'package:vinsartisanmarket/models/orderModel.dart';
import 'package:vinsartisanmarket/models/productModel.dart';
import 'package:vinsartisanmarket/models/regiUser.dart';
import 'package:vinsartisanmarket/service/authentication/userHandeler.dart';

class HttpClient {
  Dio dio = Dio();

  String baseURL = 'http://20.248.186.239/api/';

  Map<String, dynamic> headers = {
    "Accept": "application/json",
    "Content-Type": "application/json",
    "Authorization": "",
  };

  HttpClient() {
    dio.options.baseUrl = baseURL;
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 5000;
    dio.options.headers = headers;
  }

  void setToken(String token) async {
    headers["Authorization"] = "Bearer $token";
    dio.options.headers = headers;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('token', token);
  }

  Future<void> setSavedToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token = prefs.getString('token') ?? '';
    print("token----> " + token);
    headers["Authorization"] = "Bearer $token";
    dio.options.headers = headers;
  }

  Future post(String url, Map data) async {
    try {
      return await dio.post(url, data: data);
    } on DioError catch (e) {
      return e.response;
    }
  }

  //AuthCheck
  Future authCheck() async {
    Response response = await post('/auth/check', {});
    return {
      "code": response.statusCode,
      "data": response.data,
    };
  }

  //SignIn
  Future signIn(Map data) async {
    Response response = await post('/auth/login', data);
    return {
      "code": response.statusCode,
      "data": response.data,
    };
  }

  //SignIn
  Future signUp(RegiUserModel model) async {
    print(model.toMap());
    Response response = await post('/auth/register', model.toMap());
    print(response.data);
    return {
      "code": response.statusCode,
      "data": response.data,
    };
  }

  // products

  //getall

  Future<List<Productmodel>> getAllproducts() async {
    final response = await dio.get(baseURL + 'product/all/');
    List<Productmodel> productlist = [];

    print(response.data);

    if (response.statusCode == 200) {
      print(response.data);

      print("--------------------");

      return (response.data as List)
          .map((e) => Productmodel.fromMap(e))
          .toList();
    } else {
      throw Exception('Failed to load');
    }
  }

//cart

//all

  Future<List<FetchCartModel>> getCart() async {
    List<FetchCartModel> carttlist = [];
    await setSavedToken();
    final response = await dio.get(baseURL + 'cart/all');

    print(response.data);
    if (response.statusCode == 200) {
      print(response.data);

      return (response.data as List)
          .map((e) => FetchCartModel.fromMap(e))
          .toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future addCart(CartModel cartModel) async {
    await setSavedToken();
    final response = await post('cart/add', cartModel.toMap());
    print(response.data);
    return {
      "code": response.statusCode,
      "data": response.data,
    };
  }

  Future removeCartItem(int id) async {
    await setSavedToken();
    final response = await dio.delete('cart/delete/$id');
    if (kDebugMode) {
      print(response.data);
    }

    return {
      "code": response.statusCode,
      "data": response.data,
    };
  }

//wishList
  Future<List<FetchWishListModel>> getWishList() async {
    List<FetchWishListModel> carttlist = [];
    await setSavedToken();
    final response = await dio.get(baseURL + 'wishlist/all');

    print(response.data);
    if (response.statusCode == 200) {
      print(response.data);

      return (response.data as List)
          .map((e) => FetchWishListModel.fromMap(e))
          .toList();
    } else {
      throw Exception('Failed to load');
    }
  }

  Future addWishList(WishListModel wishListModel) async {
    await setSavedToken();
    final response = await post('wishlist/add', wishListModel.toMap());
    print(response.data);
    return {
      "code": response.statusCode,
      "data": response.data,
    };
  }

  Future removeWishListItem(int id) async {
    await setSavedToken();
    final response = await dio.delete('wishlist/delete/$id');
    if (kDebugMode) {
      print(response.data);
    }

    return {
      "code": response.statusCode,
      "data": response.data,
    };
  }

  //order
  Future<String> createOrder(OrderModel orderModel) async {
    String orderid = "null";
    try {
      await setSavedToken();
      final response = await post('orders/create', orderModel.toMap());
      if (kDebugMode) {
        print(response.data);
      }
      OrderModel resdata = OrderModel.fromMap(response.data);
      orderid = resdata.id.toString();
    } on Exception catch (e) {
      if (kDebugMode) {
        print(e);
      }
    }
    return orderid;
  }

  Future orderPaymentsUpdate(String id) async {
    await setSavedToken();
    final response = await dio.put('orders/updatePaymentStatus/' + id);
    if (kDebugMode) {
      print(response.data);
    }

    return {
      "code": response.statusCode,
      "data": response.data,
    };
  }

  Future<List<OrderModel>> getOders() async {
    List<OrderModel> filterdList = [];
    final user = await UserHandeler.getUser();
    await setSavedToken();
    final response = await dio.post("orders/getOrders");

    if (response.statusCode == 200) {
      if (kDebugMode) {
        print(response.data);
      }
      final orders =
          (response.data as List).map((e) => OrderModel.fromMap(e)).toList();
      orders.forEach((element) {
        if (element.user_id == user.id) {
          filterdList.add(element);
        }
      });
    } else {
      throw Exception('Failed to load');
    }
    return filterdList;
  }
}

HttpClient httpClient = HttpClient();
