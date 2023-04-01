import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

class InfoPage extends StatelessWidget {
  const InfoPage ({ Key? key, this.info }) : super(key: key);

  final info;

  @override
  Widget build (BuildContext context) {
    return Scaffold (
      appBar: AppBar (
        elevation: 0.0,
        foregroundColor: Colors.indigoAccent,
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView (
        child: Center (
          child: Container (
            margin: const EdgeInsets.fromLTRB(0, 40, 0, 0),
            child: Column (
              children: <Widget>[
                ClipRRect (
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(info.data[0]['cover'],
                    width: 280,
                    fit: BoxFit.cover,
                  ),
                ),
                Container (
                  width: 280,
                  margin: const EdgeInsets.fromLTRB(25, 0, 0, 10),
                  child: Text (info.data[0]['title'],
                    style: const TextStyle (
                      fontFamily: 'Noto',
                      fontSize: 30,
                    ),
                  ),
                ),
                Container (
                  width: 250,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  // child: Text (info.data[0]['author'],
                  //   style: const TextStyle (
                  //     fontFamily: 'Noto',
                  //     fontSize: 30,
                  //   ),
                  // ),
                ),
                Container (
                  width: double.infinity,
                  margin: const EdgeInsets.fromLTRB(0, 0, 0, 20),
                  child: Text (info.data[0]['description'],
                    style: const TextStyle (
                      fontFamily: 'Noto',
                      fontSize: 25,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}