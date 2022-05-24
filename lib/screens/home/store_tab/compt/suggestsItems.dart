import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vinsartisanmarket/components/errorpage.dart';
import 'package:vinsartisanmarket/constansts/initdata.dart';
import 'package:vinsartisanmarket/models/categoryModel.dart';
import 'package:vinsartisanmarket/models/productModel.dart';
import 'package:vinsartisanmarket/screens/home/store_tab/compt/singelitem.dart';
import 'package:vinsartisanmarket/screens/home/store_tab/compt/singellitemfull.dart';
import 'package:vinsartisanmarket/test/testdata_handeler.dart';
import 'package:vinsartisanmarket/test/testmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class SuggestItemView extends StatefulWidget {
  final List<Productmodel> productlist;
  final CategoryModel categoryModel;
  const SuggestItemView({
    Key? key,
    required this.productlist,
    required this.categoryModel,
  }) : super(key: key);

  @override
  _SuggestItemViewState createState() {
    return _SuggestItemViewState();
  }
}

class _SuggestItemViewState extends State<SuggestItemView> {
  late Future<List<TestModel>> futureData;
  List<Productmodel> suggestlist = [];
  bool isload = false;

  @override
  void initState() {
    super.initState();
    // setState(() {
    //   futureData = TestDataHandeler.fetchTestModel();
    // });
    loaddata();
  }

  loaddata() async {
    widget.productlist.forEach((element) {
      if (element.category_id == widget.categoryModel.id) {
        suggestlist.add(element);
      }
    });
    isload = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        child:
            // builder: (context, snapshot) {
            //   if (snapshot.hasData) {
            //     List<TestModel> data = snapshot.data as List<TestModel>;
            //     print(data.toString() + "------------------------------");
            //     if (data.isEmpty) {
            //       return Center(
            //           child: Lottie.asset("assets/animation/noresult.json",
            //               width: size.width * 0.54));
            //     } else {
            isload
                ? suggestlist.isEmpty
                    ? Center(
                        child: Lottie.asset("assets/animation/noresult.json",
                            width: size.width * 0.54))
                    : Container(
                        child: GridView.count(
                          physics: NeverScrollableScrollPhysics(),
                          childAspectRatio: size.width / size.height,
                          crossAxisCount: 3,
                          mainAxisSpacing: size.height * 0.01,
                          crossAxisSpacing: size.width * 0.03,
                          shrinkWrap: true,
                          children: List.generate(
                            suggestlist.length,
                            (index) {
                              bool status;
                              int quantity = 3;
                              if (quantity > 0) {
                                status = true;
                              } else {
                                status = false;
                              }
                              return Container(
                                  child: GestureDetector(
                                      onTap: () {
                                        final List<Widget> imglist = [
                                          CachedNetworkImage(
                                            imageUrl: imgebaseUrl +
                                                suggestlist[index].image,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Container(
                                              //  height: size.height * 0.01,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Colors.blueGrey,
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          ),
                                          CachedNetworkImage(
                                            imageUrl: imgebaseUrl +
                                                suggestlist[index].image,
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Container(
                                              //  height: size.height * 0.01,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                        color: Colors.blueGrey,
                                                        value: downloadProgress
                                                            .progress),
                                              ),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
                                          )
                                        ];
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    Singelitemfull(
                                                      imglist: imglist,
                                                      pid:
                                                          suggestlist[index].id,
                                                      description:
                                                          suggestlist[index]
                                                              .description,
                                                      price: suggestlist[index]
                                                          .price,
                                                      productname:
                                                          suggestlist[index]
                                                              .name,
                                                      status: status,
                                                      productList:
                                                          widget.productlist,
                                                      productmodel:
                                                          suggestlist[index],
                                                    )));
                                      },
                                      child: SingleItem(
                                        titel: suggestlist[index].name,
                                        discount: 0,
                                        price: suggestlist[index].price,
                                        pid: suggestlist[index].id,
                                        imgname: imgebaseUrl +
                                            suggestlist[index].image,
                                        preprice: suggestlist[index].price,
                                        status: status,
                                      )));
                            },
                          ),
                        ),
                      )
                : Center(
                    child: Lottie.asset(
                        "assets/animation/loadingindicator.json",
                        width: size.width * 0.4)),
        // }
        //   } else if (snapshot.hasError) {
        //     return Errorpage(size: size.width * 0.7);
        //   }
        //   // By default show a loading spinner.
        //   return Center(
        //       child: Lottie.asset("assets/animation/loadingindicator.json",
        //           width: size.width * 0.4));
        // },
      ),
    );
  }
}




///////////////////////full fetch////////////////////////////
///
///

// class SuggestItemView extends StatefulWidget {
//   const SuggestItemView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   _SuggestItemViewState createState() {
//     return _SuggestItemViewState();
//   }
// }

