import 'package:admin_pannel_monotor/models/projects.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class ProjectController extends GetxController {
  Rx<ProjectItem?> selectedProject = Rx<ProjectItem?>(null);
  RxList<ProjectItem> projectList = <ProjectItem>[
    ProjectItem("SiftSnip's Project", "1"),
    ProjectItem("Getting Started", "2"),
    ProjectItem("Basic Project", "3"),
  ].obs;

  RxList<ProjectItem> filteredList = <ProjectItem>[].obs;
  RxString searchText = ''.obs;
  final TextEditingController searchController = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    filteredList.assignAll(projectList);
  }

  void filterProjects(String query) {
    if (query.isEmpty) {
      filteredList.assignAll(projectList);
    } else {
      filteredList.assignAll(
        projectList.where((p) => p.name.toLowerCase().contains(query.toLowerCase())),
      );
    }
  }

  void selectProject(ProjectItem item) {
    selectedProject.value = item;
  }
}
