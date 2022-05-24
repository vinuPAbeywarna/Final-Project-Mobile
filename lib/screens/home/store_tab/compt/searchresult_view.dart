import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:vinsartisanmarket/components/errorpage.dart';
import 'package:vinsartisanmarket/constansts/initdata.dart';
import 'package:vinsartisanmarket/models/productModel.dart';
import 'package:vinsartisanmarket/screens/home/store_tab/compt/singelitem.dart';
import 'package:vinsartisanmarket/screens/home/store_tab/compt/singellitemfull.dart';
import 'package:vinsartisanmarket/test/testdata_handeler.dart';
import 'package:vinsartisanmarket/test/testmodel.dart';
import 'package:cached_network_image/cached_network_image.dart';

class Sresultview extends StatefulWidget {
  final String searchval;
  final List<Productmodel> productlist;
  const Sresultview({
    Key? key,
    required this.searchval,
    required this.productlist,
  }) : super(key: key);

  @override
  _SresultviewState createState() {
    return _SresultviewState();
  }
}

class _SresultviewState extends State<Sresultview> {
  List<Productmodel> filteredList = [];
  bool issearch = false;

  @override
  void initState() {
    super.initState();
    searchdata();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return issearch
        ? GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            child: Container(
                child: Container(
              child: GridView.count(
                physics: NeverScrollableScrollPhysics(),
                childAspectRatio: size.width / size.height,
                crossAxisCount: 3,
                mainAxisSpacing: size.height * 0.01,
                crossAxisSpacing: size.width * 0.03,
                shrinkWrap: true,
                children: List.generate(
                  filteredList.length,
                  (index) {
                    bool status;
                    int quantity = 3;
                    if (quantity > 0) {
                      status = true;
                    } else {
                      status = false;
                    }
                    if (filteredList.isNotEmpty) {
                      return Container(
                          child: GestureDetector(
                              onTap: () {
                                final List<Widget> imglist = [
                                  CachedNetworkImage(
                                    imageUrl:
                                        imgebaseUrl + filteredList[index].image,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Container(
                                      //  height: size.height * 0.01,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.blueGrey,
                                            value: downloadProgress.progress),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  ),
                                  CachedNetworkImage(
                                    imageUrl:
                                        imgebaseUrl + filteredList[index].image,
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Container(
                                      //  height: size.height * 0.01,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                            color: Colors.blueGrey,
                                            value: downloadProgress.progress),
                                      ),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                  )
                                ];
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Singelitemfull(
                                              imglist: imglist,
                                              pid: filteredList[index].id,
                                              description: filteredList[index]
                                                  .description,
                                              price: filteredList[index].price,
                                              productname:
                                                  filteredList[index].name,
                                              status: status,
                                              productList: widget.productlist,
                                              productmodel: filteredList[index],
                                            )));
                              },
                              child: SingleItem(
                                titel: filteredList[index].name,
                                discount: 0,
                                price: filteredList[index].price,
                                pid: filteredList[index].id,
                                imgname:
                                    imgebaseUrl + filteredList[index].image,
                                preprice: filteredList[index].price,
                                status: status,
                              )));
                    } else {
                      return Center(
                          child: Lottie.asset("assets/animation/searching.json",
                              width: size.width * 0.4));
                    }
                  },
                ),
              ),
            )),
          )
        : Center(
            child: Lottie.asset("assets/animation/loadingindicator.json",
                width: size.width * 0.4));
  }

  searchdata() async {
    issearch = false;
    filteredList = widget.productlist
        .where((e) =>
            e.name.toLowerCase().contains(widget.searchval.toLowerCase()))
        .toList();

    setState(() {
      issearch = true;
    });
  }
}
