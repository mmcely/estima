import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';
import '../../../../services/selection_service.dart';

class ViewProjectScreen extends StatefulWidget {
  const ViewProjectScreen({super.key});

  @override
  State<ViewProjectScreen> createState() => _ViewProjectScreenState();
}

class _ViewProjectScreenState extends State<ViewProjectScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _drawerExpanded = true;

  // Example data
  final Map<String, dynamic> _project = {
    'id': '1',
    'name': 'Angular Project',
    'startDate': '2022-09-26',
    'endDate': '2022-11-06',
    'status': 'In progress',
    'description': 'Description of the Project',
  };

  final List<Map<String, dynamic>> _elements = [
    {
      'module': 'MODULE N°1 : Title of the module',
      'task': 'Title of the task',
      'element': 'Specific element',
      'reference': 'REF-001',
      'unity': 'Piece',
      'quantity': 2,
      'price': 50000.0,
      'subtotal': 100000.0,
    },
    {
      'module': 'MODULE N°1 : Title of the module',
      'task': 'Title of the task',
      'element': 'Another element',
      'reference': 'REF-002',
      'unity': 'kg',
      'quantity': 5,
      'price': 10000.0,
      'subtotal': 50000.0,
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
                      title: 'Project: ${_project['name']}',
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
                          // Project info header
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
                                          _project['name'],
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
                                                _project['status'],
                                              ).withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(
                                            20,
                                          ),
                                          border: Border.all(
                                            color:
                                                SelectionService.getStatusColor(
                                                  _project['status'],
                                                ),
                                          ),
                                        ),
                                        child: FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            _project['status'],
                                            style: TextStyle(
                                              color:
                                                  SelectionService.getStatusColor(
                                                    _project['status'],
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
                                  Text(_project['description']),
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
                                                  'Start: ${_project['startDate']}',
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
                                                  'End: ${_project['endDate']}',
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
                                              'Start: ${_project['startDate']}',
                                            ),
                                            SizedBox(width: 16),
                                            Icon(Icons.flag, size: 16),
                                            SizedBox(width: 8),
                                            Text('End: ${_project['endDate']}'),
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

                          // Budget table
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(context.lg),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Project Budget',
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
                                        final index = entry.key + 1;
                                        final element = entry.value;

                                        return DataRow(
                                          cells: [
                                            DataCell(Text(index.toString())),
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
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

  void _convertToPdf() {
    // Implement PDF conversion
  }
}
