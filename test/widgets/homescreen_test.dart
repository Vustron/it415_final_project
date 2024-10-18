// utils
import 'package:babysitterapp/views/main/home.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hugeicons/hugeicons.dart';
import 'package:flutter/material.dart';

void runHomeScreenTest() {
  testWidgets('HomeScreen widget test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MaterialApp(home: HomeScreen()));

    // Verify that the AppBar is present
    expect(find.byType(AppBar), findsOneWidget);

    // Verify the AppBar height
    final AppBar appBar = tester.widget(find.byType(AppBar));
    expect(appBar.toolbarHeight, 80);

    // Verify the AppBar background color
    expect(appBar.backgroundColor, Colors.white);

    // Verify the CircleAvatar is present
    expect(find.byType(CircleAvatar), findsOneWidget);

    // Verify the title text
    expect(find.text('Hello Arvin Sison!'), findsOneWidget);

    // Verify the title text style
    final Text titleText = tester.widget(find.text('Hello Arvin Sison!'));
    expect(titleText.style?.color, Colors.black);
    expect(titleText.style?.fontSize, 21);

    // Verify the IconButton is present
    expect(find.byType(IconButton), findsOneWidget);

    // Verify the HugeIcon is present
    expect(find.byType(HugeIcon), findsOneWidget);

    // Verify the HugeIcon properties
    final HugeIcon hugeIcon = tester.widget(find.byType(HugeIcon));
    expect(hugeIcon.icon, HugeIcons.strokeRoundedMessageMultiple02);
    expect(hugeIcon.color, Colors.black);
    expect(hugeIcon.size, 31);

    // Verify the body content
    expect(find.text('HomeScreen'), findsOneWidget);

    // Verify the SizedBox in the body
    final Finder bodySizedBoxFinder = find.descendant(
      of: find.byType(Column),
      matching: find.byType(SizedBox),
    );
    expect(bodySizedBoxFinder, findsOneWidget);

    // Verify the SizedBox height in the body
    final SizedBox bodySizedBox = tester.widget(bodySizedBoxFinder);
    expect(bodySizedBox.height, 10);
  });
}
