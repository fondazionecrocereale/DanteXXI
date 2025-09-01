import '../../domain/entities/radio_station.dart';

class RadioService {
  static List<RadioStation> getRadioStations() {
    return [
      RadioStation(
        id: 1,
        name: 'Radio RAI Uno',
        streamUrl: 'https://icestreaming.rai.it/1.mp3',
        description: 'La primera radio pública de Italia',
        category: 'General',
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Rai_Radio_1_logo.svg/1200px-Rai_Radio_1_logo.svg.png',
      ),
      RadioStation(
        id: 2,
        name: 'Radio RAI Due',
        streamUrl: 'https://icestreaming.rai.it/2.mp3',
        description: 'Radio cultural y de entretenimiento',
        category: 'Cultural',
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Rai_Radio_2_logo.svg/1200px-Rai_Radio_2_logo.svg.png',
      ),
      RadioStation(
        id: 3,
        name: 'Radio RAI Tre',
        streamUrl: 'https://icestreaming.rai.it/3.mp3',
        description: 'Radio de noticias y actualidad',
        category: 'Noticias',
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Rai_Radio_3_logo.svg/1200px-Rai_Radio_3_logo.svg.png',
      ),
      RadioStation(
        id: 4,
        name: 'Radio 105',
        streamUrl: 'https://icecast.unitedradio.it/Radio105.mp3',
        description: 'Radio de música pop y entretenimiento',
        category: 'Música',
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Radio_105_logo.svg/1200px-Radio_105_logo.svg.png',
      ),
      RadioStation(
        id: 5,
        name: 'Radio Deejay',
        streamUrl: 'https://mp3.kataweb.it:8000/RadioDeejay',
        description: 'Radio de música y entretenimiento',
        category: 'Música',
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Radio_Deejay_logo.svg/1200px-Radio_Deejay_logo.svg.png',
      ),
      RadioStation(
        id: 6,
        name: 'Radio Italia',
        streamUrl: 'https://radioitalia.wm.p1.str3.com/rditaliahq',
        description: 'Solo música italiana',
        category: 'Música Italiana',
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Radio_Italia_logo.svg/1200px-Radio_Italia_logo.svg.png',
      ),
      RadioStation(
        id: 7,
        name: 'Radio Capital',
        streamUrl: 'https://live.mediaserver.kataweb.it/capital',
        description: 'Radio de música rock y alternativa',
        category: 'Rock',
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Radio_Capital_logo.svg/1200px-Radio_Capital_logo.svg.png',
      ),
      RadioStation(
        id: 8,
        name: 'RTL 102.5',
        streamUrl: 'https://151.1.245.36:8080/rtl102.5lq',
        description: 'Radio de música y entretenimiento',
        category: 'Música',
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/RTL_102.5_logo.svg/1200px/RTL_102.5_logo.svg.png',
      ),
      RadioStation(
        id: 9,
        name: 'Radio 101',
        streamUrl: 'https://live.r101.it/redundant/r101vr.rm',
        description: 'Radio de música y entretenimiento',
        category: 'Música',
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Radio_101_logo.svg/1200px-Radio_101_logo.svg.png',
      ),
      RadioStation(
        id: 10,
        name: 'Virgin Radio Classics',
        streamUrl: 'https://151.1.245.1:8080/24',
        description: 'Música clásica y hits de los 80s y 90s',
        category: 'Clásicos',
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Virgin_Radio_logo.svg/1200px-Virgin_Radio_logo.svg.png',
      ),
      RadioStation(
        id: 11,
        name: 'Radio Radicale',
        streamUrl: 'https://video-8.radioradicale.it:554/encoder/live.rm',
        description: 'Radio de política y sociedad',
        category: 'Política',
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Radio_Radicale_logo.svg/1200px-Radio_Radicale_logo.svg.png',
      ),
      RadioStation(
        id: 12,
        name: 'Jazz Radio',
        streamUrl: 'https://livestream.srg-ssr.ch/1/rsj/mp3_128',
        description: 'Música jazz las 24 horas',
        category: 'Jazz',
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Jazz_Radio_logo.svg/1200px-Jazz_Radio_logo.svg.png',
      ),
      // Radio de prueba con URL que funciona
      RadioStation(
        id: 13,
        name: 'Radio Test (Demo)',
        streamUrl: 'https://stream.radio.co/s2e2b5b5c8/listen',
        description: 'Radio de prueba para verificar funcionamiento',
        category: 'Demo',
        logo:
            'https://upload.wikimedia.org/wikipedia/commons/thumb/8/8a/Radio_Test_logo.svg/1200px-Radio_Test_logo.svg.png',
      ),
    ];
  }
}
