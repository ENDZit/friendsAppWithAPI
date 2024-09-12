import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';

class Friend {
  final String name;
  final String age;

  const Friend(this.name, this.age);

  factory Friend.fromJson(Map<String, dynamic> json) {
    return Friend(
      json['name'],
      json['age'],
    );
  }
}