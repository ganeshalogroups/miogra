// ignore_for_file: file_names, unnecessary_string_interpolations

import 'package:cached_network_image/cached_network_image.dart';
import 'package:testing/Mart/Cartscreen/Martcartappbar.dart';
import 'package:testing/Mart/MartProductsview/Frequentlybought.dart';
import 'package:testing/Mart/MartProductsview/Variants.dart';
import 'package:testing/utils/Buttons/CustomContainer.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/Const/constImages.dart';
import 'package:testing/utils/Containerdecoration.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class Viewproducts extends StatefulWidget {
dynamic fetcheddatas;
Viewproducts({super.key,required this.fetcheddatas});

  @override
  State<Viewproducts> createState() => _ViewproductsState();
}
class _ViewproductsState extends State<Viewproducts> {
  int localItemCount = 1; // Move the variable here

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Customcolors.pureWhite,
      bottomSheet: Container(
        height: 65,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2), // Light shadow
              offset: const Offset(0, -4), // Moves shadow to the top
              blurRadius: 6, // Increased for a softer effect
              spreadRadius: 2, // Optional for a more visible shadow
            ),
          ],
          color: Customcolors.pureWhite,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(15),
            topRight: Radius.circular(15),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              padding: const EdgeInsets.symmetric(vertical: 2),
              width: 100,
              decoration: CustomContainerDecoration.customisedbuttondecoration(),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    onTap: () {
                      if (localItemCount > 1) {
                        setState(() {
                          localItemCount--;
                        });
                      } else if (localItemCount == 1) {
                        Navigator.pop(context);
                      }
                    },
                    child: const Icon(
                      Icons.remove,
                      color: Customcolors.darkpurple,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    '$localItemCount',
                    style: CustomTextStyle.decorationORANGEtext22,
                  ),
                  const SizedBox(width: 8),
                  InkWell(
                    onTap: () {
                      setState(() {
                        localItemCount++;
                      });
                    },
                    child: const Icon(
                      Icons.add,
                      color: Customcolors.darkpurple,
                    ),
                  ),
                ],
              ),
            ),
            InkWell(
              onTap: () async {
                Get.to(const MartCartappbar());
              },
              child: CustomContainer(
                height: 40,
                width: MediaQuery.of(context).size.width * 0.6,
                decoration: CustomContainerDecoration.gradientbuttondecoration(),
                child: const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8, horizontal: 20),
                  child: Center(
                    child:  Text(
                      "Add Item | ₹140",
                      overflow: TextOverflow.ellipsis,
                      style: CustomTextStyle.smallwhitetext,
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Customcolors.pureWhite,
        title: const Text(
          'Product Details',
          style: CustomTextStyle.darkgrey,
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: InkWell(
          onTap: () {},
          child: const Icon(Icons.arrow_back),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child:CachedNetworkImage(
                    imageUrl: widget.fetcheddatas["productListImgUrl"],
                    height: 220.h,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                    placeholder: (context, url) => Image.asset(
                    meatdummy,
                    height: 220.h,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                    ),
                    errorWidget: (context, url, error) => Image.asset(
                    meatdummy,
                    height: 220.h,
                    width: double.infinity,
                    fit: BoxFit.fitHeight,
                    ),
                    )
                ),
              ),
              const SizedBox(height: 15),

              /// Product Name & Price
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children:  [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          "${widget.fetcheddatas["productListName"].toString().capitalizeFirst.toString()}",
                          // maxLines: 3,
                          overflow: TextOverflow.clip,
                          style: CustomTextStyle.smallboldblack,
                        ),
                      ),
                      const Text(
                        "₹150.00",
                        style: CustomTextStyle.redstrikered,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children:  [
                      Text(
                        "(${widget.fetcheddatas["subCategoryName"].toString()})",
                        style: CustomTextStyle.subblack,
                      ),
                      Text(
                        "₹${widget.fetcheddatas["productList"]["customerPrice"].toString()}",
                        style: CustomTextStyle.smallboldblack,
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${widget.fetcheddatas["productList"]["unitValue"].toString()}${widget.fetcheddatas["productList"]["unit"].toString()}",
                    style: CustomTextStyle.smallboldblack,
                  ),
                ],
              ),
               widget.fetcheddatas["productListDiscription"].isEmpty?const SizedBox(height: 0,):const SizedBox(height: 16),

              /// Product Description
             widget.fetcheddatas["productListDiscription"].isEmpty?const SizedBox(height: 0,):  const Text(
                "Product description",
                style: CustomTextStyle.chipgrey,
              ),
              const SizedBox(height: 10),
              widget.fetcheddatas["productListDiscription"].isEmpty?const SizedBox(height: 0,): SizedBox(
                width: MediaQuery.of(context).size.width / 1.1,
                child: Text(
                  "${ widget.fetcheddatas["productListDiscription"].toString().capitalizeFirst}",
                  softWrap: true,
                  textAlign: TextAlign.justify,
                  style: CustomTextStyle.smallgrey,
                ),
              ),
              const SizedBox(height: 10),
              const Divider(),
              const SizedBox(height: 20),
              /// Variants Section
            widget.fetcheddatas["customizedProduct"]["addVariants"].isNotEmpty?
              MartVariants(fetcheddatas: widget.fetcheddatas,):const SizedBox(),
              widget.fetcheddatas["customizedProduct"]["addVariants"].isNotEmpty?
              const Divider():const SizedBox(),
              widget.fetcheddatas["customizedProduct"]["addVariants"].isNotEmpty?
              const SizedBox(height: 20):const SizedBox(),

              const FrequentlyboughtTogether(),
              SizedBox(height: 65.h),
            ],
          ),
        ),
      ),
    );
  }
}

