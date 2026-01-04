import "package:flutter/material.dart";

enum Language { english, khmer, malaysia }

class DropDownLanguage extends StatefulWidget {
  const DropDownLanguage({super.key});

  @override
  State<DropDownLanguage> createState() => _DropDownLanguageState();
}

class _DropDownLanguageState extends State<DropDownLanguage> {
  String selectedValue = Language.english.name;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 15),
      child: DropdownButton<String>(
          dropdownColor: Colors.white,
          icon: Icon(Icons.arrow_drop_down_outlined),
          underline: Container(),
          value: selectedValue,
          items: [
            ...Language.values.map((element) {
              String shortText = element.name.length >= 3
                  ? element.name.substring(0, 3)
                  : element.name;
              shortText = shortText[0].toUpperCase() + shortText.substring(1);
              return DropdownMenuItem(
                value: element.name,
                child: Text(
                  shortText,
                  style: TextStyle(fontSize: 16, color: Colors.black),
                ),
              );
            }),
          ],
          onChanged: (value) {
            setState(() {
              selectedValue = value!;
              FocusScope.of(context).unfocus();
            });
          },
      ),
    );
  }
}
