import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import '../../core/constants/colors.dart';
import '../../core/constants/spacing.dart';
import '../../providers/auth_provider.dart';
import '../../providers/theme_provider.dart';
import '../../services/storage_service.dart';
import '../../widgets/custom_textfield.dart';
import '../../widgets/gradient_button.dart';

class ProfileScreen extends ConsumerStatefulWidget {
  const ProfileScreen({super.key});

  @override
  ConsumerState<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends ConsumerState<ProfileScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _addressController = TextEditingController();
  final _photoUrlController = TextEditingController();
  bool _isLoading = false;
  File? _selectedImage;
  final _storageService = StorageService();

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider);
    if (user != null) {
      _nameController.text = user.displayName ?? '';
      _emailController.text = user.email ?? '';
      _photoUrlController.text = user.photoURL ?? '';
    }
  }

  Future<void> _pickImage() async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);

    if (pickedFile != null) {
      setState(() {
        _selectedImage = File(pickedFile.path);
      });
    }
  }

  Future<void> _updateProfile() async {
    setState(() => _isLoading = true);
    try {
      final user = ref.read(userProvider);
      if (user != null) {
        String? finalPhotoUrl = _photoUrlController.text;

        // Upload local image if selected
        if (_selectedImage != null) {
          final uploadedUrl = await _storageService.uploadProfileImage(_selectedImage!);
          if (uploadedUrl != null) {
            finalPhotoUrl = uploadedUrl;
          }
        }

        await user.updateDisplayName(_nameController.text);
        if (finalPhotoUrl.isNotEmpty) {
          await user.updatePhotoURL(finalPhotoUrl);
        }

        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error updating profile: $e'), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(userProvider);
    final themeMode = ref.watch(themeProvider);
    final isDark = themeMode == ThemeMode.dark;

    ImageProvider? profileImage;
    if (_selectedImage != null) {
      profileImage = FileImage(_selectedImage!);
    } else if (user?.photoURL != null && user!.photoURL!.isNotEmpty) {
      profileImage = NetworkImage(user.photoURL!);
    } else if (_photoUrlController.text.isNotEmpty) {
      profileImage = NetworkImage(_photoUrlController.text);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: Column(
          children: [
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: AppColors.primary.withOpacity(0.1),
                    backgroundImage: profileImage,
                    child: profileImage == null
                        ? const Icon(Icons.person, size: 60, color: AppColors.primary)
                        : null,
                  ),
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: GestureDetector(
                      onTap: _pickImage,
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        decoration: const BoxDecoration(
                          color: AppColors.primary,
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(Icons.camera_alt, color: Colors.white, size: 20),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.xl),
            
            // Theme Toggle Card
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                  )
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(isDark ? Icons.dark_mode : Icons.light_mode, 
                        color: isDark ? AppColors.teal : AppColors.orange),
                      const SizedBox(width: 12),
                      Text(
                        isDark ? 'Dark Mode' : 'Light Mode',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Switch(
                    value: isDark,
                    onChanged: (val) {
                      ref.read(themeProvider.notifier).toggleTheme(val);
                    },
                    activeColor: AppColors.primary,
                  ),
                ],
              ),
            ),
            const SizedBox(height: AppSpacing.lg),

            CustomTextField(
              label: 'Full Name',
              hint: 'Your Name',
              icon: Icons.person_outline,
              controller: _nameController,
            ),
            const SizedBox(height: AppSpacing.md),
            CustomTextField(
              label: 'Email',
              hint: 'Your Email',
              icon: Icons.email_outlined,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
            ),
            const SizedBox(height: AppSpacing.md),
            CustomTextField(
              label: 'Phone Number',
              hint: 'Your Phone (Optional)',
              icon: Icons.phone_outlined,
              controller: _phoneController,
              keyboardType: TextInputType.phone,
            ),
            const SizedBox(height: AppSpacing.md),
            CustomTextField(
              label: 'Address',
              hint: 'Your Address (Optional)',
              icon: Icons.location_on_outlined,
              controller: _addressController,
            ),
            const SizedBox(height: AppSpacing.md),
            CustomTextField(
              label: 'Photo URL',
              hint: 'Link to your profile picture',
              icon: Icons.link,
              controller: _photoUrlController,
            ),
            const SizedBox(height: AppSpacing.xl),
            GradientButton(
              text: 'Save Profile',
              isLoading: _isLoading,
              onPressed: _updateProfile,
            ),
            const SizedBox(height: AppSpacing.xl),
            const Divider(),
            ListTile(
              onTap: () => ref.read(authServiceProvider).signOut(),
              leading: const Icon(Icons.logout, color: Colors.redAccent),
              title: const Text('Sign Out', style: TextStyle(color: Colors.redAccent, fontWeight: FontWeight.bold)),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
            ),
            const SizedBox(height: AppSpacing.xl),
          ],
        ),
      ),
    );
  }
}
