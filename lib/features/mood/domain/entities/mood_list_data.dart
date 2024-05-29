class MoodListData {

  String imagePath;
  String titleTxt;
  String startColor;
  String endColor;
  int presentase;

  MoodListData({
    this.imagePath = '',
    this.titleTxt = '',
    this.startColor = '',
    this.endColor = '',
    this.presentase = 0,
  });

  static List<MoodListData> tabIconsList = <MoodListData> [
    MoodListData(
      imagePath: 'assets/fitness_app/senang.png',
      titleTxt: 'Senang',
      presentase: 100,
      startColor: '#FA7D82',
      endColor: '#FFB295',
    ),
  ];
}