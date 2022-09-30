import 'package:farm/model/info_model.dart';
import 'package:farm/repository/info_repository.dart';
import 'package:get/get.dart';

class InfoController extends GetxController {
  RxList<InfoModel> info_list = <InfoModel>[].obs;
  Rx<InfoModel> info = InfoModel(
    bidtime: '',
    chulagtnm: '',
    coname: '',
    gradename: '',
    marketname: '',
    mclassname: '',
    price: '',
    sanji: '',
    sclassname: '',
    tradeamt: '',
    unitname: '',
  ).obs;

  late InfoRepository _infoRepository;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    _infoRepository = InfoRepository();

    fetchInfoState();
  }

  void fetchInfoState() async {
    var response = await _infoRepository.fetchInfo();

    if (response != null) {
      info(response);
    }
  }
}
