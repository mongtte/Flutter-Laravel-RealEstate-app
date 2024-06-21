import 'package:get/get.dart';

enum EnumTypeList {
  none,
  category,
  subCategory,
  typeAd,
  typePerson,
  statusProduct
}

enum EnumCategoryList {
  none,
  furniture,
  activity,
  franchise,
  supplier,
  consultant,
  entrepreneur
}

enum EnumTypeAdList {
  none,
  sell,
  buy,
  rent,
  rent2,
  supplier,
  search_supplier,
  consultant,
  search_consultant,
  entrepreneur,
  search_entrepreneur
}

enum EnumSubCategoryList {
  none,
  baking_cooking_and_ovens,
  refrigeration_cold_and_conservation,
  steel_furniture_and_furnishings_for_kitchen,
  kitchen_appliances,
  kitchen_utensils,
  furniture_decor_and_decoration,
  electronics_and_other_household_appliances,
  other,
  hotel,
  restaurant,
  bar_coffe,
  entertainment,
  ice_cream_and_cakes,
  pizza,
  gastronomy_and_rotisserie,
  food_laboratory,
  take_away_and_kiosks,
  food_and_raw_materials,
  professional_clothing_and_textiles,
  disposable_materials,
  advertising_material_and_stationery,
  food_packaging,
  cleaning_and_detergents,
  different_services,
  food_hygiene,
  business_consultant,
  commercial,
  geometry_architecture_and_design,
  legal,
  marketing,
  technology,
  job_security,
  financial_Insurance,
  safety,
  hotellerie_and_hotel_structures,
  catering_and_food,
  wellness,
}

Map<EnumSubCategoryList, dynamic> subCategoryMap =
    Map<EnumSubCategoryList, dynamic>();

String getStringTypeAd(EnumTypeAdList enumTypeAdList) {
  switch (enumTypeAdList) {
    case EnumTypeAdList.sell:
      return 'Sell';
    case EnumTypeAdList.buy:
      return 'Buy';
    case EnumTypeAdList.rent2:
      return 'Noleggio';
    case EnumTypeAdList.rent:
      return 'Rent';
    case EnumTypeAdList.supplier:
      return 'I am a supplier';
    case EnumTypeAdList.search_supplier:
      return 'Searching a supplier';
    case EnumTypeAdList.consultant:
      return 'I am an adviser';
    case EnumTypeAdList.search_consultant:
      return 'Searching an adviser';
    case EnumTypeAdList.entrepreneur:
      return 'I am entrepreneur';
    case EnumTypeAdList.search_entrepreneur:
      return 'Searching an entrepreneur';
    default:
      return 'Select:';
  }
}

String getStringTypeAdPublish(EnumTypeAdList enumTypeAdList) {
  switch (enumTypeAdList) {
    case EnumTypeAdList.sell:
      return 'Sell'.tr;
    case EnumTypeAdList.buy:
      return 'Buy'.tr;
    case EnumTypeAdList.rent2:
      return 'Noleggio'.tr;
    case EnumTypeAdList.rent:
      return 'Rent'.tr;
    case EnumTypeAdList.supplier:
      return 'I am a supplier'.tr;
    case EnumTypeAdList.search_supplier:
      return 'Searching a supplier'.tr;
    case EnumTypeAdList.consultant:
      return 'I am an adviser'.tr;
    case EnumTypeAdList.search_consultant:
      return 'Searching an adviser'.tr;
    case EnumTypeAdList.entrepreneur:
      return 'I am entrepreneur'.tr;
    case EnumTypeAdList.search_entrepreneur:
      return 'Searching an entrepreneur'.tr;
    default:
      return 'Select:'.tr;
  }
}

EnumCategoryList getEnumCategoryFromString(String stringCategory) {
  switch (stringCategory) {
    case 'ATTREZZATURE':
      return EnumCategoryList.furniture;
    case 'ATTIVITÀ':
      return EnumCategoryList.activity;
    case 'FRANCHISING':
      return EnumCategoryList.franchise;
    case 'FORNITORI':
      return EnumCategoryList.supplier;
    case 'CONSULENTI':
      return EnumCategoryList.consultant;
    case 'CONSULENTI':
      return EnumCategoryList.entrepreneur;
    default:
      return EnumCategoryList.none;
  }
}

