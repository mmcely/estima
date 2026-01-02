import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../core/utils/validators.dart';
import '../../../../core/responsive/responsive_extensions.dart';
import '../../../../core/widgets/common/app_dropdown.dart';
import '../../../../core/widgets/common/app_text_field.dart';
import '../../../../core/widgets/common/loaders.dart';
import '../../../../core/widgets/shared/drawer.dart';
import '../../../../core/widgets/shared/header_page.dart';
import '../../../../state/auth_controller.dart';
import '../../../../services/selection_service.dart';
import '../widgets/gender_selection.dart';
import '../widgets/photo_upload_selection.dart';

class AddUserScreen extends StatefulWidget {
  const AddUserScreen({super.key});

  @override
  State<AddUserScreen> createState() => _AddUserScreenState();
}

class _AddUserScreenState extends State<AddUserScreen> {
  final AuthController authController =
      GetInstance().isRegistered<AuthController>()
      ? Get.find<AuthController>()
      : Get.put(AuthController());
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  final _formKey = GlobalKey<FormState>();
  bool _drawerExpanded = true;
  String _selectedGender = 'Female';
  String? _selectedRole;
  String? _selectedService;
  File? _selectedImage;

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
      AppLoaders.errorSnackBar(
        title: 'Error',
        message: 'Unable to select image: ${e.toString()}',
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
                      title: 'Create a new user',
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
                        child: Padding(
                          padding: EdgeInsets.all(context.lg),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Add a user',
                                  style: TextStyle(
                                    fontSize: context.fontSizeLg * 1.5,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                SizedBox(height: context.lg),
                                if (!isDesktop) ...[
                                  PhotoUploadSection(
                                    onUploadPressed: _pickImage,
                                    selectedImage: _selectedImage,
                                  ),
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

  Widget _buildDesktopForm(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Column(
            children: [
              PhotoUploadSection(
                onUploadPressed: _pickImage,
                selectedImage: _selectedImage,
              ),
              SizedBox(height: context.lg),
              GenderSelection(
                selectedGender: _selectedGender,
                onGenderChanged: (value) {
                  setState(() {
                    _selectedGender = value;
                  });
                },
              ),
              SizedBox(height: context.md),
              AppDropdown(
                label: 'Service',
                hint: 'Select service',
                icon: Icons.work_outlined,
                value: _selectedService,
                items: SelectionService.getUserServices(),
                onChanged: (value) {
                  setState(() {
                    _selectedService = value;
                  });
                },
              ),
            ],
          ),
        ),
        SizedBox(width: context.lg),
        Expanded(
          child: Column(
            children: [
              AppTextField(
                label: 'Full Name',
                hint: 'Full Name',
                icon: Icons.person_outlined,
                validator: (value) => AppValidator.validateFullName(value),
              ),
              SizedBox(height: context.md),
              AppTextField(
                label: 'Email',
                hint: 'Email address',
                icon: Icons.email_outlined,
                keyboardType: TextInputType.emailAddress,
                validator: (value) => AppValidator.validateEmail(value),
              ),
              SizedBox(height: context.md),
              AppTextField(
                label: 'Phone',
                hint: 'Phone number',
                icon: Icons.phone_outlined,
                keyboardType: TextInputType.phone,
                validator: (value) => AppValidator.validatePhoneNumber(value),
              ),
              SizedBox(height: context.md),
              AppDropdown(
                label: 'Role',
                hint: 'Select role',
                icon: Icons.badge_outlined,
                value: _selectedRole,
                items: SelectionService.getUserRoles(),
                onChanged: (value) {
                  setState(() {
                    _selectedRole = value;
                  });
                },
              ),
              SizedBox(height: context.md),
              AppTextField(
                label: 'Password',
                hint: 'Password',
                icon: Icons.lock_outline,
                validator: (value) => AppValidator.validatePassword(value),
                obscureText: true,
                showPasswordToggle: true,
                isPasswordVisible: !authController.obscurePassword.value,
                onTogglePassword: () =>
                    authController.togglePasswordVisibility(),
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
          label: 'Full Name',
          hint: 'Full Name',
          icon: Icons.person_outlined,
          validator: (value) => AppValidator.validateFullName(value),
        ),
        SizedBox(height: context.md),
        AppTextField(
          label: 'Email',
          hint: 'Email address',
          icon: Icons.email_outlined,
          keyboardType: TextInputType.emailAddress,
          validator: (value) => AppValidator.validateEmail(value),
        ),
        SizedBox(height: context.md),
        AppTextField(
          label: 'Phone',
          hint: 'Phone number',
          icon: Icons.phone_outlined,
          keyboardType: TextInputType.phone,
          validator: (value) => AppValidator.validatePhoneNumber(value),
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
        SizedBox(height: context.md),
        AppDropdown(
          label: 'Role',
          hint: 'Select role',
          icon: Icons.badge_outlined,
          value: _selectedRole,
          items: SelectionService.getUserRoles(),
          onChanged: (value) {
            setState(() {
              _selectedRole = value;
            });
          },
        ),
        SizedBox(height: context.md),
        AppDropdown(
          label: 'Service',
          hint: 'Select service',
          icon: Icons.work_outlined,
          value: _selectedService,
          items: SelectionService.getUserServices(),
          onChanged: (value) {
            setState(() {
              _selectedService = value;
            });
          },
        ),
        SizedBox(height: context.md),
        AppTextField(
          label: 'Password',
          hint: 'Password',
          icon: Icons.lock_outline,
          validator: (value) => AppValidator.validatePassword(value),
          obscureText: true,
          showPasswordToggle: true,
          isPasswordVisible: !authController.obscurePassword.value,
          onTogglePassword: () => authController.togglePasswordVisibility(),
        ),
      ],
    );
  }
}
