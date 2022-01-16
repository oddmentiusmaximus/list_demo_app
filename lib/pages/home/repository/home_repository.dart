import 'package:countriesdemo/database/database_helper.dart';
import 'package:countriesdemo/model/country_model.dart';
import 'package:countriesdemo/web_utilities/api_helper.dart';
import 'package:countriesdemo/app_config/configs.dart';

class HomeRepository {
  Future<dynamic> getAllCountries() async {
    final response = await ApiHelper.instance.getData(API.countriesApi);
    if (response['status'] == true) {
      return CountryModel.fromJson(response);
    }
  }

  Future<dynamic> getCountriesDb() async {
    final response = await DBHelper().getCountries();
    return response;
  }

  Future<dynamic> addCountriesDb(Country countryModel) async {
    final response = await DBHelper().saveCountries(countryModel);
    return response;
  }

  Future<dynamic> deleteCountriesDb(key) async {
    final response = await DBHelper().deleteCountries(key);
    return response;
  }
}
