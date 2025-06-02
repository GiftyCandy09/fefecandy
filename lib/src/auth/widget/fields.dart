import 'package:candy_app/decoration.dart';
import 'package:dropdown_textfield/dropdown_textfield.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

// Fields
class Field_Title extends StatelessWidget {
  const Field_Title({
    required this.Title,
    super.key,
  });

  final String Title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Align(
        alignment: Alignment.topLeft,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: Text(Title,
              style: TextStyle(
                  fontFamily: "Montserrat",
                  fontSize: 14,
                  color: lightBlack,
                  fontWeight: FontWeight.w600)),
        ),
      ),
    );
  }
}

class PhoneField extends StatelessWidget {
  PhoneField({
    required this.controller,
    this.hint,
    super.key,
  });
  final TextEditingController controller;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 0.075,
        child: TextFormField(
          controller: controller,
          keyboardType: TextInputType.number,
          style: const TextStyle(
              fontFamily: "Montserrat",
              fontWeight: FontWeight.w500,
              fontSize: 14),
          decoration: InputDecoration(
            prefixIcon: Icon(
              FontAwesomeIcons.phone,
              color: black,
              size: 20,
            ),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            filled: true,
            hintText: hint,
            hintStyle: textBlackMedium,
            fillColor: lightWhite,
          ),
        ),
      ),
    );
  }
}

//

class AppTextField extends StatelessWidget {
  AppTextField({
    super.key,
    required this.controller,
    this.hint,
    this.icon,
    this.maxline,
  });
  final String? hint;
  final IconData? icon;
  final int? maxline;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.075,
          child: TextFormField(
              maxLines: maxline,
              controller: controller,
              keyboardType: TextInputType.text,
              style: const TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
                fontSize: 14,
              ),
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                  hintText: hint,
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide.none),
                  filled: true,
                  hintStyle: textBlackMedium,
                  fillColor: lightWhite,
                  prefixIcon: Icon(
                    icon,
                    size: 20,
                    color: black,
                  ))),
        ));
  }
}

class CustomTextField extends StatelessWidget {
  CustomTextField({
    super.key,
    required this.controller,
    this.hint,
    this.maxline,
  });
  final String? hint;

  final int? maxline;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
      child: TextFormField(
          maxLines: maxline,
          controller: controller,
          keyboardType: TextInputType.text,
          style: const TextStyle(
            fontFamily: "Montserrat",
            fontWeight: FontWeight.w500,
            fontSize: 14,
          ),
          textAlign: TextAlign.start,
          decoration: InputDecoration(
            hintText: hint,
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide.none),
            filled: true,
            hintStyle: textBlackMedium.copyWith(color: lightGrey, fontSize: 12),
            fillColor: lightWhite,
          )),
    );
  }
}

class AppNumField extends StatelessWidget {
  AppNumField({
    super.key,
    required this.controller,
    this.hint,
  });
  final String? hint;

  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.075,
          child: TextFormField(
              controller: controller,
              keyboardType: TextInputType.number,
              style: const TextStyle(
                fontFamily: "Montserrat",
                fontWeight: FontWeight.w500,
                fontSize: 13.5,
              ),
              textAlign: TextAlign.start,
              decoration: InputDecoration(
                hintText: hint,
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none),
                filled: true,
                hintStyle:
                    textBlackMedium.copyWith(color: lightGrey, fontSize: 12),
                fillColor: lightWhite,
              )),
        ));
  }
}

class CustomDropDownField extends StatelessWidget {
  const CustomDropDownField({
    super.key,
    required this.hint,
    required this.controller, // Changed 'value' to 'controller' for clarity
    required this.dropDownList, // Add the dropDownList parameter
  });
  final String? hint;
  final SingleValueDropDownController controller;
  final List<DropDownValueModel> dropDownList; // The list of users

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SizedBox(
          height: MediaQuery.of(context).size.height * 0.075,
          child: DropDownTextField(
            controller: controller,
            clearIconProperty: IconProperty(color: Colors.black),
            dropDownIconProperty: IconProperty(
              color: Colors.black,
              size: 40,
            ),
            enableSearch: true,
            textFieldDecoration: InputDecoration(
              hintStyle:
                  textBlackMedium.copyWith(color: lightGrey, fontSize: 12),
              hintText: hint,
              enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                  borderSide: BorderSide.none),
              filled: true,
              fillColor: lightWhite,
            ),
            dropdownColor: white,
            listSpace: 20,
            listPadding: ListPadding(top: 20),

            validator: (value) {
              if (value == null) {
                return "Required field";
              } else {
                return null;
              }
            },
            dropDownList: dropDownList, // Use the dynamic list here
            listTextStyle: textBlackMedium,
            dropDownItemCount: 5, // Adjust as needed, or remove for automatic
            onChanged: (val) {},
          ),
        ));
  }
}

class PasswordField extends StatelessWidget {
  PasswordField({
    super.key,
    required this.controller,
    required this.hint,
  });

