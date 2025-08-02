import 'package:admin_pannel_monotor/dashboard.dart';
import 'package:admin_pannel_monotor/views/employees/add_member.dart';
import 'package:admin_pannel_monotor/views/employees/edit_member.dart';
import 'package:admin_pannel_monotor/views/employees/member_list.dart';
import 'package:admin_pannel_monotor/views/employees/view_member.dart';
import 'package:admin_pannel_monotor/views/time_sheets/calender_timesheet.dart';
import 'package:admin_pannel_monotor/views/time_sheets/daily_timesheet.dart';
import 'package:admin_pannel_monotor/views/time_sheets/weekly_timesheet.dart';
import 'package:admin_pannel_monotor/views/trackboard/appusage_view.dart';
import 'package:admin_pannel_monotor/views/trackboard/snapshots_view.dart';
import 'package:admin_pannel_monotor/views/trackboard/web_usage_view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class AuthMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route) {
    // Auth check disabled temporarily
    return null;
  }
}

getPageRoute() {
  var routes = [
     GetPage(
        name: '/',
        page: () => DashboardPage(),
        middlewares: [AuthMiddleware()]),

         GetPage(
        name: '/dashboard',
        page: () => DashboardPage(),
        middlewares: [AuthMiddleware()]),
    //------------------TrackBoard--------------------//
      
      GetPage(
        name: '/trackboard/webUsage',
        page: () => WebUsageView(),
        middlewares: [AuthMiddleware()]),
     
       GetPage(
        name: '/trackboard/snapshot',
        page: () => SnapshotsView(),
        middlewares: [AuthMiddleware()]),

      GetPage(
        name: '/trackboard/appUsage',
        page: () => AppUsageView(),
        middlewares: [AuthMiddleware()]),
     ///---------------- TimeSheets ----------------///
     
      GetPage(
        name: '/timesheets/daily',
        page: () => DailyTimesheet(),
        middlewares: [AuthMiddleware()]),
   

     GetPage(
        name: '/timesheets/weekly',
        page: () => WeeklyTimesheet(),
        middlewares: [AuthMiddleware()]),

        GetPage(
        name: '/timesheets/calender',
        page: () => CalenderTimeSheet(),
        middlewares: [AuthMiddleware()]),
   
    ///---------------- Employees ----------------///

    GetPage(
        name: '/contacts/members',
        page: () => MemberList(),
        middlewares: [AuthMiddleware()]),

        GetPage(
        name: '/view-member',
        page: () => ViewMember(),
        middlewares: [AuthMiddleware()]),

     GetPage(
        name: '/edit_member/:id',
        page: () => EditMember(),
        middlewares: [AuthMiddleware()]),


        GetPage(
        name: '/contacts/addmember',
        page: () => AddMember(),
        middlewares: [AuthMiddleware()]),


  ];
  return routes
      .map(
        (e) => GetPage(
            name: e.name,
            page: e.page,
            middlewares: e.middlewares,
            transition: Transition.noTransition),
      )
      .toList();
}
