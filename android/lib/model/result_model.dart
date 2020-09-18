class ResultModel {
  final String title;
  final String info;
  final String imagePath;
  ResultModel({this.title, this.info, this.imagePath});
  factory ResultModel.fromDb(int value) {
    String _title = '';
    String _info = '';
    String _imagePath = '';
    switch (value) {
      case 0:
        _title = 'Well Hydrated';
        _imagePath = 'assets/condition/ic_people_0.svg';
        _info =
            '''kondisi tubuh anda saat ini baik sekali dengan warna urine normal, anda minum dengan cukup dan tidak mengalami dehidrasi. PERTAHANKAN!!!''';
        break;
      case 1:
        _title = 'Hydrated';
        _imagePath = 'assets/condition/ic_people_1.svg';
        _info =
            '''kondisi tubuh anda saat ini masih baik dan berada pada tahap perlu menambah sedikit minum saja. SEMANGAT!!!''';
        break;
      case 2:
        _title = 'Normal';
        _imagePath = 'assets/condition/ic_people_2.svg';
        _info =
            '''kondisi tubuh anda saat ini tergolong masih aman dan tidak dehidrasi namun dalam 1 jam kedepan anda sangat perlu minum setidaknya setengah botol atau setengah liter air untuk menjaga cairan dalam tubuh anda. TETAP SEMANGAT''';
        break;
      case 3:
        _title = 'Mild Dehydration';
        _imagePath = 'assets/condition/ic_people_3.svg';
        _info =
            '''kondisi tubuh anda sudah tergolong dehidrasi ringan, anda disarankan untuk sesegera mungkin minum air mineral 1 botol atau 1/2 liter air''';
        break;
      case 4:
        _title = 'Moderate Dehydration';
        _imagePath = 'assets/condition/ic_people_4.svg';
        _info =
            '''kondisi tubuh anda sangat dehidrasi, tubuh anda sangat kekurangan air dan butuh asupan air dengan segera. Stop minuman berkafein''';
        break;
      case 5:
        _title = 'Severe Dehydration';
        _imagePath = 'assets/condition/ic_people_5.svg';
        _info =
            '''kondisi tubuh anda dehidrasi parah, segera minum air yang banyak dan bila perlu cek kesehatan anda ke dokter ya''';
        break;
      default:
    }
    return ResultModel(title: _title, info: _info, imagePath: _imagePath);
  }
}
