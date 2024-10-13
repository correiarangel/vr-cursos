import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/shared/services/client_http/dio_client_http.dart';
import 'package:vr_curso_app/app/modules/course/domain/cuorso_dto/cuorso_dto.dart';
import 'package:vr_curso_app/app/modules/course/domain/entities/cuorse_entity.dart';
import 'package:vr_curso_app/app/modules/course/domain/repositories/i_course_repository.dart';
import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';
import 'package:vr_curso_app/app/modules/student/domain/student_dto/student_dto.dart';

class DioMock extends Mock implements DioForNative {}

class DioClientHttpMock extends Mock implements DioClientHttp {}

class ResponseMock extends Mock implements Response {}

class DioErrorMock extends Mock implements DioException {}

class RequestOptionsMock extends Mock implements RequestOptions {}

class CourseRepositoryMock extends Mock implements ICourseRepository {}

const mockStudentsData = [
  {'codigo': 1, 'nome': 'John', 'alunoCodigosMatriculas': []},
  {'codigo': 2, 'nome': 'John 2', 'alunoCodigosMatriculas': []}
];
const mockCuorsesData = [
  {
    'codigo': 1,
    'descricao': 'descricao 1',
    'ementa': 'ementa 1',
    'cursoCodigosMatriculas': []
  },
  {
    'codigo': 2,
    'descricao': 'descricao 2',
    'ementa': 'ementa 2',
    'cursoCodigosMatriculas': []
  }
];

const courseEntityMock = CourseEntity(
    id: 1, description: 'codigo', syllabus: 'syllabus', enrollmentCodes: []);

final courseDTOMock = CourseDTO(courseEntityMock);

const courseEmptyMock =
    CourseEntity(id: -1, description: '', syllabus: '', enrollmentCodes: []);

final courseDtoEmptyMock = CourseDTO(courseEmptyMock);
const List<CourseEntity> courseEntityListMock = [
  courseEntityMock,
  courseEmptyMock
];

final Map<String, dynamic> mockCoursetDataMap = {
  ' codigo': 1,
  'descricao': 'descricao',
  'ementa': 'ementa',
  'alunoCodigosMatriculas': [1]
};

final Map<String, dynamic> mockStudentDataMap = {
  'codigo': 1,
  'nome': 'John',
  'alunoCodigosMatriculas': [1]
};

final studentEntity = StudentEntity(
    id: 1, // ID inválido para testar o caso de erro
    name: 'John',
    enrollmentIds: []);

final emptyEntity = StudentEntity(
    id: -1,
    name: '', // Nome vazio para testar o erro de validação
    enrollmentIds: []);

final dtoMOCK = StudentDTO(
  entity: studentEntity, // Usando entidade válida
);

final dtoEntityMOCK = StudentDTO(
  entity: emptyEntity, // Usando entidade válida
);
