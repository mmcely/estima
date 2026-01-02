import 'package:flutter/material.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/widgets/common/app_text_field.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';

class AddSectionScreen extends StatefulWidget {
  const AddSectionScreen({super.key});

  @override
  State<AddSectionScreen> createState() => _AddSectionScreenState();
}

class _AddSectionScreenState extends State<AddSectionScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _drawerExpanded = true;

  // Controllers
  final TextEditingController _designationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;
    final theme = Theme.of(context);

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
                      title: 'Create a new section',
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
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(context.lg),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Add New Section',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: context.lg),

                                // Designation input
                                AppTextField(
                                  controller: _designationController,
                                  label: 'Designation *',
                                  hint: 'Designation of the section',
                                  icon: Icons.category_outlined,
                                  validator: (value) =>
                                      AppValidator.validateTitleText(value),
                                ),
                                SizedBox(height: context.xl),

                                // Submit button
                                Container(
                                  padding: EdgeInsets.only(top: context.lg),
                                  decoration: BoxDecoration(
                                    border: Border(
                                      top: BorderSide(
                                        color: theme.dividerColor,
                                      ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      OutlinedButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        style: OutlinedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: context.xl,
                                            vertical: context.md,
                                          ),
                                        ),
                                        child: Text('Cancel'),
                                      ),
                                      SizedBox(width: context.md),
                                      ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          padding: EdgeInsets.symmetric(
                                            horizontal: context.xl,
                                            vertical: context.md,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.circular(
                                              8,
                                            ),
                                          ),
                                        ),
                                        child: Text('Create Section'),
                                      ),
                                    ],
                                  ),
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

  @override
  void dispose() {
    _designationController.dispose();
    super.dispose();
  }
}
