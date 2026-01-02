import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/shared/app_delete_dialog.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';
import '../../../../services/selection_service.dart';

class ViewTaskScreen extends StatefulWidget {
  const ViewTaskScreen({super.key});

  @override
  State<ViewTaskScreen> createState() => _ViewTaskScreenState();
}

class _ViewTaskScreenState extends State<ViewTaskScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _drawerExpanded = true;

  // Example data
  final Map<String, dynamic> _task = {
    'id': '1',
    'title': 'Sample Task',
    'start': '2024-01-15',
    'end': '2024-01-20',
    'status': 'In progress',
    'progress': 50,
    'description': 'Description of the task',
  };

  final List<Map<String, dynamic>> _elements = [
    {
      'id': '1',
      'name': 'Specific element',
      'reference': 'REF-001',
      'unity': 'Piece',
      'quantity': 2,
      'unitPrice': 50000.0,
      'totalPrice': 100000.0,
    },
    {
      'id': '2',
      'name': 'Another element',
      'reference': 'REF-002',
      'unity': 'kg',
      'quantity': 5,
      'unitPrice': 10000.0,
      'totalPrice': 50000.0,
    },
  ];

  double get _totalBudget {
    return _elements.fold(0.0, (sum, element) => sum + element['totalPrice']);
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;
    final isMobile = MediaQuery.of(context).size.width <= 768;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Row(
          children: [
            if (isDesktop && _drawerExpanded)
              Container(width: 280, child: const AppDrawer()),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderPage(
                      title: 'Task: ${_task['title']}',
                      scaffoldKey: _scaffoldKey,
                      isDesktop: isDesktop,
                      drawerExpanded: _drawerExpanded,
                      onToggleDrawer: () {
                        setState(() {
                          _drawerExpanded = !_drawerExpanded;
                        });
                      },
                      showSearchField: false,
                      showNotifications: true,
                      actions: [
                        if (isDesktop)
                          Row(
                            children: [
                              ElevatedButton.icon(
                                onPressed: _convertToPdf,
                                icon: const Icon(Icons.picture_as_pdf),
                                label: const Text('Convert to PDF'),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: AppColors.warning,
                                  foregroundColor: Colors.white,
                                ),
                              ),
                              SizedBox(width: context.md),
                            ],
                          ),
                      ],
                    ),
                    SizedBox(height: context.spaceBtwSections),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? context.xl : context.md,
                      ),
                      child: Column(
                        children: [
                          // Task info header
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(context.lg),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        _task['title'],
                                        style: TextStyle(
                                          fontSize: context.fontSizeLg * 1.2,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Container(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 6,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              SelectionService.getStatusColor(
                                                _task['status'],
                                              ).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color:
                                                SelectionService.getStatusColor(
                                                  _task['status'],
                                                ),
                                          ),
                                        ),
                                        child: Text(
                                          _task['status'],
                                          style: TextStyle(
                                            color:
                                                SelectionService.getStatusColor(
                                                  _task['status'],
                                                ),
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: context.md),
                                  Text(_task['description']),
                                  SizedBox(height: context.md),
                                  isMobile
                                      ? Column(
                                          children: [
                                            Row(
                                              children: [
                                                Icon(
                                                  Icons.calendar_today,
                                                  size: 16,
                                                ),
                                                SizedBox(width: 8),
                                                Text(
                                                  'Start: ${_task['startDate']}',
                                                  style: TextStyle(),
                                                ),
                                              ],
                                            ),
                                            SizedBox(height: 16),
                                            Row(
                                              children: [
                                                Icon(Icons.flag, size: 16),
                                                SizedBox(width: 8),
                                                Text(
                                                  'End: ${_task['endDate']}',
                                                  style: TextStyle(),
                                                ),
                                              ],
                                            ),
                                          ],
                                        )
                                      : Row(
                                          children: [
                                            Icon(
                                              Icons.calendar_today,
                                              size: 16,
                                            ),
                                            Text(
                                              'Start: ${_task['startDate']}',
                                            ),
                                            SizedBox(width: 16),
                                            Icon(Icons.flag, size: 16),
                                            SizedBox(width: 8),
                                            Text('End: ${_task['endDate']}'),
                                            SizedBox(width: 8),
                                          ],
                                        ),

                                  if (!isDesktop)
                                    Column(
                                      children: [
                                        SizedBox(height: context.md),
                                        ElevatedButton.icon(
                                          onPressed: _convertToPdf,
                                          icon: const Icon(
                                            Icons.picture_as_pdf,
                                          ),
                                          label: const Text('Convert to PDF'),
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: AppColors.warning,
                                            foregroundColor: Colors.white,
                                          ),
                                        ),
                                      ],
                                    ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: context.lg),

                          // Elements table
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(context.lg),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Task Elements',
                                    style: TextStyle(
                                      fontSize: context.fontSizeLg,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: context.lg),
                                  SingleChildScrollView(
                                    scrollDirection: Axis.horizontal,
                                    child: DataTable(
                                      columnSpacing: 24,
                                      horizontalMargin: 16,
                                      columns: [
                                        DataColumn(
                                          label: Text(
                                            'N°',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Resource',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Reference',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Unity',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Quantity',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Unit Price',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Total',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Actions',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                      rows: _elements.asMap().entries.map((
                                        entry,
                                      ) {
                                        final index = entry.key + 1;
                                        final element = entry.value;

                                        return DataRow(
                                          cells: [
                                            DataCell(Text(index.toString())),
                                            DataCell(Text(element['name'])),
                                            DataCell(
                                              Text(element['reference']),
                                            ),
                                            DataCell(Text(element['unity'])),
                                            DataCell(
                                              Text(
                                                element['quantity'].toString(),
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                '${element['unitPrice']} FCFA',
                                              ),
                                            ),
                                            DataCell(
                                              Text(
                                                '${element['totalPrice']} FCFA',
                                              ),
                                            ),
                                            DataCell(
                                              Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () =>
                                                        Get.toNamed(
                                                          '/edit_ressource',
                                                        ),
                                                    icon: Icon(
                                                      Icons.edit,
                                                      color: AppColors.primary,
                                                      size: 20,
                                                    ),
                                                    padding: EdgeInsets.zero,
                                                    constraints:
                                                        BoxConstraints(),
                                                  ),
                                                  SizedBox(width: 8),
                                                  IconButton(
                                                    onPressed: () => AppDeleteDialog.show(
                                                      context: context,
                                                      itemName: element['name'],
                                                      title: 'Delete Element',
                                                      successMessage:
                                                          'Element deleted successfully',
                                                      confirmButtonColor:
                                                          AppColors.error,
                                                      onConfirm: () {
                                                        setState(() {
                                                          _elements.removeWhere(
                                                            (e) =>
                                                                e['id'] ==
                                                                element['id'],
                                                          );
                                                        });
                                                      },
                                                    ),
                                                    icon: Icon(
                                                      Icons.delete,
                                                      color: AppColors.error,
                                                      size: 20,
                                                    ),
                                                    padding: EdgeInsets.zero,
                                                    constraints:
                                                        BoxConstraints(),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  SizedBox(height: context.lg),

                                  // Total row
                                  Container(
                                    padding: EdgeInsets.all(context.md),
                                    decoration: BoxDecoration(
                                      color: Colors.blue.shade50,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          'Total budget',
                                          style: TextStyle(
                                            fontSize: context.fontSizeMd,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.warning,
                                          ),
                                        ),
                                        Text(
                                          '${_totalBudget} FCFA',
                                          style: TextStyle(
                                            fontSize: context.fontSizeMd,
                                            fontWeight: FontWeight.bold,
                                            color: AppColors.success,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: context.xl),
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
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed('/add_ressource'),
        child: const Icon(Icons.add),
      ),
    );
  }

  void _convertToPdf() {
    Get.snackbar(
      'PDF Conversion',
      'PDF conversion feature will be implemented soon',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}
