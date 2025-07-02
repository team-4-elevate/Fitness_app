// features/home/presentation/widgets/category_section.dart
import 'package:fitness_app/core/utils/app_extensions.dart';
import 'package:flutter/material.dart';

class CategorySection extends StatelessWidget {
  final List<Map<String, dynamic>> categories;
 final void Function()? onTap;

 const CategorySection({super.key, required this.categories, this.onTap});
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(left: 4.r, bottom: 16.r),
          child: Text(
            'Category',
            style: Theme.of(context).textTheme.titleLarge,
          ),
        ),
        //--------------------------------------------------- Category list
        Container(
          decoration: BoxDecoration(
            color: Colors.black.withOpacity(0.3),
            borderRadius: BorderRadius.circular(16.r),
          ),
          child: Container(
            margin: EdgeInsets.all(4.r),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(12.r),
            ),
            constraints: BoxConstraints(minHeight: 90.r, maxHeight: 110.r),
            child: Padding(
              padding: EdgeInsets.symmetric(vertical: 10.r),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                // ------------------------------------------------divider
                separatorBuilder: (context, index) => Padding(
                  padding: EdgeInsets.symmetric(vertical: 5.r),
                  child: VerticalDivider(
                    color: Colors.white.withOpacity(0.2),
                    thickness: 1.r,
                    width: 20.r,
                  ),
                ),
                // ------------------------------------------------itemBuilder
                itemBuilder: (context, index) {
                  final String name = categories[index]['name'];
                  final String iconPath = categories[index]['icon'];

                  return GestureDetector(
                    onTap: onTap,
                    child: SizedBox(
                      width: 70.r,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Spacer(flex: 1),
                          //------------------------------------------ Category icon
                          Expanded(
                            flex: 10,
                            child: Image.asset(iconPath, fit: BoxFit.contain),
                          ),

                          const Spacer(flex: 1),

                          //------------------------------------------ Category name
                          Flexible(
                            flex: 3,
                            child: Text(
                              name,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(color: Colors.white),
                              textAlign: TextAlign.center,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
