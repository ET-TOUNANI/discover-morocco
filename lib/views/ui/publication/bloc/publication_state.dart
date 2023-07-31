part of 'publication_cubit.dart';

@immutable
class PublicationState extends Equatable {
  const PublicationState({
    this.title='',
    this.description='',
    this.image='',
    this.video='',
  });

  final String title;
  final String description;
  final String image;
  final String video;


  @override
  List<Object> get props => [title,description,image,video];

  PublicationState copyWith({
    String? title,
    String? description,
    String? image,
    String? video,
  }) {
    return PublicationState(
      title: title ?? this.title,
      description: title ?? this.description,
      image: title ?? this.image,
      video: title ?? this.video,
    );
  }
}