EnumTypeAdList getEnumTypeAdFromString(String stringTypeAdList) {
  switch (stringTypeAdList) {
    case 'Vendo':
    case 'Sell':
      return EnumTypeAdList.sell;
    case 'Compro':
    case 'Buy':
      return EnumTypeAdList.buy;
    case 'Noleggio':
    case 'Rento':
    case 'Rent':
      return EnumTypeAdList.rent;
    case 'Affitto':
      return EnumTypeAdList.rent2;
    case 'Sono Fornitore':
    case 'Soy proveedor':
    case 'I am a supplier':
      return EnumTypeAdList.supplier;
    case 'Cerca Fornitore':
    case 'Searching a supplier':
    case 'Busco proveedor':
      return EnumTypeAdList.search_supplier;
    case 'Sono Consulente':
    case 'Soy un asesor':
    case 'I am an adviser':
      return EnumTypeAdList.consultant;
    case 'Cerca Consulente':
    case 'Busco asesor':
    case 'Searching an adviser':
      return EnumTypeAdList.search_consultant;
    case 'Sono Imprenditore':
    case 'Soy emprendedor':
    case 'I am entrepreneur':
      return EnumTypeAdList.entrepreneur;
    case 'Cerca Imprenditore':
    case 'Busco emprendedor':
    case 'Searching an entrepreneur':
      return EnumTypeAdList.search_entrepreneur;
    default:
      return EnumTypeAdList.sell;
  }
}

String getStringSubCategoryFromEnum(EnumSubCategoryList enumSubCategoryList) {
  switch (enumSubCategoryList) {
    case EnumSubCategoryList.none:
      return 'Selezionare:';

    case EnumSubCategoryList.baking_cooking_and_ovens:
      return 'Cottura, cucina e forni';

    case EnumSubCategoryList.refrigeration_cold_and_conservation:
      return 'Refrigerazione, freddo e conservazione';

    case EnumSubCategoryList.steel_furniture_and_furnishings_for_kitchen:
      return 'Mobili e arredo acciaio per cucina';

    case EnumSubCategoryList.kitchen_appliances:
      return 'Elettrodomestici per cucina';

    case EnumSubCategoryList.kitchen_utensils:
      return 'Utensili per cucina';

    case EnumSubCategoryList.furniture_decor_and_decoration:
      return 'Mobili, arredo e decorazione';

    case EnumSubCategoryList.electronics_and_other_household_appliances:
      return 'Elettronica e altri elettrodomestici';

    case EnumSubCategoryList.other:
      return 'Altro';

    case EnumSubCategoryList.hotel:
      return 'Hotel, B&B e altri alloggi';

    case EnumSubCategoryList.restaurant:
      return 'Ristoranti e trattorie';

    case EnumSubCategoryList.bar_coffe:
      return 'Bar e Caffetterie';

    case EnumSubCategoryList.entertainment:
      return 'Disco e Pub';

    case EnumSubCategoryList.ice_cream_and_cakes:
      return 'Gelateria e Pasticerie';

    case EnumSubCategoryList.pizza:
      return 'Pizzeria';

    case EnumSubCategoryList.gastronomy_and_rotisserie:
      return 'Gastronomia e Rosticeria';

    case EnumSubCategoryList.food_laboratory:
      return 'Laboratorio alimentare';

    case EnumSubCategoryList.take_away_and_kiosks:
      return 'Take away e chioschi';

    case EnumSubCategoryList.food_and_raw_materials:
      return 'Alimenti e materie prime';

    case EnumSubCategoryList.professional_clothing_and_textiles:
      return 'Abbigliamento e tessile professionale';

    case EnumSubCategoryList.disposable_materials:
      return 'Materiali monouso';

    case EnumSubCategoryList.advertising_material_and_stationery:
      return 'Materiale pubblicitario e cancelleria';

    case EnumSubCategoryList.food_packaging:
      return 'Packaging alimentari';

    case EnumSubCategoryList.cleaning_and_detergents:
      return 'Pulizia e detergenti';

    case EnumSubCategoryList.different_services:
      return 'Servizi diversi';

    case EnumSubCategoryList.food_hygiene:
      return 'HACCP/igiene degli alimenti';

    case EnumSubCategoryList.business_consultant:
      return 'Commercialista';

    case EnumSubCategoryList.commercial:
      return 'Commerciale';

    case EnumSubCategoryList.geometry_architecture_and_design:
      return 'Geometria / Architettura e Design';

    case EnumSubCategoryList.legal:
      return 'Legale';

    case EnumSubCategoryList.marketing:
      return 'Marketing';

    case EnumSubCategoryList.technology:
      return 'Tecnici informatici';

    case EnumSubCategoryList.job_security:
      return 'Sicurezza sul lavoro';

    case EnumSubCategoryList.financial_Insurance:
      return 'Finanziari/Assicurativi';

    case EnumSubCategoryList.safety:
      return 'Sicurezza';

    case EnumSubCategoryList.hotellerie_and_hotel_structures:
      return 'Hotellerie e strutture alberghiere';

    case EnumSubCategoryList.catering_and_food:
      return 'Catering e alimentare';

    case EnumSubCategoryList.wellness:
      return 'Benessere e Wellness';

    default:
      return 'Selezionare:';
  }
}

