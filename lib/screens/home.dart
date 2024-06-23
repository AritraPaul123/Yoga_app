import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:yoga_app/screens/startup.dart';
import 'package:yoga_app/services/yogadb.dart';
import '../services/model.dart';
import '../widgets/appbar.dart';
import '../widgets/customdrawer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _scaffoldkey = GlobalKey();
  late AnimationController _animationController;
  late Animation _colortween, _icontween, _drawertween, _yogatween, _hometween;
  late AnimationController _textanimationcontroller;
  late List<YogaSummary> yogasumlist;
  bool isLoading=true;

  @override

  Future makeYogaEntry(Yoga yoga, String Tablename) async {
      await YogaDataBase.instance.Insert(yoga, Tablename);
  }
  Future makeYogaSumEntry(YogaSummary yogasum, String Tablename) async {
    await YogaDataBase.instance.InsertSummary(yogasum, Tablename);
  }

  Future readYogaSumEntry(String Tablename) async{
    this.yogasumlist = (await YogaDataBase.instance.readAllYogaSum(Tablename))!;
    setState(() {
      isLoading = false;
    });
  }
  void entry(){
    makeYogaSumEntry(YogaSummary(YogaPackName:"Yoga For Beginners",WorkOutName: YogaModel.TableName1, BackImgUrl: "https://th.bing.com/th/id/OIP.i8zLL1PrFwZhwEwyCFf-kAAAAA?rs=1&pid=ImgDetMain", TotalWorkOut: "13", TotalTime: "20", KCAL: "200"), YogaModel.TableSummary);
    makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Mountain Pose(Tadasana)", YogaImgUrl: "https://www.sheknows.com/wp-content/uploads/2018/08/10-min_StandingTreePose_set5le.gif", SecondsOrTimes: "60", Description: "Stand tall with feet together, shoulders relaxed, weight evenly distributed through your soles, arms at sides. Take a deep breath and raise your hands overhead, palms facing each other with arms straight. Reach up toward the sky with your fingertips."), YogaModel.TableName1);
    makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Downward-Facing Dog(Adho Mukha Svanasana)", YogaImgUrl: "https://th.bing.com/th/id/OIP.HqoYRJ5uiVKmEGyI5i1ULQHaHa?rs=1&pid=ImgDetMain", SecondsOrTimes: "120", Description: "Start on your hands and knees, with your wrists directly under your shoulders and knees under your hips. Spread your fingers and press your weight firmly across your hands and into the mat. Straighten your legs and lift your hips into the air."), YogaModel.TableName1);
    makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Plank Pose(Phalakasana)", YogaImgUrl: "https://i.giphy.com/d3mlADRlF7SMFQRy.webp", SecondsOrTimes: "60", Description: "From Downward-Facing Dog, shift forward so your shoulders are over your wrists. Engage your core and keep your body in a straight line from head to heels."), YogaModel.TableName1);
    makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Cobra Pose(Bhujangasana)", YogaImgUrl: "https://static-bebeautiful-in.unileverservices.com/cobra-pose-yoga.gif", SecondsOrTimes: "60", Description: "Lie face down with your legs extended and the tops of your feet on the floor. Place your hands under your shoulders, elbows close to your body. Inhale and press into your hands to lift your chest off the floor, keeping your elbows slightly bent."), YogaModel.TableName1);
    makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Child's Pose(Balasana)", YogaImgUrl: "https://i.pinimg.com/originals/d0/98/f3/d098f3d2a4f3132ea90529a2c883eb25.gif", SecondsOrTimes: "120", Description: "Kneel on the floor, touch your big toes together, and sit on your heels. Bend forward, extending your arms in front of you or alongside your body, and rest your forehead on the mat."), YogaModel.TableName1);
    makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Warrior I(Virabhadrasana I) Left", YogaImgUrl: "https://fthmb.tqn.com/HxOIXkwJr2l1pfhEVJzm7mrOJHc=/1500x1000/filters:fill(87E3EF,1)/Verywell-01-3567198-WarriorOne-598a10b06f53ba00111d32f3.gif", SecondsOrTimes: "60", Description: "Stand with legs 3-4 feet apart. Turn your right foot out 90 degrees and your left foot in slightly. Bend your right knee over your right ankle, keeping your left leg straight. Raise your arms overhead, palms facing each other."), YogaModel.TableName1);
    makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Warrior I(Virabhadrasana I) Right", YogaImgUrl: "https://fthmb.tqn.com/HxOIXkwJr2l1pfhEVJzm7mrOJHc=/1500x1000/filters:fill(87E3EF,1)/Verywell-01-3567198-WarriorOne-598a10b06f53ba00111d32f3.gif", SecondsOrTimes: "60", Description: "Stand with legs 3-4 feet apart. Turn your right foot out 90 degrees and your left foot in slightly. Bend your right knee over your right ankle, keeping your left leg straight. Raise your arms overhead, palms facing each other."), YogaModel.TableName1);
    makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Warrior II(Virabhadrasana II) Left", YogaImgUrl: "https://www.verywellfit.com/thmb/QnL1gfiA-JfTD9KvR2Q_XUhzEVY=/768x0/filters:no_upscale():max_bytes(150000):strip_icc()/Verywell-03-3567198-Warrior2-598a10d4d963ac0011fc9d72.gif", SecondsOrTimes: "60", Description: "From Warrior I, open your hips and shoulders to the side, extending your arms parallel to the floor, palms down. Keep your right knee bent and your left leg straight."), YogaModel.TableName1);
    makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Warrior II(Virabhadrasana II) Right", YogaImgUrl: "https://www.verywellfit.com/thmb/QnL1gfiA-JfTD9KvR2Q_XUhzEVY=/768x0/filters:no_upscale():max_bytes(150000):strip_icc()/Verywell-03-3567198-Warrior2-598a10d4d963ac0011fc9d72.gif", SecondsOrTimes: "60", Description: "From Warrior I, open your hips and shoulders to the side, extending your arms parallel to the floor, palms down. Keep your right knee bent and your left leg straight."), YogaModel.TableName1);
    makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Triangle Pose(Trikonasana) Left", YogaImgUrl: "https://www.yogajournal.com/wp-content/uploads/2007/08/UtthitaTrikonasana-ExtendedTriangle-REV.gif", SecondsOrTimes: "60", Description: "Stand with legs 3-4 feet apart. Turn your right foot out 90 degrees and your left foot in slightly. Extend your arms out to the sides and hinge at your right hip to lower your right hand to your shin or the floor, extending your left arm towards the sky."), YogaModel.TableName1);
    makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Triangle Pose(Trikonasana) Right", YogaImgUrl: "https://www.yogajournal.com/wp-content/uploads/2007/08/UtthitaTrikonasana-ExtendedTriangle-REV.gif", SecondsOrTimes: "60", Description: " Stand with legs 3-4 feet apart. Turn your right foot out 90 degrees and your left foot in slightly. Extend your arms out to the sides and hinge at your right hip to lower your right hand to your shin or the floor, extending your left arm towards the sky."), YogaModel.TableName1);
    makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Seated Forward Bend(Paschimottanasana)", YogaImgUrl: "https://www.bing.com/th/id/OGC.b1958721972e02d3097e6f442e0d8a6b?pid=1.7&rurl=https%3a%2f%2fwww.yogajournal.com%2fwp-content%2fuploads%2f2007%2f08%2fWide-AngledSeatedForwardBend-Rev.gif%3fwidth%3d730&ehk=AtPJKdwgs9LP6lReDF75dLeh59MoMu9LnAc11cwvmZg%3d", SecondsOrTimes: "120", Description: "Sit with your legs extended in front of you. Inhale and lengthen your spine, then exhale and hinge at your hips to reach for your feet, keeping your back straight."), YogaModel.TableName1);
    makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Corpse Pose(Savasana)", YogaImgUrl: "https://www.bing.com/th/id/OGC.577d92bfac1c1e2813642f321f1b2d08?pid=1.7&rurl=https%3a%2f%2fwww.yogajournal.com%2fwp-content%2fuploads%2f2007%2f08%2fSavasana-Corpse.gif&ehk=PYWv8Soz5l5B3uzjK6MgmAzeNes8AP%2fQnfT6X%2fN5%2b%2fg%3d", SecondsOrTimes: "300", Description: "Lie on your back with your legs extended and arms at your sides, palms facing up. Close your eyes and relax your entire body, focusing on your breath."), YogaModel.TableName1);

    makeYogaSumEntry(YogaSummary(YogaPackName:"Surya Namaskar(Sun Salutation)",WorkOutName: YogaModel.TableName2, BackImgUrl: "https://www.wikihow.com/images/thumb/a/a2/Perform-Surya-Namaskar-Step-11.jpg/v4-460px-Perform-Surya-Namaskar-Step-11.jpg", TotalWorkOut: "24", TotalTime: "8", KCAL: "56"), YogaModel.TableSummary);
    for(int i=0;i<2;i++){
      makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Pranamasana(Prayer Pose)", YogaImgUrl: "https://www.wikihow.com/images/thumb/e/ef/Do-the-Surya-Namaskar-Step-1-Version-3.jpg/aid4547680-v4-728px-Do-the-Surya-Namaskar-Step-1-Version-3.jpg.webp", SecondsOrTimes: "10", Description: "Stand upright with feet together. Join your palms together in front of the chest in a prayer position."), YogaModel.TableName2);
      makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Hasta Uttanasana(Raised Arms Pose)", YogaImgUrl: "https://www.wikihow.com/images/thumb/5/52/Do-the-Surya-Namaskar-Step-3-Version-2.jpg/aid4547680-v4-728px-Do-the-Surya-Namaskar-Step-3-Version-2.jpg.webp", SecondsOrTimes: "10", Description: "Inhale, lift the arms up and back, keeping the biceps close to the ears. Stretch the whole body."), YogaModel.TableName2);
      makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Padahastasana(Hand to Foot Pose)", YogaImgUrl: "https://www.wikihow.com/images/thumb/8/8b/Do-the-Surya-Namaskar-Step-3-Version-3.jpg/aid4547680-v4-728px-Do-the-Surya-Namaskar-Step-3-Version-3.jpg.webp", SecondsOrTimes: "20", Description: "Exhale, bend forward from the waist, keeping the spine erect. Bring the hands down to the floor beside the feet."), YogaModel.TableName2);
      makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Ashwa Sanchalanasana(Equestrian Pose)", YogaImgUrl: "https://www.wikihow.com/images/thumb/f/f2/Do-the-Surya-Namaskar-Step-4-Version-2.jpg/aid4547680-v4-728px-Do-the-Surya-Namaskar-Step-4-Version-2.jpg.webp", SecondsOrTimes: "10", Description: "Inhale, push the right leg back as far as possible. Bring the right knee to the floor and look up."), YogaModel.TableName2);
      makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Dandasana(Stick Pose)", YogaImgUrl: "https://www.wikihow.com/images/thumb/a/a2/Do-the-Surya-Namaskar-Step-5-Version-3.jpg/aid4547680-v4-728px-Do-the-Surya-Namaskar-Step-5-Version-3.jpg.webp", SecondsOrTimes: "10", Description: "Hold the breath, bring the left leg back, and keep the body in a straight line. Keep the arms perpendicular to the floor."), YogaModel.TableName2);
      makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Ashtanga Namaskara(Salute with Eight Parts or Points)", YogaImgUrl: "https://www.wikihow.com/images/thumb/c/ca/Do-the-Surya-Namaskar-Step-6-Version-2.jpg/aid4547680-v4-728px-Do-the-Surya-Namaskar-Step-6-Version-2.jpg.webp", SecondsOrTimes: "10", Description: "Exhale, bring the knees down to the floor. Slightly touch the chest and chin to the floor. Raise the hips slightly."), YogaModel.TableName2);
      makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Bhujangasana(Cobra Pose)", YogaImgUrl: "https://www.wikihow.com/images/thumb/e/e6/Do-the-Surya-Namaskar-Step-7-Version-2.jpg/aid4547680-v4-728px-Do-the-Surya-Namaskar-Step-7-Version-2.jpg.webp", SecondsOrTimes: "10", Description: "Slide forward, raise the chest up into the Cobra pose. Keep the elbows bent in this pose with the shoulders away from the ears."), YogaModel.TableName2);
      makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Parvatasana(Mountain Pose)", YogaImgUrl: "https://www.wikihow.com/images/thumb/f/f2/Do-the-Surya-Namaskar-Step-8-Version-2.jpg/aid4547680-v4-728px-Do-the-Surya-Namaskar-Step-8-Version-2.jpg.webp", SecondsOrTimes: "10", Description: "Exhale, lift the hips and the tailbone up, bringing the body into an inverted 'V' pose."), YogaModel.TableName2);
      makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Ashwa Sanchalanasana(Equestrian Pose)", YogaImgUrl: "https://www.wikihow.com/images/thumb/3/38/Do-the-Surya-Namaskar-Step-9-Version-3.jpg/aid4547680-v4-728px-Do-the-Surya-Namaskar-Step-9-Version-3.jpg.webp", SecondsOrTimes: "10", Description: "Inhale, bring the right foot forward between the two hands. Left knee down to the floor. Press the hips down and look up."), YogaModel.TableName2);
      makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Padahastasana(Hand to Foot Pose)", YogaImgUrl: "https://www.wikihow.com/images/thumb/6/63/Do-the-Surya-Namaskar-Step-10-Version-3.jpg/aid4547680-v4-728px-Do-the-Surya-Namaskar-Step-10-Version-3.jpg.webp", SecondsOrTimes: "10", Description: "Exhale, bring the left foot forward. Keep the palms on the floor. Try to touch the nose to the knees."), YogaModel.TableName2);
      makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Hasta Uttanasana(Raised Arms Pose)", YogaImgUrl: "https://www.wikihow.com/images/thumb/4/49/Do-the-Surya-Namaskar-Step-11-Version-3.jpg/aid4547680-v4-728px-Do-the-Surya-Namaskar-Step-11-Version-3.jpg.webp", SecondsOrTimes: "10", Description: "Inhale, lift the arms up and back, keeping the biceps close to the ears. Stretch up the whole body."), YogaModel.TableName2);
      makeYogaEntry(Yoga(Seconds: true, YogaTitle: "Tadasana(Mountain Pose)", YogaImgUrl: "https://www.wikihow.com/images/thumb/a/a1/Do-the-Surya-Namaskar-Step-13.jpg/aid4547680-v4-728px-Do-the-Surya-Namaskar-Step-13.jpg.webp", SecondsOrTimes: "10", Description: "Exhale, straighten the body and bring the arms down. Relax in this position."), YogaModel.TableName2);
    }
  }

  void initState() {
    _animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _textanimationcontroller =
        AnimationController(vsync: this, duration: Duration(seconds: 0));
    _colortween = ColorTween(begin: Colors.transparent, end: Colors.white)
        .animate(_animationController);
    _icontween = ColorTween(begin: Colors.white, end: Colors.lightBlue)
        .animate(_animationController);
    _drawertween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    _hometween = ColorTween(begin: Colors.white, end: Colors.blue)
        .animate(_animationController);
    _yogatween = ColorTween(begin: Colors.white, end: Colors.black)
        .animate(_animationController);
    super.initState();
    readYogaSumEntry(YogaModel.TableSummary);
    //entry();
  }

  bool scrollListener(ScrollNotification scrollnotification) {
    bool scroll = false;
    if (scrollnotification.metrics.axis == Axis.vertical) {
      _animationController.animateTo(scrollnotification.metrics.pixels / 80);
      _textanimationcontroller.animateTo(scrollnotification.metrics.pixels);
      return true;
    }
    return scroll;
  }

  @override
  Widget build(BuildContext context) {
    return isLoading? Scaffold(
      body: Center(child: CircularProgressIndicator(),),
    )
        :
    ChangeNotifierProvider<HomeFitness>(
      create: (context)=>HomeFitness(),
      child: Scaffold(
        backgroundColor: Colors.white,
        drawer: Customdrawer(),
        key: _scaffoldkey,
        body: NotificationListener(
            onNotification: scrollListener,
            child: Container(
              height: double.infinity,
              child: Stack(
                children: [
                  SingleChildScrollView(
                      child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(50, 110, 50, 40),
                        decoration: BoxDecoration(
                            color: Colors.blue,
                            borderRadius: BorderRadius.only(
                                bottomRight: Radius.circular(13),
                                bottomLeft: Radius.circular(13))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              children: [
                                Consumer<HomeFitness>(
                                  builder: (context, myModel,child) {
                                    return Text("${myModel.streak}", style: TextStyle(
                                        color: Colors.white, fontSize: 24));
                                  }
                                    ),
                                Text("Streak",style: TextStyle(color: Colors.white,fontSize: 15)),
                              ],
                            ),
                            Column(
                              children: [
                                Consumer<HomeFitness>(
                                    builder: (context, myModel2,child) {
                                      return Text("${myModel2.burntCal}", style: TextStyle(
                                          color: Colors.white, fontSize: 24));
                                    }
                                ),
                                Text("KCAL",style: TextStyle(color: Colors.white,fontSize: 15)),
                              ],
                            ),
                            Column(
                              children: [
                                Consumer<HomeFitness>(
                                    builder: (context, myModel3,child) {
                                      return Text("${myModel3.mins}", style: TextStyle(
                                          color: Colors.white, fontSize: 24));
                                    }
                                ),
                                Text("Minutes",style: TextStyle(color: Colors.white,fontSize: 15)),
                              ],
                            )
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.fromLTRB(17, 20, 17, 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Text("Yoga For All",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            ListView.builder(
                              itemCount: yogasumlist.length,
                              shrinkWrap: true,
                                physics: NeverScrollableScrollPhysics(),
                                itemBuilder: (context, index)=>InkWell(
                                  onTap: (){
                                    Navigator.push(context, MaterialPageRoute(builder: (context)=>Startup(yogasumlist[index])));
                                  },
                                  child: Container(
                                    margin: EdgeInsets.only(bottom: 20),
                                    child: Stack(
                                      children: [
                                        Container(
                                            height: 200,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.circular(8),
                                                image: DecorationImage(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(yogasumlist[index].BackImgUrl.toString())))),
                                        Container(
                                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.black26,),
                                          height: 200,

                                        ),
                                        Positioned(child: Text(yogasumlist[index].YogaPackName,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,color: Colors.white),),
                                          top: 10,
                                          left: 10,
                                          right: 20,
                                        ),
                                        Positioned(child: Text("${yogasumlist[index].TotalTime} Minutes",style: TextStyle(color: Colors.white,fontSize: 14),),
                                          top: 38,
                                          left: 12,
                                          right: 30,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                            ),
                          ],
                        ),
                      ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(17, 0, 17, 6),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Padding(
                      //         padding: EdgeInsets.only(bottom: 15),
                      //         child: Text("Yoga For Students",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(bottom: 20),
                      //         child: Stack(
                      //           children: [
                      //             Container(
                      //                 height: 200,
                      //                 decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.circular(8),
                      //                     image: DecorationImage(
                      //                         fit: BoxFit.cover,
                      //                         image: AssetImage(
                      //                             "assets/images/yoga1.jpg")))),
                      //             Container(
                      //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.black26,),
                      //               height: 200,
                      //
                      //             ),
                      //             Positioned(child: Text("Yoga To Increase Concentration",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,color: Colors.white),),
                      //               top: 10,
                      //               left: 10,
                      //               right: 20,
                      //             ),
                      //             Positioned(child: Text("Last Time: Today",style: TextStyle(color: Colors.white,fontSize: 14),),
                      //               top: 38,
                      //               left: 12,
                      //               right: 30,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(bottom: 20),
                      //         child: Stack(
                      //           children: [
                      //             Container(
                      //                 height: 200,
                      //                 decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.circular(8),
                      //                     image: DecorationImage(
                      //                         fit: BoxFit.cover,
                      //                         image: AssetImage(
                      //                             "assets/images/yoga1.jpg")))),
                      //             Container(
                      //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.black26,),
                      //               height: 200,
                      //
                      //             ),
                      //             Positioned(child: Text("Yoga For Stress Relief",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,color: Colors.white),),
                      //               top: 10,
                      //               left: 10,
                      //               right: 20,
                      //             ),
                      //             Positioned(child: Text("Last Time: Today",style: TextStyle(color: Colors.white,fontSize: 14),),
                      //               top: 38,
                      //               left: 12,
                      //               right: 30,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(bottom: 20),
                      //         child: Stack(
                      //           children: [
                      //             Container(
                      //                 height: 200,
                      //                 decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.circular(8),
                      //                     image: DecorationImage(
                      //                         fit: BoxFit.cover,
                      //                         image: AssetImage(
                      //                             "assets/images/yoga1.jpg")))),
                      //             Container(
                      //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.black26,),
                      //               height: 200,
                      //
                      //             ),
                      //             Positioned(child: Text("Yoga For Good Sleep",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,color: Colors.white),),
                      //               top: 10,
                      //               left: 10,
                      //               right: 20,
                      //             ),
                      //             Positioned(child: Text("Last Time: Today",style: TextStyle(color: Colors.white,fontSize: 14),),
                      //               top: 38,
                      //               left: 12,
                      //               right: 30,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      // Container(
                      //   margin: EdgeInsets.fromLTRB(17, 0, 17, 6),
                      //   child: Column(
                      //     crossAxisAlignment: CrossAxisAlignment.start,
                      //     children: [
                      //       Padding(
                      //         padding: EdgeInsets.only(bottom: 15),
                      //         child: Text("Yoga For Old Ages",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(bottom: 20),
                      //         child: Stack(
                      //           children: [
                      //             Container(
                      //                 height: 200,
                      //                 decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.circular(8),
                      //                     image: DecorationImage(
                      //                         fit: BoxFit.cover,
                      //                         image: AssetImage(
                      //                             "assets/images/yoga1.jpg")))),
                      //             Container(
                      //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.black26,),
                      //               height: 200,
                      //
                      //             ),
                      //             Positioned(child: Text("Surya Namaskar",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,color: Colors.white),),
                      //               top: 10,
                      //               left: 10,
                      //               right: 20,
                      //             ),
                      //             Positioned(child: Text("Last Time: Today",style: TextStyle(color: Colors.white,fontSize: 14),),
                      //               top: 38,
                      //               left: 12,
                      //               right: 30,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(bottom: 20),
                      //         child: Stack(
                      //           children: [
                      //             Container(
                      //                 height: 200,
                      //                 decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.circular(8),
                      //                     image: DecorationImage(
                      //                         fit: BoxFit.cover,
                      //                         image: AssetImage(
                      //                             "assets/images/yoga1.jpg")))),
                      //             Container(
                      //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.black26,),
                      //               height: 200,
                      //
                      //             ),
                      //             Positioned(child: Text("Breathing Yoga",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,color: Colors.white),),
                      //               top: 10,
                      //               left: 10,
                      //               right: 20,
                      //             ),
                      //             Positioned(child: Text("Last Time: Today",style: TextStyle(color: Colors.white,fontSize: 14),),
                      //               top: 38,
                      //               left: 12,
                      //               right: 30,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //       Container(
                      //         margin: EdgeInsets.only(bottom: 20),
                      //         child: Stack(
                      //           children: [
                      //             Container(
                      //                 height: 200,
                      //                 decoration: BoxDecoration(
                      //                     borderRadius: BorderRadius.circular(8),
                      //                     image: DecorationImage(
                      //                         fit: BoxFit.cover,
                      //                         image: AssetImage(
                      //                             "assets/images/yoga1.jpg")))),
                      //             Container(
                      //               decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.black26,),
                      //               height: 200,
                      //
                      //             ),
                      //             Positioned(child: Text("Power Yoga",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,color: Colors.white),),
                      //               top: 10,
                      //               left: 10,
                      //               right: 20,
                      //             ),
                      //             Positioned(child: Text("Last Time: Today",style: TextStyle(color: Colors.white,fontSize: 14),),
                      //               top: 38,
                      //               left: 12,
                      //               right: 30,
                      //             ),
                      //           ],
                      //         ),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                      Container(
                        margin: EdgeInsets.fromLTRB(17, 0, 17, 6),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(bottom: 15),
                              child: Text("Choose Your Type",style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Stack(
                                children: [
                                  Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/images/yoga1.jpg")))),
                                  Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.black26,),
                                    height: 200,

                                  ),
                                  Positioned(child: Text("Increase Flexibilty",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,color: Colors.white),),
                                    top: 10,
                                    left: 10,
                                    right: 20,
                                  ),
                                  Positioned(child: Text("Last Time: Today",style: TextStyle(color: Colors.white,fontSize: 14),),
                                    top: 38,
                                    left: 12,
                                    right: 30,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Stack(
                                children: [
                                  Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/images/yoga1.jpg")))),
                                  Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.black26,),
                                    height: 200,

                                  ),
                                  Positioned(child: Text("Weight Loss Yoga",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,color: Colors.white),),
                                    top: 10,
                                    left: 10,
                                    right: 20,
                                  ),
                                  Positioned(child: Text("Last Time: Today",style: TextStyle(color: Colors.white,fontSize: 14),),
                                    top: 38,
                                    left: 12,
                                    right: 30,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.only(bottom: 20),
                              child: Stack(
                                children: [
                                  Container(
                                      height: 200,
                                      decoration: BoxDecoration(
                                          borderRadius: BorderRadius.circular(8),
                                          image: DecorationImage(
                                              fit: BoxFit.cover,
                                              image: AssetImage(
                                                  "assets/images/yoga1.jpg")))),
                                  Container(
                                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(8),color: Colors.black26,),
                                    height: 200,

                                  ),
                                  Positioned(child: Text("Yoga For Athletes",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 19,color: Colors.white),),
                                    top: 10,
                                    left: 10,
                                    right: 20,
                                  ),
                                  Positioned(child: Text("Last Time: Today",style: TextStyle(color: Colors.white,fontSize: 14),),
                                    top: 38,
                                    left: 12,
                                    right: 30,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
                  CustomAppBar(
                      animationController: _animationController,
                      colortween: _colortween,
                      icontween: _icontween,
                      drawertween: _drawertween,
                      yogatween: _yogatween,
                      hometween: _hometween,
                      onPressed: () {
                        _scaffoldkey.currentState?.openDrawer();
                      })
                ],
              ),
            )),
      ),
    );
  }
}
class HomeFitness extends ChangeNotifier{
  HomeFitness(){
    getFitnessData();
  }
  late int streak=0, burntCal=0, mins=0;
  @override
  getFitnessData() async {
    streak=await LocalDB.getStreak()??0;
    burntCal=await LocalDB.getKcal()??0;
    mins=await LocalDB.getWorkOutMin()??0;
    notifyListeners();
  }
}
