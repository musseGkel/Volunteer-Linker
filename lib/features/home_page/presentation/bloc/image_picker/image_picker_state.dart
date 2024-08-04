part of 'image_picker_bloc.dart';

class ImagePickerState extends Equatable {
  final File? image;
  final String? errorMessage;

  const ImagePickerState({
    this.image,
    this.errorMessage,
  });

  @override
  List<Object> get props => [
        image ?? '',
        errorMessage ?? '',
      ];

  ImagePickerState copyWith({
    File? image,
    String? errorMessage,
  }) {
    return ImagePickerState(
      image: image ?? this.image,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }
}
