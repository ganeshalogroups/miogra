// ignore_for_file: file_names

import 'package:testing/Features/Foodmodule/Foodcategorycontroller/Addfoodcontroller.dart';
import 'package:testing/Features/Homepage/Profile_Orders/Commoncontroller/Redirectcontroller.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:testing/utils/Decorations/boxDecoration.dart';
import 'package:testing/utils/Shimmers/Tripshimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class DriverTipSelector extends StatefulWidget {
  final GlobalKey<FormState> externalFormKey;
  const DriverTipSelector({
    super.key, required this.externalFormKey,
  });

  @override
  State<DriverTipSelector> createState() => _DriverTipSelectorState();
}

class _DriverTipSelectorState extends State<DriverTipSelector> {
  final RedirectController redirect = Get.put(RedirectController());
  int? selectedIndex;
  String? selectedAmount;
  bool deliverytip = false;
  final TextEditingController customAmountController = TextEditingController();
  Foodcartcontroller tipscontroller = Get.put(Foodcartcontroller());

//   @override
//   void initState() {
//     super.initState();
//     // redirect.getredirectDetails();
//   }
  String normalizeTip(String tip) {
  return tip.replaceAll("₹", "").trim();
}

@override
void initState() {
  super.initState();
 
  WidgetsBinding.instance.addPostFrameCallback((_) {
    final storedTip = normalizeTip(tipscontroller.selectedTipAmount.value);

    var data = redirect.redirectLoadingDetails["data"] ?? [];
    List<String> tipAmounts = data
        .where((item) => item['key'] == 'drivertipamount')
        .map<String>((item) => normalizeTip(item['value'].toString()))
        .toList();

    if (storedTip.isNotEmpty) {
      if (tipAmounts.contains(storedTip)) {
        setState(() {
          selectedIndex = tipAmounts.indexOf(storedTip);
          selectedAmount = tipAmounts[selectedIndex!]; // normalized value
          customAmountController.clear();
        });
      } else {
        setState(() {
          selectedIndex = tipAmounts.length; // "Other" index
          selectedAmount = storedTip;
          customAmountController.text = storedTip;
        });
      }
    }
  });
}


