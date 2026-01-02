import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';
import '../../../../services/selection_service.dart';

class ViewModuleScreen extends StatefulWidget {
  const ViewModuleScreen({super.key});

  @override
  State<ViewModuleScreen> createState() => _ViewModuleScreenState();
}

class _ViewModuleScreenState extends State<ViewModuleScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _drawerExpanded = true;

  // Transforme les données pour suivre la même structure que view_project
  final Map<String, dynamic> _module = {
    'id': '1',
    'name': 'Angular Project Module',
    'startDate': '2022-09-26',
    'endDate': '2022-11-06',
    'status': 'En progrès',
    'description': 'Description of the module',
  };

  // Transforme _tasks en _elements comme dans view_project
  final List<Map<String, dynamic>> _elements = [
    {
      'task': 'I.1.1 : Title of the task',
      'element': 'Title of an element',
      'reference': 'REF-001',
      'unity': 'Pièce',
      'quantity': 10,
      'price': 100.0,
      'subtotal': 1000.0,
    },
    {
      'task': 'I.1.1 : Title of the task',
      'element': 'Another element',
      'reference': 'REF-002',
      'unity': 'kg',
      'quantity': 5,
      'price': 50.0,
      'subtotal': 250.0,
    },
    {
      'task': 'I.1.2 : Second task',
      'element': 'Element for task 2',
      'reference': 'REF-003',
      'unity': 'piece',
      'quantity': 3,
      'price': 75.0,
      'subtotal': 225.0,
    },
  ];

  double get _totalBudget {
    return _elements.fold(0.0, (sum, element) => sum + element['subtotal']);
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
                      title: 'Module: ${_module['name']}',
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
                          // Module info header - MÊME STRUCTURE QUE VIEW_PROJECT
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(context.lg),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          _module['name'],
                                          style: TextStyle(
                                            fontSize:
                                                MediaQuery.of(
                                                      context,
                                                    ).size.width <
                                                    600
                                                ? context.fontSizeMd * 1.1
                                                : context.fontSizeLg * 1.2,
                                            fontWeight: FontWeight.bold,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      SizedBox(width: 12),
                                      Container(
                                        constraints: BoxConstraints(
                                          minWidth: 80,
                                          maxWidth: 120,
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          horizontal: 8,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color:
                                              SelectionService.getStatusColor(
                                                _module['status'],
                                              ).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color:
                                                SelectionService.getStatusColor(
                                                  _module['status'],
                                                ),
                                          ),
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            _module['status'],
                                            style: TextStyle(
                                              color:
                                                  SelectionService.getStatusColor(
                                                    _module['status'],
                                                  ),
                                              fontWeight: FontWeight.w500,
                                              fontSize:
                                                  MediaQuery.of(
                                                        context,
                                                      ).size.width <
                                                      768
                                                  ? 12
                                                  : 14,
                                            ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(height: context.md),
                                  Text(_module['description']),
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
                                                  'Start: ${_module['startDate']}',
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
                                                  'End: ${_module['endDate']}',
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
                                              'Start: ${_module['startDate']}',
                                            ),
                                            SizedBox(width: 16),
                                            Icon(Icons.flag, size: 16),
                                            SizedBox(width: 8),
                                            Text('End: ${_module['endDate']}'),
                                            SizedBox(width: 8),
                                          ],
                                        ),
                                  if (!isDesktop) ...[
                                    SizedBox(height: context.md),
                                    ElevatedButton.icon(
                                      onPressed: _convertToPdf,
                                      icon: const Icon(Icons.picture_as_pdf),
                                      label: const Text('Convert to PDF'),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: AppColors.warning,
                                        foregroundColor: Colors.white,
                                      ),
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: context.lg),

                          // Budget table - MÊME STRUCTURE QUE VIEW_PROJECT
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(context.lg),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Module Budget',
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
                                            'Task',
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        DataColumn(
                                          label: Text(
                                            'Element',
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
                                            'Price Excluding V.A.T',
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
                                      ],
                                      rows: _elements.asMap().entries.map((
                                        entry,
                                      ) {
                                        //final index = entry.key + 1;
                                        final element = entry.value;

                                        return DataRow(
                                          cells: [
                                            DataCell(Text(element['task'])),
                                            DataCell(Text(element['element'])),
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
                                              Text('${element['price']} FCFA'),
                                            ),
                                            DataCell(
                                              Text(
                                                '${element['subtotal']} FCFA',
                                              ),
                                            ),
                                          ],
                                        );
                                      }).toList(),
                                    ),
                                  ),
                                  SizedBox(height: context.lg),

                                  // Total row - MÊME STRUCTURE QUE VIEW_PROJECT
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
                                          '${_totalBudget.toStringAsFixed(2)} FCFA',
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
    );
  }

  void _convertToPdf() {
    // Implement PDF conversion
  }
}