EnumSubCategoryList getEnumSubCategoryFromString(String stringTypeAdList) {
  switch (stringTypeAdList) {
    //furniture
    case 'Cottura, cucina e forni':
      return EnumSubCategoryList.baking_cooking_and_ovens;
    case 'Refrigerazione, freddo e conservazione':
      return EnumSubCategoryList.refrigeration_cold_and_conservation;
    case 'Mobili e arredo acciaio per cucina':
      return EnumSubCategoryList.steel_furniture_and_furnishings_for_kitchen;
    case 'Elettrodomestici per cucina':
      return EnumSubCategoryList.kitchen_appliances;
    case 'Utensili per cucina':
      return EnumSubCategoryList.kitchen_utensils;
    case 'Mobili, arredo e decorazione':
      return EnumSubCategoryList.furniture_decor_and_decoration;
    case 'Elettronica e altri elettrodomestici':
      return EnumSubCategoryList.electronics_and_other_household_appliances;
    case 'Altro':
      return EnumSubCategoryList.other;
    //activity/franchise
    case 'Hotel, B&B e altri alloggi':
      return EnumSubCategoryList.hotel;
    case 'Ristoranti e trattorie':
      return EnumSubCategoryList.restaurant;
    case 'Bar e Caffetterie':
      return EnumSubCategoryList.bar_coffe;
    case 'Disco e Pub':
      return EnumSubCategoryList.entertainment;
    case 'Gelateria e Pasticerie':
      return EnumSubCategoryList.ice_cream_and_cakes;
    case 'Pizzeria':
      return EnumSubCategoryList.pizza;
    case 'Gastronomia e Rosticeria':
      return EnumSubCategoryList.gastronomy_and_rotisserie;
    case 'Laboratorio alimentare':
      return EnumSubCategoryList.food_laboratory;
    case 'Take away e chioschi':
      return EnumSubCategoryList.take_away_and_kiosks;
    case 'Altri negozi (Panetteria, Alimentare, ecc)':
      return EnumSubCategoryList.other;
    //supplier
    case 'Alimenti e materie prime':
      return EnumSubCategoryList.food_and_raw_materials;
    case 'Abbigliamento e tessile professionale':
      return EnumSubCategoryList.professional_clothing_and_textiles;
    case 'Cottura, cucina e forni':
      return EnumSubCategoryList.baking_cooking_and_ovens;
    case 'Elettrodomestici per cucina':
      return EnumSubCategoryList.kitchen_appliances;
    case 'Elettronica e altri elettrodomestici':
      return EnumSubCategoryList.electronics_and_other_household_appliances;
    case 'Materiali monouso':
      return EnumSubCategoryList.disposable_materials;
    case 'Materiale pubblicitario e cancelleria':
      return EnumSubCategoryList.advertising_material_and_stationery;
    case 'Mobili, arredo e decorazione':
      return EnumSubCategoryList.furniture_decor_and_decoration;
    case 'Mobili e arredo acciaio per cucina':
      return EnumSubCategoryList.steel_furniture_and_furnishings_for_kitchen;
    case 'Packaging alimentari':
      return EnumSubCategoryList.food_packaging;
    case 'Pulizia e detergenti':
      return EnumSubCategoryList.cleaning_and_detergents;
    case 'Refrigerazione, freddo e conservazione':
      return EnumSubCategoryList.refrigeration_cold_and_conservation;
    case 'Servizi diversi':
      return EnumSubCategoryList.different_services;
    case 'Utensili per cucina':
      return EnumSubCategoryList.kitchen_utensils;
    //consultant
    case 'HACCP/igiene degli alimenti':
      return EnumSubCategoryList.food_hygiene;
    case 'Commercialista':
      return EnumSubCategoryList.business_consultant;
    case 'Commerciale':
      return EnumSubCategoryList.commercial;
    case 'Geometria / Architettura e Design':
      return EnumSubCategoryList.geometry_architecture_and_design;
    case 'Legale':
      return EnumSubCategoryList.legal;
    case 'Marketing':
      return EnumSubCategoryList.marketing;
    case 'Tecnici informatici':
      return EnumSubCategoryList.technology;
    case 'Sicurezza sul lavoro':
      return EnumSubCategoryList.job_security;
    case 'Finanziari/Assicurativi':
      return EnumSubCategoryList.financial_Insurance;
    case 'Sicurezza':
      return EnumSubCategoryList.safety;
    case 'Altri':
      return EnumSubCategoryList.other;
    //entrepreneur
    case 'Hotellerie e strutture alberghiere':
      return EnumSubCategoryList.hotellerie_and_hotel_structures;
    case 'Ristorazione e cucina':
      return EnumSubCategoryList.restaurant;
    case 'Catering e alimentare':
      return EnumSubCategoryList.catering_and_food;
    case 'Benessere e Wellness':
      return EnumSubCategoryList.wellness;
    case 'Divertimento, disco e pub':
      return EnumSubCategoryList.entertainment;
    case 'Altri negozi':
      return EnumSubCategoryList.other;
    default:
      return EnumSubCategoryList.none;
  }
}

