import 'package:ifly_corporate_app/app_environment/setup/config/flavor_conf.dart';
import 'package:ifly_corporate_app/data/models/remote/corporate_list_model.dart';
import 'package:ifly_corporate_app/data/utils/json_client.dart';

class CorporateProvider {
  
  CorporateProvider({JsonClient client}) : _client =  client ?? JsonClient();
  static const fileName = 'corporate_list.json';
  final JsonClient _client;
  
  Future<List<CorporateModel>> getAllCorporates() async {
    final basePath = FlavorConfig.instance.properties['dummy_json_data'];
    final filePath = '$basePath$fileName';
    final map = await _client.fecth(filePath);
    final corporateListModel = CorporatesListModel.fromJson(map);
    return corporateListModel.corporates;
  }

  Future<CorporateModel> getCorporate(String corporateId) async {
    final List<CorporateModel> corporates = await getAllCorporates();
    final corporate = corporates.firstWhere((element) => element.companyCode == corporateId, orElse: () => null);
    if(corporate == null) {
     return CorporateModel(
       
       status: StatusModel(
       statusCode: '-1',
       statusDescription: 'Not found any corporateModel'
       ),);
    } 
    return corporate;
  }
}
