import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:karta/components/common/loading_indicator.dart';
import 'package:karta/constants/colors.dart';
import 'package:karta/models/question.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../providers/questions_provider.dart';

final loadingStateProvider = StateProvider<bool>((ref) => true);
final bottomNavBarIndexStateProvider = StateProvider<int>((ref) => 0);

class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  void changeBottomNavBarIndexState(int newIndex, WidgetRef ref) {
    ref.read(bottomNavBarIndexStateProvider.notifier).state = newIndex;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bottomNavBarIndex = ref.watch(bottomNavBarIndexStateProvider);
    final isLoading = ref.watch(loadingStateProvider);
    final futureQuestions = ref.watch(questionsFutureProvider);

    return Scaffold(
      floatingActionButton: isLoading ? null : FloatingActionButton(onPressed: () {}, child: const Icon(Icons.add, color: Colors.white)),
      bottomNavigationBar: isLoading
          ? null
          : BottomNavigationBar(
              type: BottomNavigationBarType.fixed,
              onTap: (value) => changeBottomNavBarIndexState(value, ref),
              currentIndex: bottomNavBarIndex,
              unselectedItemColor: Colors.grey.withOpacity(0.5),
              selectedItemColor: Colors.black54,
              showSelectedLabels: false,
              showUnselectedLabels: false,
              items: const [
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Quiz'),
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Topics'),
                BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Setting'),
              ],
            ),
      body: Container(
        height: 100.h,
        width: 100.w,
        decoration: const BoxDecoration(color: Colors.white),
        child: SafeArea(
          child: futureQuestions.when(
            data: (data) {
              // debugPrint(data[0].toString());

              return HomeComponent();
            },
            loading: () => Center(child: LoadingIndicator(size: 8.w)),
            error: (error, stackTrace) => Center(child: Text('Something went wrong: $error \nStackTrace: $stackTrace')),
          ),
        ),
      ),
    );
  }
}

//!
//!
//!

class HomeComponent extends ConsumerWidget {
  HomeComponent({super.key});

  final EdgeInsetsGeometry customPadding = EdgeInsets.symmetric(horizontal: 5.w);
  EdgeInsetsGeometry lessonCardMargin(int index) => index == 0 ? EdgeInsets.only(left: 5.w, right: 5.w, top: 3.h, bottom: 3.h) : EdgeInsets.only(right: 5.w, top: 3.h, bottom: 3.h);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    List<Question> questions = ref.watch(questionNotifierProvider);

    return Container(
      decoration: const BoxDecoration(),
      child: NotificationListener<OverscrollIndicatorNotification>(
        onNotification: (notification) {
          notification.disallowIndicator();
          return true;
        },
        child: ListView(
          children: [
            SizedBox(height: 5.h),
            Padding(
              padding: customPadding,
              child: Text(
                'Good morning,\nAbenezer!',
                style: GoogleFonts.montserrat(
                  textStyle: TextStyle(fontSize: 24.sp, fontWeight: FontWeight.w400),
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Padding(
              padding: customPadding,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Your lessons',
                    style: GoogleFonts.lato(
                      textStyle: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w400, color: Colors.grey),
                    ),
                  ),
                  CustomTextButton(label: 'See all', ontap: () {}),
                ],
              ),
            ),
            SizedBox(height: 2.h),
            SizedBox(
              width: 100.w,
              height: 20.h,
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                itemCount: questions.length,
                itemBuilder: (context, index) => LessonCard(
                  ontap: () {},
                  margin: lessonCardMargin(index),
                  // cardTitle: 'General Programming',
                  cardTitle: questions[index].category,
                  // cardDescription: '50 most common French verbs 50 most common French verbs 50 most common French verbs',
                  cardDescription: questions[index].question,
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
                  CustomTextButton(label: 'See all', ontap: () {}),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({super.key, required this.label, required this.ontap});
  final Function() ontap;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(5.0),
        onTap: ontap,
        child: Padding(
          padding: const EdgeInsets.all(5.0),
          child: Text(
            label,
            style: GoogleFonts.lato(
              textStyle: TextStyle(fontSize: 15.sp, color: Colors.orange),
            ),
          ),
        ),
      ),
    );
  }
}

class LessonCard extends StatelessWidget {
  LessonCard({super.key, required this.margin, required this.cardDescription, required this.cardTitle, required this.ontap});
  final EdgeInsetsGeometry margin;
  final String cardTitle;
  final String cardDescription;
  final Function() ontap;
  final Random random = Random();

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      width: 45.w,
      decoration: BoxDecoration(
        color: MyColors.colorsList[random.nextInt(3)],
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.4), offset: const Offset(2, 7), blurRadius: 10.0),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(10),
          onTap: ontap,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  cardTitle,
                  maxLines: 1,
                  style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  cardDescription,
                  maxLines: 3,
                  style: GoogleFonts.lato(textStyle: TextStyle(fontSize: 15.sp, fontWeight: FontWeight.w500)),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
