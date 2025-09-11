import 'package:ip_country_lookup/models/ip_country_data_model.dart';
import 'package:nombres_apprendre_exercices/data/constantes.dart';

bool? reforme = true;
int? standardSelectionne = constanteFrance;

// Servent aux publicités
int nombreDeRecherches = 0;
int nombreDeNombresEntres = 0;

// Publicité
bool dejaCharge = false;
bool isCountryLoaded = false;

IpCountryData countryData = IpCountryData();
List<String> countriesRequiringGDPR = [
  "AT",
  "BE",
  "BG",
  "CY",
  "CH",
  "CZ",
  "DE",
  "DK",
  "EE",
  "ES",
  "FI",
  "FR",
  "GB",
  "GR",
  "HR",
  "HU",
  "IE",
  "IS",
  "IT",
  "LI",
  "LT",
  "LU",
  "LV",
  "MT",
  "NL",
  "NO",
  "PL",
  "PT",
  "RO",
  "SE",
  "SI",
  "SK",
];
