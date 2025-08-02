import 'package:admin_pannel_monotor/helpers/theme/app_theme.dart';
import 'package:admin_pannel_monotor/helpers/theme/theme_customizer.dart';
import 'package:admin_pannel_monotor/helpers/utils/my_shadow.dart';
import 'package:admin_pannel_monotor/helpers/utils/ui_mixins.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_card.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_spacing.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:admin_pannel_monotor/images.dart';
import 'package:admin_pannel_monotor/widgets/custom_pop_menu.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_lucide/flutter_lucide.dart';

typedef LeftbarMenuFunction = void Function(String key);

class LeftbarObserver {
  static Map<String, LeftbarMenuFunction> observers = {};

  static attachListener(String key, LeftbarMenuFunction fn) {
    observers[key] = fn;
  }

  static detachListener(String key) {
    observers.remove(key);
  }

  static notifyAll(String key) {
    for (var fn in observers.values) {
      fn(key);
    }
  }
}

class LeftBar extends StatefulWidget {
  final bool isCondensed;

  const LeftBar({super.key, this.isCondensed = false});

  @override
  _LeftBarState createState() => _LeftBarState();
}

class _LeftBarState extends State<LeftBar> with SingleTickerProviderStateMixin, UIMixin {
  final ThemeCustomizer customizer = ThemeCustomizer.instance;

  bool isCondensed = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isCondensed = widget.isCondensed;
    return MyCard(
      paddingAll: 0,
      shadow: MyShadow(position: MyShadowPosition.centerRight, elevation: 0.2),
      child: AnimatedContainer(
        color: leftBarTheme.background,
        width: isCondensed ? 70 : 254,
        curve: Curves.easeInOut,
        duration: const Duration(milliseconds: 200),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  InkWell(
                      onTap: () {
                        Get.toNamed('/dashboard');
                      },
                      child: Image.asset(
                        Images.logoIcon,
                        height: widget.isCondensed ? 24 : 32,
                        color: contentTheme.primary,
                      )),
                  if (!widget.isCondensed) MySpacing.width(16),
                  if (!widget.isCondensed)
                    MyText.labelLarge(
                      "Webkit",
                      style: GoogleFonts.raleway(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: theme.colorScheme.primary,
                        letterSpacing: 1,
                      ),
                      maxLines: 1,
                    ),
                ],
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                physics: const PageScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                     MySpacing.height(20),
                   NavigationItem(
                    iconData: LucideIcons.calendar_days,
                    title: "Dashboard",
                    route: '/dashboard',
                    isCondensed: isCondensed,
                  ),
                    MySpacing.height(20),
                    MenuWidget(
                      iconData: LucideIcons.contact,
                      isCondensed: isCondensed,
                      title: "Members",
                      children: [
                        MenuItem(title: "All Members", route: '/contacts/members', isCondensed: widget.isCondensed),
                        MenuItem(title: "Add Member", route: '/contacts/addmember', isCondensed: widget.isCondensed),
                      ],
                    ),
                    MySpacing.height(20),
                    MenuWidget(
                      iconData: LucideIcons.clock,
                      isCondensed: isCondensed,
                      title: "Timesheets",
                      children: [
                        MenuItem(title: "Daily", route: '/timesheets/daily', isCondensed: widget.isCondensed),
                        MenuItem(title: "Weekly", route: '/timesheets/weekly', isCondensed: widget.isCondensed),
                       // MenuItem(title: "Calender", route: '/timesheets/calender', isCondensed: widget.isCondensed),
                      ],
                    ),
                    MySpacing.height(20),
                    MenuWidget(
                      iconData: LucideIcons.camera,
                      isCondensed: isCondensed,
                      title: "TrackBoard",
                      children: [
                        MenuItem(title: "Snapshots", route: '/trackboard/snapshot', isCondensed: widget.isCondensed),
                      ],
                    ),
                      MySpacing.height(20),
                    MenuWidget(
                      iconData: LucideIcons.activity,
                      isCondensed: isCondensed,
                      title: "Activity",
                      children: [
                        MenuItem(title: "App Usage", route: '/trackboard/appUsage', isCondensed: widget.isCondensed),
                        MenuItem(title: "Web Usage", route: '/trackboard/webUsage', isCondensed: widget.isCondensed),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuWidget extends StatefulWidget {
  final IconData iconData;
  final String title;
  final bool isCondensed;
  final bool active;
  final List<MenuItem> children;

  const MenuWidget({super.key, required this.iconData, required this.title, this.isCondensed = false, this.active = false, this.children = const []});

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> with UIMixin, SingleTickerProviderStateMixin {
  bool isHover = false;
  bool isActive = false;
  late Animation<double> _iconTurns;
  late AnimationController _controller;
  bool popupShowing = true;
  Function? hideFn;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 200), vsync: this);
    _iconTurns = _controller.drive(Tween<double>(begin: 0.0, end: 0.5).chain(CurveTween(curve: Curves.easeIn)));
    LeftbarObserver.attachListener(widget.title, onChangeMenuActive);
  }

  void onChangeMenuActive(String key) {
    if (key != widget.title) {
      // Optional: collapse others
    }
  }

  void onChangeExpansion(value) {
    isActive = value;
    if (isActive) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    isActive = widget.children.any((element) => Get.currentRoute == element.route);

    if (widget.isCondensed) {
      return CustomPopupMenu(
        backdrop: true,
        show: popupShowing,
        hideFn: (hide) => hideFn = hide,
        onChange: (_) {},
        placement: CustomPopupMenuPlacement.right,
        menu: MouseRegion(
          cursor: SystemMouseCursors.click,
          onHover: (event) => setState(() => isHover = true),
          onExit: (event) => setState(() => isHover = false),
          child: MyContainer.transparent(
            margin: MySpacing.fromLTRB(16, 0, 16, 8),
            color: isActive || isHover ? leftBarTheme.activeItemBackground : Colors.transparent,
            padding: MySpacing.xy(8, 8),
            child: Center(
              child: Icon(
                widget.iconData,
                color: (isHover || isActive) ? leftBarTheme.activeItemColor : leftBarTheme.onBackground,
                size: 20,
              ),
            ),
          ),
        ),
        menuBuilder: (_) => MyContainer.bordered(
          paddingAll: 8,
          width: 190,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: widget.children,
          ),
        ),
      );
    } else {
      return MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) => setState(() => isHover = true),
        onExit: (event) => setState(() => isHover = false),
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(24, 0, 16, 0),
          paddingAll: 0,
          child: ListTileTheme(
            contentPadding: EdgeInsets.zero,
            dense: true,
            child: ExpansionTile(
              tilePadding: MySpacing.zero,
              initiallyExpanded: isActive,
              maintainState: true,
              onExpansionChanged: (expanded) {
                LeftbarObserver.notifyAll(widget.title);
                onChangeExpansion(expanded);
              },
              trailing: RotationTransition(
                turns: _iconTurns,
                child: Icon(LucideIcons.chevron_down, size: 18, color: leftBarTheme.onBackground),
              ),
              iconColor: leftBarTheme.activeItemColor,
              childrenPadding: MySpacing.x(12),
              title: Row(
                children: [
                  Icon(widget.iconData, size: 20, color: isHover || isActive ? leftBarTheme.activeItemColor : leftBarTheme.onBackground),
                  MySpacing.width(18),
                  Expanded(
                    child: MyText.labelLarge(
                      widget.title,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      color: isHover || isActive ? leftBarTheme.activeItemColor : leftBarTheme.onBackground,
                    ),
                  ),
                ],
              ),
              collapsedBackgroundColor: Colors.transparent,
              shape: const RoundedRectangleBorder(side: BorderSide(color: Colors.transparent)),
              backgroundColor: Colors.transparent,
              children: widget.children,
            ),
          ),
        ),
      );
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}

class MenuItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;

  const MenuItem({super.key, this.iconData, required this.title, this.isCondensed = false, this.route});

  @override
  _MenuItemState createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> with UIMixin {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = Get.currentRoute == widget.route;

    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          Get.toNamed(widget.route!);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) => setState(() => isHover = true),
        onExit: (event) => setState(() => isHover = false),
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(4, 0, 8, 4),
          color: isActive || isHover ? leftBarTheme.activeItemBackground : Colors.transparent,
          width: MediaQuery.of(context).size.width,
          padding: MySpacing.xy(18, 7),
          child: MyText.bodySmall(
            "${widget.isCondensed ? "" : "- "}  ${widget.title}",
            overflow: TextOverflow.clip,
            maxLines: 1,
            textAlign: TextAlign.left,
            fontSize: 12.5,
            color: isActive || isHover ? leftBarTheme.activeItemColor : leftBarTheme.onBackground,
              fontWeight: isActive || isHover ? 600 : 500,
            ),
        ),
      ), 
    );
  }
}




class NavigationItem extends StatefulWidget {
  final IconData? iconData;
  final String title;
  final bool isCondensed;
  final String? route;

  const NavigationItem({super.key, this.iconData, required this.title, this.isCondensed = false, this.route});

  @override
  _NavigationItemState createState() => _NavigationItemState();
}

class _NavigationItemState extends State<NavigationItem> with UIMixin {
  bool isHover = false;

  @override
  Widget build(BuildContext context) {
    bool isActive = true;
    return GestureDetector(
      onTap: () {
        if (widget.route != null) {
          Get.toNamed(widget.route!);

          // MyRouter.pushReplacementNamed(context, widget.route!, arguments: 1);
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onHover: (event) {
          setState(() {
            isHover = true;
          });
        },
        onExit: (event) {
          setState(() {
            isHover = false;
          });
        },
        child: MyContainer.transparent(
          margin: MySpacing.fromLTRB(16, 0, 16, 8),
          color: isActive || isHover ? leftBarTheme.activeItemBackground : Colors.transparent,
          padding: MySpacing.xy(8, 8),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              if (widget.iconData != null)
                Center(
                  child: Icon(
                    widget.iconData,
                    color: (isHover || isActive) ? leftBarTheme.activeItemColor : leftBarTheme.onBackground,
                    size: 20,
                  ),
                ),
              if (!widget.isCondensed)
                Flexible(
                  fit: FlexFit.loose,
                  child: MySpacing.width(16),
                ),
              if (!widget.isCondensed)
                Expanded(
                  flex: 3,
                  child: MyText.labelLarge(
                    widget.title,
                    overflow: TextOverflow.clip,
                    maxLines: 1,
                    color: isActive || isHover ? leftBarTheme.activeItemColor : leftBarTheme.onBackground,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