List<String> paymentList = [
  'free_public'.tr,
  'on display for 1 day'.tr,
  'on display for 7 days'.tr,
  'on display for 1 month'.tr,
  'on display for 2 months'.tr
];

List<String> furnitureAdList = [
  'Sell'.tr,
  'Noleggio'.tr,
  'Buy'.tr,
];
List<String> activityAdList = [
  'Sell'.tr,
  'Rent'.tr,
  'Buy'.tr,
];
List<String> supplierAdList = [
  'I am a supplier'.tr,
  'Searching a supplier'.tr,
];
List<String> consultantAdList = [
  'I am an adviser'.tr,
  'Searching an adviser'.tr,
];
List<String> entrepreneurAdList = [
  'I am entrepreneur'.tr,
  'Searching an entrepreneur'.tr,
];
const List<String> furnitureSubCategoryList = [
  'Selezionare:',
  'Cottura, cucina e forni',
  'Refrigerazione, freddo e conservazione',
  'Mobili e arredo acciaio per cucina',
  'Elettrodomestici per cucina',
  'Utensili per cucina',
  'Mobili, arredo e decorazione',
  'Elettronica e altri elettrodomestici',
  'Altro',
];

const List<String> activitySubCategoryList = [
  'Selezionare:',
  'Hotel, B&B e altri alloggi',
  'Ristoranti e trattorie',
  'Bar e Caffetterie',
  'Disco e Pub',
  'Gelateria e Pasticerie',
  'Pizzeria',
  'Gastronomia e Rosticeria',
  'Laboratorio alimentare',
  'Take away e chioschi',
  'Altri negozi (Panetteria, Alimentare, ecc)',
];
const List<String> supplierSubCategoryList = [
  'Selezionare:',
  'Alimenti e materie prime',
  'Abbigliamento e tessile professionale',
  'Cottura, cucina e forni',
  'Elettrodomestici per cucina',
  'Elettronica e altri elettrodomestici',
  'Materiali monouso',
  'Materiale pubblicitario e cancelleria',
  'Mobili, arredo e decorazione',
  'Mobili e arredo acciaio per cucina',
  'Packaging alimentari',
  'Pulizia e detergenti',
  'Refrigerazione, freddo e conservazione',
  'Servizi diversi',
  'Utensili per cucina',
];
const List<String> consultantSubCategoryList = [
  'Selezionare:',
  'HACCP/igiene degli alimenti',
  'Commercialista',
  'Commerciale',
  'Geometria / Architettura e Design',
  'Legale',
  'Marketing',
  'Tecnici informatici',
  'Sicurezza sul lavoro',
  'Finanziari/Assicurativi',
  'Sicurezza',
  'Altro',
];
const List<String> entrepreneurSubCategoryList = [
  'Selezionare:',
  'Hotellerie e strutture alberghiere',
  'Ristorazione e cucina',
  'Catering e alimentare',
  'Benessere e Wellness',
  'Divertimento, disco e pub',
  'Altri negozi',
];

