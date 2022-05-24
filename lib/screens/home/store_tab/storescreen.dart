import 'dart:async';

import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:vinsartisanmarket/components/errorpage.dart';
import 'package:vinsartisanmarket/components/roundedtextFiled.dart';
import 'package:vinsartisanmarket/constansts/ui_constansts.dart';
import 'package:vinsartisanmarket/models/categoryModel.dart';
import 'package:vinsartisanmarket/models/productModel.dart';
import 'package:vinsartisanmarket/screens/home/store_tab/compt/categoryresults.dart';
import 'package:vinsartisanmarket/screens/home/store_tab/compt/itemgrid.dart';
import 'package:vinsartisanmarket/service/http_handeler/httpClient.dart';
import 'package:vinsartisanmarket/test/testmodel.dart';

import 'compt/category_menu.dart';
import 'compt/searchresult_view.dart';

class StoreScreen extends StatefulWidget {
  const StoreScreen({
    Key? key,
  }) : super(key: key);

  @override
  _StoreScreenState createState() => _StoreScreenState();
}

class _StoreScreenState extends State<StoreScreen> {
  ScrollController _scrollController = new ScrollController();
  late Future<List<Productmodel>> futureData;
  HttpClient httpClient = HttpClient();
  String stext = "";
  String categoryid = "cat004";
  bool iscat = false;
  bool issearch = false;
  int val = 0;
  final ValueNotifier<int> _counter = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();
    futureData = httpClient.getAllproducts();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: ListView(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        children: [
          FutureBuilder(
            future: futureData,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                List<Productmodel> data = snapshot.data as List<Productmodel>;
                print(data);

                return Container(
                    child: Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.03, right: size.width * 0.03),
                  child: Column(
                    children: [
                      Container(
                        child: Column(children: [
                          SizedBox(
                            height: size.height * 0.01,
                          ),
                          Container(
                            width: size.width,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                RoundedInput(
                                  onchange: (text) {
                                    setState(() {
                                      issearch = false;
                                    });
                                    if (text == "") {
                                      setState(() {
                                        issearch = false;
                                      });
                                    }
                                    setState(() {
                                      stext = text;
                                    });
                                    print("Search text -------" + stext);
                                  },
                                  valid: (text) {},
                                  save: (text) {},
                                  hintText: "Search...",
                                  icon: Icons.search_rounded,
                                ),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: size.width * 0.03),
                                  child: Container(
                                      decoration: BoxDecoration(
                                          color: kprimarylightcolor,
                                          borderRadius: BorderRadius.all(
                                              Radius.circular(
                                                  size.width * 0.05))),
                                      width: size.width * 0.15,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            bottom: size.height * 0.008),
                                        child: IconButton(
                                          icon: Icon(
                                            Icons.search_rounded,
                                            color: kprimaryColor,
                                            size: size.width * 0.1,
                                          ),
                                          onPressed: () {
                                            FocusScope.of(context).unfocus();
                                            setState(() {
                                              if (stext != "") {
                                                setState(() {
                                                  issearch = true;
                                                });
                                              } else {
                                                setState(() {
                                                  issearch = false;
                                                });
                                              }
                                            });
                                          },
                                        ),
                                      )),
                                )
                              ],
                            ),
                          ),
                          issearch
                              ? Padding(
                                  padding: EdgeInsets.only(
                                      bottom: size.height * 0.01),
                                  child: Column(
                                    children: [
                                      Padding(
                                        padding: EdgeInsets.only(
                                            bottom: size.height * 0.02,
                                            left: size.width * 0.035),
                                        child: Text(
                                          "Search results...",
                                          style: TextStyle(
                                              color:
                                                  Colors.black.withOpacity(0.8),
                                              fontSize: size.width * 0.04,
                                              fontWeight: FontWeight.w700),
                                        ),
                                      ),
                                      Sresultview(
                                        searchval: stext,
                                        productlist: data,
                                      ),
                                    ],
                                  ))
                              : SizedBox(height: size.height * 0),
                          Container(
                            decoration: BoxDecoration(color: Colors.white),
                            child: Padding(
                                padding: EdgeInsets.only(
                                    bottom: size.height * 0.018),
                                child: CachedNetworkImage(
                                  imageUrl:
                                      "https://i.pinimg.com/originals/ce/19/1f/ce191f137fdb797b99a1c2930b61c57c.jpg",
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Center(
                                    child: CircularProgressIndicator(
                                        color: Colors.blueGrey,
                                        value: downloadProgress.progress),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                )),
                          ),
                        ]),
                      ),
                      Categorymenu(arts: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryResult(
                                      categoryName: "Art Items",
                                      categoryimg: "assets/icons/arts.png",
                                      productlist: data,
                                      categoryModel: CategoryModel(
                                          id: "4",
                                          category_name: "Art Items",
                                          image:
                                              "/Images/default/categories/1.jpeg"),
                                    )));
                      }, craft: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryResult(
                                      categoryName: "Craft Items",
                                      categoryimg: "assets/icons/craft.png",
                                      productlist: data,
                                      categoryModel: CategoryModel(
                                          id: "5",
                                          category_name: "Craft Items",
                                          image:
                                              "/Images/default/categories/1.jpeg"),
                                    )));
                      }, leather: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryResult(
                                      categoryName: "Leather Items",
                                      categoryimg: "assets/icons/leather.png",
                                      productlist: data,
                                      categoryModel: CategoryModel(
                                          id: "2",
                                          category_name: "Leather Items",
                                          image:
                                              "/Images/default/categories/1.jpeg"),
                                    )));
                      }, clothes: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryResult(
                                      categoryName: "Clothes",
                                      categoryimg: "assets/icons/clothes.png",
                                      productlist: data,
                                      categoryModel: CategoryModel(
                                          id: "1",
                                          category_name: "Clothes",
                                          image:
                                              "/Images/default/categories/1.jpeg"),
                                    )));
                      }, shoes: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryResult(
                                      categoryName: "Shoese",
                                      categoryimg: "assets/icons/shoese.png",
                                      productlist: data,
                                      categoryModel: CategoryModel(
                                          id: "8",
                                          category_name: "Shoese",
                                          image:
                                              "/Images/default/categories/1.jpeg"),
                                    )));
                      }, fabric: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryResult(
                                      categoryName: 'Fabrics',
                                      categoryimg: "assets/icons/fabric.png",
                                      productlist: data,
                                      categoryModel: CategoryModel(
                                          id: "7",
                                          category_name: 'Fabrics',
                                          image:
                                              "/Images/default/categories/1.jpeg"),
                                    )));
                      }, crafttool: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryResult(
                                      categoryName: 'Craft Tool',
                                      categoryimg: "assets/icons/crafttool.png",
                                      productlist: data,
                                      categoryModel: CategoryModel(
                                          id: "6",
                                          category_name: 'Craft Tool',
                                          image:
                                              "/Images/default/categories/1.jpeg"),
                                    )));
                      }, arttool: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => CategoryResult(
                                      categoryName: 'Art Tool',
                                      categoryimg: "assets/icons/arttools.png",
                                      productlist: data,
                                      categoryModel: CategoryModel(
                                          id: "3",
                                          category_name: 'Art Tool',
                                          image:
                                              "/Images/default/categories/1.jpeg"),
                                    )));
                      }),
                    ],
                  ),
                ));
              } else if (snapshot.hasError) {
                return Errorpage(size: size.width * 0.7);
              }
              // By default show a loading spinner.
              return Center(
                  child: Lottie.asset("assets/animation/loadingindicator.json",
                      width: size.height * 0.28));
            },
          ),
          SizedBox(
            height: size.height * 0.03,
          ),
          Itemgrid(
            scrollController: _scrollController,
          ),
        ],
      ),
    );
  }
}


























