// features/edit_profile/presentation/view/pages/physical_info_page_view.dart
import 'dart:ui' as ui;

import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:fitness_app/features/edit_profile/domain/entities/physical_info_arguments.dart';
import 'package:fitness_app/features/edit_profile/presentation/view/widgets/activity_level_page.dart';
import 'package:fitness_app/features/edit_profile/presentation/view/widgets/goal_page.dart';
import 'package:fitness_app/features/edit_profile/presentation/view/widgets/weight_page.dart';
import 'package:flutter/material.dart';

enum InfoType { weight, goal, activityLevel }

class PhysicalInfoPageView extends StatefulWidget {
  final InfoType initialPage;
  final dynamic initialInfo;

  const PhysicalInfoPageView({
    super.key,
    required this.initialPage,
    required this.initialInfo,
  });
  
  factory PhysicalInfoPageView.fromArguments(PhysicalInfoArguments args) {
    return PhysicalInfoPageView(
      initialPage: args.infoType,
      initialInfo: args.physicalInfo,
    );
  }

  @override
  State<PhysicalInfoPageView> createState() => _PhysicalInfoPageViewState();
}

class _PhysicalInfoPageViewState extends State<PhysicalInfoPageView> {
  late PageController _pageController;
  late InfoType _currentInfoType;

  String? _selectedGoalId;
  String? _selectedActivityLevelId;
  int _selectedWeight = 90;

  @override
  void initState() {
    super.initState();
    _currentInfoType = widget.initialPage;
    _pageController = PageController(initialPage: widget.initialPage.index);

    if (_currentInfoType == InfoType.weight && widget.initialInfo is int) {
      _selectedWeight = widget.initialInfo;
    } else if (_currentInfoType == InfoType.weight) {
      _selectedWeight = 90;
    }

    if (_currentInfoType == InfoType.goal && widget.initialInfo is String) {
      _selectedGoalId = widget.initialInfo;
    }

    if (_currentInfoType == InfoType.activityLevel &&
        widget.initialInfo is String) {
      _selectedActivityLevelId = widget.initialInfo;
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  String _getTitle() {
    switch (_currentInfoType) {
      case InfoType.weight:
        return 'Edit Weight';
      case InfoType.goal:
        return 'Edit Goal';
      case InfoType.activityLevel:
        return 'Edit Activity Level';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/exercise_btm_background.png'),
                fit: BoxFit.cover,
              ),
            ),
          ),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 4, sigmaY: 4),
            child: Container(color: AppColors.black.withOpacity(0.3)),
          ),
          SafeArea(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: EdgeInsets.all(16.r),
                child: Row(
                  children: [
                    IconButton(
                      icon: const Icon(Icons.arrow_back_ios,
                          color: AppColors.primaryOrange),
                      onPressed: () => Navigator.pop(context),
                    ),
                    SizedBox(width: 8.r),
                    Text(
                      _getTitle(),
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 22.r,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              Expanded(
                child: PageView(
                  controller: _pageController,
                  physics: const NeverScrollableScrollPhysics(),
                  onPageChanged: (index) {
                    setState(() {
                      _currentInfoType = InfoType.values[index];
                    });
                  },
                  children: [
                    WeightPage(
                      initialWeight: _selectedWeight,
                      onWeightChanged: (weight) {
                        _selectedWeight = weight;
                      },
                    ),
                    GoalPage(
                      initialGoalId: _selectedGoalId,
                    ),
                    ActivityLevelPage(
                      initialActivityLevelId: _selectedActivityLevelId,
                    ),
                  ],
                ),
              ),
            ],
          ))
        ],
      ),
    );
  }
}
