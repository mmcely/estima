import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/shared/app_delete_dialog.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';
import '../../../../services/selection_service.dart';

class ListElementsScreen extends StatefulWidget {
  const ListElementsScreen({super.key});

  @override
  State<ListElementsScreen> createState() => _ListElementsScreenState();
}

class _ListElementsScreenState extends State<ListElementsScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  bool _drawerExpanded = true;
  int _currentPage = 1;
  final int _itemsPerPage = 7;

  // Get data from SelectionService
  List<Map<String, dynamic>> _elements = [];
  List<Map<String, dynamic>> _filteredElements = [];

  @override
  void initState() {
    super.initState();
    _loadElements();
  }

  void _loadElements() {
    final data = SelectionService.getElementsData();

    // Transform SelectionService data into usable format
    _elements = data.map((element) {
      return {
        'id': element['id'] ?? '',
        'reference': element['reference'] ?? 'N/A',
        'designation': element['designation'] ?? 'Unnamed Element',
        'unit': element['unit'] ?? 'piece',
        'price': element['price'] ?? 0.0,
        'category': element['category'] ?? 'N/A',
        'section': element['section'] ?? 'N/A',
      };
    }).toList();

    _filteredElements = _elements;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;

    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    final currentElements = _filteredElements.sublist(
      startIndex.clamp(0, _filteredElements.length),
      endIndex.clamp(0, _filteredElements.length),
    );
    final totalPages = (_filteredElements.length / _itemsPerPage).ceil();

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      floatingActionButton: !isDesktop
          ? FloatingActionButton(
              onPressed: () => Get.toNamed('/add_element'),
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
                      title: 'List of elements',
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
                      onSearchChanged: _filterElements,
                      searchHint: 'Search elements...',
                      showNotifications: true,
                    ),
                    SizedBox(height: context.spaceBtwSections),

                    // Elements table
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
                                  'List of elements',
                                  style: TextStyle(
                                    fontSize: context.fontSizeLg * 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (isDesktop)
                                  ElevatedButton.icon(
                                    onPressed: () =>
                                        Get.toNamed('/add_element'),
                                    icon: const Icon(Icons.add),
                                    label: const Text('Add element'),
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
                                    _buildMobileTable(currentElements),
                                  ] else ...[
                                    _buildDesktopTable(
                                      currentElements,
                                      context,
                                    ),
                                  ],

                                  // Pagination
                                  if (_filteredElements.length > _itemsPerPage)
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

  Widget _buildMobileTable(List<Map<String, dynamic>> elements) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: elements.length,
      itemBuilder: (context, index) {
        final element = elements[index];
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
                        element['designation'],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(
                      Icons.inventory_2,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                  SizedBox(width: context.sm),
                  Expanded(
                    child: Text(
                      element['designation'],
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
                  Text('Reference: ${element['reference']}'),
                  Spacer(),
                  Text('Unit: ${element['unit']}'),
                ],
              ),
              SizedBox(height: context.sm),
              Row(
                children: [
                  Text('Price: ${element['price']} €'),
                  Spacer(),
                  Text('Section: ${element['section']}'),
                ],
              ),
              SizedBox(height: context.sm),
              Row(children: [Text('Category: ${element['category']}')]),
              SizedBox(height: context.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Get.toNamed('/view_element'),
                    icon: Icon(Icons.visibility, color: AppColors.primary),
                    iconSize: 20,
                  ),
                  IconButton(
                    onPressed: () => Get.toNamed('/edit_element'),
                    icon: Icon(Icons.edit, color: AppColors.primary),
                    iconSize: 20,
                  ),
                  IconButton(
                    onPressed: () => AppDeleteDialog.show(
                      context: context,
                      itemName: element['designation'],
                      title: 'Delete Element',
                      successMessage: 'Element deleted successfully',
                      confirmButtonColor: AppColors.error,
                      onConfirm: () {
                        setState(() {
                          _elements.removeWhere(
                            (e) => e['id'] == element['id'],
                          );
                          _filteredElements = List.from(_elements);
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
    List<Map<String, dynamic>> elements,
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
                'Reference',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Designation',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Unit',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
            DataColumn(
              label: Text(
                'Price',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
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
          rows: elements.map((element) {
            return DataRow(
              cells: [
                DataCell(Text(element['reference'])),
                DataCell(
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: SelectionService.getRandomColor(
                            element['designation'],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Icon(
                          Icons.inventory_2,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                      SizedBox(width: 12),
                      Text(
                        element['designation'],
                        style: TextStyle(fontWeight: FontWeight.w500),
                      ),
                    ],
                  ),
                ),
                DataCell(Text(element['unit'])),
                DataCell(
                  Text(
                    '${element['price']} €',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                DataCell(Text(element['category'])),
                DataCell(Text(element['section'])),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.toNamed('/view_element'),
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
                        onPressed: () => Get.toNamed('/edit_element'),
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
                          itemName: element['designation'],
                          title: 'Delete Element',
                          successMessage: 'Element deleted successfully',
                          confirmButtonColor: AppColors.error,
                          onConfirm: () {
                            setState(() {
                              _elements.removeWhere(
                                (e) => e['id'] == element['id'],
                              );
                              _filteredElements = List.from(_elements);
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

  void _filterElements(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredElements = _elements;
      } else {
        _filteredElements = _elements.where((element) {
          return element['designation'].toLowerCase().contains(
                query.toLowerCase(),
              ) ||
              element['reference'].toLowerCase().contains(
                query.toLowerCase(),
              ) ||
              element['category'].toLowerCase().contains(query.toLowerCase()) ||
              element['section'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
      _currentPage = 1;
    });
  }
}
