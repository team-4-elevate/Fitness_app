// features/home/presentation/widgets/shared_section.dart
import 'package:fitness_app/core/theme/app_colors.dart';
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

enum SectionSize {
  dailyToRecommendations('Daily To Recommendations', 104, 104),
  upcomingWorkouts('Upcoming Workouts', 80, 80),
  recommendationForYou('Recommendation For You', 104, 104),
  popularTraining('popular training', 200, 176);

  final String displayName;
  final double width;
  final double height;

  const SectionSize(this.displayName, this.width, this.height);
}

class SharedSection extends StatefulWidget {
  String sectionTitle;
  final bool showSeeAll;
  final bool isPopularTraining;
  final List<Map<String, dynamic>> recommendations;
  final VoidCallback? onSeeAllPressed;

  SharedSection({
    super.key,
    required this.sectionTitle,
    this.showSeeAll = true,
    this.isPopularTraining = false,
    required this.recommendations,
    this.onSeeAllPressed,
  });

  SectionSize? sectionSizeFromTitle(String sectionTitle) {
    try {
      return SectionSize.values.firstWhere(
        (e) => e.displayName.toLowerCase() == sectionTitle.toLowerCase(),
      );
    } catch (e) {
      for (var size in SectionSize.values) {
        if (size.displayName.toLowerCase().contains(
              sectionTitle.toLowerCase(),
            ) ||
            sectionTitle.toLowerCase().contains(
              size.displayName.toLowerCase(),
            )) {
          return size;
        }
      }
      return SectionSize.recommendationForYou;
    }
  }

  @override
  State<SharedSection> createState() => _SharedSectionState();
}

class _SharedSectionState extends State<SharedSection> {
  @override
  Widget build(BuildContext context) {
    final sectionSize = widget.sectionSizeFromTitle(widget.sectionTitle);
    final width = sectionSize?.width ?? 100.0;
    final height = sectionSize?.height ?? 100.0;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ---------------------------title with seeAll button
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 4.r),
              child: Text(
                sectionSize?.displayName ?? widget.sectionTitle,
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ),
            if (widget.showSeeAll)
              TextButton(
                onPressed: widget.onSeeAllPressed,
                child: Text(
                  'See All',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontSize: 14.r,
                  ),
                ),
              ),
          ],
        ),
        widget.showSeeAll ? const SizedBox.shrink() : SizedBox(height: 8.r),

        // -------------------------------------------------- content
        Container(
          decoration: BoxDecoration(borderRadius: BorderRadius.circular(12.r)),
          height: height.r + 10.r,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,

            itemCount: widget.recommendations.length,
            separatorBuilder: (context, index) => SizedBox(width: 12.r),
            itemBuilder: (context, index) {
              final recommendation = widget.recommendations[index];
              return Container(
                width: width.r,
                height: height.r,
                margin: EdgeInsets.symmetric(vertical: 5.r),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20.r),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8.r,
                      offset: Offset(0, 4.r),
                    ),
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.r),
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: _buildImageWidget(recommendation['image']),
                      ),

                      if (!widget.isPopularTraining) ...[
                        // ----------------------------------------------gray container with text
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: 0,
                          child: Container(
                            height: height.r * 0.4,
                            decoration: BoxDecoration(
                              color: AppColors.surfaceDark.withOpacity(0.5),
                              borderRadius: BorderRadius.all(
                                Radius.circular(height / 2.r),
                              ),
                            ),
                          ),
                        ),

                        // Text at bottom
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: height.r * 0.1,
                          child: Text(
                            recommendation['name'].length > 10
                                ? '${recommendation['name'].substring(0, 10)}...'
                                : recommendation['name'],
                            style: Theme.of(
                              context,
                            ).textTheme.bodyMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.w600,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ] else ...[
                        //-------------------------------- Popular training
                        Positioned(
                          left: 0,
                          right: 0,
                          bottom: height.r * 0.4,
                          child: Text(
                            'Exercises That\nStrengthen Your ${recommendation['name']}',
                            style: Theme.of(
                              context,
                            ).textTheme.titleLarge?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                        Positioned(
                          left: 16.r,
                          bottom: 8.r,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.r,
                              vertical: 6.r,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceDark,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              recommendation['tasks'],
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: Colors.white),
                            ),
                          ),
                        ),

                        Positioned(
                          right: 16.r,
                          bottom: 8.r,
                          child: Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: 12.r,
                              vertical: 6.r,
                            ),
                            decoration: BoxDecoration(
                              color: AppColors.surfaceDark,
                              borderRadius: BorderRadius.circular(20.r),
                            ),
                            child: Text(
                              recommendation['level'],
                              style: Theme.of(context).textTheme.bodyMedium
                                  ?.copyWith(color: AppColors.primaryOrange),
                              textAlign: TextAlign.center,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  //--------------------------------------------------------netwok image
  bool _isNetworkImage(String path) {
    return path.startsWith('http://') || path.startsWith('https://');
  }

  Widget _buildImageWidget(String imagePath) {
    if (_isNetworkImage(imagePath)) {
      return Image.network(
        imagePath,
        fit: BoxFit.cover,
        loadingBuilder: (context, child, loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value:
                  loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
            ),
          );
        },
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.textSecondary,
            child: Center(child: Icon(Icons.broken_image, size: 40)),
          );
        },
      );
    } else {
      return Image.asset(
        imagePath,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Container(
            color: AppColors.textSecondary,
            child: Center(child: Icon(Icons.broken_image, size: 40)),
          );
        },
      );
    }
  }
}
