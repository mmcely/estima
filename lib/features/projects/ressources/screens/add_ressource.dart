import 'package:flutter/material.dart';
import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/widgets/common/app_dropdown.dart';
import '../../../../core/widgets/common/app_text_field.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';
import '../../../../services/selection_service.dart';

class AddRessourceScreen extends StatefulWidget {
  const AddRessourceScreen({super.key});

  @override
  State<AddRessourceScreen> createState() => _AddRessourceScreenState();
}

class _AddRessourceScreenState extends State<AddRessourceScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _drawerExpanded = true;

  // Dependent dropdown variables
  String? _selectedProject;
  String? _selectedModule;
  String? _selectedTask;
  String? _selectedSection;
  String? _selectedCategory;
  String? _selectedElement;

  // Calculation variables
  final TextEditingController _quantityController = TextEditingController(
    text: '1',
  );
  double _unityPrice = 0.0;
  double _totalPrice = 0.0;
  String _elementUnit = 'piece';

  // Data
  List<String> _projects = [];
  List<String> _modules = ['Select the module'];
  List<String> _tasks = ['Select the task'];
  List<String> _sections = [];
  List<String> _categories = ['Select the category'];
  List<String> _elements = ['Select the element'];

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    setState(() {
      _projects = SelectionService.getProjects();
      _sections = SelectionService.getSections();
      _selectedProject = _projects[0];
      _selectedModule = _modules[0];
      _selectedTask = _tasks[0];
      _selectedSection = _sections[0];
      _selectedCategory = _categories[0];
      _selectedElement = _elements[0];
      _calculateTotalPrice();
    });
  }

  void _updateModules() {
    if (_selectedProject != null && _selectedProject != _projects[0]) {
      final modules = SelectionService.getModulesForProject(_selectedProject!);
      setState(() {
        _modules = modules;
        _selectedModule = _modules[0];
        _updateTasks();
      });
    } else {
      setState(() {
        _modules = ['Select the module'];
        _selectedModule = _modules[0];
        _updateTasks();
      });
    }
  }

  void _updateTasks() {
    if (_selectedModule != null && _selectedModule != _modules[0]) {
      final tasks = SelectionService.getTasksForModule(_selectedModule!);
      setState(() {
        _tasks = tasks;
        _selectedTask = _tasks[0];
      });
    } else {
      setState(() {
        _tasks = ['Select the task'];
        _selectedTask = _tasks[0];
      });
    }
  }

  void _updateCategories() {
    if (_selectedSection != null && _selectedSection != _sections[0]) {
      final categories = SelectionService.getCategoriesForSection(
        _selectedSection!,
      );
      setState(() {
        _categories = categories;
        _selectedCategory = _categories[0];
        _updateElements();
      });
    } else {
      setState(() {
        _categories = ['Select the category'];
        _selectedCategory = _categories[0];
        _updateElements();
      });
    }
  }

  void _updateElements() {
    if (_selectedCategory != null && _selectedCategory != _categories[0]) {
      final elements = SelectionService.getElementsForCategory(
        _selectedCategory!,
      );
      setState(() {
        _elements = elements;
        _selectedElement = _elements[0];
        _updateUnityPrice();
      });
    } else {
      setState(() {
        _elements = ['Select the element'];
        _selectedElement = _elements[0];
        _updateUnityPrice();
      });
    }
  }

  void _updateUnityPrice() {
    if (_selectedElement != null && _selectedElement != _elements[0]) {
      setState(() {
        _unityPrice = SelectionService.getPriceForElement(_selectedElement!);
        _elementUnit = SelectionService.getElementUnit(_selectedElement!);
        _calculateTotalPrice();
      });
    } else {
      setState(() {
        _unityPrice = 0.0;
        _elementUnit = 'piece';
        _calculateTotalPrice();
      });
    }
  }

  void _calculateTotalPrice() {
    final quantity = int.tryParse(_quantityController.text) ?? 1;
    setState(() {
      _totalPrice = _unityPrice * quantity;
    });
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // Additional validation
      if (_selectedProject == _projects[0]) {
        _showError('Please select a project');
        return;
      }

      if (_selectedModule == _modules[0]) {
        _showError('Please select a module');
        return;
      }

      if (_selectedTask == _tasks[0]) {
        _showError('Please select a task');
        return;
      }

      if (_selectedSection == _sections[0]) {
        _showError('Please select a section');
        return;
      }

      if (_selectedCategory == _categories[0]) {
        _showError('Please select a category');
        return;
      }

      if (_selectedElement == _elements[0]) {
        _showError('Please select an element');
        return;
      }

      // Successful submission
      final ressourceData = {
        'project': _selectedProject,
        'module': _selectedModule,
        'task': _selectedTask,
        'section': _selectedSection,
        'category': _selectedCategory,
        'element': _selectedElement,
        'quantity': int.parse(_quantityController.text),
        'unityPrice': _unityPrice,
        'totalPrice': _totalPrice,
        'unit': _elementUnit,
      };

      print('Ressource created: $ressourceData');

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Ressource added successfully!'),
          backgroundColor: Colors.green,
          duration: Duration(seconds: 2),
        ),
      );

      // Reset form
      Future.delayed(Duration(seconds: 2), () {
        _formKey.currentState!.reset();
        _initializeData();
      });
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Theme.of(context).colorScheme.error,
      ),
    );
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
                      title: 'Create a new ressource',
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
                                  'Add New Ressource',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: context.lg),

                                // Project dropdown
                                AppDropdown(
                                  label: 'Project *',
                                  hint: 'Select the project',
                                  icon: Icons.business_outlined,
                                  value: _selectedProject,
                                  items: _projects,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedProject = value;
                                      _updateModules();
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value == _projects[0]) {
                                      return 'Project is required';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: context.md),

                                // Module dropdown
                                AppDropdown(
                                  label: 'Module *',
                                  hint: 'Select the module',
                                  icon: Icons.view_module_outlined,
                                  value: _selectedModule,
                                  items: _modules,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedModule = value;
                                      _updateTasks();
                                    });
                                  },
                                  enabled:
                                      _selectedProject != null &&
                                      _selectedProject != _projects[0],
                                  validator: (value) {
                                    if (_selectedProject != null &&
                                        _selectedProject != _projects[0] &&
                                        (value == null ||
                                            value == _modules[0])) {
                                      return 'Module is required';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: context.md),

                                // Task dropdown
                                AppDropdown(
                                  label: 'Task *',
                                  hint: 'Select the task',
                                  icon: Icons.task_outlined,
                                  value: _selectedTask,
                                  items: _tasks,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedTask = value;
                                    });
                                  },
                                  enabled:
                                      _selectedModule != null &&
                                      _selectedModule != _modules[0],
                                  validator: (value) {
                                    if (_selectedModule != null &&
                                        _selectedModule != _modules[0] &&
                                        (value == null || value == _tasks[0])) {
                                      return 'Task is required';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: context.md),

                                // Section dropdown
                                AppDropdown(
                                  label: 'Section *',
                                  hint: 'Select the section',
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

                                // Category dropdown
                                AppDropdown(
                                  label: 'Category *',
                                  hint: 'Select the category',
                                  icon: Icons.folder_outlined,
                                  value: _selectedCategory,
                                  items: _categories,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedCategory = value;
                                      _updateElements();
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

                                // Element dropdown
                                AppDropdown(
                                  label: 'Element *',
                                  hint: 'Select the element',
                                  icon: Icons.inventory_outlined,
                                  value: _selectedElement,
                                  items: _elements,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedElement = value;
                                      _updateUnityPrice();
                                    });
                                  },
                                  enabled:
                                      _selectedCategory != null &&
                                      _selectedCategory != _categories[0],
                                  validator: (value) {
                                    if (_selectedCategory != null &&
                                        _selectedCategory != _categories[0] &&
                                        (value == null ||
                                            value == _elements[0])) {
                                      return 'Element is required';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: context.md),

                                // Quantity input
                                AppTextField(
                                  controller: _quantityController,
                                  label: 'Quantity *',
                                  hint: 'Enter quantity',
                                  icon: Icons.numbers_outlined,
                                  keyboardType: TextInputType.number,
                                  onChanged: (value) {
                                    _calculateTotalPrice();
                                  },
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Quantity is required';
                                    }
                                    final quantity = int.tryParse(value);
                                    if (quantity == null) {
                                      return 'Please enter a valid number';
                                    }
                                    if (quantity < 1) {
                                      return 'Quantity must be at least 1';
                                    }
                                    return null;
                                  },
                                  suffixText: _elementUnit,
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
                                        onPressed: _submitForm,
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
                                        child: Text('Add Ressource'),
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
    _quantityController.dispose();
    super.dispose();
  }
}
