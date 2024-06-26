import 'package:parish_aid_admin/core/utils/enums.dart';

String? baseUrl;
String? appApiKey;
String? fileUrl;

void initApi(Environment env) {
  switch (env) {
    case Environment.live:
      fileUrl = 'https://';
      baseUrl = "https://stagingapi.parishaid.com/api/v1";
      appApiKey = "";
      break;

    case Environment.test:
      fileUrl = 'https://';
      baseUrl = "https://stagingapi.parishaid.com/api/v1";
      appApiKey = "test_98805e8a-003a-4327-80a2-67d197a30188";
  }
}
