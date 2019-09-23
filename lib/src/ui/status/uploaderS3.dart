import 'dart:convert';
import 'dart:io';

import 'package:amazon_cognito_identity_dart/sig_v4.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../shared/S3Constants.dart';

class UploadToS3 {
  Future<String> send(
      {@required String imagePathOfPhone,
      @required String imagePathInS3Bucket,
      @required String nameFile,
      @required Function onSendProgress}) async {
    final file = File(imagePathOfPhone);
    final length = await file.length();

    final policy = Policy.fromS3PreSignedPost(
        imagePathInS3Bucket, BUCKET_NAME_S3, ACCESS_ID_S3, 15, length,
        region: REGION_S3);
    final key = SigV4.calculateSigningKey(
        SECRED_ID_S3, policy.datetime, REGION_S3, 's3');
    final signature = SigV4.calculateSignature(key, policy.encode());

    Dio dio = Dio();
    FormData formData = FormData.from({
      'key': policy.key,
      'acl': 'public-read',
      'X-Amz-Credential': policy.credential,
      'X-Amz-Algorithm': 'AWS4-HMAC-SHA256',
      'X-Amz-Date': policy.datetime,
      'Policy': policy.encode(),
      'X-Amz-Signature': signature,
      'file': UploadFileInfo(file, nameFile)
    });
    // await dio.postUri(Uri.parse(S3_ENDPOINT),
    //     data: formData,
    //     onSendProgress: (int p, int t) => onSendProgress(p / t));
    // return '$S3_ENDPOINT/$imagePathInS3Bucket';
  }
}

class Policy {
  String expiration;
  String region;
  String bucket;
  String key;
  String credential;
  String datetime;
  int maxFileSize;

  Policy(this.key, this.bucket, this.datetime, this.expiration, this.credential,
      this.maxFileSize,
      {this.region});

  factory Policy.fromS3PreSignedPost(
    String key,
    String bucket,
    String accessKeyId,
    int expiryMinutes,
    int maxFileSize, {
    String region,
  }) {
    final datetime = SigV4.generateDatetime();
    final expiration = (DateTime.now())
        .add(Duration(minutes: expiryMinutes))
        .toUtc()
        .toString()
        .split(' ')
        .join('T');
    final cred =
        '$accessKeyId/${SigV4.buildCredentialScope(datetime, region, 's3')}';
    final policy = Policy(key, bucket, datetime, expiration, cred, maxFileSize,
        region: region);
    return policy;
  }

  String encode() {
    final bytes = utf8.encode(toString());
    return base64.encode(bytes);
  }

  @override
  String toString() {
    return '''
      { "expiration": "${this.expiration}",
        "conditions": [
          {"bucket": "${this.bucket}"},
          ["starts-with", "\$key", "${this.key}"],
          {"acl": "public-read"},
          ["content-length-range", 1, ${this.maxFileSize}],
          {"x-amz-credential": "${this.credential}"},
          {"x-amz-algorithm": "AWS4-HMAC-SHA256"},
          {"x-amz-date": "${this.datetime}" }
        ]
      }
    ''';
  }
}
