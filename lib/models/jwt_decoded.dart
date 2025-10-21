class JwtDecoded {
  final String sub;
  final int roleId;
  final String? companyId;
  final int iat;
  final int exp;

  const JwtDecoded({
    required this.sub,
    required this.roleId,
    required this.companyId,
    required this.iat,
    required this.exp,
  });

  factory JwtDecoded.fromJson(Map<String, dynamic> map) {
    return JwtDecoded(
      sub: map['sub'] ?? "",
      roleId: map['roleId'] ?? 3,
      companyId: map['companyId'],
      iat: map['iat'] ?? 0,
      exp: map['exp'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'sub': sub,
      'roleId': roleId,
      if (companyId != null) 'companyId': companyId,
      'iat': iat,
      'exp': exp,
    };
  }

  DateTime get expirationDate =>
      DateTime.fromMillisecondsSinceEpoch(exp * 1000);

  DateTime get issuedAtDate => DateTime.fromMillisecondsSinceEpoch(iat * 1000);
}
