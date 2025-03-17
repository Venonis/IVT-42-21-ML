import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_application_1/domain/domain.dart';
part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthService authService;

  AuthBloc(this.authService) : super(AuthInitial()) {
    on<AuthLogin>(_onLogin);
    on<AuthSignUp>(_onSignUp);
    on<AuthLogout>(_onLogout);
    on<AuthCheckStatus>(_onCheckStatus);
  }

  Future<void> _onLogin(AuthLogin event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authService.logIn(email: event.email, password: event.password);
      emit(AuthAuthenticated(message: 'Вход выполнен успешно'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onSignUp(AuthSignUp event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authService.signUp(email: event.email, password: event.password);
      emit(AuthAuthenticated(message: 'Регистрация прошла успешно'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onLogout(AuthLogout event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      await authService.logOut();
      emit(AuthUnauthenticated(message: 'Вы вышли из аккаунта'));
    } catch (e) {
      emit(AuthError(e.toString()));
    }
  }

  Future<void> _onCheckStatus(AuthCheckStatus event, Emitter<AuthState> emit) async {
    final isLoggedIn = authService.isLoggedIn();
    emit(isLoggedIn 
      ? AuthAuthenticated() 
      : AuthUnauthenticated()
    );
  }
}