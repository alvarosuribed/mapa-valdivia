import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mapbox_gl/mapbox_gl.dart';
import 'package:url_launcher/url_launcher.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Centros de Tortura - Valdivia',
      theme: ThemeData(primarySwatch: Colors.red),
      home: const MapScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapboxMapController? mapController;

  final String accessToken =
      'pk.eyJ1IjoiYWx2YXJvdXJpYmVkIiwiYSI6ImNtYWQzMDltazBhNzkyaW9obmg1NWF5N3YifQ.Dbj-NU5ngqRsUG4LTRCwdw';

  final List<Map<String, dynamic>> memorials = [
    {
      'id': 'm1',
      'name': 'Memorial puente Estancilla ',
      'latLng':
          const LatLng(-39.843214, -73.292676), // Ajusta estas coordenadas
      'imageUrl': 'assets/images/Imagen11.png',
      'description':
          'Este es un sitio de memoria en el puente Estancilla debido a que fueron ejecutados 2 personas en el año 1984, aunque esta lamentable situación es parte de la operación "Alfa Carbón", relacionado con otros asesinatos en la población Rubén Darío." Este memorial nació como una cruz de madera en honor a Rogelio Tapia de la Puente y Raúl Barrientos Matamala, asesinados por la CNI en agosto de 1984 en el puente Estancilla. La cruz fue varias veces destruida y repuesta, hasta que finalmente el memorial fue reforzado con concreto y metal por gestión de los familiares e instalando una placa que recuerda además a Juan Boncompte Andreu, acribillado en Valdivia, en la población Rubén Darío; Mario Mujica Barros, en Los Ángeles; Luciano Aedo Arias, Mario Lagos Rodríguez y Nelson Herrera Riveros, en Concepción, todos asesinados por la CNI en la operación «alfa carbón». Los jóvenes pertenecían a una unidad del MIR de la zona sur. Dos años más tarde, en agosto de 1986 se crearía la Agrupación de Familiares de Ejecutados Políticos (AFEP) de Valdivia" (AFDD-AFEP. "Ruta de la Memoria.").'
    },
    {
      'id': 'm2',
      'name': 'Memorial por la Vida ',
      'latLng':
          const LatLng(-39.829286, -73.215529), // Ajusta estas coordenadas
      'imageUrl': 'assets/images/Imagen12.png',
      'description':
          'Esta escultura es un sitio de memoria en recuerdo a las víctimas de la provincia de Valdivia. Recuerda a las 116 víctimas de crímenes de lesa humanidad perpetrados por la última dictadura civil-militar de la entonces provincia de Valdivia. La escultura fue diseñada por Alejandro Verdi. Cada 11 de septiembre se realiza una romería al memorial donde se hace un acto conmemorativo. "El año 2000 la AFDD-AFEP Valdivia con el fin de hacer una reparación simbólica para las víctimas de las violaciones al derecho a la vida ocurridas en Valdivia durante el gobierno militar ya que en la provincia están reconocidas 116 víctimas de estas violaciones. Por ello presentamos esta iniciativa con el diseño del escultor Alejandro Verdi, quien junto a la secretaria de la AFDD-AFEP para instalar la obra en el patio 24, fila 02, sepultura 28 y 29 folio 3558 del Cementerio Municipal (AFDD-AFEP. "Ruta de la Memoria.").'
    },
    {
      'id': 'm3',
      'name': 'Memorial puente Pichoy',
      'latLng':
          const LatLng(-39.686207, -73.101840), // Ajusta estas coordenadas
      'imageUrl': 'assets/images/Imagen13.png',
      'description':
          'Este sitio ubicado en el Puente Pichoy es un sitio de memoria debido a que se ejecutaron a 4 hombres el 12 de octubre de 1973. Recuerda a: Gilberto Antonio Ortega Alegría (39, empleado y dirigente sindical), José Manuel Arriagada Cortés (19, suplementero), José Gabriel Arriagada Zúñiga (30, topógrafo), José Manuel Carrasco Torres (contador). "Todos ellos fueron detenidos el día 10 de octubre de 1973 por Carabineros de Malalhue y de Lanco, y conducidos al retén de Malahue, siendo trasladados posteriormente a la Tenencia de lanco, donde permanecieron detenidos hasta el día 12 de octubre de 1973. En dicho recinto, producto de las torturas, falleció Gilberto Antonio Ortega Alegría, en presencia de testigos. Al cabo de pocas horas, los otros tres detenidos y el cuerpo de Ortega fueron sacados de la Tenencia para ser trasladados a Valdivia. José Gabriel Arriagada fue amarado con José Manuel Arriagada, y Carrasco con el cuerpo de Ortega. Al llegar al Puente Pichoy, los detenidos fueron ejecutados. Todos los cuerpos registraban múltiples impactos de bala. Sus restos fueron entregados a sus familiares para su sepultación. Versiones verbales entradas a las familias por autoridades de Carabineros dieron como razón de la muerte el que los detenidos habrían intentado fugarse, sin dar explicaciones más circunstanciadas sobre ello." (CNVR 1996) AFDD-AFEP. "Ruta de la Memoria."'
    },
    {
      'id': 'm4',
      'name': 'Memorial "La Mano"',
      'latLng':
          const LatLng(-39.840816, -73.215917), // Ajusta estas coordenadas
      'imageUrl': 'assets/images/Imagen14.png',
      'description':
          'En la población Rubén Darío, está ubicado este memorial/paradero donde se recuerda a: Juan José Boncompte Andreu (31, economista), asesinado el 24 de agosto de 1984 en dicha población (operación alfa carbón). Su mujer, Inés embarazada de 7 meses, estaba con él en el momento del allanamiento de su casa y ejecución de parte de alrededor de 15 funcionarios de la CNI (AFDD-AFEP. "Ruta de la Memoria.").'
    },
    {
      'id': 'm5',
      'name': 'Memorial de Llancahue ',
      'latLng': const LatLng(-39.850833, -73.193920), // Coordenadas corregidas
      'imageUrl': 'assets/images/Imagen15.png',
      'description':
          'La foto corresponde al memorial Llancahue debido a que fueron ejecutados 12 personas. Recuerda a 12 jóvenes miristas fusilados el 3 y 4 de octubre de 1973 sin juicio justo alguno, acusados falsamente de un supuesto asalto al retén de Neltume. La ejecución fue realizada en el marco de la Caravana de la Muerte en el interior del regimiento de caballería nº2 Cazadores de Valdivia, donde hoy se ubica la cárcel de la ciudad. La mayoría de las víctimas trabajaban en el Complejo Forestal y Maderero Panguipulli (COFOMAP) o eran jóvenes miristas. La reconstitución de escena en el marco de la investigación realizada por el ministro en visita Juan Guzmán reveló casi 30 años más tarde que el asalto realmente nunca existió. Pedro Barría Ordoñez (22, estudiante), José Barrientos Warner (29, estudiante y músico de la orquesta de cámara de la UACh), Santiago García Morales (26, obrero maderero), Luis Guzmán Soto (21, obrero maderero), Fernando Krauss Iturra (24, estudiante UACh), José Liendo Vera (28, estudiante UACh), Luis Pezo Jara (29, obrero maderero), Víctor Rudolph Reyes (32, obrero maderero), Rudemir Saavedra Bahamondez (29, obrero maderero), Víctor Saavedra Muñoz (19, obrero maderero), Luis Valenzuela Ferrada (20, obrero maderero).'
    },
    {
      'id': 'm6',
      'name': 'Memorial UACH',
      'latLng':
          const LatLng(-39.805979, -73.248119), // Ajusta estas coordenadas
      'imageUrl': 'assets/images/Imagen16.png',
      'description':
          'Este sitio de memoria está ubicado en el campus Isla Teja de la Universidad Austral de Chile, entre el edificio de Facultad de Medicina y Pabellón Docente. El primer monolito corresponde al año 1994 para reflexionar acerca de las violaciones de DD. HH, el segundo monolito del año 2006 se inscriben los nombres de 9 estudiantes que fueron víctima de la dictadura por ser parte de la comunidad universitaria. Por último, en el año 2023 se le agrega un décimo nombre: José Luis Appel de la Cruz, José René Barrientos Warner, Carmen Angélica Delard Cabezas, Víctor Fernando Krauss Iturra, Gregorio José Liendo Vera, Mario Alejandro Mellado Manríquez, Sergio Raúl Pardo Pedemonte, Héctor Darío Valenzuela Salazar, Hugo Rivol Vásquez Martínez, Rogelio Humberto Tapia de la Puente.'
    },
    {
      'id': 'm7',
      'name': 'Memorial del LARR',
      'latLng':
          const LatLng(-39.815720, -73.242436), // Ajusta estas coordenadas
      'imageUrl': 'assets/images/Imagen17.png',
      'description':
          'Frente al Liceo Armando Robles Rivera, histórico establecimiento donde cursó sus estudios Salvador Allende, se recuerda también a otros tres exestudiantes que fueron víctimas del terrorismo de Estado durante la dictadura cívico-militar. Se trata de Raúl Barrientos Matamala, ejecutado el 23 de agosto de 1984; Pedro Barría Ordoñez, detenido desaparecido desde el 4 de octubre de 1973; y Roberto Acuña Reyes, detenido el 14 de febrero de 1975, cuyo paradero continúa desconocido hasta hoy. Sus nombres forman parte de la memoria viva que interpela a las nuevas generaciones desde este espacio educativo.'
    },
    // Agrega más memoriales según necesites
  ];

  final List<Map<String, dynamic>> tortureSites = [
    {
      'id': '1',
      'name': 'Gimnasio del CENDYR',
      'latLng': const LatLng(-39.828964, -73.226985),
      'imageUrl': 'assets/images/x_region_gimnasio_cendyr_valdivia.jpg',
      'description':
          'De acuerdo a testimonios recabados en el Informe Valech, este recinto fue utilizado en el año 1973 por personal del Ejército para la reclusión y tortura de presos políticos, hombres y mujeres, quienes durante su permanencia eran mantenidos en una sala del gimnasio de 36 x 26 metros, durmiendo en las graderías del recinto. A los prisioneros aquí recluidos, les estaba prohibido salir al aire libre y en cuanto ingresaban se les asignaba un número, por el cual sería identificado durante toda su estadía en el lugar. En el Gimnasio CENDYR los detenidos fueron sometidos a golpizas y torturas, simulacros de fusilamiento y aplicación de electricidad, para luego ser trasladados a interrogatorios al regimiento de caballería, al SIM (Servicio de Inteligencia Militar) y al cuartel de Investigaciones de la ciudad de Valdivia, generalmente en camiones cerrados. Este inmueble está identificado en el Catastro de la Memoria, de acuerdo a la nómina de inmuebles incluidos por la Comisión Nacional sobre Prisión Política y Tortura, de modo que presenta una connotación socio-histórica relevante. Para continuar con el hito 7, te recomendamos seguir por calle Ángel Muñoz hacia la Av. Simpson, para luego llegar a calle Racloma y bajar por ella hasta calle Bueras, donde te encontrarás, inmediatamente con el Regimiento Bueras, al que no se puede ingresar debido al resguardo militar. No obstante, desde el exterior, puedes observar su estructura que se mantiene sin modificaciones. Las caballerizas fueron zonas de detención y tortura. Criminales y complices: - Sargento Calderón (Ejército)'
    },
    {
      'id': '2',
      'name': 'Ex Reten Las Animas',
      'latLng': const LatLng(-39.816750, -73.225889),
      'imageUrl': 'assets/images/animas.png',
      'description':
          'El antiguo Retén de Carabineros, Las Ánimas ubicado a un costado del puente Calle Calle 1 fue utilizado para la detención de presos políticos de la regiónEl Retén Las Ánimas funcionó como un punto de tránsito y facilitación de la represión en la cadena de detención, interrogatorio, tortura y posterior ejecución extrajudicial de ambos militantes. Es decir: No fue un lugar de ejecución, pero sí un espacio institucional del Estado donde se coordinó el traspaso de prisioneros políticos desde la jurisdicción de Carabineros (que los había detenido) hacia la Central Nacional de Informaciones (CNI), lo que muestra colaboración operativa entre fuerzas policiales y represivas. El Retén Las Ánimas, por tanto, facilitó la continuidad del circuito represivo, que culminó con las muertes de Riffo y Bravo en septiembre de 1981, después de ser utilizados en operativos militares en Neltume Actualmente se encuentra funcionando el instituto CRESED. Fuente: Memoriaviva.cl, Comisión Valech e Informe Rettig.'
    },
    {
      'id': '3',
      'name': 'Palacio de la Risa',
      'latLng': const LatLng(-39.820877, -73.230605),
      'imageUrl': 'assets/images/Imagen3.png',
      'description':
          'El centro de detención y tortura conocido como el "Palacio de la Risa" estaba ubicado en Av. Ramón Picarte N.º 1451, Valdivia (actualmente una iglesia evangélica) y funcionó entre septiembre de 1973 y el año 1975. Este centro de tortura era el Cuartel del Servicio de Inteligencia Militar (SIM) en Valdivia. Los detenidos provenían de la ciudad de Valdivia y de otras comunas de la provincia. Unos permanecían vendados y amarrados y otros en calabozos sin alimento ni agua. Luego, la mayoría era trasladada a otros centros de reclusión, principalmente a la cárcel. Los testimonios dieron cuenta de diversos tormentos físicos y psicológicos. Sufrieron golpes, aplicación de electricidad, amenazas, simulacros de fusilamiento, colgamientos y el submarino. Actualmente se encuentra una iglesia, específicamente una de carácter Mormón.'
    },
    {
      'id': '4',
      'name': 'Ramón Picarte con José Martí',
      'latLng': const LatLng(-39.81642505682883, -73.23508942608196),
      'imageUrl': 'assets/images/Imagen4.png',
      'description':
          'Según consta de los antecedentes recabados por la comisión Valech, el mayor número de detenidos en el Cuartel de Investigaciones de Valdivia se registró entre los años 1973 y 1975. Los presos políticos relataron que los detenidos, hombres y mujeres, eran mantenidos en calabozos en el subterráneo del edificio y en una pequeña sala de aislamiento. Permanecían vendados e incomunicados durante todo el tiempo. En los testimonios se consignó que sufrieron golpes, aplicación de electricidad, vejaciones y amenazas. Actualmente el sitio se encuentra eriazo, con claros signos de ser ocupado como una especie de ruco.'
    },
    {
      'id': '5',
      'name': 'IV División del Ejército',
      'latLng': const LatLng(-39.82046247754091, -73.22927303086153),
      'imageUrl': 'assets/images/Imagen5.png',
      'description':
          'La IV División Del Ejército / Guarnición Militar, Valdivia fue un recinto de reclusión transitoria, utilizado principalmente para interrogatorios y torturas. Los detenidos ingresaron luego de presentarse por haber sido llamados a través de bandos u otros medios, o bien luego de haber sido detenidos en sus hogares, centros de trabajo o de estudio. Unos pocos pasaron previamente por retenes de carabineros. Algunos testimonios refieren que fueron llevados a este lugar desde la Cárcel de Valdivia, en donde permanecían detenidos. Los testimonios dan cuenta que fueron sometidos a golpes, en ocasiones con paleta de madera, amenazas, simulacro de fusilamiento, prolongadas posiciones forzadas. Actualmente se encuentra funcionando el servicio de Bienes Nacionales.'
    },
    {
      'id': '6',
      'name': 'Regimiento Militar Bueras',
      'latLng': const LatLng(-39.82580273106032, -73.23211489048818),
      'imageUrl': 'assets/images/Imagen6.png',
      'description':
          'En un área de la ciudad de Valdivia se concentraba cuatro recintos militares: el Regimiento de Caballería Blindada No 2 "Cazadores", el Regimiento de Artillería N° 2" Maturana", el Regimiento de Telecomunicaciones N.º 4 "Membrillar" y la Fiscalía Militar (Valdivia), los cuales jugaron un rol central en el proceso de represión en la X Región y sirvieron como centros de interrogatorio y tortura de presos políticos. Muchos de los prisioneros, hombres y mujeres, fueron trasladados desde recintos como la cárcel o comisarías de Valdivia y otras ciudades. Varios eran traídos luego de ser detenidos durante operativos militares en zonas rurales, especialmente en la precordillera de Valdivia. Los presos llegaban en camiones, hacinados y en muy malas condiciones físicas. Por las características del lugar, es probable que los detenidos no supieran con certeza en cuál de los tres regimientos se encontraban. Se los mantuvo al interior del regimiento en el gimnasio, en galpones y en las caballerizas, incomunicados, encapuchados durante varios días, privados de alimento y agua. Hay víctimas que denunciaron haber sido rapadas al ingresar. La Fiscalía Militar de Valdivia funcionó en el Regimiento N° 2 Cazadores, por lo cual muchos prisioneros fueron llevados desde la cárcel u otros recintos por personal del Servicio de Inteligencia Militar (SIM) para ser interrogados. Ex presos políticos denunciaron haber sufrido golpes, algunos con varillas de mimbre; aplicación de electricidad, simulacros de fusilamiento, el submarino en agua con inmundicias, extracción de uñas, obligación de permanecer en posiciones forzadas, colgamientos y quemaduras con cigarrillos. Luego de un tiempo eran trasladados a la Comisaría de Valdivia, a la cárcel o al recinto de reclusión ubicado en el gimnasio del Banco del Estado-Cendyr.'
    },
    {
      'id': '7',
      'name': 'Regimiento N°8 Llancahue',
      'latLng': const LatLng(-39.851887, -73.192547),
      'imageUrl': 'assets/images/Imagen7.png',
      'description':
          'En el Campo de Tiro de las Fuerzas Especiales del Regimiento N° 8 Llancahue fueron fusilados 12 trabajadores pertenecientes al Complejo Maderero Panguipulli, después de un supuesto "Consejo de Guerra". Las víctimas eran: Pedro Purísimo Barria Ordóñez (22 años, estudiante), José René Barrientos Warner (29 años, estudiante), Sergio Jaime Bravo Aguilera (21 años, obrero maderero), Santiago Segundo Garcia Morales (26 años, obrero maderero), Luis Enrique del Carmen Guzman Soto (21 años, obrero maderero), Fernando Krauss Iturra (24 años, estudiante), José Gregorio Liendo Vera (28 años), Luis Hernán Pezo Jara (29 años, obrero maderero), Víctor Eugenio Rudolf Reyes (32 años, obrero maderero), Rudemir Saavedra Bahamondes (obrero maderero), Víctor Segundo Saavedra Muñoz (19 años, obrero maderero), Luis Mario Valenzuela Ferrada (20 años, obrero maderero). Este recinto también fue utilizado como centro de reclusión y tortura de presos políticos. Los presos eran trasladados del regimiento hasta el campo de concentración Llancahue para ser interrogados y sometidos a brutales torturas.'
    },
    {
      'id': '8',
      'name': 'Casa de la Memoria',
      'latLng': const LatLng(-39.817281, -73.246891),
      'imageUrl': 'assets/images/Imagen8.png',
      'description':
          'Este centro de detención en la ciudad de Valdivia pertenecía a la Central Nacional de Informaciones (CNI) y servia tambien como oficina para agentes civiles de las Fuerzas Armadas y Carabineros. La existencia de este centro fue reconocida públicamente en 1984, cuando su dirección se publica en el Diario Oficial, parte del decreto del Ministerio del Interior No 594 (14 de junio de 1984). Este señala lugares de detención para los efectos que indica: Decreto: Artículo único: Las siguientes dependencias de la Central Nacional de Informaciones serán consideradas como lugares de detención, para los efectos del cumplimiento de los arrestos que se dispongan en virtud de la disposición vigésimo cuarta transitoria de la Constitución Política de la República de Chile. Entre los centros de detención enumerados en este decreto está la Casa-habitación, Pérez Rosales, No 764 Valdivia. Presos políticos denunciaron haber estado en este recinto, ubicado en Pérez Rosales 764 en Valdivia, entre los años 1981 y 1988. La mayor cantidad de detenidos en este lugar se consignó en el año 1986. De acuerdo a los testimonios recibidos por la Comisión Valech se pudo establecer que, luego de ser detenidos por este organismo de seguridad, los presos eran conducidos hasta el subterráneo de este recinto, en donde fueron sometidos a interrogatorios y torturas, permanentemente vendados, amarrados y desnudos. Se encontraban incomunicados, sin comida ni agua ni condiciones higiénicas mínimas. Los presos politicos sufrieron golpes, el teléfono, aplicación de electricidad,amenazas, entre otras, de ser lanzados al mar; simulacro de fusilamiento; eran obligados a presenciar torturas de otros detenidos, soportaban inmersión en líquidos con excrementos, ahogamiento con bolsas plásticas amarrada en la cabeza; colgamiento; debían permanecer amarrados y con los ojos vendados, se les amenazaba con perros, permanecían en posiciones forzadas, recibían golpes en las plantas de los pies, amenazas de detención, y tortura o muerte a familiares. También consta que fueron conducidos luego de su detención a Recintos de la CNI en Niebla (en Noviembre de 1984), y otros a un Recinto CNI en Caleta Miramar, Pelluco, (Noviembre de 1988), en Puerto Montt. No fue posible, sin embargo, obtener más antecedentes respecto a estos lugares.'
    },
    {
      'id': '09',
      'name': 'Ex Cárcel de Isla Teja',
      'latLng': const LatLng(-39.813321, -73.262983),
      'imageUrl': 'assets/images/Imagen10.png',
      'description':
          'En este recinto ubicado en la Isla Teja se concentraron los detenidos políticos en el año 1973, y en menor número hasta el año 1989. Los testimonios de presos políticos consignan que se trataba de un edificio de construcción nueva, inaugurado en 1973. Hombres y mujeres permanecían separados. En 1973 los prisioneros políticos no tenían permiso para ver a sus familiares ni para trabajar. Con el tiempo esta situación cambió y se permitieron las visitas los  días sábado y facilidades para trabajar en un taller de carpintería. Los detenidos llegaban en su mayoría en muy malas condiciones físicas y anímicas, debido a que desde el mismo momento de su detención eran sometidos a malos tratos e intensos interrogatorios. En 1973 procedían de los diversos retenes y comisarías de la provincia, así como de recintos militares habilitados para este propósito. De acuerdo a los testimonios recibidos, en 1973 los detenidos eran sometidos a constantes amenazas. En varias oportunidades, los guardias hacían descargas  de metralletas en la madrugada, simulando operativos de liberación; sufrieron simulacros de fusilamiento, golpes, fueron obligados a permanecer en prolongadas posiciones forzadas y fueron hostigados permanentemente. Los detenidos eran sacados del penal durante la noche, por personal del Servicio de Inteligencia Militar (SIM), que los trasladaban a otros recintos en los cuales eran interrogados y torturados. Los sitios de tortura más frecuentes, según los testimonios, eran el Regimiento "Cazadores", en cuyo interior funcionaban la Fiscalía Militar, y el Cuartel del Servicio de Inteligencia Militar (SIM) de calle Errázuriz. Volvían a la Cárcel en muy malas condiciones. En el traslado eran también golpeados y amenazados, muchas veces vendados y amarrados. El año 2018, el complejo fue declarado Monumento Histórico en calidad de Sitio de la Memoria mediante Decreto N°97 28/02/2018, valorando también sus atributos históricos, arquitectónicos y urbanos.'
    },
  ];
  // Ajustamos el punto de inicio al Gimnasio del CENDYR
  final LatLng center = const LatLng(-39.828964, -73.226985);

  final LatLngBounds valdiviaBounds = LatLngBounds(
    southwest: const LatLng(-39.845, -73.26),
    northeast: const LatLng(-39.810, -73.20),
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, // fondo oscuro serio
      appBar: AppBar(
        title: const Text('Centros de Tortura - Valdivia'),
        centerTitle: true,
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
        backgroundColor: Colors.red.shade900,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LiteraturaRecomendadaScreen(),
              ),
            ),
          ),
        ],
      ),
      body: MapboxMap(
        accessToken: accessToken,
        styleString: 'mapbox://styles/mapbox/satellite-streets-v12',
        initialCameraPosition: const CameraPosition(
          // Iniciamos con un zoom más cercano
          target: LatLng(-39.823000, -73.235000),
          zoom: 13.0, // Aumentado considerablemente de 8.0
        ),
        onMapCreated: _onMapCreated,
        onStyleLoadedCallback: _addCustomMarkers,
        myLocationEnabled: !kIsWeb, // Deshabilitar en web
      ),
    );
  }

  void _onMapCreated(MapboxMapController controller) {
    mapController = controller;

    final pts = <LatLng>[
      ...tortureSites.map((s) => s['latLng'] as LatLng),
      ...memorials.map((m) => m['latLng'] as LatLng),
    ];

    if (pts.isEmpty) {
      // Si no hay puntos, centrar en Valdivia
      mapController!.animateCamera(
        CameraUpdate.newLatLngZoom(center, 13.0),
      );
      return;
    }

    final b = _bounds(pts);

    mapController!.animateCamera(
      CameraUpdate.newLatLngBounds(
        b,
        left: 20,
        top: 20,
        right: 20,
        bottom: 20,
      ),
    );

    Future.delayed(const Duration(milliseconds: 500), () {
      final currentZoom = controller.cameraPosition?.zoom ?? 0;
      if (currentZoom < 11.5) {
        // Reducido para mejor visibilidad
        controller.animateCamera(
          CameraUpdate.zoomTo(11.5),
        );
      }
    });
  }

  // calcula LatLngBounds que contiene toda la lista de puntos
  LatLngBounds _bounds(List<LatLng> pts) {
    if (pts.isEmpty) {
      return LatLngBounds(
        southwest: const LatLng(-39.86, -73.28),
        northeast: const LatLng(-39.80, -73.18),
      );
    }

    double minLat = pts.first.latitude,
        maxLat = pts.first.latitude,
        minLng = pts.first.longitude,
        maxLng = pts.first.longitude;

    for (var p in pts) {
      if (p.latitude < minLat) minLat = p.latitude;
      if (p.latitude > maxLat) maxLat = p.latitude;
      if (p.longitude < minLng) minLng = p.longitude;
      if (p.longitude > maxLng) maxLng = p.longitude;
    }

    return LatLngBounds(
      southwest: LatLng(minLat, minLng),
      northeast: LatLng(maxLat, maxLng),
    );
  }

  void _addCustomMarkers() {
    if (mapController == null) return;

    // Agregar centros de tortura con configuración específica para web/móvil
    for (var site in tortureSites) {
      // Círculo para centros de tortura
      mapController!.addCircle(CircleOptions(
        geometry: site['latLng'],
        circleRadius: 8.0, // Más grande para centros
        circleColor: '#FF0000',
        circleStrokeWidth: 3.0,
        circleStrokeColor: '#FFFFFF',
      ));

      // Texto para centros de tortura - CORREGIDO EL TAMAÑO
      mapController!.addSymbol(SymbolOptions(
        geometry: site['latLng'],
        textField: site['name'],
        textSize: kIsWeb ? 16.0 : 14.0, // Más grande en web
        textOffset: const Offset(0, -3.0),
        textHaloWidth: 3.0,
        textHaloColor: '#000000',
        textColor: '#FFFFFF',
        textAnchor: 'top',
      ));
    }

    // Agregar memoriales
    for (var mem in memorials) {
      // Círculo para memoriales
      mapController!.addCircle(CircleOptions(
        geometry: mem['latLng'],
        circleRadius: 6.0,
        circleColor: '#0080FF',
        circleStrokeWidth: 2.0,
        circleStrokeColor: '#FFFFFF',
      ));

      // Texto para memoriales
      mapController!.addSymbol(SymbolOptions(
        geometry: mem['latLng'],
        textField: mem['name'],
        textSize: kIsWeb ? 14.0 : 12.0,
        textOffset: const Offset(0, -2.5),
        textHaloWidth: 2.0,
        textHaloColor: '#000000',
        textColor: '#FFFFFF',
        textAnchor: 'top',
      ));
    }

    // Agregar listeners
    mapController!.onSymbolTapped.add(_onSymbolTapped);
    mapController!.onCircleTapped.add(_onCircleTapped);
  }

  // Nuevo método para manejar toques en círculos
  void _onCircleTapped(Circle circle) {
    _handleTap(circle.options.geometry!);
  }

  void _onSymbolTapped(Symbol symbol) {
    _handleTap(symbol.options.geometry!);
  }

  // Método unificado para manejar toques
  void _handleTap(LatLng tappedLocation) {
    // Buscar en centros de tortura con tolerancia
    final tappedSite = tortureSites.firstWhere(
      (site) => _isNearLocation(site['latLng'], tappedLocation),
      orElse: () => <String, dynamic>{},
    );

    if (tappedSite.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CentroDetailScreen(site: tappedSite),
        ),
      );
      return;
    }

    // Buscar en memoriales con tolerancia
    final tappedMemorial = memorials.firstWhere(
      (memorial) => _isNearLocation(memorial['latLng'], tappedLocation),
      orElse: () => <String, dynamic>{},
    );

    if (tappedMemorial.isNotEmpty) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MemorialDetailScreen(memorial: tappedMemorial),
        ),
      );
    }
  }

  // Método auxiliar para comparar ubicaciones con tolerancia
  bool _isNearLocation(LatLng location1, LatLng location2) {
    const tolerance = 0.0001;
    return (location1.latitude - location2.latitude).abs() < tolerance &&
        (location1.longitude - location2.longitude).abs() < tolerance;
  }
}

