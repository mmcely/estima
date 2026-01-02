import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/utils/colors.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';

class ParametersScreen extends StatefulWidget {
  const ParametersScreen({super.key});

  @override
  State<ParametersScreen> createState() => _ParametersScreenState();
}

class _ParametersScreenState extends State<ParametersScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  bool _drawerExpanded = true;
  int _selectedTab = 1; // 0: Account, 1: Notifications, 2: Connections

  // Data for notifications
  final List<NotificationSetting> _notificationSettings = [
    NotificationSetting(
      type: 'New for you',
      email: true,
      browser: true,
      app: true,
    ),
    NotificationSetting(
      type: 'Account activity',
      email: true,
      browser: true,
      app: true,
    ),
    NotificationSetting(
      type: 'A new browser used to sign in',
      email: true,
      browser: true,
      app: false,
    ),
    NotificationSetting(
      type: 'A new device is linked',
      email: true,
      browser: false,
      app: false,
    ),
  ];

  String _notificationTiming = 'Only when I\'m online';

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
                      title: 'Account Settings',
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
                      child: Card(
                        elevation: 4,
                        child: Column(
                          children: [
                            // Navigation tabs
                            Container(
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: BorderSide(
                                    color: Theme.of(context).dividerColor,
                                  ),
                                ),
                              ),
                              child: TabBar(
                                controller: TabController(
                                  length: 3,
                                  initialIndex: _selectedTab,
                                  vsync: Navigator.of(context),
                                ),
                                onTap: (index) =>
                                    setState(() => _selectedTab = index),
                                labelColor: Theme.of(context).primaryColor,
                                unselectedLabelColor: Colors.grey,
                                indicatorColor: Theme.of(context).primaryColor,
                                tabs: const [
                                  Tab(
                                    icon: Icon(Icons.person, size: 20),
                                    text: 'Account',
                                  ),
                                  Tab(
                                    icon: Icon(Icons.notifications, size: 20),
                                    text: 'Notifications',
                                  ),
                                  Tab(
                                    icon: Icon(Icons.link, size: 20),
                                    text: 'Connections',
                                  ),
                                ],
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(context.lg),
                              child: _selectedTab == 1
                                  ? _buildNotificationsTab(context)
                                  : _selectedTab == 0
                                  ? _buildAccountTab(context)
                                  : _buildConnectionsTab(context),
                            ),
                          ],
                        ),
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

  Widget _buildAccountTab(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Account Settings',
          style: TextStyle(
            fontSize: context.fontSizeLg * 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: context.lg),
        Text(
          'This tab would contain account settings like profile information, security settings, etc.',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  Widget _buildNotificationsTab(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Notifications',
          style: TextStyle(
            fontSize: context.fontSizeLg * 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: context.lg),

        // Recent Devices / Permission Section
        Card(
          elevation: 2,
          child: Padding(
            padding: EdgeInsets.all(context.md),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Recent Devices',
                  style: TextStyle(
                    fontSize: context.fontSizeMd,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 8),
                Text(
                  'We need permission from your browser to show notifications.',
                  style: TextStyle(color: Colors.grey),
                ),
                SizedBox(height: 4),
                GestureDetector(
                  onTap: _requestNotificationPermission,
                  child: Text(
                    'Request Permission',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        SizedBox(height: context.lg),

        // Notification settings table
        Text(
          'Notification Settings',
          style: TextStyle(
            fontSize: context.fontSizeMd,
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: context.md),

        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          child: DataTable(
            columns: [
              DataColumn(
                label: Text(
                  'Type',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Email',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'Browser',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
              DataColumn(
                label: Text(
                  'App',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
            rows: _notificationSettings.map((setting) {
              return DataRow(
                cells: [
                  DataCell(Text(setting.type)),
                  DataCell(
                    Center(
                      child: Checkbox(
                        value: setting.email,
                        onChanged: (value) {
                          setState(() {
                            _notificationSettings[_notificationSettings.indexOf(
                              setting,
                            )] = setting.copyWith(
                              email: value ?? false,
                            );
                          });
                        },
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Checkbox(
                        value: setting.browser,
                        onChanged: (value) {
                          setState(() {
                            _notificationSettings[_notificationSettings.indexOf(
                              setting,
                            )] = setting.copyWith(
                              browser: value ?? false,
                            );
                          });
                        },
                      ),
                    ),
                  ),
                  DataCell(
                    Center(
                      child: Checkbox(
                        value: setting.app,
                        onChanged: (value) {
                          setState(() {
                            _notificationSettings[_notificationSettings.indexOf(
                              setting,
                            )] = setting.copyWith(
                              app: value ?? false,
                            );
                          });
                        },
                      ),
                    ),
                  ),
                ],
              );
            }).toList(),
          ),
        ),

        SizedBox(height: context.xl),

        // Notification timing selector
        Text(
          'When should we send you notifications?',
          style: TextStyle(
            fontSize: context.fontSizeMd,
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: context.md),

        DropdownButtonFormField<String>(
          value: _notificationTiming,
          decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8.0),
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: context.md,
              vertical: context.sm,
            ),
          ),
          items: const [
            DropdownMenuItem(
              value: 'Only when I\'m online',
              child: Text('Only when I\'m online'),
            ),
            DropdownMenuItem(value: 'Anytime', child: Text('Anytime')),
          ],
          onChanged: (value) {
            setState(() {
              _notificationTiming = value ?? _notificationTiming;
            });
          },
        ),

        SizedBox(height: context.xl),

        // Action buttons
        Row(
          children: [
            ElevatedButton(
              onPressed: _saveSettings,
              style: ElevatedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: context.xl,
                  vertical: context.md,
                ),
              ),
              child: const Text('Save changes'),
            ),
            SizedBox(width: context.md),
            OutlinedButton(
              onPressed: _resetSettings,
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(
                  horizontal: context.xl,
                  vertical: context.md,
                ),
              ),
              child: const Text('Discard'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildConnectionsTab(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Connections',
          style: TextStyle(
            fontSize: context.fontSizeLg * 1.5,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: context.lg),
        Text(
          'This tab would contain connections to other services, linked accounts, etc.',
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }

  void _requestNotificationPermission() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Notification Permission'),
        content: const Text(
          'This app would like to send you notifications. Allow?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Deny'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              Get.snackbar(
                'Success',
                'Notification permission granted',
                snackPosition: SnackPosition.BOTTOM,
              );
            },
            child: const Text('Allow'),
          ),
        ],
      ),
    );
  }

  void _saveSettings() {
    Get.snackbar(
      'Success',
      'Settings saved successfully',
      snackPosition: SnackPosition.BOTTOM,
    );
  }

  void _resetSettings() {
    setState(() {
      _notificationTiming = 'Only when I\'m online';
      _notificationSettings.clear();
      _notificationSettings.addAll([
        NotificationSetting(
          type: 'New for you',
          email: true,
          browser: true,
          app: true,
        ),
        NotificationSetting(
          type: 'Account activity',
          email: true,
          browser: true,
          app: true,
        ),
        NotificationSetting(
          type: 'A new browser used to sign in',
          email: true,
          browser: true,
          app: false,
        ),
        NotificationSetting(
          type: 'A new device is linked',
          email: true,
          browser: false,
          app: false,
        ),
      ]);
    });

    Get.snackbar(
      'Reset',
      'Settings reset to defaults',
      snackPosition: SnackPosition.BOTTOM,
    );
  }
}

class NotificationSetting {
  final String type;
  bool email;
  bool browser;
  bool app;

  NotificationSetting({
    required this.type,
    required this.email,
    required this.browser,
    required this.app,
  });

  NotificationSetting copyWith({
    String? type,
    bool? email,
    bool? browser,
    bool? app,
  }) {
    return NotificationSetting(
      type: type ?? this.type,
      email: email ?? this.email,
      browser: browser ?? this.browser,
      app: app ?? this.app,
    );
  }
}
