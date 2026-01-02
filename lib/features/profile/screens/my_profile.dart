import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/widgets/common/app_text_field.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';
import '../../users/users/widgets/gender_selection.dart';
import '../../users/users/widgets/photo_upload_selection.dart';

class MyProfileScreen extends StatefulWidget {
  const MyProfileScreen({super.key});

  @override
  State<MyProfileScreen> createState() => _MyProfileScreenState();
}

class _MyProfileScreenState extends State<MyProfileScreen> {
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _drawerExpanded = true;
  String _selectedGender = 'Female';
  String? _selectedRole;
  String? _selectedService;
  File? _selectedImage;
  bool _isPasswordVisible = false;

  // Controllers
  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _matriculeController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  // Demonstration data
  final int projectsAsHead = 2;
  final int finishedTasks = 13;

  @override
  void initState() {
    super.initState();
    _initializeData();
  }

  void _initializeData() {
    // Initialize with demonstration data
    _fullNameController.text = 'Jane Doe';
    _birthdayController.text = '1990-01-01';
    _locationController.text = 'New York, USA';
    _emailController.text = 'jane.doe@example.com';
    _matriculeController.text = 'EMP001';
    _phoneController.text = '655555555';
    _addressController.text = '123 Main Street';
    _passwordController.text = '0000';
    _selectedGender = 'Female';
    _selectedRole = 'Chef de projet';
    _selectedService = 'IT Department';
  }

