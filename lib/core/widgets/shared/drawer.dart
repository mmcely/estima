import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../utils/sizes.dart';
import 'drawer_elements/drawer_header.dart';
import 'drawer_elements/drawer_item.dart';
import 'drawer_elements/drawer_section_header.dart';
import 'drawer_elements/drawer_sub_menu_item.dart';
import 'drawer_elements/expandable_drawer_item.dart';

import '../../../../state/auth_controller.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final AuthController authController =
        GetInstance().isRegistered<AuthController>()
        ? Get.find<AuthController>()
        : Get.put(AuthController());
    final userData = authController.getMockUserData();

    return Drawer(
      child: Container(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            // Header with user profile
            CustomDrawerHeader(context, userData),

            // Dashboard
            DrawerItem(
              context,
              icon: Icons.dashboard_outlined,
              title: 'Dashboard',
              onTap: () => _navigateAndCloseDrawer('/dashboard', context),
            ),

            const Divider(),

            // Users Section
            DrawerSectionHeader(context, 'Users'),

            ExpandableDrawerItem(
              context,
              icon: Icons.emoji_events_sharp,
              title: 'Roles',
              children: [
                DrawerSubMenuItem(
                  context,
                  title: 'Roles list',
                  onTap: () => _navigateAndCloseDrawer('/list_roles', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Add role',
                  onTap: () => _navigateAndCloseDrawer('/add_role', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Edit role',
                  onTap: () => _navigateAndCloseDrawer('/edit_role', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Permissions',
                  onTap: () =>
                      _navigateAndCloseDrawer('/set_permissions', context),
                ),
              ],
            ),

            ExpandableDrawerItem(
              context,
              icon: Icons.business_outlined,
              title: 'Services',
              children: [
                DrawerSubMenuItem(
                  context,
                  title: 'Services list',
                  onTap: () =>
                      _navigateAndCloseDrawer('/list_services', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Add service',
                  onTap: () => _navigateAndCloseDrawer('/add_service', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Edit service',
                  onTap: () =>
                      _navigateAndCloseDrawer('/edit_service', context),
                ),
              ],
            ),

            ExpandableDrawerItem(
              context,
              icon: Icons.people_outline,
              title: 'Users',
              children: [
                DrawerSubMenuItem(
                  context,
                  title: 'Users list',
                  onTap: () => _navigateAndCloseDrawer('/list_users', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'View user',
                  onTap: () => _navigateAndCloseDrawer('/view_user', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Add user',
                  onTap: () => _navigateAndCloseDrawer('/add_user', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Edit user',
                  onTap: () => _navigateAndCloseDrawer('/edit_user', context),
                ),
              ],
            ),

            const Divider(),

            // Pricing Section
            DrawerSectionHeader(context, 'Pricing'),

            ExpandableDrawerItem(
              context,
              icon: Icons.category_outlined,
              title: 'Sections',
              children: [
                DrawerSubMenuItem(
                  context,
                  title: 'Sections list',
                  onTap: () =>
                      _navigateAndCloseDrawer('/list_sections', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Add section',
                  onTap: () => _navigateAndCloseDrawer('/add_section', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Edit section',
                  onTap: () =>
                      _navigateAndCloseDrawer('/edit_section', context),
                ),
              ],
            ),

            ExpandableDrawerItem(
              context,
              icon: Icons.subject_outlined,
              title: 'Categories',
              children: [
                DrawerSubMenuItem(
                  context,
                  title: 'Categories list',
                  onTap: () =>
                      _navigateAndCloseDrawer('/list_categories', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Add category',
                  onTap: () =>
                      _navigateAndCloseDrawer('/add_category', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Edit category',
                  onTap: () =>
                      _navigateAndCloseDrawer('/edit_category', context),
                ),
              ],
            ),

            ExpandableDrawerItem(
              context,
              icon: Icons.view_compact_outlined,
              title: 'Elements',
              children: [
                DrawerSubMenuItem(
                  context,
                  title: 'Elements list',
                  onTap: () =>
                      _navigateAndCloseDrawer('/list_elements', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Add element',
                  onTap: () => _navigateAndCloseDrawer('/add_element', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Edit element',
                  onTap: () =>
                      _navigateAndCloseDrawer('/edit_element', context),
                ),
              ],
            ),

            const Divider(),

            // Projects Section
            DrawerSectionHeader(context, 'Projects'),

            ExpandableDrawerItem(
              context,
              icon: Icons.folder_outlined,
              title: 'Projects',
              children: [
                DrawerSubMenuItem(
                  context,
                  title: 'Projects list',
                  onTap: () =>
                      _navigateAndCloseDrawer('/list_projects', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'View project',
                  onTap: () =>
                      _navigateAndCloseDrawer('/view_project', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Gantt project',
                  onTap: () =>
                      _navigateAndCloseDrawer('/gantt_project', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Add project',
                  onTap: () => _navigateAndCloseDrawer('/add_project', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Edit project',
                  onTap: () =>
                      _navigateAndCloseDrawer('/edit_project', context),
                ),
              ],
            ),

            ExpandableDrawerItem(
              context,
              icon: Icons.view_module_outlined,
              title: 'Modules',
              children: [
                DrawerSubMenuItem(
                  context,
                  title: 'Modules list',
                  onTap: () =>
                      _navigateAndCloseDrawer('/list_modules', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'View module',
                  onTap: () => _navigateAndCloseDrawer('/view_module', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Add module',
                  onTap: () => _navigateAndCloseDrawer('/add_module', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Edit module',
                  onTap: () => _navigateAndCloseDrawer('/edit_module', context),
                ),
              ],
            ),

            ExpandableDrawerItem(
              context,
              icon: Icons.task_outlined,
              title: 'Tasks',
              children: [
                DrawerSubMenuItem(
                  context,
                  title: 'Tasks list',
                  onTap: () => _navigateAndCloseDrawer('/list_tasks', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'View task',
                  onTap: () => _navigateAndCloseDrawer('/view_task', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Add task',
                  onTap: () => _navigateAndCloseDrawer('/add_task', context),
                ),
                DrawerSubMenuItem(
                  context,
                  title: 'Edit task',
                  onTap: () => _navigateAndCloseDrawer('/edit_task', context),
                ),
              ],
            ),

            const Divider(),

            // Chat Section
            DrawerSectionHeader(context, 'Chat'),

            DrawerItem(
              context,
              icon: Icons.chat,
              title: 'Chat Room',
              onTap: () => _navigateAndCloseDrawer('/chat', context),
            ),

            const Divider(),

            // Settings Section
            DrawerSectionHeader(context, 'Settings'),

            DrawerItem(
              context,
              icon: Icons.person_outline,
              title: 'My profile',
              onTap: () => _navigateAndCloseDrawer('/my_profile', context),
            ),

            DrawerItem(
              context,
              icon: Icons.settings,
              title: 'Parameters',
              onTap: () => _navigateAndCloseDrawer('/parameters', context),
            ),

            DrawerItem(
              context,
              icon: Icons.logout_outlined,
              title: 'Log out',
              onTap: () => authController.logout(),
            ),

            SizedBox(height: TSizes.spaceBtwSections * 1.5),
          ],
        ),
      ),
    );
  }

  // Method to handle navigation and close drawer if needed
  void _navigateAndCloseDrawer(String route, BuildContext context) {
    // Check if on mobile/tablet (drawer open)
    final isMobileOrTablet =
        MediaQuery.of(context).size.width < 1200; // Your desktop breakpoint

    // Close drawer before navigating on mobile/tablet
    if (isMobileOrTablet) {
      Navigator.of(context).pop();
    }

    // Navigate to route
    Get.toNamed(route);
  }
}
