import 'package:flutter_test/flutter_test.dart';
import 'package:job_application_tracker/main.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  testWidgets('CareerTrack app displays its title', (tester) async {
    SharedPreferences.setMockInitialValues({});
    await tester.pumpWidget(const JobTrackerApp());
    await tester.pump();
    expect(find.text('CareerTrack'), findsOneWidget);
  });
}
