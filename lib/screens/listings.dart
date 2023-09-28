import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sellpad/utils/Colors.dart';

import '../widgets/product_list_tile.dart';

class ListingsScreen extends StatefulWidget {
  const ListingsScreen({Key? key}) : super(key: key);

  @override
  State<ListingsScreen> createState() => _ListingsScreenState();
}

class _ListingsScreenState extends State<ListingsScreen> {
  int pageSelected = -1;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageSelected = 1;
    catSelected = 1;
  }

  int catSelected = -1;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 22.0.w),
        child: Column(
          children: [
            SizedBox(
              height: 20.h,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () {
                    setState(() {
                      catSelected = 1;
                    });
                  },
                  child: Container(
                    width: 100.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: catSelected == 1 ? gradient : null,
                      color: catSelected != 1 ? grey.withOpacity(0.3) : null,
                    ),
                    child: Center(
                      child: Text(
                        'Products',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: catSelected == 1 ? white : grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      catSelected = 2;
                    });
                  },
                  child: Container(
                    width: 100.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: catSelected == 2 ? gradient : null,
                      color: catSelected != 2 ? grey.withOpacity(0.3) : null,
                    ),
                    child: Center(
                      child: Text(
                        'Services',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: catSelected == 2 ? white : grey,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: 10.w,
                ),
                GestureDetector(
                  onTap: () {
                    setState(() {
                      catSelected = 3;
                    });
                  },
                  child: Container(
                    width: 100.w,
                    height: 40.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      gradient: catSelected == 3 ? gradient : null,
                      color: catSelected != 3 ? grey.withOpacity(0.3) : null,
                    ),
                    child: Center(
                      child: Text(
                        'Housing',
                        style: GoogleFonts.outfit(
                          fontWeight: FontWeight.w500,
                          fontSize: 15,
                          color: catSelected == 3 ? white : grey,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 6,
            ),
            Expanded(
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return ProductListTile(
                    productImage: 'assets/listed_pro_img.png',
                    productName: 'Iphone 14',
                    productLocation: 'Los Angeles',
                    productPrice: '\$12',
                  );
                },
                itemCount: 5,
                shrinkWrap: true,
                scrollDirection: Axis.vertical,
                physics: BouncingScrollPhysics(),
              ),
            ),
            SizedBox(
              height: 20,
            )
          ],
        ),
      ),
    );
  }
}
