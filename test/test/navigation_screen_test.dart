import 'package:fitness_app/features/app_sections/ChatAipage.dart';
import 'package:fitness_app/features/app_sections/HomePage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:fitness_app/main.dart';


void main() {
  testWidgets('Initial page is HomePage and navigation works', (WidgetTester tester) async {
    // 1. شغل التطبيق
    await tester.pumpWidget(MyApp());

    // 2. اتأكد إن الصفحة اللي ظاهرة أول ما التطبيق يشتغل هي HomePage
    expect(find.byType(HomePage), findsOneWidget);

    // 3. اضغط على أيقونة "Chat" (التانية)
    final chatIcon = find.byWidgetPredicate(
      (widget) =>
          widget is Image &&
          widget.image is AssetImage &&
          (widget.image as AssetImage).assetName.contains('chat_ai'),
    );
    expect(chatIcon, findsOneWidget);

    await tester.tap(chatIcon);
    await tester.pumpAndSettle();

    // 4. اتأكد إن الصفحة اتغيرت لـ ChatAipage
    expect(find.byType(ChatAipage), findsOneWidget);
    expect(find.text("Chat"), findsOneWidget);
    expect(find.text("Home"), findsNothing);
    expect(find.text("Gym"), findsNothing);
    expect(find.text("Profile"), findsNothing);
    

  });
}