  @override
  Widget build(BuildContext context) {
    return Form(
    key: widget.externalFormKey,
    autovalidateMode: AutovalidateMode.onUserInteraction,
      child: Container(
        width: MediaQuery.of(context).size.width / 1,
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        decoration: BoxDecorationsFun.whiteCircelRadiusDecoration(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Tips for Delivery Partner",
              style: CustomTextStyle.boldblack12,
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(() {
              if (redirect.isredirectLoading.isTrue) {
             //   return const Center(child: TipShimmerLoader());
              } else if (redirect.redirectLoadingDetails["data"] == null ||
                  redirect.redirectLoadingDetails["data"] == "null") {
                return const Center(child: SizedBox());
              }
              if (tipscontroller.getbillfoodcartloading.isTrue) {
                return const Center(child: TipShimmerLoader());
              } else if (tipscontroller.getbillfoodcart == null) {
                return const TipShimmerLoader();
              } else if (tipscontroller.getbillfoodcart["data"].isEmpty) {
                return const Center(child: SizedBox());
              } else {
                List<String> getTipAmounts() {
                  var data = redirect.redirectLoadingDetails["data"] ?? [];
                  return data
                      .where((item) => item['key'] == 'drivertipamount')
                      .map<String>((item) => item['value'].toString().trim())
                      .toList();
                }
      
                List<String> tipAmounts = getTipAmounts();
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Wrap(
                      spacing: 8.0,
                      runSpacing: 8.0,
                      children: List.generate(tipAmounts.length + 1, (index) {
                        final isOther = index == tipAmounts.length;
                        final isSelected = selectedIndex == index;
                        final String label = isOther ? 'Other' : tipAmounts[index];
      
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedIndex = null;
                                selectedAmount = null;
                                customAmountController.clear();
                                tipscontroller.setTipAmount(''); // Clear stored tip when unselected
                              } else {
                                selectedIndex = index;
                                if (isOther) {
                                  selectedAmount = null;
                                  customAmountController.clear();
                                  tipscontroller.setTipAmount(''); // Clear stored tip when choosing "Other"
                                } else {
                                  selectedAmount = tipAmounts[index];
                                  tipscontroller.setTipAmount(selectedAmount!); // Store selected tip
                                }
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 12, vertical: 5),
                            decoration: BoxDecoration(
                                color: isSelected
                                    ? const Color.fromRGBO(248, 221, 208, 0.973)
                                    : Customcolors.DECORATION_WHITE,
                                gradient: isSelected
                                    ? const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
  Customcolors.lightpurple,
Customcolors.darkpurple
                                        ],
                                      )
                                    : const LinearGradient(
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        colors: [
                                          Color.fromARGB(255, 255, 255,
                                              255), // Color code for #F98322
                                          Color.fromARGB(
                                              255, 255, 255, 255), // End color
                                        ],
                                      ),
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(
                                    color: Customcolors.DECORATION_LIGHTGREY)),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  label,
                                  style: isSelected
                                      ? CustomTextStyle.smallwhitetext
                                      : CustomTextStyle.foodpricetext,
                                ),
                                if (isSelected) ...[
                                  const SizedBox(width: 6),
                                  const Icon(Icons.cancel,
                                      size: 18, color: Colors.white),
                                ],
                              ],
                            ),
                          ),
                        );
                      }),
                    ),
                    if (selectedIndex == tipAmounts.length)
                      Padding(
                        padding: const EdgeInsets.only(top: 16.0),
                        child: TextFormField(
                          cursorColor: Customcolors.DECORATION_GREY,
                          cursorWidth: 2.0, // Set the cursor width
                          cursorRadius: const Radius.circular(5.0),
                          controller: customAmountController,
                          keyboardType: TextInputType.number,
     inputFormatters: [
  FilteringTextInputFormatter.digitsOnly,
  LengthLimitingTextInputFormatter(5),
],

  validator: (value) {
    if (selectedIndex == tipAmounts.length) {
      if (value == null || value.trim().isEmpty) {
        return 'Please provide a tip amount. ‘Other’ option requires a minimum tip.';
      }
      if (!RegExp(r'^\d{1,5}$').hasMatch(value.trim())) {
        return 'Only digits allowed, up to 5 digits';
      }
    }
    return null;
  },
                        //   validator: (value) {
                        //   if (selectedIndex == 3) {
                        //     // Only validate if "Other" is selected
                        //     if (value == null || value.trim().isEmpty) {
                        //       return 'Please enter tip amount';
                        //     }
                        //     if (!RegExp(r'^\d{1,2}$').hasMatch(value.trim())) {
                        //       return 'Accepts only two numerical characters';
                        //     }
                        //   }
                        //   return null; // No validation if "Other" not selected
                        // },
                        
                          // onChanged: (value) {
                          //   setState(() {
                          //     selectedAmount = value.trim();
                          //     tipscontroller.setTipAmount(selectedAmount!); // Save in GetX
                          //   });
                          // },
//                           onChanged: (value) {
//   final trimmedValue = value.trim();
//   if (trimmedValue.isEmpty || trimmedValue == '.' || trimmedValue == ',') {
//     setState(() {
//       selectedAmount = '';
//       tipscontroller.setTipAmount('');
//     });
//   } else {
//     final number = double.tryParse(trimmedValue);
//     if (number != null) {
//       setState(() {
//         selectedAmount = trimmedValue;
//         tipscontroller.setTipAmount(selectedAmount!);
//       });
//     } else {
//       // Optionally, show a validation message
//     }
//   }
// },
onChanged: (value) {
  final trimmedValue = value.trim();
  if (trimmedValue.isEmpty) {
    setState(() {
      selectedAmount = '';
      tipscontroller.setTipAmount('');
    });
  } else {
    final number = double.tryParse(trimmedValue);
    if (number != null) {
      setState(() {
        selectedAmount = trimmedValue;
        tipscontroller.setTipAmount(selectedAmount!);
      });
    }
  }
}
,
                          decoration: const InputDecoration(
                            hintText: 'Enter tip amount',
                            prefixText: "₹  ",
                            prefixStyle: CustomTextStyle.foodpricetext,
                            helperStyle: CustomTextStyle.grey12,
                            hintStyle: CustomTextStyle.hinttextstyl,
                            contentPadding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 10),
                            isDense: false,
                            isCollapsed: false,
                            counterText: "",
                            errorMaxLines: 2,
                            fillColor: Colors.transparent,
                            filled: true,
                            errorStyle: CustomTextStyle.notetext, // Add this line
                            focusedBorder: UnderlineInputBorder(
                              borderSide:BorderSide(color: Customcolors.DECORATION_GREY),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:BorderSide(color: Customcolors.DECORATION_GREY),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(15),
                                bottomRight: Radius.circular(15),
                              ),
                            ),
                             errorBorder: UnderlineInputBorder(
                             borderSide: BorderSide(color: Customcolors.DECORATION_RED),
                                    borderRadius: BorderRadius.only(
                                      bottomLeft: Radius.circular(15),
                                      bottomRight: Radius.circular(15),
                                    ),
                                  ),
                                  focusedErrorBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(color: Customcolors.DECORATION_RED),
                                      borderRadius: BorderRadius.only(
                                        bottomLeft: Radius.circular(15),
                                        bottomRight: Radius.circular(15),
                                      )),
                          ),
                        ),
                      ),
                    // const SizedBox(height: 16),
                    // if (selectedAmount != null && selectedAmount!.isNotEmpty)
                    //   Text(
                    //     'Selected Tip Amount:  ${tipscontroller.selectedTipAmount.value.replaceAll("₹", "")}',
                    //     style: CustomTextStyle.foodpricetext,
                    //   ),
                  ],
                );
              }
            }),
          ],
        ),
      ),
    );
  }
}


// class TipsstoredController extends GetxController {
//   RxString selectedTipAmount = ''.obs;

//   void setTipAmount(String value) {
//     selectedTipAmount.value = value.replaceAll("₹", "").trim();
//   }
// }







