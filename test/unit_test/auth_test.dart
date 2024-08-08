// ignore: unused_import

import 'package:dartz/dartz.dart';
import 'package:flaviourfleet/core/failure/failure.dart';
import 'package:flaviourfleet/features/auth/domain/entity/auth_entity.dart';
import 'package:flaviourfleet/features/auth/domain/usecases/auth_usecase.dart';
import 'package:flaviourfleet/features/auth/presentation/navigator/login_navigator.dart';
import 'package:flaviourfleet/features/auth/presentation/viewmodel/auth_view_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'auth_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<AuthUseCase>(),
  MockSpec<LoginViewNavigator>(),
  // MockSpec<RegisterViewNavigator>(),
])
void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  late AuthUseCase mockAuthUsecase;
  late LoginViewNavigator mockLoginNavigator;
  // late RegisterViewNavigator mockRegisterNavigator;

  late ProviderContainer container;

  setUp(() {
    mockAuthUsecase = MockAuthUseCase();
    mockLoginNavigator = MockLoginViewNavigator();
    //mockRegisterNavigator = MockRegisterViewNavigator();
    container = ProviderContainer(overrides: [
      authViewModelProvider.overrideWith(
          (ref) => AuthViewModel(mockLoginNavigator, mockAuthUsecase))
    ]);
  });

  test('check for the inital state in Auth state', () {
    final authState = container.read(authViewModelProvider);
    expect(authState.isLoading, false);
    expect(authState.error, isNull);
  });

  group("Login tests", () {
    test('login test with valid username and password', () async {
      // Arrange
      const correctUsername = 'abhinash';
      const correctPassword = 'abhinash123';

      when(mockAuthUsecase.loginStudent(any, any)).thenAnswer((invocation) {
        final username = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        return Future.value(
            username == correctUsername && password == correctPassword
                ? const Right(true)
                : Left(Failure(error: 'Invalid Credentails')));
      });
      // Act
      await container
          .read(authViewModelProvider.notifier)
          .loginStudent('abhinash', 'abhinash123');
      final authState = container.read(authViewModelProvider);
      // Assert
      expect(authState.error, isNull);
    });
    test('login test with invalid username and password', () async {
      // Arrange
      const correctUsername = 'abhinash';
      const correctPassword = 'abhinash123';

      when(mockAuthUsecase.loginStudent(any, any)).thenAnswer((invocation) {
        final username = invocation.positionalArguments[0] as String;
        final password = invocation.positionalArguments[1] as String;
        return Future.value(
            username == correctUsername && password == correctPassword
                ? const Right(true)
                : Left(Failure(error: 'Invalid Credentails')));
      });
      // Act
      await container
          .read(authViewModelProvider.notifier)
          .loginStudent('abhinash', 'abhinash');
      final authState = container.read(authViewModelProvider);
      // Assert
      expect(authState.error, isNull);
    });
  });

  group("Register tests", () {
    test("register with user credientials", () async {
      when(mockAuthUsecase.registerStudent(any))
          .thenAnswer((_) => Future.value(const Right(true)));

      const AuthEntity user = AuthEntity(
          fname: "abhinash",
          lname: "tripathi",
          address: "nepal",
          email: "abc@gmail.com",
          password: "abcdef");

      await container
          .read(authViewModelProvider.notifier)
          .registerStudent(user);
      final authState = container.read(authViewModelProvider);
      // Assert
      expect(authState.error, isNull);
    });
    test("register with existing email", () async {
      const existingMail = "abc@gmail.com";
      // Arrange
      when(mockAuthUsecase.registerStudent(any)).thenAnswer((invocation) {
        final AuthEntity user = invocation.positionalArguments[0] as AuthEntity;
        return Future.value(user.email == existingMail
            ? Left(Failure(error: 'Email already exists'))
            : const Right(true));
      });
      // Act
      const AuthEntity user = AuthEntity(
          fname: "abhinash",
          lname: "tripathi",
          address: "nepal",
          email: "abc@gmail.com",
          password: "abcdef");
      await container
          .read(authViewModelProvider.notifier)
          .registerStudent(user);
      final authState = container.read(authViewModelProvider);

      // Assert
      expect(authState.error, isNull);
    });
  });

  tearDown(() {
    container.dispose();
  });
}
