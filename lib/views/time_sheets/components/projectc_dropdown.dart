import 'package:admin_pannel_monotor/controller/employees/project_controller.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_container.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_project_search.dart';
import 'package:admin_pannel_monotor/helpers/widgets/my_text.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:admin_pannel_monotor/models/projects.dart';

class ProjectDropdown extends StatelessWidget {
  final ProjectController controller = Get.put(ProjectController());
  final double maxDropdownWidth = 300;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      final availableWidth = constraints.maxWidth;
      final dropdownWidth = availableWidth > maxDropdownWidth
          ? maxDropdownWidth
          : availableWidth * 0.9;

      return Obx(() {
        return PopupMenuButton<ProjectItem>(
          constraints: BoxConstraints(
            maxWidth: dropdownWidth,
            minWidth: 200,
          ),
          onSelected: (ProjectItem item) => controller.selectProject(item),
          offset: const Offset(0, 50),
          itemBuilder: (context) {
            return [
                  PopupMenuItem(
                  enabled: false,
                  child: SizedBox(
                    width: dropdownWidth - 32, // Account for padding
                    child: MyProjectSearch(
                      controller.searchController,
                      controller: controller,
                    ),
                  ),
                ),
              ...controller.filteredList.map(
                (project) => PopupMenuItem<ProjectItem>(
                  value: project,
                  child: SizedBox(
                    width: dropdownWidth - 32,
                    child: _ProjectPopupItem(
                      project: project,
                      controller: controller,
                    ),
                  ),
                ),
              )
            ];
          },
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: 150,
              maxWidth: dropdownWidth,
            ),
            child: MyContainer(
               padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              // border: Border(
              //   left: BorderSide(color: Colors.green, width: 5),
              // ),
              // borderColor: Theme.of(context).colorScheme.secondary,
              bordered: true,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.work_outline, size: 16, color: Colors.black),
                  const SizedBox(width: 8),
                  Expanded(
                    child: MyText(
                      controller.selectedProject.value?.name ??
                          'Select Project',
                      fontWeight: 500,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  
                    const Icon(Icons.arrow_drop_down_circle_sharp, size: 18),
                ],
              ),
            ),
          ),
        );
      });
    });
  }
}

class _ProjectPopupItem extends StatelessWidget {
  final ProjectItem project;
  final ProjectController controller;

  const _ProjectPopupItem({
    required this.project,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Row(
          children: [
            GestureDetector(
              onTap: () => controller.selectProject(project),
              child: Icon(
                controller.selectedProject.value?.id == project.id
                    ? Icons.check_box
                    : Icons.check_box_outline_blank,
                color: controller.selectedProject.value?.id == project.id
                    ? Colors.blue
                    : Colors.grey,
                size: 20,
              ),
            ),

            const SizedBox(width: 10),
            // Container(
            //   width: 24,
            //   height: 24,
            //   decoration: BoxDecoration(
            //     color: Colors.green,
            //     shape: BoxShape.circle,
            //   ),
            //   child:Icon(Icons.folder_open_outlined, size: 14, color: Colors.white)

            // ),
            // const SizedBox(width: 10),
            Expanded(
              child: MyText(
                project.name,
                fontWeight: 500,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ));
  }
}
