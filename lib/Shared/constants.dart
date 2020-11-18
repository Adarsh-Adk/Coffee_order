import 'package:flutter/material.dart';

const textInputDecoration = InputDecoration(
    filled: true,
    fillColor: Colors.white,

    enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(
            const Radius.circular(40.0),
        ),
        borderSide: BorderSide(color: Colors.white, width: 3.0)),
    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.brown,width: 3.0))
    );
