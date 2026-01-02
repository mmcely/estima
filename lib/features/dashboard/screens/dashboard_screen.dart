import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../core/widgets/shared/header_page.dart';
import '../widgets/first_row.dart';
import '../widgets/second_row.dart';
import '../widgets/third_row.dart';
import '../../../core/widgets/shared/drawer.dart';
import '../../../core/responsive/responsive_extensions.dart';
import '../../../state/auth_controller.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final AuthController authController =
      GetInstance().isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());

  final int _selectedYear = DateTime.now().year;
  String _selectedChartFilter = 'Year';
  late Map<String, dynamic> _userData;
  late Map<String, dynamic> _dashboardStats;
  bool _drawerExpanded = true;

  // Key to access the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();
    final authController = Get.find<AuthController>();
    _userData = authController.getMockUserData();
    _dashboardStats = authController.getMockDashboardStats();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;

    return Scaffold(
      key: _scaffoldKey,
      drawer: const AppDrawer(),
      body: SafeArea(
        child: Row(
          children: [
            // Fixed sidebar for desktop (conditional)
            if (isDesktop && _drawerExpanded)
              Container(width: 280, child: const AppDrawer()),

            // Main content
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(context.defaultSpace),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with title and actions
                    HeaderPage(
                      title: 'Dashboard',
                      scaffoldKey: _scaffoldKey,
                      isDesktop: isDesktop,
                      isDashboard: true,
                      drawerExpanded: _drawerExpanded,
                      onToggleDrawer: () {
                        setState(() {
                          _drawerExpanded = !_drawerExpanded;
                        });
                      },
                      showNotifications: true,
                    ),
                    SizedBox(height: context.spaceBtwSections),

                    // First row: Welcome Card and Stats
                    FirstRow(
                      context,
                      _userData,
                      _dashboardStats,
                      _selectedYear,
                    ), // Pass parameters
                    SizedBox(height: context.spaceBtwSections),

                    // Second row: Charts and Stats
                    SecondRow(
                      context,
                      _userData,
                      _dashboardStats,
                      _selectedYear,
                      _selectedChartFilter,
                      setState,
                    ), // Pass parameters
                    SizedBox(height: context.spaceBtwSections),

                    // Third row: Statistics and Transactions
                    ThirdRow(context, _userData), // Pass parameters
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
