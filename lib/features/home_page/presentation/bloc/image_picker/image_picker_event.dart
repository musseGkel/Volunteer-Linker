part of 'image_picker_bloc.dart';

sealed class ImagePickerEvent extends Equatable {
  Stream<ImagePickerState> handle();

  const ImagePickerEvent();

  @override
  List<Object> get props => [];
}

class PickImageFromGalleryEvent extends ImagePickerEvent {
  final ImagePicker _picker = ImagePicker();
  final ImagePickerState state;

  PickImageFromGalleryEvent({
    required this.state,
  });

  @override
  Stream<ImagePickerState> handle() async* {
    ImagePickerState updatedState;
    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
      if (pickedFile != null) {
        final image = FileImage(File(pickedFile.path));
        updatedState = state.copyWith(
          image: image,
        );
        yield updatedState;
      } else {
        updatedState = state.copyWith(errorMessage: 'No image selected.');
        yield updatedState;
      }
    } catch (e) {
      updatedState = state.copyWith(errorMessage: 'Failed to pick image: $e');
      yield updatedState;
    }
  }
}

class TakePhotoEvent extends ImagePickerEvent {
  final ImagePickerState state;
  final ImagePicker _picker = ImagePicker();

  TakePhotoEvent({
    required this.state,
  });

  @override
  Stream<ImagePickerState> handle() async* {
    ImagePickerState updatedState;

    try {
      final pickedFile = await _picker.pickImage(source: ImageSource.camera);
      if (pickedFile != null) {
        final image = FileImage(File(pickedFile.path));
        updatedState = state.copyWith(image: image);
        yield updatedState;
      } else {
        updatedState = state.copyWith(errorMessage: 'No image taken.');
        yield updatedState;
      }
    } catch (e) {
      updatedState = state.copyWith(errorMessage: 'Failed to take photo: $e');
      yield updatedState;
    }
  }
}