// Abrir Google Maps with navegación en tiempo real
Future<void> _openGoogleMaps(double lat, double lon) async {
  final uri = Uri.parse(
    'https://www.google.com/maps/dir/?api=1'
    '&destination=$lat,$lon'
    '&travelmode=driving',
  );
  if (await canLaunchUrl(uri)) {
    await launchUrl(
      uri,
      mode: LaunchMode.externalApplication,
    );
  } else {
    throw 'No se pudo abrir Google Maps';
  }
}

class CentroDetailScreen extends StatelessWidget {
  final Map<String, dynamic> site;
  const CentroDetailScreen({required this.site, super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87, // fondo oscuro serio
      appBar: AppBar(
        backgroundColor: Colors.red.shade900, // rojo más profundo
        title: Text(
          site['name'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.visible,
          // texto más legible
        ),
        // Eliminamos el leading predeterminado
        automaticallyImplyLeading: false,
        // Creamos un layout personalizado con los dos iconos
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Icono para volver atrás
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 24,
              onPressed: () => Navigator.pop(context),
            ),
            // Icono de Google Maps
            IconButton(
              icon: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTj7a_vT12veGl75W7xDh66jq42uQFWI0lXAw&s',
                width: 20,
                height: 20,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.map, color: Colors.white, size: 20);
                },
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 20,
              onPressed: () => _openGoogleMaps(
                site['latLng'].latitude,
                site['latLng'].longitude,
              ),
            ),
          ],
        ),
        leadingWidth: 100, // Ancho suficiente para ambos
        // Añadimos el icono de menú a la derecha
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LiteraturaRecomendadaScreen(),
              ),
            ),
          ),
        ],
      ), // Ancho suficiente para ambos
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      FullscreenImageScreen(imageUrl: site['imageUrl']),
                ),
              ),
              child: Image.asset(
                site['imageUrl'],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 60),
              child: Text(
                site['description'],
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.6,
                  color: Colors.white70, // texto más legible
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Nueva pestaña de "Literatura recomendada" con diseño mejorado
class LiteraturaRecomendadaScreen extends StatelessWidget {
  const LiteraturaRecomendadaScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final libros = [
      'AFDD-AFEP. "Ruta de la Memoria." AFDD-AFEP Valdivia, 2023.',
      'Agrupación de Ex-Presos Políticos y Familiares. Postales para la Memoria: Recorrido fotográfico y testimonial de centros de detención en Valdivia, 1973–1990. Valdivia: Marilaf-Martel Pontigo-Katz, 2022.',
      'Alegría, Luis, y Natalia Uribe. Guía metodológica para la gestión de sitios de memoria en Chile. Santiago de Chile: Ediciones de la Corporación Parque por la Paz Villa Grimaldi, 2014.',
      'Brinkmann Sheihing, Beatriz. "Memorias de la prisión política en Valdivia, 1973–1991." Catálogo Bibliográfico de Escritores y Literatura de la Región de Los Ríos, 2019.',
      'Centro Cultural Museo y Memoria de Neltume. Memorial Cementerio General de Valdivia, 2018.',
      'Ex Presos Políticos y Familiares de Valdivia. "La HISTORIA es NUESTRA…". Revista de Patrimonio & Memoria, no. 1 (2020): 1–20.',
      'Memoria Viva. "Centros de detención." Memoria Viva, 2022.',
      'Read, Peter, y Marivic Wyndham. Sin descansar, en mi memoria: La lucha por la creación de sitios de memoria en Chile desde la transición a la democracia. Canberra: ANU Press, 2017.',
    ];

    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        title: const Text(
          'Literatura recomendada',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.red.shade900,
        centerTitle: true,
      ),
      body: SafeArea(
        // Adding SafeArea to prevent overlap with system UI
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(16),
              width: double.infinity,
              color: Colors.red.shade900,
              child: const Text(
                'Bibliografía sobre Memoria y Derechos Humanos',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: libros.length,
                itemBuilder: (context, index) => Card(
                  elevation: 3,
                  margin:
                      const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
                  color: Colors.grey.shade900,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                    side: BorderSide(color: Colors.red.shade800, width: 1),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 24,
                          height: 24,
                          decoration: BoxDecoration(
                            color: Colors.red.shade800,
                            shape: BoxShape.circle,
                          ),
                          margin: const EdgeInsets.only(right: 12, top: 2),
                          child: Center(
                            child: Text(
                              '${index + 1}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          child: Text(
                            libros[index],
                            style: const TextStyle(
                              fontSize: 15,
                              height: 1.5,
                              color: Colors.white70,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// Agregar abajo el widget de pantalla completa
class FullscreenImageScreen extends StatelessWidget {
  final String imageUrl;
  const FullscreenImageScreen({required this.imageUrl, super.key});

  @override
  Widget build(BuildContext context) {
    final isNetwork = imageUrl.startsWith('http');
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTap: () => Navigator.pop(context),
        child: Center(
          child: InteractiveViewer(
            child: isNetwork ? Image.network(imageUrl) : Image.asset(imageUrl),
          ),
        ),
      ),
    );
  }
}

// Correct class definition for MemorialDetailScreen
class MemorialDetailScreen extends StatelessWidget {
  final Map<String, dynamic> memorial;

  const MemorialDetailScreen({
    required this.memorial,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      appBar: AppBar(
        backgroundColor: Colors.blue.shade900,
        title: Text(
          memorial['name'],
          style: const TextStyle(
            color: Colors.white,
            fontSize: 16,
            fontWeight: FontWeight.bold,
          ),
          overflow: TextOverflow.visible,
        ),
        automaticallyImplyLeading: false,
        leading: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 24,
              onPressed: () => Navigator.pop(context),
            ),
            IconButton(
              icon: Image.network(
                'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTj7a_vT12veGl75W7xDh66jq42uQFWI0lXAw&s',
                width: 20,
                height: 20,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(Icons.map, color: Colors.white, size: 20);
                },
              ),
              padding: EdgeInsets.zero,
              constraints: const BoxConstraints(),
              iconSize: 20,
              onPressed: () => _openGoogleMaps(
                memorial['latLng'].latitude,
                memorial['latLng'].longitude,
              ),
            ),
          ],
        ),
        leadingWidth: 100,
        actions: [
          IconButton(
            icon: const Icon(Icons.menu, color: Colors.white),
            onPressed: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const LiteraturaRecomendadaScreen(),
              ),
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: () => Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) =>
                      FullscreenImageScreen(imageUrl: memorial['imageUrl']),
                ),
              ),
              child: Image.asset(
                memorial['imageUrl'],
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    height: 200,
                    color: Colors.grey.shade800,
                    child: const Center(
                      child: Icon(Icons.image_not_supported,
                          size: 50, color: Colors.white70),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 10, right: 10, top: 10, bottom: 60),
              child: Text(
                memorial['description'],
                style: const TextStyle(
                  fontSize: 18,
                  height: 1.6,
                  color: Colors.white70,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
