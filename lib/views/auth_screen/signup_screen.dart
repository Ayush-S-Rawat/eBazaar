import 'package:ebazaar/consts/consts.dart';
import 'package:ebazaar/controllers/auth_controller.dart';
import 'package:ebazaar/views/home_screen/home.dart';
import 'package:ebazaar/widgets_common/applogo_widget.dart';
import 'package:ebazaar/widgets_common/bg_widgets.dart';
import 'package:ebazaar/widgets_common/custom_textfields.dart';
import 'package:ebazaar/widgets_common/our_button.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  bool? ischecked = false;
  var controller = Get.put(AuthController());

  // text controllers
  var nameController = TextEditingController();
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var passwordRetypeController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return bgwidget(
        child: Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: Column(
          children: [
            (context.screenHeight * 0.1).heightBox,
            applogowidget(),
            "Join the $appname".text.fontFamily(bold).white.size(18).make(),
            15.heightBox,
            Column(
              children: [
                customTextField(
                    hint: nameHint,
                    title: name,
                    controller: nameController,
                    isPass: false),
                customTextField(
                    hint: emailHint,
                    title: email,
                    controller: emailController,
                    isPass: false),
                customTextField(
                    title: password,
                    hint: passwordHint,
                    controller: passwordController,
                    isPass: true),
                customTextField(
                    title: retypepassword,
                    hint: passwordHint,
                    controller: passwordRetypeController,
                    isPass: true),
                Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () {},
                    child: forgetpass.text.make(),
                  ),
                ),
                Row(
                  children: [
                    Checkbox(
                      activeColor: redColor,
                      checkColor: whiteColor,
                      value: ischecked,
                      onChanged: (newValue) {
                        setState(() {
                          ischecked = newValue;
                        });
                      },
                    ),
                    10.widthBox,
                    Expanded(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: "I agree to the ",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              ),
                            ),
                            TextSpan(
                              text: termsAndCond,
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              ),
                            ),
                            TextSpan(
                              text: " & ",
                              style: TextStyle(
                                fontFamily: regular,
                                color: fontGrey,
                              ),
                            ),
                            TextSpan(
                              text: privacyPolicy,
                              style: TextStyle(
                                fontFamily: regular,
                                color: redColor,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
                5.heightBox,
                ourButton(
                  color: (ischecked == true) ? redColor : lightGrey,
                  title: signup,
                  textColor: whiteColor,
                  onPress: () async {
                    if (ischecked != false) {
                      try {
                        await controller
                            .signupMethod(
                                context: context,
                                email: emailController.text,
                                password: passwordController.text)
                            .then((value) {
                          return controller.storeUserData(
                              email: emailController.text,
                              password: passwordController.text,
                              name: nameController.text);
                        }).then((value) {
                          VxToast.show(context, msg: loggedIn);
                          Get.offAll(() => Home());
                        });
                      } catch (e) {
                        auth.signOut();
                        VxToast.show(context, msg: e.toString());
                      }
                    }
                  },
                ).box.width(context.screenWidth - 50).make(),
                10.heightBox,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    alreadyHaveAccount.text.color(fontGrey).make(),
                    login.text.color(redColor).make().onTap(() {
                      Get.back();
                    })
                  ],
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
