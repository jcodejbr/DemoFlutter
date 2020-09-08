import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:servicio/core/offline/connection_status.dart';
import 'package:servicio/features/home/presentation/pages/perfil_usuario.dart';
import 'package:servicio/features/shared/widgets/FTDropDown.dart';
import 'package:servicio/themes/background.dart';

class FTAppBar extends StatefulWidget {
  String nombre_usuario;
  final media;

  FTAppBar({
    @required this.media,
    @required this.nombre_usuario
    });

  @override
  State<StatefulWidget> createState() {
    return FTAppBarState();
  }
}

class FTAppBarState extends State<FTAppBar> {
  StreamSubscription _connectionChangeStream;
   ConnectionStatusSingleton connectionStatus;
  bool isOffline = false;

  @override 
  void initState() {
    super.initState();
    connectionStatus =
        ConnectionStatusSingleton.getInstance();

    checkConenction();

    _connectionChangeStream =
        connectionStatus.connectionChange.listen(connectionChanged);
  }

  void checkConenction() async{
    bool isOffline1 = await connectionStatus.checkConnection();
    setState(() {
      isOffline = isOffline1;
    });
  }

  void connectionChanged(dynamic hasConnection) {
    setState(() {
      isOffline = hasConnection;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 80,
        width: widget.media.width,
        child: Container(
          decoration: showdowContainer,
          child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(top: 10, left: 15),
                  child: Row(
                    children: <Widget>[
                      Icon(Icons.important_devices, size: 35, color: colorPrimario),
                      SizedBox(width: 10),
                      Text("Dev. Movil", style: GoogleFonts.oswald(fontSize: 24, color: colorPrimario)),
                      SizedBox(width: 30),
                      Icon(Icons.wifi, size: 30, color: isOffline ? Colors.green : Colors.red),
                      SizedBox(width: 10),
                      Text( isOffline ? "En linea" : "Sin conexión", style: GoogleFonts.oswald(fontSize: 14, color: isOffline ? colorPrimario :Colors.red)),
                      
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 30, right: 15),
                  child: Row(children: <Widget>[
                    Text(
                      widget.nombre_usuario,
                      style: GoogleFonts.arapey(fontSize: 19),
                    ),
                    SimpleAccountMenu(
                      icons: [
                        Icon(Icons.person),
                      ],
                      iconColor: Colors.white,
                      onChange: (index) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    PerfilUsuarioPage()));
                      },
                    )
                  ]),
                )
              ]),
        ));
  }
}
