import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/shared/app_delete_dialog.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';
import '../../../../services/selection_service.dart';

class ListCategoriesScreen extends StatefulWidget {
  const ListCategoriesScreen({super.key});

  @override
  State<ListCategoriesScreen> createState() => _ListCategoriesScreenState();
}

class _ListCategoriesScreenState extends State<ListCategoriesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  bool _drawerExpanded = true;
  int _currentPage = 1;
  final int _itemsPerPage = 7;

  // Get data from SelectionService
  List<Map<String, dynamic>> _categories = [];
  List<Map<String, dynamic>> _filteredCategories = [];

  @override
  void initState() {
    super.initState();
    _loadCategories();
  }

  void _loadCategories() {
    final data = SelectionService.getCategoriesData();

    // Transform SelectionService data into usable format
    _categories = data.map((category) {
      return {
        'id': category['id'] ?? '',
        'designation': category['designation'] ?? 'Unnamed Category',
        'section': category['section'] ?? 'N/A',
      };
    }).toList();

    _filteredCategories = _categories;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;

    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    final currentCategories = _filteredCategories.sublist(
      startIndex.clamp(0, _filteredCategories.length),
      endIndex.clamp(0, _filteredCategories.length),
    );
    final totalPages = (_filteredCategories.length / _itemsPerPage).ceil();

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      floatingActionButton: !isDesktop
          ? FloatingActionButton(
              onPressed: () => Get.toNamed('/add_category'),
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
                      title: 'List of categories',
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
                      onSearchChanged: _filterCategories,
                      searchHint: 'Search categories...',
                      showNotifications: true,
                    ),
                    SizedBox(height: context.spaceBtwSections),

                    // Categories table
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
                                  'List of categories',
                                  style: TextStyle(
                                    fontSize: context.fontSizeLg * 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (isDesktop)
                                  ElevatedButton.icon(
                                    onPressed: () =>
                                        Get.toNamed('/add_category'),
                                    icon: const Icon(Icons.add),
                                    label: const Text('Add category'),
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
                                    _buildMobileTable(currentCategories),
                                  ] else ...[
                                    _buildDesktopTable(
                                      currentCategories,
                                      context,
                                    ),
                                  ],

                                  // Pagination
                                  if (_filteredCategories.length >
                                      _itemsPerPage)
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

  Widget _buildMobileTable(List<Map<String, dynamic>> categories) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: categories.length,
      itemBuilder: (context, index) {
        final category = categories[index];
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
                      color: SelectionService.getRandomColor(
                        category['designation'],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.label, color: Colors.white, size: 24),
                  ),
                  SizedBox(width: context.sm),
                  Expanded(
                    child: Text(
                      category['designation'],
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: context.sm),
              Row(children: [Text('Section: ${category['section']}')]),
              SizedBox(height: context.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Get.toNamed('/view_category'),
                    icon: Icon(Icons.visibility, color: AppColors.primary),
                    iconSize: 20,
                  ),
                  IconButton(
                    onPressed: () => Get.toNamed('/edit_category'),
                    icon: Icon(Icons.edit, color: AppColors.primary),
                    iconSize: 20,
                  ),
                  IconButton(
                    onPressed: () => AppDeleteDialog.show(
                      context: context,
                      itemName: category['designation'],
                      title: 'Delete Category',
                      successMessage: 'Category deleted successfully',
                      confirmButtonColor: AppColors.error,
                      onConfirm: () {
                        setState(() {
                          _categories.removeWhere(
                            (c) => c['id'] == category['id'],
                          );
                          _filteredCategories = List.from(_categories);
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
    List<Map<String, dynamic>> categories,
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
                'Category',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Section',
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
          rows: categories.map((category) {
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
                            category['designation'],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(Icons.label, color: Colors.white, size: 24),
                      ),
                      SizedBox(width: 12),
                      Text(
                        category['designation'],
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                DataCell(Text(category['section'])),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.toNamed('/view_category'),
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
                        onPressed: () => Get.toNamed('/edit_category'),
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
                          itemName: category['designation'],
                          title: 'Delete Category',
                          successMessage: 'Category deleted successfully',
                          confirmButtonColor: AppColors.error,
                          onConfirm: () {
                            setState(() {
                              _categories.removeWhere(
                                (c) => c['id'] == category['id'],
                              );
                              _filteredCategories = List.from(_categories);
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

  void _filterCategories(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredCategories = _categories;
      } else {
        _filteredCategories = _categories.where((category) {
          return category['designation'].toLowerCase().contains(
                query.toLowerCase(),
              ) ||
              category['section'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
      _currentPage = 1;
    });
  }
}
