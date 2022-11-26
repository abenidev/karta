import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class HomeScreen extends ConsumerWidget {
  HomeScreen({super.key});

  final EdgeInsetsGeometry customPadding = EdgeInsets.symmetric(horizontal: 5.w);
  EdgeInsetsGeometry lessonCardMargin(int index) => index == 0 ? EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h, bottom: 3.h) : EdgeInsets.only(right: 5.w, top: 3.h, bottom: 3.h);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: Container(
            decoration: const BoxDecoration(),
            child: ListView(
              children: [
                SizedBox(height: 5.h),
                Padding(
                  padding: customPadding,
                  child: Text(
                    'Good morning,\nAshley!',
                    style: GoogleFonts.montserrat(
                      textStyle: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                Padding(
                  padding: customPadding,
                  child: Text(
                    'Your lessons',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w400, color: Colors.grey),
                    ),
                  ),
                ),
                SizedBox(height: 2.h),
                SizedBox(
                  width: 100.w,
                  height: 40.h,
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemCount: 30,
                    itemBuilder: (context, index) => LessonCard(
                      margin: lessonCardMargin(index),
                    ),
                  ),
                ),
                const Divider(),
                Padding(
                  padding: customPadding,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Discover new things to learn',
                        style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 15.sp)),
                      ),
                      TextButton(
                        onPressed: () {},
                        child: Text(
                          'See all',
                          style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 15.sp, color: Colors.orange)),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LessonCard extends StatelessWidget {
  const LessonCard({super.key, required this.margin});
  final EdgeInsetsGeometry margin;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: 45.w,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.4), offset: const Offset(2, 7), blurRadius: 10.0),
        ],
      ),
      child: Column(
        children: [
          Container(
            decoration: const BoxDecoration(),
            height: 27.h,
            width: 45.w,
            child: const ClipRRect(
              borderRadius: BorderRadius.only(topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
              child: Image(image: AssetImage('assets/pencil.jpg'), fit: BoxFit.fill),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Text(
              '50 most common French verbs 50 most common French verbs 50 most common French verbs',
              maxLines: 2,
              style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }
}
