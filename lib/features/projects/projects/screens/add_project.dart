import 'package:flutter/material.dart';
import '../../../../core/utils/validators.dart';
import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/widgets/common/app_text_field.dart';
import '../../../../core/widgets/common/app_dropdown.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';
import '../../../../services/selection_service.dart';

class AddProjectScreen extends StatefulWidget {
  const AddProjectScreen({super.key});

  @override
  State<AddProjectScreen> createState() => _AddProjectScreenState();
}

class _AddProjectScreenState extends State<AddProjectScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _drawerExpanded = true;

  // Dropdown variables
  String? _selectedHead;
  String? _selectedStatus;
  DateTime? _startDate;
  DateTime? _endDate;

  // Data
  List<String> _heads = [];
  List<String> _statuses = [];

  // Controllers
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _startDateController = TextEditingController();
  final TextEditingController _endDateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    setState(() {
      _heads = SelectionService.getHeads();
      _statuses = SelectionService.getProjectStatuses();
      _selectedHead = _heads[0];
      _selectedStatus = _statuses[0];
      _startDate = DateTime.now();
      _endDate = DateTime.now().add(const Duration(days: 30));
      _updateDateControllers();
    });
  }

  void _updateDateControllers() {
    _startDateController.text = _startDate != null
        ? '${_startDate!.year}-${_startDate!.month.toString().padLeft(2, '0')}-${_startDate!.day.toString().padLeft(2, '0')}'
        : '';

    _endDateController.text = _endDate != null
        ? '${_endDate!.year}-${_endDate!.month.toString().padLeft(2, '0')}-${_endDate!.day.toString().padLeft(2, '0')}'
        : '';
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: isStartDate
          ? (_startDate ?? DateTime.now())
          : (_endDate ?? DateTime.now()),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Theme.of(context).primaryColor,
              onPrimary: Theme.of(context).colorScheme.onPrimary,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          _startDate = picked;
          if (_endDate != null && _endDate!.isBefore(picked)) {
            _endDate = picked.add(const Duration(days: 1));
          }
        } else {
          _endDate = picked;
        }
        _updateDateControllers();
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
                      title: 'Create a new project',
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
                                  'Add New Project',
                                  style: theme.textTheme.titleLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: context.lg),

                                // Head dropdown
                                AppDropdown(
                                  label: 'Head of Project *',
                                  hint: 'Select the head of project',
                                  icon: Icons.person_outlined,
                                  value: _selectedHead,
                                  items: _heads,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedHead = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null || value == _heads[0]) {
                                      return 'Project head is required';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: context.md),

                                // Title input
                                AppTextField(
                                  controller: _titleController,
                                  label: 'Project Title *',
                                  hint: 'Title of project',
                                  icon: Icons.title_outlined,
                                  validator: (value) =>
                                      AppValidator.validateTitleText(value),
                                ),
                                SizedBox(height: context.md),

                                // Date pickers
                                Text(
                                  'Project Timeline',
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 8),
                                if (isDesktop)
                                  Row(
                                    children: [
                                      Expanded(
                                        child: _buildDateField(
                                          context: context,
                                          label: 'Start Date *',
                                          controller: _startDateController,
                                          onTap: () =>
                                              _selectDate(context, true),
                                        ),
                                      ),
                                      SizedBox(width: context.md),
                                      Expanded(
                                        child: _buildDateField(
                                          context: context,
                                          label: 'End Date *',
                                          controller: _endDateController,
                                          onTap: () =>
                                              _selectDate(context, false),
                                        ),
                                      ),
                                    ],
                                  )
                                else ...[
                                  _buildDateField(
                                    context: context,
                                    label: 'Start Date *',
                                    controller: _startDateController,
                                    onTap: () => _selectDate(context, true),
                                  ),
                                  SizedBox(height: context.md),
                                  _buildDateField(
                                    context: context,
                                    label: 'End Date *',
                                    controller: _endDateController,
                                    onTap: () => _selectDate(context, false),
                                  ),
                                  SizedBox(height: context.md),
                                ],
                                SizedBox(height: context.md),
                                // Status dropdown
                                AppDropdown(
                                  label: 'Project Status *',
                                  hint: 'Select the status of project',
                                  icon: Icons.flag_outlined,
                                  value: _selectedStatus,
                                  items: _statuses,
                                  onChanged: (value) {
                                    setState(() {
                                      _selectedStatus = value;
                                    });
                                  },
                                  validator: (value) {
                                    if (value == null ||
                                        value == _statuses[0]) {
                                      return 'Project status is required';
                                    }
                                    return null;
                                  },
                                ),
                                SizedBox(height: context.md),

                                // Description
                                AppTextField(
                                  controller: _descriptionController,
                                  label: 'Description',
                                  hint: 'Description of the project',
                                  icon: Icons.description_outlined,
                                  maxLines: 4,
                                ),
                                SizedBox(height: context.xl),

                                // Summary Card
                                _buildSummaryCard(context),
                                SizedBox(height: context.lg),

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
                                        child: Text('Create Project'),
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

  Widget _buildDateField({
    required BuildContext context,
    required String label,
    required TextEditingController controller,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: 8),
        GestureDetector(
          onTap: onTap,
          child: AbsorbPointer(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: 'YYYY-MM-DD',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(8.0),
                ),
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 14,
                ),
                prefixIcon: Icon(
                  Icons.calendar_today,
                  color: theme.iconTheme.color,
                ),
                suffixIcon: Icon(
                  Icons.arrow_drop_down,
                  color: theme.iconTheme.color,
                ),
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'This field is required';
                }
                return null;
              },
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSummaryCard(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      child: Padding(
        padding: EdgeInsets.all(context.md),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(Icons.summarize, color: theme.primaryColor),
                SizedBox(width: 8),
                Text(
                  'Project Summary',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: context.sm),
            Divider(),
            SizedBox(height: context.sm),
            _buildSummaryRow('Head', _selectedHead ?? 'Not selected', context),
            _buildSummaryRow(
              'Title',
              _titleController.text.isNotEmpty
                  ? _titleController.text
                  : 'Not entered',
              context,
            ),
            _buildSummaryRow('Start Date', _startDateController.text, context),
            _buildSummaryRow('End Date', _endDateController.text, context),
            _buildSummaryRow(
              'Status',
              _selectedStatus ?? 'Not selected',
              context,
            ),
            if (_descriptionController.text.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: context.sm),
                  Text(
                    'Description:',
                    style: theme.textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(height: 4),
                  Text(
                    _descriptionController.text,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, String value, BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 2,
            child: Text(
              '$label:',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Text(value, style: theme.textTheme.bodyMedium),
          ),
        ],
      ),
    );
  }
}
