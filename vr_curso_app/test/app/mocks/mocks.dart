import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:mocktail/mocktail.dart';
import 'package:vr_curso_app/app/core/shared/services/client_http/dio_client_http.dart';
import 'package:vr_curso_app/app/modules/course/domain/cuorso_dto/cuorso_dto.dart';
import 'package:vr_curso_app/app/modules/course/domain/entities/cuorse_entity.dart';
import 'package:vr_curso_app/app/modules/course/domain/repositories/i_course_repository.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/entities/enrollment_entity.dart';
import 'package:vr_curso_app/app/modules/enrollment/domain/params_dto/enrollment_dto.dart';
import 'package:vr_curso_app/app/modules/student/domain/entities/student_entity.dart';
import 'package:vr_curso_app/app/modules/student/domain/student_dto/student_dto.dart';
import 'package:vr_curso_app/app/modules/student/presenter/models/student_model.dart';

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

const mockLstEnrollmentsData = [
  {
    'codigo': 1,
    'curso': {
      'codigo': 1,
      'descricao': 'descricao 1',
      'ementa': 'ementa 1',
      'cursoCodigosMatriculas': [1]
    },
    'aluno': {
      'codigo': 1,
      'nome': 'John',
      'alunoCodigosMatriculas': [1]
    }
  }
];

const mockEnrollmentData = {
  'codigo': 1,
  'curso': {
    'codigo': 1,
    'descricao': 'descricao 1',
    'ementa': 'ementa 1',
    'cursoCodigosMatriculas': [1]
  },
  'aluno': {
    'codigo': 1,
    'nome': 'John',
    'alunoCodigosMatriculas': [1]
  }
};
const courseEntityMock = CourseEntity(
    id: 1, description: 'codigo', syllabus: 'syllabus', enrollmentCodes: []);

final courseDTOMock = CourseDTO(courseEntityMock);



final enrollmenEntityMock = EnrollmentEntity(
    id: 1, course: courseEntityMock, student: studentEntityMock);
final enrollmenEmptyMock = EnrollmentEntity(
    id: -1, course: courseEmptyMock, student: studentEmptyMock);
final enrollmenDtoMock = EnrollmentDTO(entity: enrollmenEntityMock);
final enrollmenDtoEmptyMock = EnrollmentDTO(entity: enrollmenEmptyMock);

final List<EnrollmentEntity> lstEnrollmenEntityMock = [enrollmenEntityMock];

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


final studentEntityMock =
    StudentEntity(id: 1, name: 'John', enrollmentIds: [1]);
final List<StudentEntity> studentListEntityMock = [studentEntityMock];
final studentModelMock = StudentModel(id: 1, name: 'John', enrollmentIds: [1]);
final studentDTOMock = StudentDTO(entity: studentEntityMock);


final studentEmptyMock = StudentEntity(
    id: -1, //
    name: '',
    enrollmentIds: []);

final dtoMOCK = StudentDTO(
  entity: studentModelMock, // Usando entidade válida
);

final dtoEntityMOCK = StudentDTO(
  entity: studentEmptyMock, // Usando entidade válida
);
