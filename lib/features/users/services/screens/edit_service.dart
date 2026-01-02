import 'package:flutter/material.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/widgets/common/app_text_field.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';

class EditServiceScreen extends StatefulWidget {
  const EditServiceScreen({super.key});

  @override
  State<EditServiceScreen> createState() => _EditServiceScreenState();
}

class _EditServiceScreenState extends State<EditServiceScreen> {
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
                      title: 'Edit a service',
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
                                  'Edit a service',
                                  style: TextStyle(
                                    fontSize: context.fontSizeLg * 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: context.lg),

                                // Title input
                                AppTextField(
                                  label: 'Title',
                                  hint: 'Title of service',
                                  icon: Icons.work_outlined,
                                  validator: (value) =>
                                      AppValidator.validateTitleText(value),
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
