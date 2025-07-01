enum UpdatePassUiType { oldPass, newPass, confirmPass }

extension UpdatePasswordX on UpdatePassUiType {
  bool get isOld => this == UpdatePassUiType.oldPass;
  bool get isNew => this == UpdatePassUiType.newPass;
  bool get isConfirm => this == UpdatePassUiType.confirmPass;
}
