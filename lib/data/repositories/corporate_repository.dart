import 'package:flutter/foundation.dart';
import 'package:ifly_corporate_app/data/models/local/auth_prefrence_data.dart';
import 'package:ifly_corporate_app/data/models/remote/corporate_list_model.dart';
import 'package:ifly_corporate_app/data/providers/corporate_provider.dart';
import 'package:ifly_corporate_app/data/providers/local_storage_provider.dart';

class CorporateRepository {
  CorporateRepository(
      {CorporateProvider corporateProvider,
      LocalStorageProvider localStorageProvider})
      : _corporateProvider = corporateProvider ?? CorporateProvider(),
        _localStorageProvider = localStorageProvider ?? LocalStorageProvider();
        
  final CorporateProvider _corporateProvider;
  final LocalStorageProvider _localStorageProvider;


  Future<CorporatePreference> getCorporatePreference() async {

    try {
       final corporate = await _localStorageProvider.read(LocalStorageEntity.corporate);
       return corporate;
    } catch (ex){
       rethrow;
    }
  }
   Future<bool> clearCorporatePreference() async {
      try {
       final isRemoved = await _localStorageProvider.remove(LocalStorageEntity.corporate);
       return isRemoved;
    } catch (ex){
       rethrow;
    }
  }
  Future<bool> updateCorporatePreference(CorporateModel corporate) async {
    return _localStorageProvider.update(LocalStorageEntity.corporate, CorporatePreference.fromModel(model: corporate));
  }


  Future<CorporateModel> authenticate({@required String corporateCode,}) async {
    return _corporateProvider.getCorporate(corporateCode);
  }
}
