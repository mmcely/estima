import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/widgets/common/app_text_field.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';

class AddRoleScreen extends StatefulWidget {
  const AddRoleScreen({super.key});

  @override
  State<AddRoleScreen> createState() => _AddRoleScreenState();
}

class _AddRoleScreenState extends State<AddRoleScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _drawerExpanded = true;

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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header with title and actions
                    HeaderPage(
                      title: 'Create a new role',
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

                    // Form card
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isDesktop ? context.xl : context.md,
                      ),
                      child: Card(
                        elevation: 4,
                        child: Padding(
                          padding: EdgeInsets.all(context.lg),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Add a role',
                                  style: TextStyle(
                                    fontSize: context.fontSizeLg * 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: context.lg),

                                // Title input
                                AppTextField(
                                  label: 'Title',
                                  hint: 'Title of role',
                                  icon: Icons.badge_outlined,
                                  validator: (value) =>
                                      AppValidator.validateTitleText(value),
                                ),
                                SizedBox(height: context.md),

                                // Priority input
                                AppTextField(
                                  label: 'Priority',
                                  hint: '1',
                                  icon: Icons.priority_high_outlined,
                                  validator: (value) =>
                                      AppValidator.validatePriority(value),
                                  keyboardType: TextInputType.number,
                                ),
                                SizedBox(height: context.xl),

                                // Submit button
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    ElevatedButton(
                                      onPressed: () {},
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                          horizontal: context.xl,
                                          vertical: context.md,
                                        ),
                                      ),
                                      child: const Text('Submit'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
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
}
