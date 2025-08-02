import 'package:admin_pannel_monotor/models/roles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class RoleController extends GetxController {
  RxList<RoleModel> roles = <RoleModel>[].obs;

  Rx<RoleModel?> selectedRole = Rx<RoleModel?>(null);

  final TextEditingController searchController = TextEditingController();
  RxString searchText = ''.obs;

  var selectedTab = 0.obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyRoles();
  }

  void selectTab(int index) => selectedTab.value = index;

  void loadDummyRoles() {
    roles.value = [
      RoleModel(
        id: '1',
        name: 'Organization Admin',
        description: 'Full access to organization settings and members.',
      ),
      RoleModel(
        id: '2',
        name: 'Manager',
        description: 'Can manage teams and assign tasks.',
      ),
      RoleModel(
        id: '3',
        name: 'User',
        description: 'Limited access to assigned tasks and timesheets.',
      ),
    ];

    selectedRole.value = roles.first;
  }

  void selectRole(RoleModel role) {
    selectedRole.value = role;
  }

  void addRole(RoleModel role) {
    roles.add(role);
    update();
  }

  void updateRole(RoleModel updated) {
    final index = roles.indexWhere((r) => r.id == updated.id);
    if (index != -1) {
      roles[index] = updated;
      update();
    }
  }

  void deleteRole(String id) {
    roles.removeWhere((r) => r.id == id);
    update();
  }

  List<RoleModel> get filteredRoles {
    if (searchText.value.isEmpty) return roles;
    return roles
        .where((role) =>
            role.name.toLowerCase().contains(searchText.value.toLowerCase()))
        .toList();
  }

  void onSearch(String value) {
    searchText.value = value;
  }
}
