part of 'publication_cubit.dart';

@immutable
class PublicationState extends Equatable {
  const PublicationState({
    this.title = '',
    this.description = '',
    this.image = '',
    this.status = FormzStatus.pure,
    this.errorMessage,
    this.video = '',
  });

  final String title;
  final String description;
  final String image;
  final String video;
  final FormzStatus status;
  final String? errorMessage;

  @override
  List<Object> get props => [title, description, image, video, status];

  PublicationState copyWith({
    String? title,
    String? description,
    String? image,
    String? video,
    String? errorMessage,
    FormzStatus? status,
  }) {
    return PublicationState(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      video: video ?? this.video,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
    );
  }
}
