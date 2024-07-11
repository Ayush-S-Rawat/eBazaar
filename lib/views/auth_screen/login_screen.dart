import 'package:ebazaar/consts/consts.dart';
import 'package:ebazaar/consts/lists.dart';
import 'package:ebazaar/controllers/auth_controller.dart';
import 'package:ebazaar/views/auth_screen/signup_screen.dart';
import 'package:ebazaar/views/home_screen/home.dart';
// import 'package:ebazaar/main.dart';
import 'package:ebazaar/widgets_common/applogo_widget.dart';
import 'package:ebazaar/widgets_common/bg_widgets.dart';
import 'package:ebazaar/widgets_common/custom_textfields.dart';
import 'package:ebazaar/widgets_common/our_button.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return bgwidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogowidget(),
            "Log in to $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Column(
              children: [
                customTextField(
                    hint: emailHint,
                    title: email,
                    isPass: false,
                    controller: controller.emailController),
                customTextField(
                    title: password,
                    hint: passwordHint,
                    isPass: true,
                    controller: controller.passwordController),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: forgetpass.text.make(),
                  ),
                ),
                5.heightBox,
                ourButton(
                  color: redColor,
                  title: login,
                  textColor: whiteColor,
                  onPress: () async {
                    await controller
                        .loginMethod(context: context)
                        .then((value) {
                      if (value != null) {
                        VxToast.show(context, msg: loggedIn);
                        Get.offAll(() => Home());
                      }
                    });
                  },
                ).box.width(context.screenWidth - 50).make(),
                5.heightBox,
                createNewAccount.text.color(fontGrey).make(),
                5.heightBox,
                ourButton(
                  color: lightGolden,
                  title: signup,
                  textColor: redColor,
                  onPress: () {
                    Get.to(() => SignupScreen());
                  },
                ).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                loginWith.text.color(fontGrey).make(),
                5.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                      3,
                      (index) => Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: CircleAvatar(
                              backgroundColor: lightGrey,
                              radius: 25,
                              child: Image.asset(
                                socialIconList[index],
                                width: 30,
                              ),
                            ),
                          )),
                )
              ],
            )
                .box
                .white
                .rounded
                .padding(EdgeInsets.all(16))
                .width(context.screenWidth - 70)
                .shadowSm
                .make(),
          ],
        ),
      ),
    ));
  }
}
