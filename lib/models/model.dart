class YogaModel{
  static String IDName="ID";
  static String YogaName="YogaName";
  static String SecondsOrNot="SecondsOrNot";
  static String ImageName="ImageName";
  static String Description="Description";
  static String TableName1="YogaForBeginners";
  static String TableName2="SuryaNamaskar";
  static String TableName3="AllIn1Yoga";
  static String TableSummary="YogaSummary";
  static String YogaPackName="YogaPackName";
  static String WorkoutName="WorkOutName";
  static String BackImgName="BackImg";
  static String TotalWorkOut="TotalWorkOut";
  static String TotalTime="TotalTime";
  static String KCAL="KCAL";
  static String SecondsOrTimes="SecondsOrTimes";
  static String YogaIndex="index";
  static List<String> Yogatable1Columns=[IDName, YogaName, SecondsOrNot, ImageName];
}
class Yoga{                     //Individual Workout set Model
  final int? id;
  final bool Seconds;
  final String YogaTitle;
  final String YogaImgUrl;
  final String SecondsOrTimes;
  final String Description;
  const Yoga({
    this.id,
    required this.Seconds,
    required this.YogaTitle,
    required this.YogaImgUrl,
    required this.SecondsOrTimes,
    required this.Description
});

  Yoga copy({
    int? id,
    bool? Seconds,
    String? YogaTitle,
    String? YogaImgUrl,
    String? SecondsOrTimes,
    String? Description
}){
    return Yoga(
      id: id?? this.id,
      Seconds: Seconds?? this.Seconds,
      YogaTitle: YogaTitle?? this.YogaTitle,
      YogaImgUrl: YogaImgUrl?? this.YogaImgUrl,
      SecondsOrTimes: SecondsOrTimes?? this.SecondsOrTimes,
      Description: Description?? this.Description
    );
  }

  static Yoga fromJson(Map<String, Object?> json){
    return Yoga(
        id: json[YogaModel.IDName] as int?,
        Seconds: json[YogaModel.SecondsOrNot]==1,
        YogaTitle: json[YogaModel.YogaName] as String,
        YogaImgUrl: json[YogaModel.ImageName] as String,
        SecondsOrTimes: json[YogaModel.SecondsOrTimes] as String,
        Description: json[YogaModel.Description] as String,
    );
  }
  Map<String, Object?> toJson() {
        return {
          YogaModel.IDName : id,
          YogaModel.SecondsOrNot : Seconds?1:0,
          YogaModel.YogaName : YogaTitle,
          YogaModel.ImageName : YogaImgUrl,
          YogaModel.SecondsOrTimes : SecondsOrTimes,
          YogaModel.Description: Description
        };
  }
}
class YogaSummary{                    //Whole workout set summary model
  final int? id;
  final String YogaPackName;
  final String WorkOutName;
  final String BackImgUrl;
  final String TotalTime;
  final String TotalWorkOut;
  final String KCAL;
  // final int index;
  const YogaSummary({
    this.id,
    required this.YogaPackName,
    required this.WorkOutName,
    required this.BackImgUrl,
    required this.TotalWorkOut,
    required this.TotalTime,
    required this.KCAL
    // required this.index
  });

  YogaSummary copy({
    int? id,
    String? YogaPackName,
    String? WorkOutName,
    String? BackImgUrl,
    String? TotalTime,
    String? TotalWorkOut,
    String? KCAL
    // int? index
  }){
    return YogaSummary(
      id: id?? this.id,
      YogaPackName: YogaPackName?? this.YogaPackName,
      WorkOutName: WorkOutName?? this.WorkOutName,
      BackImgUrl: BackImgUrl?? this.BackImgUrl,
      TotalTime: TotalTime?? this.TotalTime,
      TotalWorkOut: TotalWorkOut?? this.TotalWorkOut,
      KCAL: KCAL?? this.KCAL
      // index: index?? this.index
    );
  }

  static YogaSummary fromJson(Map<String, Object?> json) {
    return YogaSummary(
        id: json[YogaModel.IDName] as int?,
        YogaPackName: json[YogaModel.YogaPackName] as String,
        WorkOutName: json[YogaModel.WorkoutName] as String,
        BackImgUrl: json[YogaModel.BackImgName] as String,
        TotalTime: json[YogaModel.TotalTime] as String,
        TotalWorkOut: json[YogaModel.TotalWorkOut] as String,
        KCAL: json[YogaModel.KCAL] as String,
        // index: json[YogaModel.YogaIndex] as int
    );
  }
  Map<String, Object?> toJson() {
    return {
      YogaModel.IDName : id,
      YogaModel.YogaPackName :YogaPackName,
      YogaModel.WorkoutName : WorkOutName,
      YogaModel.BackImgName : BackImgUrl,
      YogaModel.TotalTime : TotalTime,
      YogaModel.TotalWorkOut: TotalWorkOut,
      YogaModel.KCAL: KCAL
      // YogaModel.YogaIndex: index
    };
  }
}
