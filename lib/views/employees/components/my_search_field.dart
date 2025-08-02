import 'package:admin_pannel_monotor/helpers/utils/ui_mixins.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

class MySearchField extends StatefulWidget {
  final String hintText;

  const MySearchField({
    super.key,
    this.hintText = "Search here",
  });

  @override
  State<MySearchField> createState() => _MySearchFieldState();
}

class _MySearchFieldState extends State<MySearchField>
    with SingleTickerProviderStateMixin, UIMixin {
  bool isHovered = false;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {});
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showBorder = isHovered || _focusNode.hasFocus;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: Padding(
        padding: const EdgeInsets.all(4.0),
        child: Container(
          width: 250,
          height: 45, // ✅ Slightly increased
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(24),
            border: Border.all(
              color: showBorder
                  ? const Color.fromARGB(255, 163, 198, 227)
                  : Colors.transparent,
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.04),
                blurRadius: 6,
                offset: Offset(0, 2),
              ),
            ],
          ),
          child: TextField(
  focusNode: _focusNode,
  style: const TextStyle(fontSize: 13, height: 1.4, color: Colors.black),
  textAlignVertical: TextAlignVertical.center,
  decoration: InputDecoration(
    isDense: true,
    hintText: widget.hintText,
    hintStyle: const TextStyle(fontSize: 13, color: Colors.black),
    suffixIcon: Padding(
      padding: const EdgeInsets.only(right: 8.0,),
      child: Container(
       
        height: 20,
        width: 20,
        decoration: BoxDecoration(
          color: contentTheme.primary,
          shape: BoxShape.circle,
        ),
        child: const Icon(
          LucideIcons.search,
          size: 14,
          color: Colors.white,
        ),
      ),
    ),
    border: InputBorder.none,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 16,
      vertical: 0, // ✅ Adjusted vertical padding
    ),
  ),
),

        ),
      ),
    );
  }
}
