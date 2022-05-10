class Promotion {
  final String image;
  final String title;
  final String subTitle;

  Promotion(this.image, this.title, this.subTitle);
  factory Promotion.empty() {
    return Promotion('', '', '');
  }
}
 
// final promotion = Promotion('assets/images/dog_reading_vector.svg',
//     'Get 80% Off', 'Exclusive for UI/UX Designing.');
