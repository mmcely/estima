import 'package:flutter/material.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/widgets/common/app_text_field.dart';
import '../../../../core/widgets/common/app_dropdown.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';
import '../../../../services/selection_service.dart';

class EditElementScreen extends StatefulWidget {
  const EditElementScreen({super.key});

  @override
  State<EditElementScreen> createState() => _EditElementScreenState();
}

class _EditElementScreenState extends State<EditElementScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _drawerExpanded = true;

  // Variables for dependent dropdowns
  String? _selectedSection;
  String? _selectedCategory;
  String? _selectedUnity;

  // Data
  List<String> _sections = [];
  List<String> _categories = ['Select the category'];
  final List<String> _units = [
    'Select the unit',
    'piece',
    'meter',
    'kilogram',
    'liter',
    'hour',
  ];

  // Controllers
  final TextEditingController _referenceController = TextEditingController();
  final TextEditingController _designationController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    setState(() {
      _sections = SelectionService.getSections();
      _selectedSection = _sections[0];
      _selectedCategory = _categories[0];
      _selectedUnity = _units[0];
    });
  }

  void _updateCategories() {
    if (_selectedSection != null && _selectedSection != _sections[0]) {
      final categories = SelectionService.getCategoriesForSection(
        _selectedSection!,
      );
      setState(() {
        _categories = categories;
        _selectedCategory = _categories[0];
      });
    } else {
      setState(() {
        _categories = ['Select the category'];
        _selectedCategory = _categories[0];
      });
    }
  }

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
                      title: 'Edit a element',
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
                                  'Edit Element',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: context.lg),

                                // Section dropdown
                                AppDropdown(
                                  label: 'Sections *',
                                  hint: 'Select section',
                                  icon: Icons.category_outlined,
                                  value: _selectedSection,
                                  items: _sections,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedSection = value;
                                      _updateCategories();
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value == _sections[0]) {
                                      return 'Section is required';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: context.md),

                                // Category dropdown (dependent on section)
                                AppDropdown(
                                  label: 'Categories *',
                                  hint: 'Select category',
                                  icon: Icons.label_outlined,
                                  value: _selectedCategory,
                                  items: _categories,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedCategory = value;
                                    });
                                  },
                                  enabled:
                                      _selectedSection != null &&
                                      _selectedSection != _sections[0],
                                  validator: (value) {
                                    if (_selectedSection != null &&
                                        _selectedSection != _sections[0] &&
                                        (value == null ||
                                            value == _categories[0])) {
                                      return 'Category is required';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: context.md),

                                // Reference input
                                AppTextField(
                                  controller: _referenceController,
                                  label: 'Reference',
                                  hint: 'Reference of the element',
                                  icon: Icons.code_outlined,
                                ),
                                SizedBox(height: context.md),

                                // Designation input
                                AppTextField(
                                  controller: _designationController,
                                  label: 'Designation *',
                                  hint: 'Designation of the element',
                                  icon: Icons.inventory_2_outlined,
                                  validator: (value) =>
                                      AppValidator.validateTitleText(value),
                                ),
                                SizedBox(height: context.md),

                                // Price input
                                AppTextField(
                                  controller: _priceController,
                                  label: 'Price Excluding VAT *',
                                  hint: 'Price of the element',
                                  icon: Icons.attach_money_outlined,
                                  keyboardType: TextInputType.numberWithOptions(
                                    decimal: true,
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Price is required';
                                    }
                                    final price = double.tryParse(value);
                                    if (price == null || price <= 0) {
                                      return 'Please enter a valid price';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: context.md),

                                // Unity dropdown
                                AppDropdown(
                                  label: 'Unity *',
                                  hint: 'Select unity',
                                  icon: Icons.square_foot_outlined,
                                  value: _selectedUnity,
                                  items: _units,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedUnity = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value == _units[0]) {
                                      return 'Unit is required';
                                    }
                                    return null;
                                  },
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
                                        child: Text('Create Element'),
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
    _referenceController.dispose();
    _designationController.dispose();
    _priceController.dispose();
    super.dispose();
  }
}
