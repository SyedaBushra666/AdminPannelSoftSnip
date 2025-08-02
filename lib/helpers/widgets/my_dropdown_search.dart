import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';

class MyDropdownSearch extends StatelessWidget {
  final TextEditingController controller;
  final RxString searchText;
  final String hintText;
  final double? width;

  const MyDropdownSearch({
    Key? key,
    required this.controller,
    required this.searchText,
    this.hintText = "Search...",
    this.width,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Focus(
      child: Builder(
        builder: (context) {
          final isFocused = Focus.of(context).hasFocus;
          return SizedBox(
            width: width ?? MediaQuery.of(context).size.width * 0.95,
            child: MyContainer(
              paddingAll: 0,
              child: TextField(
                controller: controller,
                onChanged: (value) => searchText.value = value,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: hintText,
                  hintStyle: const TextStyle(color: Colors.black54),
                  suffixIcon: ValueListenableBuilder<TextEditingValue>(
                    valueListenable: controller,
                    builder: (context, value, child) {
                      return value.text.isNotEmpty
                          ? IconButton(
                              splashRadius: 3,
                              padding: EdgeInsets.zero,
                              icon: const Icon(Icons.clear, size: 20, color: Colors.black87),
                              onPressed: () {
                                controller.clear();
                                searchText.value = '';
                              },
                            )
                          : const SizedBox.shrink();
                    },
                  ),
                  prefixIcon: const Icon(
                    Icons.search,
                    size: 20,
                    color: Color.fromARGB(255, 0, 28, 48),
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: isFocused ? Colors.black : Colors.grey.shade800,
                      width: isFocused ? 2.0 : 1.5,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: BorderSide(
                      color: isFocused ? Colors.black : Colors.grey.shade800,
                      width: 1.5,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8),
                    borderSide: const BorderSide(
                      color: Colors.black,
                      width: 2.0,
                    ),
                  ),
                  contentPadding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                ),
                style: const TextStyle(fontSize: 14),
              ),
            ),
          );
        },
      ),
    );
  }
}
