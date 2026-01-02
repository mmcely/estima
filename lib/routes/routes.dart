import 'package:get/get.dart';

// Authentication
import '../features/auth/screens/forgot_password_screen.dart';
import '../features/auth/screens/login_screen.dart';
import '../features/auth/screens/reset_password_screen.dart';

// Dashboard
import '../features/dashboard/screens/dashboard_screen.dart';

// Users section
import '../features/users/roles/screens/add_role.dart';
import '../features/users/roles/screens/edit_role.dart';
import '../features/users/roles/screens/list_roles.dart';
import '../features/users/services/screens/add_service.dart';
import '../features/users/services/screens/edit_service.dart';
import '../features/users/services/screens/list_services.dart';
import '../features/users/users/screens/add_user.dart';
import '../features/users/users/screens/edit_user.dart';
import '../features/users/users/screens/list_users.dart';
import '../features/users/users/screens/view_user.dart';

// Pricing section
import '../features/pricing/sections/screens/add_section.dart';
import '../features/pricing/sections/screens/edit_section.dart';
import '../features/pricing/sections/screens/list_sections.dart';
import '../features/pricing/categories/screens/list_categories_screen.dart';
import '../features/pricing/categories/screens/add_category.dart';
import '../features/pricing/categories/screens/edit_category.dart';
import '../features/pricing/elements/screens/add_element.dart';
import '../features/pricing/elements/screens/edit_element.dart';
import '../features/pricing/elements/screens/list_elements.dart';

// Projects section
import '../features/projects/projects/screens/add_project.dart';
import '../features/projects/projects/screens/edit_project.dart';
import '../features/projects/projects/screens/gantt_project.dart';
import '../features/projects/projects/screens/list_projects.dart';
import '../features/projects/projects/screens/view_project.dart';
import '../features/projects/modules/screens/add_module.dart';
import '../features/projects/modules/screens/edit_module.dart';
import '../features/projects/modules/screens/list_modules.dart';
import '../features/projects/modules/screens/view_module.dart';
import '../features/projects/tasks/screens/add_task.dart';
import '../features/projects/tasks/screens/edit_task.dart';
import '../features/projects/tasks/screens/list_tasks.dart';
import '../features/projects/tasks/screens/view_task.dart';
import '../features/projects/ressources/screens/add_ressource.dart';
import '../features/projects/ressources/screens/edit_ressource.dart';

// Chat
import '../features/chat/screens/chat_screen.dart';

// Profile
import '../features/profile/screens/my_profile.dart';

// Settings section
import '../features/settings/screens/parameters.dart';

class AppRoutes {
  static final List<GetPage> routes = [
    // Routes d'authentification
    GetPage(name: '/login', page: () => LoginScreen()),
    GetPage(name: '/forgot-password', page: () => ForgotPasswordScreen()),
    GetPage(
      name: '/reset-password/:token',
      page: () {
        final token = Get.parameters['token'];
        return ResetPasswordScreen(token: token);
      },
    ),

    // Dashboard
    GetPage(name: '/dashboard', page: () => const DashboardScreen()),

    // Section Users - Roles
    GetPage(name: '/list_roles', page: () => const ListRolesScreen()),
    GetPage(name: '/add_role', page: () => const AddRoleScreen()),
    GetPage(name: '/edit_role', page: () => const EditRoleScreen()),

    // Section Users - Services
    GetPage(name: '/list_services', page: () => ListServicesScreen()),
    GetPage(name: '/add_service', page: () => const AddServiceScreen()),
    GetPage(name: '/edit_service', page: () => const EditServiceScreen()),

    // Section Users - Users
    GetPage(name: '/list_users', page: () => ListUsersScreen()),
    GetPage(name: '/view_user', page: () => ViewUserScreen()),
    GetPage(name: '/add_user', page: () => AddUserScreen()),
    GetPage(name: '/edit_user', page: () => EditUserScreen()),

    // Section Pricing - Sections
    GetPage(name: '/list_sections', page: () => ListSectionsScreen()),
    GetPage(name: '/add_section', page: () => const AddSectionScreen()),
    GetPage(name: '/edit_section', page: () => const EditSectionScreen()),

    // Section Pricing - Categories
    GetPage(name: '/list_categories', page: () => const ListCategoriesScreen()),
    GetPage(name: '/add_category', page: () => const AddCategoryScreen()),
    GetPage(name: '/edit_category', page: () => const EditCategoryScreen()),

    // Section Pricing - Elements
    GetPage(name: '/list_elements', page: () => ListElementsScreen()),
    GetPage(name: '/add_element', page: () => const AddElementScreen()),
    GetPage(name: '/edit_element', page: () => const EditElementScreen()),

    // Section Projects - Projects
    GetPage(name: '/list_projects', page: () => const ListProjectsScreen()),
    GetPage(name: '/view_project', page: () => const ViewProjectScreen()),
    GetPage(name: '/gantt_project', page: () => const GanttProjectScreen()),
    GetPage(name: '/add_project', page: () => const AddProjectScreen()),
    GetPage(name: '/edit_project', page: () => const EditProjectScreen()),

    // Section Projects - Modules
    GetPage(name: '/list_modules', page: () => ListModulesScreen()),
    GetPage(name: '/view_module', page: () => const ViewModuleScreen()),
    GetPage(name: '/add_module', page: () => const AddModuleScreen()),
    GetPage(name: '/edit_module', page: () => const EditModuleScreen()),

    // Section Projects - Tasks
    GetPage(name: '/list_tasks', page: () => const ListTasksScreen()),
    GetPage(name: '/view_task', page: () => const ViewTaskScreen()),
    GetPage(name: '/add_task', page: () => const AddTaskScreen()),
    GetPage(name: '/edit_task', page: () => const EditTaskScreen()),

    // Section Projects - Ressources
    GetPage(name: '/add_ressource', page: () => const AddRessourceScreen()),
    GetPage(name: '/edit_ressource', page: () => const EditRessourceScreen()),

    // Section Chat
    GetPage(name: '/chat', page: () => const ChatScreen()),

    // Section Profile
    GetPage(name: '/my_profile', page: () => const MyProfileScreen()),

    // Section Settings
    GetPage(name: '/parameters', page: () => const ParametersScreen()),
  ];
}
