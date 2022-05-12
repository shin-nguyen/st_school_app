class Promotion {
  final int id;
  final String image;
  final String title;
  final String subTitle;

  Promotion(this.id, this.image, this.title, this.subTitle);
  factory Promotion.empty() {
    return Promotion(0, '', '', '');
  }
}
 
// final promotion = Promotion('assets/images/dog_reading_vector.svg',
//     'Get 80% Off', 'Exclusive for UI/UX Designing.');
