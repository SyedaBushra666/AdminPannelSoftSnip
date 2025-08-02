import 'package:admin_pannel_monotor/controller/employees/project_controller.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';
import 'package:flutter/material.dart';

class MyProjectSearch extends StatelessWidget {
   final ProjectController controller;
  final double? width;

  //const MyProjectSearch({super.key, required this.controller, this.width});
  const  MyProjectSearch(TextEditingController searchController, {
    Key? key, 
    required this.controller,
    this.width,
  }) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Focus(                                                           
      child: Builder(
        builder: (context) {
          final isFocused = Focus.of(context).hasFocus;
          return SizedBox(
            width: width ?? MediaQuery.of(context).size.width * 0.45, // Increased width
            child: MyContainer(
              paddingAll: 0,
              child: TextField(
                controller: controller.searchController,
                onChanged: (value) => controller.searchText.value = value,
                decoration: InputDecoration(
                  isDense: true, // Reduces height
                  hintText: "Search Projectcs",
                  hintStyle: TextStyle(color: Colors.black54), // Slightly muted
                  suffixIcon: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: controller.searchController,
                    builder: (context, value, child) {
                      return value.text.isNotEmpty
                          ? IconButton(
                              splashRadius: 3,
                              padding: EdgeInsets.zero, // Tighter icon padding
                              icon: Icon(
                                Icons.clear, 
                                size: 20,
                                color: Colors.black87, // Darker icon
                              ),
                              onPressed: () {
                                controller.searchController.clear();
                                controller.searchText.value = '';
                              },
                            )
                          : SizedBox.shrink();
                    },
                  ),
                  prefixIcon: Icon(
                    Icons.search, 
                    size: 20,
                    color: const Color.fromARGB(255, 0, 28, 48), // Darker blue
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: isFocused ? Colors.black:Colors.grey.shade800,
                      width: isFocused ? 2.0 : 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: isFocused ?  Colors.black:Colors.grey.shade800,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                    
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    vertical: 8, // Reduced height
                    horizontal: 12,
                  ),
                ),
                style: TextStyle(fontSize: 14),
              ),
            ),
          );
        },
      ),
    );
  }
}