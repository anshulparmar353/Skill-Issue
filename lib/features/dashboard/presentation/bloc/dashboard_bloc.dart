import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/features/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'package:skill_issue/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:skill_issue/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {

  final GetDashboardDataUseCase getDashboard;

  DashboardBloc(this.getDashboard)
      : super(DashboardState.initial()) {

    on<LoadDashboard>(_load);
  }

  Future<void> _load(LoadDashboard event, emit) async {

    emit(DashboardState(loading: true));

    try {

      final data = await getDashboard();

      emit(DashboardState(
        loading: false,
        data: data,
      ));

    } catch (e) {

      emit(DashboardState(
        loading: false,
        error: "Failed to load dashboard",
      ));
    }
  }
}
