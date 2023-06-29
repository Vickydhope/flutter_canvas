import 'package:flutter_canvas/res/app_assets.dart';

class SliderModel {
  String image;
  String title;
  String description;

  // Constructor for variables
  SliderModel(
      {required this.title, required this.description, required this.image});

  void setImage(String getImage) {
    image = getImage;
  }

  void setTitle(String getTitle) {
    title = getTitle;
  }

  void setDescription(String getDescription) {
    description = getDescription;
  }

  String getImage() {
    return image;
  }

  String getTitle() {
    return title;
  }

  String getDescription() {
    return description;
  }
}

// List created
List<SliderModel> getSlides() {
  List<SliderModel> slides = <SliderModel>[];

  slides.add(SliderModel(title: "Sample Title", description: "", image: slider1));
  slides.add(SliderModel(title: "Sample Title", description: "", image: slider2));
  slides.add(SliderModel(title: "Sample Title", description: "", image: slider3));
  return slides;
}
