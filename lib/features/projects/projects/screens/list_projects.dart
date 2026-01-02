import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/shared/app_delete_dialog.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';
import '../../../../services/selection_service.dart';

class ListProjectsScreen extends StatefulWidget {
  const ListProjectsScreen({super.key});

  @override
  State<ListProjectsScreen> createState() => _ListProjectsScreenState();
}

class _ListProjectsScreenState extends State<ListProjectsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  bool _drawerExpanded = true;
  int _currentPage = 1;
  final int _itemsPerPage = 7;

  // Get data from SelectionService
  List<Map<String, dynamic>> _projects = [];
  List<Map<String, dynamic>> _filteredProjects = [];

  @override
  void initState() {
    super.initState();
    _loadProjects();
  }

  void _loadProjects() {
    final data = SelectionService.getProjectsData();

    // Transform SelectionService data into usable format
    _projects = data.map((project) {
      return {
        'id': project['id'] ?? '',
        'name': project['name'] ?? 'Unnamed Project',
        'startDate': project['startDate'] ?? 'N/A',
        'endDate': project['endDate'] ?? 'N/A',
        'status': project['status'] ?? 'Planned',
        'description': project['description'] ?? 'No description',
        'head': project['head'] ?? 'N/A',
      };
    }).toList();

    _filteredProjects = _projects;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;

    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    final currentProjects = _filteredProjects.sublist(
      startIndex.clamp(0, _filteredProjects.length),
      endIndex.clamp(0, _filteredProjects.length),
    );
    final totalPages = (_filteredProjects.length / _itemsPerPage).ceil();

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      floatingActionButton: !isDesktop
          ? FloatingActionButton(
              onPressed: () => Get.toNamed('/add_project'),
              child: const Icon(Icons.add),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            // Desktop sidebar
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
                      title: 'List of projects',
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
                      onSearchChanged: _filterProjects,
                      searchHint: 'Search projects...',
                      showNotifications: true,
                    ),
                    SizedBox(height: context.spaceBtwSections),

                    // Projects table
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
                                  'List of projects',
                                  style: TextStyle(
                                    fontSize: context.fontSizeLg * 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (isDesktop)
                                  ElevatedButton.icon(
                                    onPressed: () =>
                                        Get.toNamed('/add_project'),
                                    icon: const Icon(Icons.add),
                                    label: const Text('Add project'),
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
                                    _buildMobileTable(currentProjects),
                                  ] else ...[
                                    _buildDesktopTable(
                                      currentProjects,
                                      context,
                                    ),
                                  ],

                                  // Pagination
                                  if (_filteredProjects.length > _itemsPerPage)
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

  Widget _buildMobileTable(List<Map<String, dynamic>> projects) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: projects.length,
      itemBuilder: (context, index) {
        final project = projects[index];
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
                  Container(
                    width: 40,
                    height: 40,
                    decoration: BoxDecoration(
                      color: SelectionService.getRandomColor(project['name']),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.business, color: Colors.white, size: 24),
                  ),
                  SizedBox(width: context.sm),
                  Expanded(
                    child: Text(
                      project['name'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.sm),
              Row(
                children: [
                  Text('Start: ${project['startDate']}'),
                  Spacer(),
                  Text('End: ${project['endDate']}'),
                ],
              ),
              SizedBox(height: context.sm),
              Row(
                children: [
                  Text('Head: ${project['head']}'),
                  Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: SelectionService.getStatusColor(project['status']),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      project['status'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.sm),
              Text(
                project['description'],
                style: TextStyle(fontSize: 12),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: context.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Get.toNamed('/view_project'),
                    icon: Icon(Icons.visibility, color: AppColors.primary),
                    iconSize: 20,
                  ),
                  IconButton(
                    onPressed: () => Get.toNamed('/gantt_project'),
                    icon: Icon(Icons.timeline, color: AppColors.primary),
                    iconSize: 20,
                  ),
                  IconButton(
                    onPressed: () => Get.toNamed('/edit_project'),
                    icon: Icon(Icons.edit, color: AppColors.primary),
                    iconSize: 20,
                  ),
                  IconButton(
                    onPressed: () => AppDeleteDialog.show(
                      context: context,
                      itemName: project['name'],
                      title: 'Delete Project',
                      successMessage: 'Project deleted successfully',
                      confirmButtonColor: AppColors.error,
                      onConfirm: () {
                        setState(() {
                          _projects.removeWhere(
                            (p) => p['id'] == project['id'],
                          );
                          _filteredProjects = List.from(_projects);
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
    List<Map<String, dynamic>> projects,
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
                'Project',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Head',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Start',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text('End', style: TextStyle(fontWeight: FontWeight.bold)),
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
          rows: projects.map((project) {
            return DataRow(
              cells: [
                DataCell(
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: SelectionService.getRandomColor(
                            project['name'],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.business,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            project['name'],
                            style: TextStyle(fontWeight: FontWeight.w500),
                          ),
                          SizedBox(height: 2),
                          Text(
                            project['description'],
                            style: TextStyle(
                              fontSize: 12,
                              color: Theme.of(
                                context,
                              ).textTheme.bodySmall?.color,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                DataCell(Text(project['head'])),
                DataCell(Text(project['startDate'])),
                DataCell(Text(project['endDate'])),
                DataCell(
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: SelectionService.getStatusColor(project['status']),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      project['status'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.toNamed('/view_project'),
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
                        onPressed: () => Get.toNamed('/gantt_project'),
                        icon: Icon(
                          Icons.timeline,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        onPressed: () => Get.toNamed('/edit_project'),
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
                          itemName: project['name'],
                          title: 'Delete Project',
                          successMessage: 'Project deleted successfully',
                          confirmButtonColor: AppColors.error,
                          onConfirm: () {
                            setState(() {
                              _projects.removeWhere(
                                (p) => p['id'] == project['id'],
                              );
                              _filteredProjects = List.from(_projects);
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

  void _filterProjects(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredProjects = _projects;
      } else {
        _filteredProjects = _projects.where((project) {
          return project['name'].toLowerCase().contains(query.toLowerCase()) ||
              project['description'].toLowerCase().contains(
                query.toLowerCase(),
              ) ||
              project['status'].toLowerCase().contains(query.toLowerCase()) ||
              project['head'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
      _currentPage = 1;
    });
  }
}
