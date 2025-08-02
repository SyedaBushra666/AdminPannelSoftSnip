import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_pannel_monotor/models/member.dart';

class MemberController extends GetxController {
  RxList<Member> members = <Member>[].obs;

  // ✅ Make selectedMember observable
 // Rxn<Member> selectedMember = Rxn<Member>();
  Rx<Member?> selectedMember = Rx<Member?>(null);
   /// Current search text
  RxString searchText = ''.obs;
  final TextEditingController searchController = TextEditingController();
  @override
  void onInit(){
    super.onInit();
    loadDummyData();
  }

  var selectedTab = 0.obs;

  RxnString selectedRole = RxnString();
  RxnString selectedProject = RxnString();
  String selectSize = "All";
  String selectedStatus = "All";

  void selectTab(int index) => selectedTab.value = index;

  void onSelectedSize(String size) {
    selectSize = size;
    update();
  }

  void onSelectedStatus(String status) {
    selectedStatus = status;
    update();
  }

  void loadDummyData() {
    members.value = [
      Member(
        id: '1',
        firstName: 'Ali',
        lastName: 'Raza',
        email: 'ali@example.com',
        role: 'Organization Admin',
        project: 'Project A',
      ),
      Member(
        id: '2',
        firstName: 'Sara',
        lastName: 'Khan',
        email: 'sara@example.com',
        role: 'Team Member',
        project: 'Project B',
        isActive: false,
      ),
      Member(
        id: '3',
        firstName: 'Umer',
        lastName: 'Raza',
        email: 'raxa@example.com',
        role: 'Team Lead',
        project: 'Project A',
        isActive: false,
      ),
    ];

     // Set default selected member
  selectedMember.value =   Member(
        id: '3',
        firstName: 'Umer',
        lastName: 'Raza',
        email: 'raxa@example.com',
        role: 'Team Lead',
        project: 'Project A',
        isActive: false,
      );
  }

  void selectRole(String role) => selectedRole.value = role;
  void selectProject(String project) => selectedProject.value = project;

  void addMember(Member member) {
    members.add(member);
    update();
  }

  void updateMember(Member updated) {
    final index = members.indexWhere((m) => m.id == updated.id);
    if (index != -1) {
      members[index] = updated;
      update();
    }
  }

  Member? findMemberById(String id) => members.firstWhereOrNull((m) => m.id == id);

  void deleteMember(String id) {
    members.removeWhere((m) => m.id == id);
    update();
  }

  //for select  members  dropdown
  void selectMember(Member member){
   selectedMember.value = member;
  }

  /// Filtered list based on search text
  List<Member> get filteredMembers {
    if (searchText.value.isEmpty) return members;
    return members
        .where((member) => member.firstName
            .toLowerCase()
            .contains(searchText.value.toLowerCase()))
        .toList();
  }
  /// Called when user types in search box
  void onSearch(String value) {
    searchText.value = value;
  }
  
}