//=======================PEOPLETYPE===============================
List<String> itListPeopleType = [
  'Selezionare:',
  'Privato',
  'Partita IVA',
  'Azienda'
];
List<String> enListPeopleType = ['Select:', "Private", "IVA", "Agency"];
List<String> esListPeopleType = ['Seleccionar:', "Privado", "IVA", "Agencia"];

//=======================CONDITION===============================
List<String> itListCondition = [
  'Selezionare:',
  'Nuovo (mai usato)',
  'Come nuovo (poco usato)',
  'Buono (normale uso)',
  'Usurato (ma funzionante)',
  'Danneggiato (da riparare)'
];
List<String> enListCondition = [
  'Select:',
  'New (never used)',
  'Like new (slightly used)',
  'Good (normal usage)',
  'Worn (but working)',
  'Damaged (to be repaired)'
];
List<String> esListCondition = [
  'Seleccionar:',
  'Nuevo (nunca usado)',
  'Como nuevo (poco usado)',
  'Bueno (uso normal)',
  'Desgastado (pero trabajando)',
  'Dañado (para ser reparado)'
];

//=======================ADTYPE===================================
List<String> mueblesListIt = ["Vendo", "Compro", "Noleggio"];
List<String> mueblesListEn = ["Sell", "Buy", "Noleggio"];
List<String> mueblesListEs = ["Vendo", "Compro", "Rento"];
List<String> buyListIt = ['Vendo', 'Compro', 'Affitto'];

//===========PROVEDOR=================

List<String> proveedorListIt = [
  'Sono Fornitore',
  'Cerca Fornitore',
];

List<String> proveedorListEn = [
  'I am a supplier',
  'Searching a supplier',
];

List<String> proveedorListEs = [
  'Soy proveedor',
  'Busco proveedor',
];

//===========ASESOR=================

List<String> asesorListIt = [
  'Sono Consulente',
  'Cerca Consulente',
];

List<String> asesorListEn = [
  'I am an adviser',
  'Searching an adviser',
];

List<String> asesorListEs = [
  'Soy asesor',
  'Busco asesor',
];

//=============EMPRENDEDOR==============================

List<String> emprendedorListIt = [
  'Sono Imprenditore',
  'Cerca Imprenditore',
];

List<String> emprendedorListEn = [
  'I am entrepreneur',
  'Searching an entrepreneur',
];

List<String> emprendedorListEs = [
  'Soy emprendedor',
  'Busco emprendedor',
];

List<String> buyListEs = ['Vendo', 'Compro', 'Rento'];
List<String> buyListEn = ['Sell', 'Buy', 'Rent'];
