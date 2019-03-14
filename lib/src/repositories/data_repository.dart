import 'package:flutter_app/src/models/action_model.dart';
import 'package:flutter_app/src/models/company_info_model.dart';
import 'package:flutter_app/src/repositories/actions_api_provider.dart';
import 'package:flutter_app/src/repositories/company_api_provider.dart';

class DataRepository {
  final actionsApiProvider = ActionsApiProvider();
  final companyApiProvider = CompanyApiProvider();

  Future<CompanyInfo> getCompanyInfo() =>
      companyApiProvider.fetchCompanyInfo();

  Future<List<Action>> getAllActions() =>
      actionsApiProvider.fetchActionList();
}