  Future<void> _pickImage() async {
    try {
      final XFile? image = await ImagePicker().pickImage(
        source: ImageSource.gallery,
        maxWidth: 800,
        maxHeight: 800,
        imageQuality: 85,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
      }
    } catch (e) {
      Get.snackbar(
        'Error',
        'Unable to select image: ${e.toString()}',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  Future<void> _selectDate() async {
    final DateTime? picked = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthdayController.text =
            "${picked.year}-${picked.month.toString().padLeft(2, '0')}-${picked.day.toString().padLeft(2, '0')}";
      });
    }
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Save profile data
      print('Full Name: ${_fullNameController.text}');
      print('Gender: $_selectedGender');
      print('Birthday: ${_birthdayController.text}');
      print('Location: ${_locationController.text}');
      print('Email: ${_emailController.text}');
      print('Matricule: ${_matriculeController.text}');
      print('Phone: ${_phoneController.text}');
      print('Address: ${_addressController.text}');
      print('Role: $_selectedRole');
      print('Service: $_selectedService');
      print('Password: ${_passwordController.text}');

      // Show success message
      Get.snackbar(
        'Success',
        'Profile updated successfully',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    }
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
            if (isDesktop && _drawerExpanded)
              Container(width: 280, child: const AppDrawer()),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    HeaderPage(
                      title: 'My Profile',
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
                          // Header with statistics
                          _buildStatsHeader(context),
                          SizedBox(height: context.lg),

                          // Profile form
                          Card(
                            elevation: 4,
                            child: Padding(
                              padding: EdgeInsets.all(context.lg),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'My Profile',
                                      style: TextStyle(
                                        fontSize: context.fontSizeLg * 1.5,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    SizedBox(height: context.lg),

                                    if (!isDesktop) ...[
                                      _buildProfileSection(context),
                                      SizedBox(height: context.lg),
                                    ],

                                    Text(
                                      'Personal Information',
                                      style: TextStyle(
                                        fontSize: context.fontSizeLg,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    SizedBox(height: context.md),

                                    if (isDesktop) ...[
                                      _buildDesktopForm(context),
                                    ] else ...[
                                      _buildMobileForm(context),
                                    ],

                                    SizedBox(height: context.xl),

                                    // Save Changes Button
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          onPressed: _saveProfile,
                                          style: ElevatedButton.styleFrom(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: context.xl,
                                              vertical: context.md,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          child: const Text('Save Changes'),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
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

  Widget _buildStatsHeader(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1200;
    final isMobile = MediaQuery.of(context).size.width < 768;

    return Card(
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.all(isMobile ? context.md : context.lg),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // User info row
            Row(
              children: [
                if (!isDesktop || isMobile)
                  Container(
                    width: isMobile ? 50 : 60,
                    height: isMobile ? 50 : 60,
                    margin: EdgeInsets.only(right: context.md),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: Colors.grey.shade200,
                    ),
                    child: _selectedImage != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              _selectedImage!,
                              fit: BoxFit.cover,
                            ),
                          )
                        : Icon(
                            Icons.person,
                            size: isMobile ? 30 : 40,
                            color: Colors.grey,
                          ),
                  ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jane Doe',
                        style: TextStyle(
                          fontSize: isMobile
                              ? context.fontSizeMd
                              : context.fontSizeLg,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Project Manager',
                        style: TextStyle(
                          fontSize: isMobile
                              ? context.fontSizeSm
                              : context.fontSizeMd,
                          color: Colors.grey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),

            SizedBox(height: isMobile ? context.md : context.lg),

            // Stats cards row
            isMobile
                ? Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: _buildStatCard(
                              '$projectsAsHead',
                              'Project(s) as head',
                              context,
                            ),
                          ),
                          SizedBox(width: context.sm),
                          Expanded(
                            child: _buildStatCard(
                              '$finishedTasks',
                              'Finished task(s)',
                              context,
                            ),
                          ),
                        ],
                      ),
                    ],
                  )
                : Row(
                    children: [
                      Expanded(
                        flex: 1,
                        child: _buildStatCard(
                          '$projectsAsHead',
                          'Project(s) as head',
                          context,
                        ),
                      ),
                      SizedBox(width: context.md),
                      Expanded(
                        flex: 1,
                        child: _buildStatCard(
                          '$finishedTasks',
                          'Finished task(s)',
                          context,
                        ),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatCard(String value, String label, BuildContext context) {
    return Flexible(
      child: Container(
        constraints: BoxConstraints(minWidth: 100),
        padding: EdgeInsets.all(context.sm),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey.shade300),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                value,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            SizedBox(height: 4),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Text(
                label,
                style: TextStyle(fontSize: 10, color: Colors.grey),
                maxLines: 2,
                textAlign: TextAlign.center,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProfileSection(BuildContext context) {
    return Column(
      children: [
        PhotoUploadSection(
          onUploadPressed: _pickImage,
          selectedImage: _selectedImage,
        ),
        SizedBox(height: context.md),
        GenderSelection(
          selectedGender: _selectedGender,
          onGenderChanged: (value) {
            setState(() {
              _selectedGender = value;
            });
          },
        ),
      ],
    );
  }

  Widget _buildDesktopForm(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              _buildProfileSection(context),
              SizedBox(height: context.lg),
              AppTextField(
                enabled: false,
                label: _selectedService,
                icon: Icons.work_outlined,
              ),
              SizedBox(height: context.md),
              AppTextField(
                controller: _birthdayController,
                label: 'Birthday',
                hint: 'YYYY-MM-DD',
                icon: Icons.calendar_today_outlined,
                onTap: () => _selectDate(),
              ),
              SizedBox(height: context.md),
              AppTextField(
                controller: _matriculeController,
                label: 'Matricule',
                hint: 'Matricule',
                icon: Icons.badge_outlined,
              ),
              SizedBox(height: context.md),
              AppTextField(
                controller: _addressController,
                label: 'Address',
                hint: 'Address',
                icon: Icons.location_on_outlined,
              ),
            ],
          ),
        ),
        SizedBox(width: context.lg),
        Expanded(
          child: Column(
            children: [
              AppTextField(
                controller: _fullNameController,
                label: 'Full Name',
                hint: 'Full Name',
                icon: Icons.person_outlined,
                validator: (value) => AppValidator.validateFullName(value),
              ),
              SizedBox(height: context.md),
              AppTextField(
                controller: _emailController,
                label: 'Email',
                hint: 'Email address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => AppValidator.validateEmail(value),
              ),
              SizedBox(height: context.md),
              AppTextField(
                controller: _phoneController,
                label: 'Phone',
                hint: 'Phone number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) => AppValidator.validatePhoneNumber(value),
              ),
              SizedBox(height: context.md),
              AppTextField(
                controller: _locationController,
                label: 'Location',
                hint: 'Location',
                icon: Icons.place_outlined,
              ),
              SizedBox(height: context.md),
              AppTextField(
                enabled: false,
                label: _selectedRole,
                icon: Icons.badge_outlined,
              ),
              SizedBox(height: context.md),
              AppTextField(
                controller: _passwordController,
                label: 'Password',
                hint: 'Password',
                icon: Icons.lock_outline,
                obscureText: !_isPasswordVisible,
                showPasswordToggle: true,
                isPasswordVisible: _isPasswordVisible,
                onTogglePassword: () {
                  setState(() {
                    _isPasswordVisible = !_isPasswordVisible;
                  });
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildMobileForm(BuildContext context) {
    return Column(
      children: [
        AppTextField(
          controller: _fullNameController,
          label: 'Full Name',
          hint: 'Full Name',
          icon: Icons.person_outlined,
          validator: (value) => AppValidator.validateFullName(value),
        ),
        SizedBox(height: context.md),
        AppTextField(
          controller: _emailController,
          label: 'Email',
          hint: 'Email address',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => AppValidator.validateEmail(value),
        ),
        SizedBox(height: context.md),
        AppTextField(
          controller: _phoneController,
          label: 'Phone',
          hint: 'Phone number',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) => AppValidator.validatePhoneNumber(value),
        ),
        SizedBox(height: context.md),
        AppTextField(
          controller: _birthdayController,
          label: 'Birthday',
          hint: 'YYYY-MM-DD',
          icon: Icons.calendar_today_outlined,
          onTap: () => _selectDate(),
        ),
        SizedBox(height: context.md),
        AppTextField(
          controller: _locationController,
          label: 'Location',
          hint: 'Location',
          icon: Icons.place_outlined,
        ),
        SizedBox(height: context.md),
        AppTextField(
          controller: _matriculeController,
          label: 'Matricule',
          hint: 'Matricule',
          icon: Icons.badge_outlined,
        ),
        SizedBox(height: context.md),
        AppTextField(
          controller: _addressController,
          label: 'Address',
          hint: 'Address',
          icon: Icons.location_on_outlined,
        ),
        SizedBox(height: context.md),
        AppTextField(
          enabled: false,
          label: _selectedRole,
          icon: Icons.badge_outlined,
        ),
        SizedBox(height: context.md),
        AppTextField(
          enabled: false,
          label: _selectedService,
          icon: Icons.work_outlined,
        ),
        SizedBox(height: context.md),
        AppTextField(
          controller: _passwordController,
          label: 'Password',
          hint: 'Password',
          icon: Icons.lock_outline,
          obscureText: !_isPasswordVisible,
          showPasswordToggle: true,
          isPasswordVisible: _isPasswordVisible,
          onTogglePassword: () {
            setState(() {
              _isPasswordVisible = !_isPasswordVisible;
            });
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    _fullNameController.dispose();
    _birthdayController.dispose();
    _locationController.dispose();
    _emailController.dispose();
    _matriculeController.dispose();
    _phoneController.dispose();
    _addressController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
}
