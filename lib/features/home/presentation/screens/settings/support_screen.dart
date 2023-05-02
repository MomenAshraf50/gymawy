import 'package:flutter/material.dart';
import 'package:gymawy/core/util/resources/constants_manager.dart';
import 'package:gymawy/core/util/resources/extensions_manager.dart';
import 'package:gymawy/core/util/widgets/default_button.dart';
import 'package:gymawy/core/util/widgets/default_text_field.dart';
import 'package:gymawy/features/home/presentation/controller/home_cubit.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';

class SupportScreen extends StatelessWidget {
  const SupportScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String username = 'bookspot.mailsupp0rt@gmail.com';
    String password = 'hddalvmiwssrzogu';
    HomeCubit homeCubit = HomeCubit.get(context);
    return Scaffold(
      body: Padding(
        padding: designApp,
        child: Column(
          children: [
            defaultAppBar(
                title: 'Support',
                context: context
            ),
            verticalSpace(5.h),
            DefaultTextField(
                controller: homeCubit.supportTextController,
                hint: 'how can we help you',
                maxLines: 10,
            ),
            verticalSpace(5.h),
            DefaultButton(
                text: 'Send your Question',
                onPressed: ()
               async {
                 final smtpServer = gmail(username, password);
                  final message = Message()
                    ..from = Address(username, 'Gymawy Supporter')
                    ..recipients.add(username)
                    ..subject = 'Question from $email ${DateTime.now()}'
                    ..text = homeCubit.supportTextController.text
                    ..html = "<h1>Your OTP Verification code is ${homeCubit.supportTextController.text}</h1>";

                  try {
                    final sendReport = await send(message, smtpServer);
                    designToastDialog(context: context, toast: TOAST.success,text:'Question sent successfully');
                    homeCubit.supportTextController.text = '';
                    debugPrintFullText('Message sent: $sendReport');
                  } on MailerException catch (e) {
                    debugPrintFullText('Message not sent.');
                    designToastDialog(context: context, toast: TOAST.error,text:'please, try again!');
                    for (var p in e.problems) {
                    debugPrintFullText('Problem: ${p.code}: ${p.msg}');
                    }
                  }
               },
            )
          ],
        ),
      ),
    );
  }
}
