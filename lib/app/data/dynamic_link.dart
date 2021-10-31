import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';

/**
 * Created by Bayu Nugroho
 * Copyright (c) 2021 . All rights reserved.
 */
class DynamicLinkService {

  Future<void> initDynamicLinks() async {
    //on background
    FirebaseDynamicLinks.instance.onLink(
        onSuccess: (PendingDynamicLinkData? dynamicLink) async {
          final Uri? deepLink = dynamicLink?.link;

          if (deepLink != null) {
            print(deepLink.queryParameters.values.first);
          }
        }, onError: (OnLinkErrorException e) async {
      print('onLinkError');
      print(e.message);
    });

    //on foreground
    final PendingDynamicLinkData? data =
    await FirebaseDynamicLinks.instance.getInitialLink();
    final Uri? deepLink = data?.link;

    if (deepLink != null) {
      print(deepLink.queryParameters.values.first);
    }
  }

  Future<Uri> createDynamicLink(String id) async {
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: 'https://bayunugroho404.page.link',
      link: Uri.parse('https://www.evoqys.in/?aa=$id'),
      androidParameters: AndroidParameters(
        packageName: 'com.bayunugroho404.noteapp.noteapp',
        minimumVersion: 1,
      ),
      iosParameters: IosParameters(
        bundleId: 'your_ios_bundle_identifier',
        minimumVersion: '1',
        appStoreId: 'your_app_store_id',
      ),
    );
    // var dynamicUrl = await parameters.buildUrl();
    final ShortDynamicLink shortLink = await parameters.buildShortLink();
    var dynamicUrl = shortLink.shortUrl;

    return dynamicUrl;
  }

}