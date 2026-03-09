import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skill_issue/features/dashboard/domain/usecases/get_dashboard_data_usecase.dart';
import 'package:skill_issue/features/dashboard/presentation/bloc/dashboard_event.dart';
import 'package:skill_issue/features/dashboard/presentation/bloc/dashboard_state.dart';

class DashboardBloc extends Bloc<DashboardEvent, DashboardState> {
  final GetDashboardDataUseCase getDashboard;

  DashboardBloc(this.getDashboard) : super(DashboardInitial()) {
    on<LoadDashboard>(_load);
  }

  Future<void> _load(LoadDashboard event, emit) async {
    emit(DashboardLoading());

    final result = await getDashboard();

    result.fold(
      (failure) => emit(DashboardError(failure.message)),
      (data) => emit(DashboardLoaded(data)),
    );
  }
}
