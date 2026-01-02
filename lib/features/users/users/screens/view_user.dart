import 'package:flutter/material.dart';

import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';
import '../../../../services/selection_service.dart';

class ViewUserScreen extends StatefulWidget {
  const ViewUserScreen({super.key});

  @override
  State<ViewUserScreen> createState() => _ViewUserScreenState();
}

class _ViewUserScreenState extends State<ViewUserScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _drawerExpanded = true;

  // Sample data
  final Map<String, dynamic> _user = {
    'id': '1',
    'name': 'John Doe',
    'email': 'john.doe@example.com',
    'role': 'Administrator',
    'gender': 'Male',
    'phone': '655 555 555',
    'birthDate': '1990-05-15',
    'matricule': 'EMP001',
    'address': '123 Main Street, City',
    'birthLocation': 'New York, USA',
    'service': 'IT Department',
    'status': 'Active',
    'createdAt': '15/01/2024',
  };

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;

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
                      title: 'User Profile: ${_user['name']}',
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
                    ),
                    SizedBox(height: context.spaceBtwSections),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? context.xl : context.md,
                      ),
                      child: Column(
                        children: [
                          // Header card with profile
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(context.lg),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // Profile header
                                  Row(
                                    children: [
                                      // Avatar
                                      CircleAvatar(
                                        radius: 40,
                                        backgroundColor:
                                            SelectionService.getRandomColor(
                                              _user['name'],
                                            ),
                                        child: Text(
                                          _user['name'][0],
                                          style: TextStyle(
                                            fontSize: 32,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: context.lg),
                                      // User info
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              _user['name'],
                                              style: TextStyle(
                                                fontSize: context.fontSizeLg,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(height: 4),
                                            Text(
                                              _user['email'],
                                              style: TextStyle(
                                                fontSize: context.fontSizeSm,
                                              ),
                                            ),
                                            SizedBox(height: 8),
                                            Row(
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color: SelectionService()
                                                        .getRoleColor(
                                                          _user['role'],
                                                        ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    _user['role'],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                SizedBox(width: 8),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                    horizontal: 12,
                                                    vertical: 4,
                                                  ),
                                                  decoration: BoxDecoration(
                                                    color:
                                                        SelectionService.getStatusColor(
                                                          _user['status'],
                                                        ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                          20,
                                                        ),
                                                  ),
                                                  child: Text(
                                                    _user['status'],
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      // Stats for desktop
                                      if (isDesktop) ...[
                                        SizedBox(width: context.xl),
                                        _buildStatCard(
                                          value: '5',
                                          label: 'Projects',
                                          icon: Icons.business_center,
                                        ),
                                        SizedBox(width: context.md),
                                        _buildStatCard(
                                          value: '42',
                                          label: 'Tasks',
                                          icon: Icons.task,
                                        ),
                                        SizedBox(width: context.md),
                                        _buildStatCard(
                                          value: '85%',
                                          label: 'Completion',
                                          icon: Icons.trending_up,
                                        ),
                                      ],
                                    ],
                                  ),
                                  // Stats for mobile
                                  if (!isDesktop) ...[
                                    SizedBox(height: context.lg),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceAround,
                                      children: [
                                        _buildStatCard(
                                          value: '5',
                                          label: 'Projects',
                                          icon: Icons.business_center,
                                        ),
                                        _buildStatCard(
                                          value: '42',
                                          label: 'Tasks',
                                          icon: Icons.task,
                                        ),
                                        _buildStatCard(
                                          value: '85%',
                                          label: 'Completion',
                                          icon: Icons.trending_up,
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                          SizedBox(height: context.lg),
                          // Personal Information card
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(context.lg),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Personal Information',
                                    style: TextStyle(
                                      fontSize: context.fontSizeLg,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(height: context.lg),
                                  if (isDesktop) ...[
                                    _buildDesktopInfoGrid(),
                                  ] else ...[
                                    _buildMobileInfoList(),
                                  ],
                                  SizedBox(height: context.xl),
                                  // Action buttons
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () {},
                                        child: const Text('Back'),
                                      ),
                                      SizedBox(width: context.md),
                                      ElevatedButton(
                                        onPressed: () {},
                                        child: const Text('Edit Profile'),
                                      ),
                                    ],
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

  Widget _buildDesktopInfoGrid() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              _buildInfoRow('Gender', _user['gender']),
              SizedBox(height: context.md),
              _buildInfoRow('Phone Number', _user['phone']),
              SizedBox(height: context.md),
              _buildInfoRow('Birth Date', _user['birthDate']),
              SizedBox(height: context.md),
              _buildInfoRow('Matricule', _user['matricule']),
            ],
          ),
        ),
        SizedBox(width: context.xl),
        Expanded(
          child: Column(
            children: [
              _buildInfoRow('Address', _user['address']),
              SizedBox(height: context.md),
              _buildInfoRow('Birth Location', _user['birthLocation']),
              SizedBox(height: context.md),
              _buildInfoRow('Service', _user['service']),
              SizedBox(height: context.md),
              _buildInfoRow('Member Since', _user['createdAt']),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileInfoList() {
    return Column(
      children: [
        _buildInfoRow('Gender', _user['gender']),
        SizedBox(height: context.md),
        _buildInfoRow('Phone Number', _user['phone']),
        SizedBox(height: context.md),
        _buildInfoRow('Birth Date', _user['birthDate']),
        SizedBox(height: context.md),
        _buildInfoRow('Matricule', _user['matricule']),
        SizedBox(height: context.md),
        _buildInfoRow('Address', _user['address']),
        SizedBox(height: context.md),
        _buildInfoRow('Birth Location', _user['birthLocation']),
        SizedBox(height: context.md),
        _buildInfoRow('Service', _user['service']),
        SizedBox(height: context.md),
        _buildInfoRow('Member Since', _user['createdAt']),
      ],
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 4),
        Text(value, style: TextStyle(fontSize: 16)),
      ],
    );
  }

  Widget _buildStatCard({
    required String value,
    required String label,
    required IconData icon,
  }) {
    return Column(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: Colors.blue, size: 30),
        ),
        SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        SizedBox(height: 4),
        Text(label, style: TextStyle(fontSize: 12)),
      ],
    );
  }
}
