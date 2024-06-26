import 'package:dartz/dartz.dart';
import 'package:mario_app/Domain/entities/LessonResponseEntity.dart';
import 'package:mario_app/Domain/entities/failure.dart';
import 'package:mario_app/Domain/repo/main_screen_repository.dart';

class GetLessonsUseCase{
  MainScreenRepository mainScreenRepository;
  GetLessonsUseCase({required this.mainScreenRepository});
  Future<Either<Failures,LessonResponseEntity>>invoke(String token){
    return mainScreenRepository.getLessons(token);
  }
}