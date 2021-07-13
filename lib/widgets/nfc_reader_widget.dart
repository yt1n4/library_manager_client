import 'dart:io';

import 'package:librarymanagerclient/repositories/nfc_result_repository.dart';
import 'package:nfc_manager/nfc_manager.dart';

class NfcReaderWidget {
  void read(String state, NfcResultRepository exporter) {
    if (Platform.isAndroid) {
      // Android のとき
      NfcManager.instance.startSession(
        onDiscovered: (NfcTag tag) async {
          final tagData = tag.data['nfcf']['identifier'];
          NfcManager.instance.stopSession();

          // 8ビットを逆順にして16進数にして結合して文字列にする
          final tagDataRev = tagData.reversed.toList();
          final tagDataHex =
              tagDataRev.map((n) => n.toRadixString(16)).toList();
          // 現在の値と異なる場合に更新する
          if (tagDataHex.join() != state) {
            exporter.exportResult(tagDataHex.join());
          }
        },
      );
    } else if (Platform.isIOS) {
      // iOSのとき
      // デバイスのNFCリーダーが機能しないため適当な値を入れる
      if (state.isEmpty) {
        Future.delayed(Duration(milliseconds: 10))
            .then((_) => exporter.exportResult('0000000000000'));
      }
    }
  }
}
