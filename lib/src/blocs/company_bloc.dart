import 'package:flutter_app/src/models/company_info_model.dart';
import 'package:flutter_app/src/repositories/data_repository.dart';
import 'package:rxdart/rxdart.dart';

class CompanyBloc {
  final _dataRepository = DataRepository();
  final _companyFetcher = ReplaySubject<CompanyInfo>(maxSize: 1);

  Observable<CompanyInfo> get companyInfoStream => _companyFetcher.stream;

  fetchCompanyInfo() async {
    CompanyInfo companyInfo = await _dataRepository.getCompanyInfo();
    _companyFetcher.sink.add(companyInfo);
  }

  dispose() {
    _companyFetcher.close();
  }
}


final companyBloc = CompanyBloc();
