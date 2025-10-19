
// ignore_for_file: file_names

import 'package:testing/parcel/p_services_provider/p_Round_Trip_Validation.dart';
import 'package:testing/parcel/p_services_provider/p_address_provider.dart';
import 'package:testing/utils/Buttons/CustomTextstyle.dart';
import 'package:testing/utils/CustomColors/Customcolors.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChipSelector extends StatefulWidget {
  final bool isSingle;
  final bool isRound;
  final Function(String?) onChipTapped;
  final Map<String, List<String>> mapofCat;
  final String? defaultSelectedChip; // New parameter for default selected chip name

  const ChipSelector({
    super.key,
    required this.onChipTapped,
    required this.mapofCat,
    this.defaultSelectedChip,
    this.isRound  = false,
    this.isSingle = false
  });

  @override
  ChipSelectorState createState() => ChipSelectorState();
}

class ChipSelectorState extends State<ChipSelector> {
  String? selectedChip;


  @override
  void initState() {
    super.initState();



print('cheeecccchh ===========>>> 1');

if(widget.isSingle){

print('cheeecccchh ===========>>> 2');

WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return; // Check if the widget is still mounted
        var parcelcontent   =  Provider.of<ParcelAddressProvider>(context,listen: false).packagecontent;
          // Set the default selected chip from the provided argument
          if (parcelcontent != null && widget.mapofCat.containsKey(parcelcontent)) {
            selectedChip = parcelcontent;
            widget.onChipTapped(selectedChip); 
          }
      });
print('cheeecccchh ===========>>> 3');


}else{

print('cheeecccchh ===========>>>');


    WidgetsBinding.instance.addPostFrameCallback((_) {
          if (!mounted) return; // Check if the widget is still mounted
          var parcelcontent   =  Provider.of<RoundTripLOcatDataProvider>(context,listen: false).packagecontent;
          // Set the default selected chip from the provided argument
          if (parcelcontent != null && widget.mapofCat.containsKey(parcelcontent)) {
            selectedChip = parcelcontent;
            widget.onChipTapped(selectedChip); // Trigger the callback with the default selected chip
          }
      });
      }

      
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8.0,
      runSpacing: 20.0,
      children: widget.mapofCat.entries.map((entry) {
        final key = entry.key; // The unique identifier
        final label = entry.value; // The label to display
        bool isSelected = selectedChip == key; // Check if the chip is selected by key

        return InkWell(
          onTap: () {
            setState(() {
              // Toggle selection: deselect if already selected, otherwise select
              if (isSelected) {
                selectedChip = null; // Deselect all
              } else {
                selectedChip = key; // Select the new chip by key
              }
            });

            widget.onChipTapped(selectedChip);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(
              vertical: 6.0,
              horizontal: 12.0,
            ),
            decoration: BoxDecoration(
              color: isSelected ? Customcolors.darkpurple : Colors.white, // Change color if selected
              border: Border.all(color: isSelected ? Customcolors.darkpurple : Colors.grey),
              borderRadius: BorderRadius.circular(40),
            ),
            child: SizedBox(
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Image.network(
                    label.first,
                    errorBuilder: (context, error, stackTrace) => const Icon(
                      Icons.image_not_supported,
                      size: 20,
                      color: Colors.grey,
                    ),
                    height: 20,
                    width: 20,
                    color: isSelected ? Colors.white.withOpacity(1) : null,
                  ),
                  const SizedBox(width: 5),
                  Text(
                    key.toString(), // Display the label from the map's value
                    style: isSelected ? CustomTextStyle.white12text : CustomTextStyle.profiletitle,
                  ),
                ],
              ),
            ),
          ),
        );
      }).toList(),
    );
  }
}