// class StoreScreen extends StatefulWidget {
//   const StoreScreen({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _StoreScreenState createState() => _StoreScreenState();
// }

// class _StoreScreenState extends State<StoreScreen> {
//   late Future<Bannermodel> futureData;
//   ScrollController _scrollController = new ScrollController();
//   late List<TestModel> plist;
//   String stext = "";
//   String categoryid = "";
//   bool iscat = false;
//   bool issearch = false;
//   int val = 0;

//   @override
//   void initState() {
//     super.initState();
//     futureData = DataHandeler.fetchbanner();
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return ListView(
//       keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
//       children: [
//         Container(
//           child: Column(children: [
//             SizedBox(
//               height: size.height * 0.01,
//             ),
//             Container(
//               width: size.width,
//               child: Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   RoundedInput(
//                     onchange: (text) {
//                       setState(() {
//                         issearch = false;
//                       });
//                       if (text == "") {
//                         setState(() {
//                           issearch = false;
//                         });
//                       }
//                       setState(() {
//                         stext = text;
//                       });
//                       print("Search text -------" + stext);
//                     },
//                     valid: (text) {},
//                     save: (text) {},
//                     hintText: "Search...",
//                     icon: Icons.search_rounded,
//                   ),
//                   Padding(
//                     padding: EdgeInsets.only(left: size.width * 0.03),
//                     child: Container(
//                         decoration: BoxDecoration(
//                             color: kprimarylightcolor,
//                             borderRadius: BorderRadius.all(
//                                 Radius.circular(size.width * 0.05))),
//                         width: size.width * 0.15,
//                         child: Padding(
//                           padding: EdgeInsets.only(bottom: size.height * 0.008),
//                           child: IconButton(
//                             icon: Icon(
//                               Icons.search_rounded,
//                               color: kprimaryColor,
//                               size: size.width * 0.1,
//                             ),
//                             onPressed: () {
//                               FocusScope.of(context).unfocus();
//                               setState(() {
//                                 if (stext != "") {
//                                   setState(() {
//                                     issearch = true;
//                                   });
//                                 } else {
//                                   setState(() {
//                                     issearch = false;
//                                   });
//                                 }
//                               });
//                             },
//                           ),
//                         )),
//                   )
//                 ],
//               ),
//             ),
//             issearch
//                 ? Padding(
//                     padding: EdgeInsets.only(bottom: size.height * 0.013),
//                     child: Column(
//                       children: [
//                         Padding(
//                           padding: EdgeInsets.only(
//                               bottom: size.height * 0.02,
//                               left: size.width * 0.035),
//                           child: Text(
//                             "Search results...",
//                             style: TextStyle(
//                                 color: Colors.black.withOpacity(0.8),
//                                 fontSize: size.width * 0.04,
//                                 fontWeight: FontWeight.w700),
//                           ),
//                         ),
//                         Sresultview(
//                           searchval: stext,
//                         ),
//                       ],
//                     ))
//                 : SizedBox(height: size.height * 0),
//             Padding(
//               padding: EdgeInsets.only(bottom: size.height * 0.013),
//               child: FutureBuilder(
//                 future: futureData,
//                 builder: (context, snapshot) {
//                   if (snapshot.hasData) {
//                     Bannermodel data = snapshot.data as Bannermodel;
//                     print(data);
//                     return Container(
//                       child: Container(
//                         child: Image.network(fixbanner + data.image),
//                         // height: size.height * 0.2,
//                         width: size.width,
//                       ),
//                     );
//                   } else if (snapshot.hasError) {
//                     return Errorpage(size: size.width * 0.7);
//                   }
//                   // By default show a loading spinner.
//                   return Center(
//                       child: Lottie.asset("assets/animation/loading2.json",
//                           width: size.height * 0.08));
//                 },
//               ),
//             ),
//             Categorymenu(
//               biscuts: () async {
//                 bool isconnect = await NetworkHandeler.hasNetwork();

//                 if (isconnect == true) {
//                   categoryid = "cat009";
//                   val = 9;
//                   setState(() {
//                     issearch = false;
//                   });
//                 } else {
//                   NointernetScreen(pushscreen: Home());
//                 }
//               },
//               dried: () async {
//                 bool isconnect = await NetworkHandeler.hasNetwork();

//                 if (isconnect == true) {
//                   categoryid = "cat005";
//                   val = 5;
//                   setState(() {
//                     issearch = false;
//                   });
//                 } else {
//                   NointernetScreen(pushscreen: Home());
//                 }
//               },
//               spices: () async {
//                 bool isconnect = await NetworkHandeler.hasNetwork();
//                 print(val);

//                 if (isconnect == true) {
//                   categoryid = "cat003";

//                   setState(() {
//                     issearch = false;
//                     val = 3;
//                   });
//                   print(val);
//                 } else {
//                   NointernetScreen(pushscreen: Home());
//                 }
//               },
//               grain: () async {
//                 setState(() {
//                   iscat = false;
//                 });
//                 bool isconnect = await NetworkHandeler.hasNetwork();

//                 if (isconnect == true) {
//                   setState(() {
//                     categoryid = "cat006";
//                     iscat = true;
//                     issearch = false;
//                     print(categoryid);
//                   });
//                 } else {
//                   NointernetScreen(pushscreen: Home());
//                 }
//               },
//               grocery: () async {
//                 setState(() {
//                   iscat = false;
//                 });
//                 bool isconnect = await NetworkHandeler.hasNetwork();

//                 if (isconnect == true) {
//                   setState(() {
//                     categoryid = "cat008";
//                     iscat = true;
//                     issearch = false;
//                     print(categoryid);
//                   });
//                 } else {
//                   NointernetScreen(pushscreen: Home());
//                 }
//               },
//               milk: () async {
//                 setState(() {
//                   iscat = false;
//                 });
//                 bool isconnect = await NetworkHandeler.hasNetwork();

//                 if (isconnect == true) {
//                   setState(() {
//                     categoryid = "cat007";
//                     iscat = true;
//                     issearch = false;
//                     print(categoryid);
//                   });
//                 } else {
//                   NointernetScreen(pushscreen: Home());
//                 }
//               },
//               fish: () async {
//                 setState(() {
//                   iscat = false;
//                 });
//                 bool isconnect = await NetworkHandeler.hasNetwork();

//                 if (isconnect == true) {
//                   setState(() {
//                     categoryid = "cat002";
//                     iscat = true;
//                     issearch = false;
//                   });
//                 } else {
//                   NointernetScreen(pushscreen: Home());
//                 }
//               },
//               other: () async {
//                 setState(() {
//                   iscat = false;
//                 });
//                 bool isconnect = await NetworkHandeler.hasNetwork();

//                 if (isconnect == true) {
//                   setState(() {
//                     categoryid = "cat010";
//                     iscat = true;
//                     issearch = false;
//                   });
//                 } else {
//                   NointernetScreen(pushscreen: Home());
//                 }
//                 iscat = false;
//               },
//               readymade: () async {
//                 setState(() {
//                   iscat = false;
//                 });
//                 bool isconnect = await NetworkHandeler.hasNetwork();

//                 if (isconnect == true) {
//                   setState(() {
//                     categoryid = "cat004";

//                     iscat = true;
//                     issearch = false;
//                   });
//                 } else {
//                   NointernetScreen(pushscreen: Home());
//                 }
//                 iscat = false;
//               },
//               vegetabels: () async {
//                 setState(() {
//                   iscat = false;
//                 });
//                 bool isconnect = await NetworkHandeler.hasNetwork();

//                 if (isconnect == true) {
//                   setState(() {
//                     categoryid = "cat001";

//                     iscat = true;
//                     issearch = false;
//                   });
//                 } else {
//                   NointernetScreen(pushscreen: Home());
//                 }
//               },
//             )
//           ]),
//         ),
//         SizedBox(
//           height: size.height * 0.03,
//         ),
//         val == 1
//             ? Itemgridcategory(
//                 catid: categoryid,
//               )
//             : val == 2
//                 ? Itemgridcategory(
//                     catid: categoryid,
//                   )
//                 : val == 3
//                     ? Itemgridcategory(
//                         catid: categoryid,
//                       )
//                     : val == 4
//                         ? Itemgridcategory(
//                             catid: categoryid,
//                           )
//                         : val == 5
//                             ? Itemgridcategory(
//                                 catid: categoryid,
//                               )
//                             : val == 6
//                                 ? Itemgridcategory(
//                                     catid: categoryid,
//                                   )
//                                 : val == 7
//                                     ? Itemgridcategory(
//                                         catid: categoryid,
//                                       )
//                                     : val == 8
//                                         ? Itemgridcategory(
//                                             catid: categoryid,
//                                           )
//                                         : val == 9
//                                             ? Itemgridcategory(
//                                                 catid: categoryid,
//                                               )
//                                             : val == 10
//                                                 ? Itemgridcategory(
//                                                     catid: categoryid,
//                                                   )
//                                                 : SizedBox(
//                                                     height: size.height * 0.00,
//                                                   ),
//         Itemgridall(
//           scrollController: _scrollController,
//         ),
//       ],
//     );
//   }

//   loaddata() {
//     TestModel p;
//     p = TestModel(
//         id: 17,
//         product_id: "vp-001",
//         name: "Polpani",
//         description: "rasai",
//         image: "1637575218-vp-001.png",
//         vlink1: "https://www.youtube.com/watch?v=FZ42oeNOWLw",
//         vlink2: "https://www.youtube.com/watch?v=FZ42oeNOWLw",
//         price: 4500,
//         preprice: 4509,
//         discount: 0.05,
//         quantity: "5",
//         rating: "0",
//         status: "Active",
//         category: "category",
//         subcat_id: "subcat_id",
//         created_at: "created_at",
//         updated_at: "updated_at");
//     plist.add(p);
//     p = TestModel(
//         id: 18,
//         product_id: "vp-001",
//         name: "Pol",
//         description: "rasai",
//         image: "1637575218-vp-001.png",
//         vlink1: "https://www.youtube.com/watch?v=FZ42oeNOWLw",
//         vlink2: "https://www.youtube.com/watch?v=FZ42oeNOWLw",
//         price: 4500,
//         preprice: 4509,
//         discount: 0.05,
//         quantity: "5",
//         rating: "0",
//         status: "Active",
//         category: "category",
//         subcat_id: "subcat_id",
//         created_at: "created_at",
//         updated_at: "updated_at");
//     plist.add(p);
//     p = TestModel(
//         id: 17,
//         product_id: "vp-001",
//         name: "kiri",
//         description: "rasai",
//         image: "1637575218-vp-001.png",
//         vlink1: "https://www.youtube.com/watch?v=FZ42oeNOWLw",
//         vlink2: "https://www.youtube.com/watch?v=FZ42oeNOWLw",
//         price: 4500,
//         preprice: 4509,
//         discount: 0.05,
//         quantity: "5",
//         rating: "0",
//         status: "Active",
//         category: "category",
//         subcat_id: "subcat_id",
//         created_at: "created_at",
//         updated_at: "updated_at");
//     plist.add(p);
//   }
// }

