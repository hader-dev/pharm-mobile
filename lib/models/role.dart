class Role {
  final int roleId;
  final String label;

  const Role({
    required this.roleId,
    required this.label,
  });

  factory Role.superAdmin() => const Role(roleId: 1, label: 'Super Admin');
  factory Role.admin() => const Role(roleId: 2, label: 'Admin');
  factory Role.guest() => const Role(roleId: 3, label: 'Guest');
  factory Role.distributionManager() =>
      const Role(roleId: 4, label: 'Distribution Manager');
  factory Role.distributionOperator() =>
      const Role(roleId: 5, label: 'Distribution Operator');
  factory Role.stockHolder() => const Role(roleId: 6, label: 'Stock Holder');
  factory Role.delegate() => const Role(roleId: 7, label: 'Delegate');
  factory Role.pharmacyManager() =>
      const Role(roleId: 8, label: 'Pharmacy Manager');

  factory Role.fromId(int roleId) {
    switch (roleId) {
      case 1:
        return Role.superAdmin();
      case 2:
        return Role.admin();
      case 3:
        return Role.guest();
      case 4:
        return Role.distributionManager();
      case 5:
        return Role.distributionOperator();
      case 6:
        return Role.stockHolder();
      case 7:
        return Role.delegate();
      case 8:
        return Role.pharmacyManager();
      default:
        throw ArgumentError('Unknown roleId: $roleId');
    }
  }

  bool get isSuperAdmin => roleId == 1;
  bool get isAdmin => roleId == 2;
  bool get isGuest => roleId == 3;
  bool get isDistributionManager => roleId == 4;
  bool get isDistributionOperator => roleId == 5;
  bool get isStockHolder => roleId == 6;
  bool get isDelegate => roleId == 7;
  bool get isPharmacyManager => roleId == 8;

  bool get isDistributor => roleId >= 4 && roleId <= 6;
}
