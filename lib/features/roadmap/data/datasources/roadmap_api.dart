import '../../../../core/network/dio_client.dart';
import '../models/roadmap_model.dart';

class RoadmapApi {

  final DioClient dio;

  RoadmapApi(this.dio);

  Future<RoadmapModel> getRoadmap() async {

    final res = await dio.dio.get("/roadmap");

    return RoadmapModel.fromJson(res.data);
  }
}
