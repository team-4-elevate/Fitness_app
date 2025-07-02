import 'package:fitness_app/core/responsive/responsive_design.dart';
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class ProfileCustomRow extends StatefulWidget {
  final String title;
  final IconData icon;
  final bool isToggleSwitch;
  final bool initialToggleValue;
  final VoidCallback? onTap;
  final Function(bool)? onToggleChanged;

  const ProfileCustomRow({
    super.key,
    required this.title,
    required this.icon,
    this.isToggleSwitch = false,
    this.initialToggleValue = false,
    this.onTap,
    this.onToggleChanged,
  });

  @override
  State<ProfileCustomRow> createState() => _ProfileCustomRowState();
}

class _ProfileCustomRowState extends State<ProfileCustomRow> {
  late bool _isToggled;

  @override
  void initState() {
    super.initState();
    _isToggled = widget.initialToggleValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GestureDetector(
          onTap: widget.isToggleSwitch
              ? () {
                  setState(() {
                    _isToggled = !_isToggled;
                  });
                  widget.onToggleChanged?.call(_isToggled);
                }
              : () => widget.onTap?.call(),
          behavior: HitTestBehavior.opaque,
          child: Row(
            children: [
              Icon(widget.icon, color: AppColors.primaryOrange, size: 30.r),
              R.spaceW16,
              Expanded(
                child: Text(
                  widget.title,
                  style: context.textTheme.bodyLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              widget.isToggleSwitch
                  ? IgnorePointer(
                      child: Switch(
                        value: _isToggled,
                        onChanged: null,
                        activeColor: AppColors.primaryOrange,
                        activeTrackColor: AppColors.white,
                        inactiveThumbColor: AppColors.primaryOrange,
                        inactiveTrackColor: Colors.grey.withOpacity(0.3),
                      ),
                    )
                  : Icon(
                      Icons.arrow_forward_ios_rounded,
                      color: AppColors.primaryOrange,
                      size: 25.r,
                    ),
            ],
          ),
        ).paddingSymmetric(vertical: 8.r),
        Divider(color: AppColors.textSecondary.withOpacity(.3)),
      ],
    );
  }
}
