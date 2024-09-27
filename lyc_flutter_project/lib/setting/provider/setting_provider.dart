import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lyc_flutter_project/common/model/api_response.dart';
import 'package:lyc_flutter_project/setting/model/block_member.dart';
import 'package:lyc_flutter_project/setting/model/member_model.dart';
import 'package:lyc_flutter_project/setting/repository/setting_repository.dart';

class SettingProvider extends ChangeNotifier {
  final SettingRepositoryProvider repositoryProvider;

  SettingProvider({
    required this.repositoryProvider,
  });

  MemberModel? _memberModel;
  bool _loadingMember = true;

  List<BlockMember> _blockMembers = [];
  bool _loadingBlockMembers = false;
  bool _hasMoreBlockMembers = true;

  String? _oldPassword;
  String? _newPassword;
  String? _confirmPassword;

  PushAlarmModel? _pushAlarmModel;
  bool _loadingPushAlarm = true;

  get member => _memberModel;

  get loadingMember => _loadingMember;

  get alarm => _pushAlarmModel;

  get loadingPushAlarm => _loadingPushAlarm;

  get newPassword => _newPassword;

  get blockMembers => _blockMembers;

  get loadingBlockMembers => _loadingBlockMembers;

  Future<void> getProfile({
    bool refresh = false,
  }) async {
    try {
      if (_memberModel == null || refresh) {
        _loadingMember = true;
        notifyListeners();
        final resp = await repositoryProvider.repository.getMemberInfo();
        _memberModel = resp.result;
        _loadingMember = false;
        notifyListeners();
      }
    } catch (e) {
      _loadingPushAlarm = false;
      notifyListeners();
      throw Exception(e);
    }
  }

  void updateProfileImage(XFile newImage) {
    _memberModel =
        _memberModel!.copyWith(profileImage: newImage.path.toString());
  }

  void updateNickname(String newNickname) {
    _memberModel = _memberModel!.copyWith(nickname: newNickname);
  }

  void updateLoginId(String newLoginId) {
    _memberModel = _memberModel!.copyWith(loginId: newLoginId);
  }

  void updateIntroduction(String newIntroduction) {
    _memberModel = _memberModel!.copyWith(introduction: newIntroduction);
  }

  bool canSaveMemberInfo() {
    return true;
  }

  Future<void> saveMemberInfo() async {
    if (canSaveMemberInfo()) {
      await repositoryProvider.repository.updateMemberInfo(
        memberModel: _memberModel!,
      );
    }
  }

  void setOldPassword(String pw) {
    _oldPassword = pw;
  }

  void setNewPassword(String pw) {
    _newPassword = pw;
  }

  void setConfirmPassword(String pw) {
    _confirmPassword = pw;
  }

  Future<bool> checkOldPassword(String? pw) async {
    if (pw == null || pw.isEmpty) return false;
    try {
      PasswordModel tempModel =
          PasswordModel(oldPassword: pw, newPassword: "", confirmPassword: " ");
      await repositoryProvider.repository
          .updatePassword(passwordModel: tempModel);
      return false;
    } on DioException catch (e) {
      if (e.response?.data["code"] == "MEMBER4013") {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<bool> saveNewPassword() async {
    if (_oldPassword == null ||
        _newPassword == null ||
        _confirmPassword == null) {
      return false;
    }
    try {
      PasswordModel model = PasswordModel(
        oldPassword: _oldPassword!,
        newPassword: _newPassword!,
        confirmPassword: _confirmPassword!,
      );
      await repositoryProvider.repository.updatePassword(
        passwordModel: model,
      );
      return true;
    } on DioException catch (e) {
      if (e.response?.data["code"] == "MEMBER2014") {
        return true;
      } else {
        return false;
      }
    }
  }

  Future<void> getBlockMembers({
    bool refresh = false,
    int pageSize = 10,
    int? blockMemberId,
  }) async {
    if (_loadingBlockMembers || !_hasMoreBlockMembers) return;

    if (!refresh & _blockMembers.isNotEmpty) {
      blockMemberId = _blockMembers.last.memberId;
    }

    try {
      _loadingBlockMembers = true;
      notifyListeners();
      final resp = await repositoryProvider.repository.getBlockMembers(
        pageSize: pageSize,
        blockMemberId: blockMemberId,
      );
      final list = resp.result.members;
      _blockMembers = refresh
          ? [...list]
          : [
              ..._blockMembers,
              ...list,
            ];
      _hasMoreBlockMembers = list.length >= pageSize;
    } catch (e) {
      if (e is ApiResponse) {
        print("error in getRanking: ${e.message}");
      } else {
        print("error in getRanking");
      }
    } finally {
      _loadingBlockMembers = false;
      notifyListeners();
    }
  }

  Future<void> blockMember({required int memberId}) async {
    try {
      await repositoryProvider.repository.blockMember(memberId: memberId);
      await getBlockMembers(refresh: true);
    } catch (e) {
      if (e is ApiResponse) {
        Exception(e.message);
      } else {
        Exception(e);
      }
    }
  }

  Future<void> unblockMember({required int memberId}) async {
    try {
      await repositoryProvider.repository.unblockMember(memberId: memberId);
    } catch (e) {
      if (e is ApiResponse) {
        Exception(e.message);
      } else {
        Exception(e);
      }
    }
  }

  void updatePushAlarm({
    bool dm = false,
    bool feed = false,
    bool schedule = false,
    bool likeMark = false,
    bool event = false,
    bool ad = false,
  }) async {
    if (dm) _pushAlarmModel = _pushAlarmModel!.copyWith(dm: dm);
    if (feed) _pushAlarmModel = _pushAlarmModel!.copyWith(feed: feed);
    if (schedule)
      _pushAlarmModel = _pushAlarmModel!.copyWith(schedule: schedule);
    if (likeMark)
      _pushAlarmModel = _pushAlarmModel!.copyWith(likeMark: likeMark);
    if (event) _pushAlarmModel = _pushAlarmModel!.copyWith(event: event);
    if (ad) _pushAlarmModel = _pushAlarmModel!.copyWith(ad: ad);
    notifyListeners();
  }
}
