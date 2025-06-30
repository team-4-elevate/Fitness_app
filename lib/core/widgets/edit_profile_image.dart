// core/widgets/edit_profile_image.dart
import 'dart:io';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class EditprofileImage extends StatefulWidget {
  final bool? isEditButton;

  const EditprofileImage({
    super.key,
    this.isEditButton,
  });

  @override
  State<EditprofileImage> createState() => _EditprofileImageState();
}

class _EditprofileImageState extends State<EditprofileImage> {
  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? pickedImage = await _picker.pickImage(source: source);
      if (pickedImage != null) {
        setState(() {
          _selectedImage = File(pickedImage.path);
        });
      }
    } catch (e) {
      debugPrint('Error picking image: $e');
    }
  }

  void _showImageSourceOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceDark,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20.r),
            topRight: Radius.circular(20.r),
          ),
        ),
        padding: EdgeInsets.symmetric(vertical: 16.r),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.r,
              height: 5.r,
              decoration: BoxDecoration(
                color: Colors.grey.shade600,
                borderRadius: BorderRadius.circular(5.r),
              ),
              margin: EdgeInsets.only(bottom: 16.r),
            ),
            Text(
              'Select Image from',
              style: TextStyle(
                color: Colors.white,
                fontSize: 18.r,
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: 20.r),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _buildOptionItem(
                  icon: Icons.photo_library_outlined,
                  label: 'Gallery',
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.gallery);
                  },
                ),
                _buildOptionItem(
                  icon: Icons.camera_alt_outlined,
                  label: 'Camera',
                  onTap: () {
                    Navigator.of(context).pop();
                    _pickImage(ImageSource.camera);
                  },
                ),
              ],
            ),
            SizedBox(height: 20.r),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionItem(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15.r),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.all(16.r),
            decoration: BoxDecoration(
              color: AppColors.primaryOrange.withOpacity(0.2),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              color: AppColors.white,
              size: 28.r,
            ),
          ),
          SizedBox(height: 8.r),
          Text(
            label,
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.r,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: AppColors.primaryOrange.withOpacity(0.3),
                spreadRadius: 10,
                blurRadius: 15,
              ),
            ],
          ),
          child: CircleAvatar(
            radius: 60.r,
            backgroundImage: _selectedImage != null
                ? FileImage(_selectedImage!)
                : const AssetImage('assets/images/onboarding_vector_3.png')
                    as ImageProvider,
          ),
        ),
        widget.isEditButton == true
            ? GestureDetector(
                onTap: () => _showImageSourceOptions(context),
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: AppColors.primaryOrange,
                        width: 3.r,
                      )),
                  child: Icon(
                    Icons.edit_outlined,
                    size: 24.r,
                    color: AppColors.primaryOrange,
                  ),
                ),
              )
            : Container(),
      ],
    );
  }
}
