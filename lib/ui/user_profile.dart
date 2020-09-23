import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'file:///D:/real_estate_app/lib/bloc/profile/profile_bloc.dart';
import 'package:real_estate_app/model/get_profile.dart';
import 'package:real_estate_app/ui/house_deatil_profile.dart';
import 'package:real_estate_app/widget/card_designer_home.dart';
import 'package:real_estate_app/widget/color_app.dart';

class UserProfile extends StatefulWidget {
  @override
  _UserProfile createState() => _UserProfile();
}

class _UserProfile extends State<UserProfile> {

  @override
  void initState() {
    BlocProvider.of<ProfileBloc>(context)..add(GetProfileUserEvent());
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      body: body(),
    );
  }

  Widget appBar() {
    return AppBar(
      backgroundColor: Colors.grey.shade100,
      elevation: 0,
      centerTitle: false,
      actions: <Widget>[
        Transform.translate(
          offset: Offset(0, 15),
          child: Text(
            "الملف الشخصي",
            style: TextStyle(fontSize: 20, color: Colors.black54),
          ),
        ),
        SizedBox(
          width: 25,
        ),
      ],
    );
  }

  Widget body() {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, ProfileState state) {
        if (state is ProfileInitial)
          return Center(child: CircularProgressIndicator());
        else if (state is LoadingDataProfile)
          return Center(child: CircularProgressIndicator());
        else if(state is InvalidFetchState)
          return Center(child: IconButton(onPressed: (){
            BlocProvider.of<ProfileBloc>(context)..add(GetProfileUserEvent());
          },icon: Icon(Icons.refresh,color: colorApp,),),);
        else if(state is FetchProfile)
          return showProfile(state.getProfile);
        else
          return Text("Invalid response");
      },
    );
  }

  Widget showProfile(GetProfile getProfile){
    return ListView(
        padding:
        EdgeInsets.only(top: 20, bottom: 20, right: 15, left: 15),
        children: [
          profileImage(),
          space(height: 30),
          rowInfo(text: getProfile.data.user.firstName + getProfile.data.user.lastName, title:"الاسم الكامل:" ),
          space(),
          Divider(),
          space(),
          rowInfo(text: getProfile.data.user.email, title:"البريد الاكتروني :" ),
          space(),
          Divider(),
          space(),
          rowInfo(
              text: getProfile.data.user.phone == null
                  ? "لا يوجد"
                  : getProfile.data.user.phone,
              title: "رقم الهاتف :" ),
          Divider(),
          space(height: 20),
          Padding(
            padding: EdgeInsets.only(top: 10.0),
            child: Container(
              height: MediaQuery.of(context).size.height * .3,
              width: MediaQuery.of(context).size.width * .9,
              child: ListView.builder(
                physics: BouncingScrollPhysics(),
                shrinkWrap: true,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) => HouesDetailProfile(
                            properties:getProfile.data.properties[index],
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          left: 8, right: 0),
                      child: CardDesignerHome(imageUrl: getProfile.data.properties[index].img,price: getProfile.data.properties[index].price.toString(),),
                    ),
                  );
                },
                itemCount: getProfile.data.properties.length,
              ),
            ),
          ),
        ]);
  }

  Widget space({double height, double width}) {
    return SizedBox(
      height: height ?? 10,
      width: width ?? 0,
    );
  }

  Widget rowInfo({@required String title, @required String text }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          text ?? "",
          textDirection: TextDirection.rtl,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        SizedBox(
          width: 20,
        ),
        Text(
          title,
          textDirection: TextDirection.rtl,
          style: TextStyle(color: Colors.black, fontSize: 18),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }

  Widget profileImage() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Material(
          elevation: 5.0,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(90)),
          shadowColor: activeIconNavBar.withOpacity(0.3),
          child: Container(
            width: 100,
            height: 100,
            child: Center(child: Icon(CupertinoIcons.person_solid,color: colorApp,size: 60,),),
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: Colors.white),
          ),
        ),
      ],
    );
  }
}
