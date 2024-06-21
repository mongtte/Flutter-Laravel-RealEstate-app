import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hero/lang/lang.dart';
import 'package:hero/modules/me/cards/customer_sheet_screen.dart';
import 'package:hero/modules/publish_ad/publish_ad.dart';
import 'package:hero/theme/theme.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:hero/shared/shared.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  var controller = Get.find<PublishAdController>();
  final ScrollController _scrollController = ScrollController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  void initState() {
    super.initState();
    formKey = GlobalKey<FormState>();
  }

  String local = TranslationService.locale.toString();

  String selectedValue = "Private";

  void _handleRadioValueChanged(String? value) {
    setState(() {
      selectedValue = value!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 0,
      ),
      body: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              20.height,
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  20.width,
                  Text(
                    local.substring(0, 3) == "it_"
                        ? "Sono un/una"
                        : local.substring(0, 3) == "en_"
                            ? "I am a/an"
                            : "Soy un/una",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    children: [
                      Radio(
                          value: "Private",
                          groupValue: selectedValue,
                          onChanged: _handleRadioValueChanged),
                      Text(
                        local.substring(0, 3) == "it_"
                            ? "Privato"
                            : local.substring(0, 3) == "en_"
                                ? "Private"
                                : "Privado",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Radio(
                          value: "Agency",
                          groupValue: selectedValue,
                          onChanged: _handleRadioValueChanged),
                      Text(
                        local.substring(0, 3) == "it_"
                            ? "Agenzia"
                            : local.substring(0, 3) == "en_"
                                ? "Agency"
                                : "Agencia",
                        style: TextStyle(fontSize: 18),
                      )
                    ],
                  )
                ],
              ),
              selectedValue == "Agency"
                  ? privateSide()
                  : SizedBox(
                      child: Padding(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, top: 40),
                          child: Column(
                            children: [
                              Text(
                                "Total    \$${controller.price}",
                                style: ThemeConfig.bodyText1.override(
                                    color: Colors.black, fontSize: 25),
                              ),
                              20.height,
                              InkWell(
                                child: Container(
                                    height: 50,
                                    decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.circular(6),
                                      border: Border.all(
                                        color: Colors.white,
                                        width: 0.7,
                                      ),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Text(
                                          "Buy",
                                          style: TextStyle(
                                              fontSize: 24,
                                              color: Colors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ],
                                    )),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PaymentSheetScreenWithCustomFlow()));
                                },
                              ),
                            ],
                          )),
                    )
            ],
          )),
    );
  }

  Widget privateSide() {
    return Column(
      children: [
        Text(
          "Total    \$${controller.price}",
          style:
              ThemeConfig.bodyText1.override(color: Colors.black, fontSize: 25),
        ),
        Stack(children: [
          Container(
              padding: EdgeInsets.only(bottom: 60),
              child: Form(
                key: formKey,
                child: ListView(
                    controller: _scrollController,
                    shrinkWrap: true,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 15, top: 10, bottom: 10),
                        child: Text(
                          local.substring(0, 3) == "it_"
                              ? "Dati fiscali"
                              : local.substring(0, 3) == "en_"
                                  ? "Tax Data"
                                  : "Datos fiscales",
                          style: TextStyle(fontSize: 28),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TitlePrincipalAds(local.substring(0, 3) == "it_"
                            ? "Ragione sociale"
                            : local.substring(0, 3) == "en_"
                                ? "Business Name"
                                : "Nombre del Negocio"),
                      ),
                      PaymentField(controller.controllerBusinessName),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TitlePrincipalAds(local.substring(0, 3) == "it_"
                            ? "Partita IVA"
                            : local.substring(0, 3) == "en_"
                                ? "VAT Number"
                                : "Número de valor agregado"),
                      ),
                      PaymentField(controller.controllerVatNumber),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TitlePrincipalAds(local.substring(0, 3) == "it_"
                            ? "Codice Fiscale"
                            : local.substring(0, 3) == "en_"
                                ? "Tax ID Code"
                                : "Código de identificación fiscal"),
                      ),
                      PaymentField(controller.controllerTaxId),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TitlePrincipalAds(local.substring(0, 3) == "it_"
                            ? "Indirizzo sede legale"
                            : local.substring(0, 3) == "en_"
                                ? "Registered Office Address"
                                : "Dirección del domicilio social"),
                      ),
                      PaymentField(controller.controllerAddress),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TitlePrincipalAds(local.substring(0, 3) == "it_"
                            ? "Comune"
                            : local.substring(0, 3) == "en_"
                                ? "Common"
                                : "Común"),
                      ),
                      PaymentField(controller.controllerCommon),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TitlePrincipalAds(local.substring(0, 3) == "it_"
                            ? "Sigla Provincia"
                            : local.substring(0, 3) == "en_"
                                ? "Province Abbreviation"
                                : "Abreviatura de provincia"),
                      ),
                      PaymentField(controller.controllerProvince),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TitlePrincipalAds(local.substring(0, 3) == "it_"
                            ? "CAP"
                            : local.substring(0, 3) == "en_"
                                ? "Postal Code"
                                : "CÓDIGO POSTAL"),
                      ),
                      PaymentField(controller.controllerPostal),
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 10),
                        child: Text(
                          local.substring(0, 3) == "it_"
                              ? "Fattura elettronica"
                              : local.substring(0, 3) == "en_"
                                  ? "Electronic Invoice"
                                  : "Factura electrónica",
                          style: TextStyle(fontSize: 28),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TitlePrincipalAds(local.substring(0, 3) == "it_"
                            ? "Indirizzo PEC"
                            : local.substring(0, 3) == "en_"
                                ? "PEC Address"
                                : "dirección PEC"),
                      ),
                      PaymentField(controller.controllerPEC),
                      Padding(
                        padding: EdgeInsets.only(left: 15, top: 10, bottom: 10),
                        child: Text(
                          local.substring(0, 3) == "it_"
                              ? "Contatti"
                              : local.substring(0, 3) == "en_"
                                  ? "Contacts"
                                  : "Contactos",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TitlePrincipalAds(local.substring(0, 3) == "it_"
                            ? "Telefono"
                            : local.substring(0, 3) == "en_"
                                ? "Telephone"
                                : "Teléfono"),
                      ),
                      PaymentField(controller.controllerTelephone),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TitlePrincipalAds(local.substring(0, 3) == "it_"
                            ? "Fax"
                            : local.substring(0, 3) == "en_"
                                ? "Fax"
                                : "Fax"),
                      ),
                      PaymentField(controller.controllerFax),
                      Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: TitlePrincipalAds(local.substring(0, 3) == "it_"
                            ? "Referente"
                            : local.substring(0, 3) == "en_"
                                ? "Referent"
                                : "Referente"),
                      ),
                      PaymentField(controller.controllerReferent),
                      Padding(
                        padding: EdgeInsets.only(left: 15, right: 15, top: 10),
                        child: InkWell(
                          child: Container(
                              height: 50,
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 0.7,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    "Buy",
                                    style: TextStyle(
                                        fontSize: 24, color: Colors.white),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              )),
                          onTap: () {
                            if (formKey.currentState!.validate() &&
                                controller.postAgency() == true) {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          PaymentSheetScreenWithCustomFlow()));
                            }
                          },
                        ),
                      )
                    ]),
              ))
        ])
      ],
    );
  }
}
