import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/shared/app_delete_dialog.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';
import '../../../../services/selection_service.dart';

class ListUsersScreen extends StatefulWidget {
  const ListUsersScreen({super.key});

  @override
  State<ListUsersScreen> createState() => _ListUsersScreenState();
}

class _ListUsersScreenState extends State<ListUsersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  bool _drawerExpanded = true;
  int _currentPage = 1;
  final int _itemsPerPage = 7;

  // Get data from SelectionService
  List<Map<String, dynamic>> _users = [];
  List<Map<String, dynamic>> _filteredUsers = [];

  @override
  void initState() {
    super.initState();
    _users = SelectionService.getUsers();
    _filteredUsers = _users;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;

    // Calculate pagination values
    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    final currentUsers = _filteredUsers.sublist(
      startIndex.clamp(0, _filteredUsers.length),
      endIndex.clamp(0, _filteredUsers.length),
    );
    final totalPages = (_filteredUsers.length / _itemsPerPage).ceil();

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      floatingActionButton: !isDesktop
          ? FloatingActionButton(
              onPressed: () => Get.toNamed('/add_user'),
              child: const Icon(Icons.add),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            // Sidebar for desktop
            if (isDesktop && _drawerExpanded)
              SizedBox(width: 280, child: const AppDrawer()),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header
                    HeaderPage(
                      title: 'List of users',
                      scaffoldKey: _scaffoldKey,
                      isDesktop: isDesktop,
                      drawerExpanded: _drawerExpanded,
                      onToggleDrawer: () {
                        setState(() {
                          _drawerExpanded = !_drawerExpanded;
                        });
                      },
                      showSearchField: true,
                      searchController: _searchController,
                      onSearchChanged: _filterUsers,
                      searchHint: 'Search users...',
                      showNotifications: true,
                    ),
                    SizedBox(height: context.spaceBtwSections),

                    // Users table
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? context.xl : context.md,
                      ),
                      child: Column(
                        children: [
                          // Title and Add button
                          Padding(
                            padding: EdgeInsets.only(bottom: context.lg),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'List of users',
                                  style: TextStyle(
                                    fontSize: context.fontSizeLg * 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (isDesktop)
                                  ElevatedButton.icon(
                                    onPressed: () => Get.toNamed('/add_user'),
                                    icon: const Icon(Icons.add),
                                    label: const Text('Add user'),
                                  ),
                              ],
                            ),
                          ),

                          // Table
                          Card(
                            elevation: 4,
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  // Table headers
                                  if (!isDesktop) ...[
                                    _buildMobileTable(currentUsers),
                                  ] else ...[
                                    _buildDesktopTable(currentUsers, context),
                                  ],

                                  // Pagination
                                  if (_filteredUsers.length > _itemsPerPage)
                                    Padding(
                                      padding: EdgeInsets.all(context.md),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          IconButton(
                                            onPressed: _currentPage > 1
                                                ? () {
                                                    setState(() {
                                                      _currentPage--;
                                                    });
                                                  }
                                                : null,
                                            icon: const Icon(
                                              Icons.chevron_left,
                                            ),
                                          ),
                                          SizedBox(width: context.sm),
                                          Text(
                                            'Page $_currentPage of $totalPages',
                                            style: TextStyle(
                                              fontSize: context.fontSizeSm,
                                            ),
                                          ),
                                          SizedBox(width: context.sm),
                                          IconButton(
                                            onPressed: _currentPage < totalPages
                                                ? () {
                                                    setState(() {
                                                      _currentPage++;
                                                    });
                                                  }
                                                : null,
                                            icon: const Icon(
                                              Icons.chevron_right,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: context.xl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMobileTable(List<Map<String, dynamic>> users) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: users.length,
      itemBuilder: (context, index) {
        final user = users[index];
        return Container(
          padding: EdgeInsets.all(context.md),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: Theme.of(context).dividerColor,
                width: 1,
              ),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: SelectionService.getRandomColor(
                      user['name'],
                    ),
                    child: Text(
                      user['name'][0],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: context.sm),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user['name'],
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        Text(user['email']),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.sm),
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: SelectionService().getRoleColor(user['role']),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      user['role'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(width: 8),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: SelectionService.getStatusColor(user['status']),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      user['status'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.sm),
              Text('Service: ${user['service']}'),
              SizedBox(height: context.sm),
              Text('Created: ${user['created']}'),
              SizedBox(height: context.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Get.toNamed('/view_user'),
                    icon: Icon(Icons.visibility, color: AppColors.primary),
                    iconSize: 20,
                  ),
                  IconButton(
                    onPressed: () => Get.toNamed('/edit_user'),
                    icon: Icon(Icons.edit, color: AppColors.primary),
                    iconSize: 20,
                  ),
                  IconButton(
                    onPressed: () => AppDeleteDialog.show(
                      context: context,
                      itemName: user['name'],
                      title: 'Delete User',
                      successMessage: 'User deleted successfully',
                      confirmButtonColor: AppColors.error,
                      onConfirm: () {
                        setState(() {
                          _users.removeWhere((u) => u['id'] == user['id']);
                          _filteredUsers = List.from(_users);
                        });
                      },
                    ),
                    icon: Icon(Icons.delete, color: AppColors.error),
                    iconSize: 20,
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildDesktopTable(
    List<Map<String, dynamic>> users,
    BuildContext context,
  ) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: MediaQuery.of(context).size.width - 350,
        ),
        child: DataTable(
          columnSpacing: 24,
          horizontalMargin: 16,
          columns: [
            DataColumn(
              label: Text(
                'User',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Role',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Service',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Status',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Actions',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ],
          rows: users.map((user) {
            return DataRow(
              cells: [
                DataCell(
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: SelectionService.getRandomColor(
                          user['name'],
                        ),
                        child: Text(
                          user['name'][0],
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user['name'],
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          Text(user['email']),
                        ],
                      ),
                    ],
                  ),
                ),
                DataCell(
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: SelectionService().getRoleColor(user['role']),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      user['role'],
                      style: const TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataCell(Text(user['service'])),
                DataCell(
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: BoxDecoration(
                          color: SelectionService.getStatusColor(
                            user['status'],
                          ),
                          shape: BoxShape.circle,
                        ),
                      ),
                      SizedBox(width: 8),
                      Text(user['status']),
                    ],
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.toNamed('/view_user'),
                        icon: Icon(
                          Icons.visibility,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        onPressed: () => Get.toNamed('/edit_user'),
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        onPressed: () => AppDeleteDialog.show(
                          context: context,
                          itemName: user['name'],
                          title: 'Delete User',
                          successMessage: 'User deleted successfully',
                          confirmButtonColor: AppColors.error,
                          onConfirm: () {
                            setState(() {
                              _users.removeWhere((u) => u['id'] == user['id']);
                              _filteredUsers = List.from(_users);
                            });
                          },
                        ),
                        icon: Icon(
                          Icons.delete,
                          color: AppColors.error,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }

  void _filterUsers(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredUsers = _users;
      } else {
        _filteredUsers = _users.where((user) {
          return user['name'].toLowerCase().contains(query.toLowerCase()) ||
              user['email'].toLowerCase().contains(query.toLowerCase()) ||
              user['role'].toLowerCase().contains(query.toLowerCase()) ||
              user['service'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
      _currentPage = 1;
    });
  }
}
