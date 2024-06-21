import 'package:get/get.dart';
import 'package:hero/lang/translation_service.dart';
//import 'package:hero/modules/auth/auth_controller.dart';
import 'package:hero/modules/forgot-password/forgot-password-controller.dart';
import 'package:hero/modules/publish_ad/publish_ad.dart';
import 'package:hero/routes/app_pages.dart';
// import 'package:hero/modules/forgot-password/forgot-password.dart';
// import 'package:hero/modules/registry/widgets/button_continue_widget.dart';
// import 'package:hero/routes/routes.dart';
import 'package:hero/shared/constants/colors.dart';
import 'package:hero/shared/widgets/custom_widgets.dart';
import 'package:hero/theme/theme.dart';
import 'package:flutter/material.dart';

class AfterPayment extends StatefulWidget {
  AfterPayment();

  @override
  _AfterPaymentState createState() => _AfterPaymentState();
}

class _AfterPaymentState extends State<AfterPayment> {
  bool passwordVisibility = false;
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  //var controller = Get.find<AuthController>();
  String local = TranslationService.locale.toString();
  final controller = Get.find<PublishAdController>();

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          local.substring(0, 3) == "it_"
              ? "Inserimento annumcio"
              : local.substring(0, 3) == "en_"
                  ? "Ad insertion"
                  : "Inserción de anuncios",
          style: TextStyle(color: ColorConstants.white, fontSize: 22),
        ),
        backgroundColor: ColorConstants.principalColor,
        iconTheme: IconThemeData(color: ColorConstants.titlePrincipal),
      ),
      body: ListView(children: [
        IngresarCodigo(),
        SizedBox(
          height: 20.0,
        ),
        Container(
          width: 200,
          height: 50,
          child: TextButton(
              onPressed: () {
                controller.nexStep(Routes.HOME);
              },
              style: TextButton.styleFrom(
                  backgroundColor: ColorConstants.principalColor),
              child: Text(
                local.substring(0, 3) == "it_"
                    ? "Inserisci un altro annuncio"
                    : local.substring(0, 3) == "en_"
                        ? "Place another ad"
                        : "Poner otro anuncio",
                style: TextStyle(color: Colors.white, fontSize: 18.0),
              )),
        ),
      ]),
    );
  }
}

class IngresarCodigo extends StatelessWidget {
  IngresarCodigo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String local = TranslationService.locale.toString();
    return Padding(
      padding: EdgeInsetsDirectional.fromSTEB(16, 20, 16, 0),
      child: Column(
        children: [
          SizedBox(
            child: Image(
              image: AssetImage('assets/images/favicon.png'),
              width: 200,
              height: 200,
            ),
          ),
          SizedBox(
            height: 10,
          ),
          TitlePrincipalAds(
            local.substring(0, 3) == "it_"
                ? "Ottimo, abbiamo"
                : local.substring(0, 3) == "en_"
                    ? "Great, we have"
                    : 'Genial, tenemos',
          ),
          TitlePrincipalAds(
            local.substring(0, 3) == "it_"
                ? "Ricevuto il tuo annuncio"
                : local.substring(0, 3) == "en_"
                    ? "Received your ad"
                    : 'Recibí tu anuncio',
          ),
          TitlePrincipalAds(
            local.substring(0, 3) == "it_"
                ? "Ecco cosa succedera ora:"
                : local.substring(0, 3) == "en_"
                    ? "Here's what will happen now:"
                    : 'Esto es lo que sucederá ahora:',
          ),
          TitlePrincipalAds(
            local.substring(0, 3) == "it_"
                ? "1. Revisioneremo il tuo annuncio, lo facciamo per garantire alla nosta community annunci sicuri e di qualita."
                : local.substring(0, 3) == "en_"
                    ? "1. We will review your ad, we do this to guarantee our community safe and quality ads."
                    : '1. Revisaremos su anuncio, lo hacemos para garantizar a nuestra comunidad anuncios seguros y de calidad.',
          ),
          TitlePrincipalAds(
            local.substring(0, 3) == "it_"
                ? "2. Riceveral una email di converma appena il tuo annunico verra approvato."
                : local.substring(0, 3) == "en_"
                    ? "2. You will receive a confirmation email as soon as your advert is approved."
                    : '2. Recibirá un correo electrónico de confirmación tan pronto como se apruebe su anuncio.',
          ),
          TitlePrincipalAds(
            local.substring(0, 3) == "it_"
                ? "3. Troverai il tuo annuncio online su subito e nella tua area riservata dopo pochi minuti dalla ricezione della mail."
                : local.substring(0, 3) == "en_"
                    ? "3. You will find your ad online immediately and in your reserved area a few minutes after receiving the email."
                    : '3. Encontrarás tu anuncio online inmediatamente y en tu área reservada unos minutos después de recibir el correo electrónico.',
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 10,
          ),
        ],
      ),
    );
  }
}
