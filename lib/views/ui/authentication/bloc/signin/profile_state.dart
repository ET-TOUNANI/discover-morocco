part of 'profile_bloc.dart';

class ProfileState extends Equatable {
  const ProfileState({
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.status = FormzStatus.pure,
    this.name = '',
    this.phone = '',
    this.photo ='',
    this.errorMessage,
  });

  final Email email;
  final Password password;
  final String name;
  final String photo;
  final String phone;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [email, password, status, photo, phone, name];

  ProfileState copyWith(
      {Email? email,
      Password? password,
      String? name,
      String? phone,
      String? photo,
      FormzStatus? status,
      String? errorMessage}) {
    return ProfileState(
      email: email ?? this.email,
      password: password ?? this.password,
      status: status ?? this.status,
      name: name ?? this.name,
      phone: phone ?? this.phone,
      photo: photo ?? this.photo,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
