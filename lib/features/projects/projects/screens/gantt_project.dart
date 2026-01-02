import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:math';

import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';
import '../../../../data/models/project_model.dart';

class GanttProjectScreen extends StatefulWidget {
  const GanttProjectScreen({super.key});

  @override
  State<GanttProjectScreen> createState() => _GanttProjectScreenState();
}

class _GanttProjectScreenState extends State<GanttProjectScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _drawerExpanded = true;

  DateTime _startDate = DateTime.now().subtract(const Duration(days: 30));
  DateTime _endDate = DateTime.now().add(const Duration(days: 30));
  List<GanttTask> _tasks = [];

  @override
  void initState() {
    super.initState();
    _initializeTasks();
  }

  void _initializeTasks() {
    _tasks = [
      GanttTask(
        id: 1,
        text: "Project #1",
        startDate: DateTime.now().subtract(const Duration(days: 20)),
        endDate: DateTime.now().add(const Duration(days: 40)),
        parentId: null,
        color: const Color(0xFF4f9a7b),
        isProject: true,
      ),
      GanttTask(
        id: 2,
        text: "Task #1",
        startDate: DateTime.now().subtract(const Duration(days: 15)),
        endDate: DateTime.now().add(const Duration(days: 5)),
        parentId: 1,
        color: const Color(0xFF4f9a7b),
      ),
      GanttTask(
        id: 3,
        text: "Task #2",
        startDate: DateTime.now().subtract(const Duration(days: 10)),
        endDate: DateTime.now().add(const Duration(days: 10)),
        parentId: 1,
        color: const Color(0xFF4f9a7b),
      ),
      GanttTask(
        id: 4,
        text: "Task #3",
        startDate: DateTime.now().subtract(const Duration(days: 5)),
        endDate: DateTime.now().add(const Duration(days: 15)),
        parentId: 2,
        color: const Color(0xFF4f9a7b),
      ),
      GanttTask(
        id: 5,
        text: "Project #2",
        startDate: DateTime.now().subtract(const Duration(days: 10)),
        endDate: DateTime.now().add(const Duration(days: 30)),
        parentId: null,
        color: const Color(0xFFbbb815),
        isProject: true,
      ),
      GanttTask(
        id: 6,
        text: "Task #1",
        startDate: DateTime.now().subtract(const Duration(days: 5)),
        endDate: DateTime.now().add(const Duration(days: 5)),
        parentId: 5,
        color: const Color(0xFFbbb815),
      ),
    ];

    if (_tasks.isNotEmpty) {
      _startDate = _tasks
          .map((task) => task.startDate)
          .reduce((a, b) => a.isBefore(b) ? a : b);
      _endDate = _tasks
          .map((task) => task.endDate)
          .reduce((a, b) => a.isAfter(b) ? a : b);
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;
    final isMobile = MediaQuery.of(context).size.width < 768;

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
                      title: 'Title of the project',
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
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Gantt chart',
                            style: TextStyle(
                              fontSize: isMobile
                                  ? context.fontSizeMd * 1.2
                                  : context.fontSizeLg * 1.5,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: context.md),

                          // Controls
                          Card(
                            elevation: 2,
                            child: Padding(
                              padding: EdgeInsets.all(context.md),
                              child: isMobile
                                  ? Column(
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text('Zoom: '),
                                            SizedBox(width: context.sm),
                                            IconButton(
                                              icon: Icon(Icons.zoom_out),
                                              onPressed: _zoomOut,
                                            ),
                                            IconButton(
                                              icon: Icon(Icons.zoom_in),
                                              onPressed: _zoomIn,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: context.sm),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            ElevatedButton.icon(
                                              onPressed: _exportData,
                                              icon: Icon(Icons.download),
                                              label: Text('Export'),
                                            ),
                                            ElevatedButton.icon(
                                              onPressed: _convertToPdf,
                                              icon: Icon(Icons.picture_as_pdf),
                                              label: Text('PDF'),
                                              style: ElevatedButton.styleFrom(
                                                backgroundColor:
                                                    AppColors.warning,
                                                foregroundColor: Colors.white,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    )
                                  : Row(
                                      children: [
                                        Expanded(
                                          child: Row(
                                            children: [
                                              Text('Zoom: '),
                                              SizedBox(width: context.sm),
                                              IconButton(
                                                icon: Icon(Icons.zoom_out),
                                                onPressed: _zoomOut,
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.zoom_in),
                                                onPressed: _zoomIn,
                                              ),
                                            ],
                                          ),
                                        ),
                                        ElevatedButton.icon(
                                          onPressed: _exportData,
                                          icon: Icon(Icons.download),
                                          label: Text('Export'),
                                        ),
                                        SizedBox(width: context.md),
                                        if (!isDesktop)
                                          ElevatedButton.icon(
                                            onPressed: _convertToPdf,
                                            icon: Icon(Icons.picture_as_pdf),
                                            label: Text('PDF'),
                                            style: ElevatedButton.styleFrom(
                                              backgroundColor:
                                                  AppColors.warning,
                                              foregroundColor: Colors.white,
                                            ),
                                          ),
                                      ],
                                    ),
                            ),
                          ),
                          SizedBox(height: context.lg),

                          // Gantt chart - SIMPLIFIÉ POUR ÉVITER LES ERREURS
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(context.lg),
                              child: _buildGanttChart(context),
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

  Widget _buildGanttChart(BuildContext context) {
    final isMobile = MediaQuery.of(context).size.width < 768;
    final int totalDays = _endDate.difference(_startDate).inDays + 1;
    final double dayWidth = isMobile ? 20.0 : 30.0;

    // Calcule la largeur totale nécessaire
    final double totalWidth = 200 + (totalDays * dayWidth);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Container(
        width: totalWidth,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Date header
            Container(
              height: isMobile ? 30 : 40,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey.shade300),
              ),
              child: Row(
                children: [
                  Container(
                    width: isMobile ? 120 : 200,
                    padding: EdgeInsets.symmetric(
                      horizontal: isMobile ? context.sm : context.md,
                    ),
                    child: Text(
                      'Work Areas',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: isMobile ? 12 : 14,
                      ),
                    ),
                  ),
                  Expanded(
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: totalDays,
                      itemBuilder: (context, index) {
                        final date = _startDate.add(Duration(days: index));
                        return Container(
                          width: dayWidth,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Colors.grey.shade300,
                              width: 0.5,
                            ),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            DateFormat('d').format(date),
                            style: TextStyle(
                              fontSize: isMobile ? 8 : 10,
                              color: date.weekday == 6 || date.weekday == 7
                                  ? AppColors.error
                                  : AppColors.warning,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: context.md),

            // Tasks
            Container(
              height: isMobile ? 300 : 400,
              child: ListView.builder(
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemCount: _tasks.length,
                itemBuilder: (context, index) {
                  final task = _tasks[index];
                  return _buildTaskRow(task, totalDays, dayWidth, isMobile);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTaskRow(
    GanttTask task,
    int totalDays,
    double dayWidth,
    bool isMobile,
  ) {
    final int startOffset = task.startDate.difference(_startDate).inDays;
    final int taskDuration = task.endDate.difference(task.startDate).inDays + 1;
    final double taskWidth = taskDuration * dayWidth;
    final double taskLeft = max(0, startOffset * dayWidth);

    return Container(
      height: isMobile ? 30 : 40,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: [
          Container(
            width: isMobile ? 120 : 200,
            padding: EdgeInsets.symmetric(
              horizontal: isMobile ? context.sm : context.md,
            ),
            child: Row(
              children: [
                Icon(
                  task.isProject ? Icons.folder : Icons.assignment,
                  size: isMobile ? 12 : 16,
                  color: task.color,
                ),
                SizedBox(width: isMobile ? context.xs : context.sm),
                Expanded(
                  child: Text(
                    task.text,
                    style: TextStyle(
                      fontWeight: task.isProject
                          ? FontWeight.bold
                          : FontWeight.normal,
                      color: task.color,
                      fontSize: isMobile ? 10 : 14,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Stack(
              children: [
                if (startOffset >= 0 && taskWidth > 0)
                  Positioned(
                    left: taskLeft,
                    width: taskWidth,
                    child: Container(
                      height: isMobile ? 20 : 30,
                      margin: EdgeInsets.symmetric(vertical: isMobile ? 2 : 5),
                      decoration: BoxDecoration(
                        color: task.color.withOpacity(0.7),
                        borderRadius: BorderRadius.circular(4),
                        border: Border.all(color: task.color, width: 1),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _zoomIn() {
    setState(() {
      _startDate = _startDate.add(const Duration(days: 7));
      _endDate = _endDate.subtract(const Duration(days: 7));
    });
  }

  void _zoomOut() {
    setState(() {
      _startDate = _startDate.subtract(const Duration(days: 7));
      _endDate = _endDate.add(const Duration(days: 7));
    });
  }

  void _exportData() {
    // Implement export
  }

  void _convertToPdf() {
    // Implement PDF conversion
  }
}