// class _SuggestItemViewState extends State<SuggestItemView> {
//   late Future<List<TestModel>> futureData;

//   @override
//   void initState() {
//     super.initState();
//     // setState(() {
//     //   futureData = TestDataHandeler.fetchTestModel();
//     // });
//   }

//   @override
//   Widget build(BuildContext context) {
//     Size size = MediaQuery.of(context).size;
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Container(
//         child: FutureBuilder(
//           future: futureData,
//           builder: (context, snapshot) {
//             if (snapshot.hasData) {
//               List<TestModel> data = snapshot.data as List<TestModel>;
//               print(data.toString() + "------------------------------");
//               if (data.isEmpty) {
//                 return Center(
//                     child: Lottie.asset("assets/animation/noresult.json",
//                         width: size.width * 0.54));
//               } else {
//                 return Container(
//                   child: GridView.count(
//                     physics: NeverScrollableScrollPhysics(),
//                     childAspectRatio: size.width / size.height,
//                     crossAxisCount: 3,
//                     mainAxisSpacing: size.height * 0.01,
//                     crossAxisSpacing: size.width * 0.03,
//                     shrinkWrap: true,
//                     children: List.generate(
//                       5,
//                       (index) {
//                         bool status;
//                         int quantity = 3;
//                         if (quantity > 0) {
//                           status = true;
//                         } else {
//                           status = false;
//                         }
//                         return Container(
//                             child: GestureDetector(
//                                 onTap: () {
//                                   final List<Widget> imglist = [
//                                     CachedNetworkImage(
//                                       imageUrl:
//                                           "https://www.ubuy.com.kh/productimg/?image=aHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0kvNjErNHpTWERld0wuX0FDX1VMMTAyMF8uanBn.jpg",
//                                       progressIndicatorBuilder:
//                                           (context, url, downloadProgress) =>
//                                               Container(
//                                         //  height: size.height * 0.01,
//                                         child: Center(
//                                           child: CircularProgressIndicator(
//                                               color: Colors.blueGrey,
//                                               value: downloadProgress.progress),
//                                         ),
//                                       ),
//                                       errorWidget: (context, url, error) =>
//                                           Icon(Icons.error),
//                                     ),
//                                     CachedNetworkImage(
//                                       imageUrl:
//                                           "https://www.casio.com/content/dam/casio/product-info/locales/intl/en/timepiece/product/watch/G/GA/GA7/GA-700-1B/assets/GA-700-1B_Seq2.jpg.transform/main-visual-sp/image.jpg",
//                                       progressIndicatorBuilder:
//                                           (context, url, downloadProgress) =>
//                                               Container(
//                                         //  height: size.height * 0.01,
//                                         child: Center(
//                                           child: CircularProgressIndicator(
//                                               color: Colors.blueGrey,
//                                               value: downloadProgress.progress),
//                                         ),
//                                       ),
//                                       errorWidget: (context, url, error) =>
//                                           Icon(Icons.error),
//                                     )
//                                   ];
//                                   Navigator.push(
//                                       context,
//                                       MaterialPageRoute(
//                                           builder: (context) => Singelitemfull(
//                                                 imglist: imglist,
//                                                 pid: 'A-456',
//                                                 description:
//                                                     'The Casio GA110GB-1A G-Shock Gents Watch is a giant in watch proportions. Living up to the G-Shock name with the X-Large G, the black piece with a two-toned gold dial, features an analogue and digital display with shock and magnetic resistance, an auto LED light with afterglow, world time, 4 daily alarms, 1 snooze, an hourly time signal, stopwatch, countdown timer, full auto calendar and 12/24 hour formats. The watch is made for every day of the year.',
//                                                 price: 150,
//                                                 productname: "Men's Watch",
//                                                 status: status,
//                                               )));
//                                 },
//                                 child: SingleItem(
//                                   titel: "Men's Watch",
//                                   discount: 50,
//                                   price: 150,
//                                   pid: "A-456",
//                                   imgname:
//                                       "https://www.ubuy.com.kh/productimg/?image=aHR0cHM6Ly9tLm1lZGlhLWFtYXpvbi5jb20vaW1hZ2VzL0kvNjErNHpTWERld0wuX0FDX1VMMTAyMF8uanBn.jpg",
//                                   preprice: 200,
//                                   status: status,
//                                 )));
//                       },
//                     ),
//                   ),
//                 );
//               }
//             } else if (snapshot.hasError) {
//               return Errorpage(size: size.width * 0.7);
//             }
//             // By default show a loading spinner.
//             return Center(
//                 child: Lottie.asset("assets/animation/loadingindicator.json",
//                     width: size.width * 0.4));
//           },
//         ),
//       ),
//     );
//   }
// }
