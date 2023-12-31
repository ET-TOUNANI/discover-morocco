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
    required this.destination
  });

  final String title;
  final String description;
  final String image;
  final String video;
  final FormzStatus status;
  final String? errorMessage;
  final DestinationModel destination;

  @override
  List<Object> get props => [title, description, image, video, status,destination];

  PublicationState copyWith({
    String? title,
    String? description,
    String? image,
    String? video,
    String? errorMessage,
    FormzStatus? status,
    DestinationModel? destination,
  }) {
    return PublicationState(
      title: title ?? this.title,
      description: description ?? this.description,
      image: image ?? this.image,
      video: video ?? this.video,
      errorMessage: errorMessage ?? this.errorMessage,
      status: status ?? this.status,
      destination: destination ?? this.destination,
    );
  }
}
