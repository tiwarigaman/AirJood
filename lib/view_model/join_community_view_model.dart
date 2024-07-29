import 'package:airjood/repository/join_community_repository.dart';
import 'package:flutter/widgets.dart';
import 'package:provider/provider.dart';
import '../utils/utils.dart';
import 'get_community_details_view_model.dart';
import 'get_community_list_view_model.dart';

class JoinCommunityViewModel extends ChangeNotifier {
  final myRepo = JoinCommunityRepository();
  bool _joinCommunityLoading = false;

  bool get addInvitationLoading => _joinCommunityLoading;

  joinCommunityLoading(bool val) {
    _joinCommunityLoading = val;
    notifyListeners();
  }

  Future<void> joinCommunityApi(dynamic token, Map<String, String> data,
      BuildContext context,{int? communityId}) async {
    joinCommunityLoading(true);
    myRepo.joinCommunityApi(token, data).then((value) {
      joinCommunityLoading(false);
      Provider.of<GetCommunityDetailsViewModel>(context, listen: false)
          .getCommunityDetailsApi(token, communityId!);
      Provider.of<GetCommunityListViewModel>(context, listen: false)
          .communityListGetApi(token, '');
      Utils.toastMessage('${value['message']}');
    }).onError((error, stackTrace) {
      joinCommunityLoading(false);
      Utils.toastMessage('$error');
    });
  }
}
