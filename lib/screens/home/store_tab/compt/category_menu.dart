import 'package:flutter/material.dart';
import 'package:vinsartisanmarket/components/categoryitem.dart';

class Categorymenu extends StatelessWidget {
  final Function arts;
  final Function craft;
  final Function leather;
  final Function clothes;
  final Function shoes;
  final Function fabric;
  final Function crafttool;
  final Function arttool;

  const Categorymenu({
    Key? key,
    required this.arts,
    required this.craft,
    required this.leather,
    required this.clothes,
    required this.shoes,
    required this.fabric,
    required this.crafttool,
    required this.arttool,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      decoration: BoxDecoration(
          color: Colors.indigoAccent.withOpacity(0.18),
          borderRadius: const BorderRadius.all(Radius.circular(20))),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.025),
                  child: GestureDetector(
                    onTap: () {
                      clothes();
                    },
                    child: const CategoryItem(
                      imgsrc: "assets/icons/clothes.png",
                      label: 'Clothes',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: size.width * 0.025,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      leather();
                    },
                    child: const CategoryItem(
                      imgsrc: "assets/icons/leather.png",
                      label: 'Leather Items',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.01, right: size.width * 0.025),
                  child: GestureDetector(
                    onTap: () {
                      arts();
                    },
                    child: const CategoryItem(
                      imgsrc: 'assets/icons/arts.png',
                      label: 'Art Items',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                    right: size.width * 0.025,
                  ),
                  child: GestureDetector(
                    onTap: () {
                      arttool();
                    },
                    child: const CategoryItem(
                      imgsrc: "assets/icons/arttools.png",
                      label: 'Art Tools',
                    ),
                  ),
                ),
              ],
            ),
            //row brake
            SizedBox(
              height: size.height * 0.03,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.025),
                  child: GestureDetector(
                    onTap: () {
                      craft();
                    },
                    child: const CategoryItem(
                      imgsrc: "assets/icons/craft.png",
                      label: 'Craft Items',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.025),
                  child: GestureDetector(
                    onTap: () {
                      crafttool();
                    },
                    child: const CategoryItem(
                      imgsrc: "assets/icons/crafttool.png",
                      label: 'Craft Tools',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: size.width * 0.01, right: size.width * 0.025),
                  child: GestureDetector(
                    onTap: () {
                      fabric();
                    },
                    child: const CategoryItem(
                      imgsrc: "assets/icons/fabric.png",
                      label: 'Fabrics',
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: size.width * 0.025),
                  child: GestureDetector(
                    onTap: () {
                      shoes();
                    },
                    child: const CategoryItem(
                      imgsrc: "assets/icons/shoese.png",
                      label: 'Shoese',
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
