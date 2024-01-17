import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';

import 'package:uzaar/utils/colors.dart';
import 'package:uzaar/widgets/featured_services_widget.dart';

import 'package:uzaar/widgets/featured_products_widget.dart';

import '../../../utils/Buttons.dart';
import '../../../widgets/alert_dialog_reusable.dart';
import '../../BusinessDetailPages/product_details_page.dart';

enum ReportReason { notInterested, notAuthentic, inappropriate, violent, other }

class SellerListingsScreen extends StatefulWidget {
  const SellerListingsScreen({super.key});

  @override
  State<SellerListingsScreen> createState() => _SellerListingsScreenState();
}

class _SellerListingsScreenState extends State<SellerListingsScreen> {
  late Set<ReportReason> selectedReasons = {};
  handleOptionSelection(ReportReason reason) {
    if (selectedReasons.contains(reason)) {
      selectedReasons.remove(reason);
    } else {
      selectedReasons.add(reason);
    }
    print(selectedReasons);
  }

  @override
  Widget build(BuildContext context) {
    return GlowingOverscrollIndicator(
      axisDirection: AxisDirection.down,
      color: primaryBlue,
      child: Padding(
        padding: const EdgeInsets.only(left: 20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Featured Products',
                style: kBodyHeadingTextStyle,
              ),
              SizedBox(
                height: 20.h,
              ),
              Container(
                decoration: const BoxDecoration(color: Colors.white),
                height: 187,
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return FeaturedProductsWidget(
                      productCondition: 'New',
                      image: 'assets/product-ph.png',
                      productCategory: 'Electronics',
                      productName: 'Iphone 14',
                      // productLocation: 'Los Angeles',
                      productPrice: '120',
                      onImageTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => const ProductDetailsPage(
                              productData: null,
                            ),
                          ),
                        );
                      },
                      onOptionTap: () {
                        showDialog(
                          context: context,
                          builder: (context) => StatefulBuilder(
                            builder: (BuildContext context,
                                StateSetter stateSetterObject) {
                              return AlertDialogReusable(
                                description:
                                    'Select any reason to report. We will show you less listings like this next time.',
                                title: 'Report Listing',
                                itemsList: [
                                  SizedBox(
                                    height: 35,
                                    child: ListTile(
                                      title: Text(
                                        'Not Interested',
                                        style: kTextFieldInputStyle,
                                      ),
                                      leading: GestureDetector(
                                        onTap: () {
                                          stateSetterObject(() {
                                            handleOptionSelection(
                                                ReportReason.notInterested);
                                          });
                                        },
                                        child: SvgPicture.asset(
                                            selectedReasons.contains(
                                                    ReportReason.notInterested)
                                                ? 'assets/selected_check.svg'
                                                : 'assets/default_check.svg'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: ListTile(
                                      title: Text(
                                        'Not Authentic',
                                        style: kTextFieldInputStyle,
                                      ),
                                      leading: GestureDetector(
                                        onTap: () {
                                          stateSetterObject(() {
                                            handleOptionSelection(
                                                ReportReason.notAuthentic);
                                          });
                                        },
                                        child: SvgPicture.asset(
                                            selectedReasons.contains(
                                                    ReportReason.notAuthentic)
                                                ? 'assets/selected_check.svg'
                                                : 'assets/default_check.svg'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: ListTile(
                                      title: Text(
                                        'Inappropriate',
                                        style: kTextFieldInputStyle,
                                      ),
                                      leading: GestureDetector(
                                        onTap: () {
                                          stateSetterObject(() {
                                            handleOptionSelection(
                                                ReportReason.inappropriate);
                                          });
                                        },
                                        child: SvgPicture.asset(
                                            selectedReasons.contains(
                                                    ReportReason.inappropriate)
                                                ? 'assets/selected_check.svg'
                                                : 'assets/default_check.svg'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: ListTile(
                                      title: Text(
                                        'Violent or prohibited content',
                                        style: kTextFieldInputStyle,
                                      ),
                                      leading: GestureDetector(
                                        onTap: () {
                                          stateSetterObject(() {
                                            handleOptionSelection(
                                                ReportReason.violent);
                                          });
                                        },
                                        child: SvgPicture.asset(selectedReasons
                                                .contains(ReportReason.violent)
                                            ? 'assets/selected_check.svg'
                                            : 'assets/default_check.svg'),
                                      ),
                                    ),
                                  ),
                                  SizedBox(
                                    height: 35,
                                    child: ListTile(
                                      title: Text(
                                        'Other',
                                        style: kTextFieldInputStyle,
                                      ),
                                      leading: GestureDetector(
                                        onTap: () {
                                          stateSetterObject(() {
                                            handleOptionSelection(
                                                ReportReason.other);
                                          });
                                        },
                                        child: SvgPicture.asset(selectedReasons
                                                .contains(ReportReason.other)
                                            ? 'assets/selected_check.svg'
                                            : 'assets/default_check.svg'),
                                      ),
                                    ),
                                  ),
                                ],
                                button: primaryButton(
                                    context: context,
                                    buttonText: 'Send',
                                    onTap: () => Navigator.of(context).pop(),
                                    showLoader: false),
                              );
                            },
                          ),
                        );
                      },
                    );
                  },
                  itemCount: 6,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
              Text(
                'Featured Services',
                style: kBodyHeadingTextStyle,
              ),
              SizedBox(
                height: 20.h,
              ),
              SizedBox(
                height: 187,
                child: GestureDetector(
                  // onTap: () => Navigator.of(context).push(
                  //   MaterialPageRoute(
                  //     builder: (context) => const ServiceDetailsPage(
                  //       serviceData: null,
                  //     ),
                  //   ),
                  // ),
                  child: ListView.builder(
                    itemBuilder: (context, index) {
                      return const FeaturedServicesWidget(
                        image: 'assets/service-ph.png',
                        serviceCategory: 'Designing',
                        serviceName: 'Graphic Design',
                        serviceLocation: 'Los Angeles',
                        servicePrice: '20',
                        onOptionTap: null,
                        onImageTap: null,
                      );
                    },
                    itemCount: 6,
                    shrinkWrap: true,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                  ),
                ),
              ),
              SizedBox(
                height: 20.h,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