  final TextEditingController controller;
  var isobscure = true.obs;
  final String hint;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Obx(
              () => SizedBox(
                height: MediaQuery.of(context).size.height * 0.075,
                child: TextFormField(
                  controller: controller,
                  obscureText: isobscure.value,
                  style: const TextStyle(
                      fontFamily: "Montserrat",
                      fontWeight: FontWeight.w500,
                      fontSize: 14),
                  decoration: InputDecoration(
                    hintText: hint,
                    prefixIcon: Obx(
                      () => IconButton(
                        onPressed: () {
                          isobscure.value = !isobscure.value;
                        },
                        icon: isobscure.value
                            ? Icon(
                                FontAwesomeIcons.lock,
                                color: black,
                                size: 20,
                              )
                            : Icon(
                                FontAwesomeIcons.lockOpen,
                                color: black,
                                size: 20,
                              ),
                      ),
                    ),
                    suffixIcon: Obx(
                      () => IconButton(
                        onPressed: () {
                          isobscure.value = !isobscure.value;
                        },
                        icon: isobscure.value
                            ? Icon(
                                FontAwesomeIcons.eyeSlash,
                                color: black,
                                size: 20,
                              )
                            : Icon(
                                FontAwesomeIcons.eye,
                                color: black,
                                size: 20,
                              ),
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                        borderSide: BorderSide.none),
                    filled: true,
                    hintStyle: textBlackMedium,
                    fillColor: lightWhite,
                  ),
                ),
              ),
            )));
  }
}

class Info_Field extends StatelessWidget {
  const Info_Field(
      {super.key,
      required this.width,
      required this.Title,
      required this.height,
      this.Info,
      this.icon});

  final double width;
  final double height;
  final String Title;
  final String? Info;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 12.5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: lightWhite,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Icon(
                icon,
                color: lightBlack,
                size: 25,
              ),
            ),
            SizedBox(
              width: width * 0.1,
            ),
            SizedBox(
              width: width * 0.65,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8, top: 8),
                    child: SizedBox(
                      width: width * 0.45,
                      // color: green,
                      child: Text(
                        Title,
                        style: textBlackMediumBold,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 8),
                    child: SizedBox(
                      // width: width * 0.95,

                      child: Text(
                        Info ?? "No Entry",
                        maxLines: 1,
                        style: textBlackMini,
                        overflow: TextOverflow.ellipsis,
                        textAlign: TextAlign.start,
                      ),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

// class SignUpPasswordField extends StatelessWidget {
//   const SignUpPasswordField({
//     super.key,
//     required this.controller,
//   });

//   final TextEditingController controller;

//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//         child: Padding(
//             padding: const EdgeInsets.only(top: 10),
//             child: FancyPasswordField(
//                 hidePasswordIcon: const Icon(
//                   FontAwesomeIcons.eye,
//                   color: Colors.black,
//                 ),
//                 showPasswordIcon: const Icon(
//                   FontAwesomeIcons.eyeSlash,
//                   color: Colors.black,
//                 ),
//                 hasStrengthIndicator: false,
//                 style: const TextStyle(
//                   fontSize: 12,
//                   fontFamily: 'Montserrat',
//                 ),
//                 cursorColor: Colors.black,
//                 decoration: InputDecoration(
//                     enabledBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide:
//                             const BorderSide(width: 2.5, color: Colors.black)),
//                     focusedBorder: OutlineInputBorder(
//                         borderRadius: BorderRadius.circular(10),
//                         borderSide:
//                             const BorderSide(width: 2.5, color: Colors.black))),
//                 controller: controller,
//                 validationRules: {
//                   DigitValidationRule(),
//                   UppercaseValidationRule(),
//                   LowercaseValidationRule(),
//                   SpecialCharacterValidationRule(),
//                   MinCharactersValidationRule(8),
//                 },
//                 strengthIndicatorBuilder: (strength) => Text(
//                       strength.toString(),
//                     ),
//                 validationRuleBuilder: (rules, value) {
//                   final allRulesValidated =
//                       rules.every((rule) => rule.validate(value));
//                   if (value.isEmpty) {
//                     return const SizedBox.shrink(); // Hide rules when empty
//                   }

//                   return allRulesValidated
//                       ? const SizedBox.shrink() // Hide the ListView
//                       : ListView(
//                           shrinkWrap: true,
//                           children: rules
//                               .map(
//                                 (rule) => rule.validate(value)
//                                     ? Row(
//                                         children: [
//                                           const Icon(
//                                             FontAwesomeIcons.solidCircleCheck,
//                                             color: Colors.green,
//                                           ),
//                                           const SizedBox(width: 12),
//                                           Text(
//                                             rule.name,
//                                             style: const TextStyle(
//                                               color: Colors.green,
//                                             ),
//                                           ),
//                                         ],
//                                       )
//                                     : Row(
//                                         children: [
//                                           const Icon(
//                                             Icons.close,
//                                             color: Colors.red,
//                                           ),
//                                           const SizedBox(width: 12),
//                                           Text(
//                                             rule.name,
//                                             style: const TextStyle(
//                                               color: Colors.red,
//                                             ),
//                                           ),
//                                         ],
//                                       ),
//                               )
//                               .toList(),
//                         );
//                 })));
//   }
// }
