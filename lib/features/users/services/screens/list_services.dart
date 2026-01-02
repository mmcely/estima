import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/shared/app_delete_dialog.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';
import '../../../../services/selection_service.dart';

class ListServicesScreen extends StatefulWidget {
  const ListServicesScreen({super.key});

  @override
  State<ListServicesScreen> createState() => _ListServicesScreenState();
}

class _ListServicesScreenState extends State<ListServicesScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final TextEditingController _searchController = TextEditingController();
  bool _drawerExpanded = true;
  int _currentPage = 1;
  final int _itemsPerPage = 7;

  // Data from SelectionService
  List<Map<String, dynamic>> _services = [];
  List<Map<String, dynamic>> _filteredServices = [];

  @override
  void initState() {
    super.initState();
    _services = SelectionService.getServices();
    _filteredServices = _services;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;

    final startIndex = (_currentPage - 1) * _itemsPerPage;
    final endIndex = startIndex + _itemsPerPage;
    final currentServices = _filteredServices.sublist(
      startIndex.clamp(0, _filteredServices.length),
      endIndex.clamp(0, _filteredServices.length),
    );
    final totalPages = (_filteredServices.length / _itemsPerPage).ceil();

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      floatingActionButton: !isDesktop
          ? FloatingActionButton(
              onPressed: () => Get.toNamed('/add_service'),
              child: const Icon(Icons.add),
            )
          : null,
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop && _drawerExpanded)
              SizedBox(width: 280, child: const AppDrawer()),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderPage(
                      title: 'List of services',
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
                      onSearchChanged: _filterServices,
                      searchHint: 'Search services...',
                      showNotifications: true,
                    ),
                    SizedBox(height: context.spaceBtwSections),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? context.xl : context.md,
                      ),
                      child: Column(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(bottom: context.lg),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'List of services',
                                  style: TextStyle(
                                    fontSize: context.fontSizeLg * 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                if (isDesktop)
                                  ElevatedButton.icon(
                                    onPressed: () =>
                                        Get.toNamed('/add_service'),
                                    icon: const Icon(Icons.add),
                                    label: const Text('Add service'),
                                  ),
                              ],
                            ),
                          ),
                          Card(
                            elevation: 4,
                            child: SizedBox(
                              width: double.infinity,
                              child: Column(
                                children: [
                                  if (!isDesktop) ...[
                                    _buildMobileTable(currentServices),
                                  ] else ...[
                                    _buildDesktopTable(
                                      currentServices,
                                      context,
                                    ),
                                  ],
                                  if (_filteredServices.length > _itemsPerPage)
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

  Widget _buildMobileTable(List<Map<String, dynamic>> services) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: services.length,
      itemBuilder: (context, index) {
        final service = services[index];
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
                      color: SelectionService().getServiceColor(
                        service['title'],
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.business, size: 24),
                  ),
                  SizedBox(width: context.sm),
                  Expanded(
                    child: Text(
                      service['title'],
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
                  Text('Status: '),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                    decoration: BoxDecoration(
                      color: SelectionService.getStatusColor(service['status']),
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text(
                      service['status'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  Spacer(),
                  Text(
                    'Created: ${service['created']}',
                    style: TextStyle(fontSize: 12),
                  ),
                ],
              ),
              SizedBox(height: context.sm),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  IconButton(
                    onPressed: () => Get.toNamed('/edit_service'),
                    icon: Icon(Icons.edit, color: AppColors.primary),
                    iconSize: 20,
                  ),
                  IconButton(
                    onPressed: () => AppDeleteDialog.show(
                      context: context,
                      itemName: service['title'],
                      title: 'Delete Service',
                      successMessage: 'Service deleted successfully',
                      confirmButtonColor: AppColors.error,
                      onConfirm: () {
                        setState(() {
                          _services.removeWhere(
                            (s) => s['id'] == service['id'],
                          );
                          _filteredServices = List.from(_services);
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
    List<Map<String, dynamic>> services,
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
                'Title',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            DataColumn(
              label: Text(
                'Status',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            DataColumn(
              label: Text(
                'Created',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
            DataColumn(
              label: Text(
                'Actions',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
              ),
            ),
          ],
          rows: services.map((service) {
            return DataRow(
              cells: [
                DataCell(
                  Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: SelectionService().getServiceColor(
                            service['title'],
                          ),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: const Icon(Icons.business, size: 24),
                      ),
                      SizedBox(width: 12),
                      Text(
                        service['title'],
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                DataCell(
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                    decoration: BoxDecoration(
                      color: SelectionService.getStatusColor(service['status']),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      service['status'],
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
                DataCell(
                  Text(service['created'], style: TextStyle(fontSize: 14)),
                ),
                DataCell(
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => Get.toNamed('/edit_service'),
                        icon: Icon(
                          Icons.edit,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
                      ),
                      SizedBox(width: 8),
                      IconButton(
                        onPressed: () => AppDeleteDialog.show(
                          context: context,
                          itemName: service['title'],
                          title: 'Delete Service',
                          successMessage: 'Service deleted successfully',
                          confirmButtonColor: AppColors.error,
                          onConfirm: () {
                            setState(() {
                              _services.removeWhere(
                                (s) => s['id'] == service['id'],
                              );
                              _filteredServices = List.from(_services);
                            });
                          },
                        ),
                        icon: Icon(
                          Icons.delete,
                          color: AppColors.error,
                          size: 20,
                        ),
                        padding: EdgeInsets.zero,
                        constraints: BoxConstraints(),
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

  void _filterServices(String query) {
    setState(() {
      if (query.isEmpty) {
        _filteredServices = _services;
      } else {
        _filteredServices = _services.where((service) {
          return service['title'].toLowerCase().contains(query.toLowerCase());
        }).toList();
      }
      _currentPage = 1;
    });
  }
}
