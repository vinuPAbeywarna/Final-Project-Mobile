import 'package:flutter/material.dart';

import 'package:vinsartisanmarket/components/internet_not_connect.dart';
import 'package:vinsartisanmarket/constansts/ui_constansts.dart';
import 'package:vinsartisanmarket/models/fetchCartModel.dart';
import 'package:vinsartisanmarket/screens/orders/userdetails.dart';
import 'package:vinsartisanmarket/service/network/networkhandeler.dart';

class Orderdetails extends StatefulWidget {
  final List<FetchCartModel> itemList;

  const Orderdetails({Key? key, required this.itemList}) : super(key: key);
  @override
  _OrderdetailsState createState() => _OrderdetailsState();
}

class _OrderdetailsState extends State<Orderdetails> {
  List<DataRow> datarow = [];
  double total = 0.0;
  @override
  void initState() {
    loaddata();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: Center(
            child: Text(
              "Order Details",
              style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                  fontSize: size.width * 0.05,
                  fontWeight: FontWeight.w700),
            ),
          ),
          elevation: 0,
          backgroundColor: Colors.white,
          iconTheme: IconThemeData(
            color: Colors.black, //change your color here
          ),
        ),
        floatingActionButton: FloatingActionButton.extended(
          onPressed: () async {
            print("pressed");
            bool isconnect = await NetworkHandeler.hasNetwork();
            if (isconnect == true) {
              print("connect");

              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => Userdetailscreen(
                            colist: widget.itemList,
                            total: total,
                          )));
            } else {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => NointernetScreen(
                          pushscreen:
                              Orderdetails(itemList: widget.itemList))));
            }

            //  await DataHandeler.createOrder(order);
          },
          label: Text("Continue"),
          icon: Icon(Icons.arrow_forward_ios_sharp),
          backgroundColor: Colors.indigoAccent,
        ),
        body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Container(
            // decoration: BoxDecoration(color: Color(0XFFffffff)),
            height: size.height * 0.82,
            child: ListView(
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Card(
                        color: klightbackgoundcolor,
                        shadowColor: Colors.indigo,
                        child: Container(
                          width: size.width,
                          child: DataTable(columns: [
                            DataColumn(
                                label: Text('Product',
                                    style: TextStyle(
                                      fontSize: size.width * 0.035,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.7),
                                    ))),
                            DataColumn(
                                label: Text('Total',
                                    style: TextStyle(
                                      fontSize: size.width * 0.035,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.black.withOpacity(0.78),
                                    ))),
                          ], rows: datarow),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Container(
            decoration: const BoxDecoration(color: klightbackgoundcolor),
            height: size.height * 0.08,
            width: size.width,
            //  height: size.height * 0.06,
            child: Padding(
              padding: EdgeInsets.only(
                  left: size.width * 0.04, top: size.height * 0.02),
              child: Text(
                "Total  RS. "+ total.toStringAsFixed(0) ,
                style: TextStyle(
                    color: Colors.black.withOpacity(0.8),
                    fontSize: size.width * 0.043,
                    fontWeight: FontWeight.w700),
              ),
            ),
          )
        ]));
  }

  loaddata() async {
    var data = widget.itemList;
    double tot = 0.0;
    data.forEach((element) {
      tot = tot + (element.qty * element.product.price);
      DataRow d = DataRow(cells: [
        DataCell(Text(
          element.product.name,
          style: TextStyle(
            fontWeight: FontWeight.w700,
            color: Colors.black.withOpacity(0.8),
          ),
        )),
        DataCell(
          Text(
           "RS. "+ element.product.price.toStringAsFixed(0) +
                " X " +
                element.qty.toString(),
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: Colors.black.withOpacity(0.8),
            ),
          ),
        ),
      ]);
      setState(() {
        datarow.add(d);
      });
    });
    setState(() {
      total = tot;
    });
  }
}
