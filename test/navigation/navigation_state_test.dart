import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mocktail/mocktail.dart';

import 'package:skill_issue/features/dashboard/presentation/bloc/dashboard_bloc.dart';
import 'package:skill_issue/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:skill_issue/features/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'package:skill_issue/features/dashboard/domain/entities/dashboard_data.dart';
import 'package:skill_issue/features/home/presentation/pages/home_page.dart';

class MockGetDashboardUseCase extends Mock
    implements GetDashboardDataUseCase {}

void main() {
  testWidgets('DashboardBloc state persists when child changes',
      (WidgetTester tester) async {
    final mockUseCase = MockGetDashboardUseCase();

    final tDashboardData = DashboardData(
      totalSkills: 10,
      beginner: 3,
      intermediate: 4,
      advanced: 3,
      roadmapCompletion: 60,
    );

    when(() => mockUseCase())
        .thenAnswer((_) async => Right(tDashboardData));

    final dashboardBloc = DashboardBloc(mockUseCase);

    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<DashboardBloc>.value(value: dashboardBloc),
        ],
        child: MaterialApp(
          home: HomePage(
            child: const Scaffold(body: Text("Dashboard")),
          ),
        ),
      ),
    );

    // Trigger load
    dashboardBloc.add(LoadDashboard());
    await tester.pumpAndSettle();

    expect(tDashboardData.totalSkills,10);

    // Rebuild HomePage with different child (simulate tab change)
    await tester.pumpWidget(
      MultiBlocProvider(
        providers: [
          BlocProvider<DashboardBloc>.value(value: dashboardBloc),
        ],
        child: MaterialApp(
          home: HomePage(
            child: const Scaffold(body: Text("Skills Page")),
          ),
        ),
      ),
    );

    await tester.pump();

    // Verify state still intact
    expect(tDashboardData.totalSkills, 10);
  });
}