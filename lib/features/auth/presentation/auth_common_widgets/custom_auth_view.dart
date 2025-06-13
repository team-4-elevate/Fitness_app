import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import '../../domain/arguments/auth_pages_ui_arguments.dart';

class CustomAuthScreensView extends StatelessWidget {
  final AuthPagesUiArguments args;
  const CustomAuthScreensView({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
            image: AssetImage('assets/icons/super_fit_logo.png'),
            fit: BoxFit.cover,
          ))),
          BackdropFilter(
            filter: ui.ImageFilter.blur(sigmaX: 8, sigmaY: 8),
            child: Container(color: Colors.black.withOpacity(0.3)),
          ),
          SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Center(
                  child: SizedBox(
                    height: 50,
                    width: 70,
                    child: Image.asset('assets/images/fit 1.png'),
                  ),
                ),
                const SizedBox(height: 80),
                SingleChildScrollView(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        args.firstTitleArguments!.text,
                        style: TextStyle(
                          fontSize: args.firstTitleArguments!.isBold ? 20 : 18,
                          color: Colors.white,
                          fontWeight: args.firstTitleArguments!.isBold
                              ? FontWeight.w800
                              : FontWeight.w400,
                        ),
                      ),
                      const SizedBox(height: 6),
                      Text(
                        args.secondTitleArguments!.text,
                        style: TextStyle(
                          fontSize: args.secondTitleArguments!.isBold ? 20 : 18,
                          color: Colors.white,
                          fontWeight: args.secondTitleArguments!.isBold
                              ? FontWeight.w800
                              : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                ClipRRect(
                  borderRadius: BorderRadius.circular(50),
                  child: BackdropFilter(
                    filter: ui.ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 32,vertical: 24),
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.2),
                      ),
                      child: args.content,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
