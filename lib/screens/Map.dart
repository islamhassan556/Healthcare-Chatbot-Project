// ignore_for_file: prefer_collection_literals, prefer_const_constructors, avoid_function_literals_in_foreach_calls, file_names

import 'dart:async';
import 'dart:collection';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Mappage extends StatefulWidget {
  const Mappage({Key? key}) : super(key: key);

  @override
  State<Mappage> createState() => _MappageState();
}

class Hospital {
  final String name;
  final LatLng position;

  Hospital({required this.name, required this.position});
}

class _MappageState extends State<Mappage> {
  var myMarkers = HashSet<Marker>();
  var polylines = Set<Polyline>();
  final List<Hospital> hospitals = [
  Hospital(name: "مستشفى الهلال الاحمر باسوان Red Cercent Hospital in Aswan", position: LatLng(24.08800125, 32.90044403)),
  Hospital(name: "Aswan University Hospital", position: LatLng(24.08613777, 32.90711975)),
  Hospital(name: "مستشفيات جامعة أسوان", position: LatLng(24.09004784, 32.8948822)),
  Hospital(name: "Evangelical Mission Hospital - Al Germaniah", position: LatLng(24.08496094, 32.89260101)),
  Hospital(name: "Aswan Mental Health Hospital", position: LatLng(23.98172569, 32.88729858)),
  Hospital(name: "المستشفى التخصصي أسوان", position: LatLng(24.08493423, 32.89469528)),
  Hospital(name: "مستشفي الكوثليك", position: LatLng(24.09536552, 32.89946365)),
  Hospital(name: "مستشفى حفصة التخصصي", position: LatLng(24.09446716, 32.90139771)),
  Hospital(name: "مستشفى أسوان العسكري", position: LatLng(24.04797935, 32.8807373)),
  Hospital(name: "مركز مجدى يعقوب للقلب باسوان", position: LatLng(24.08626747, 32.9082222)),
  Hospital(name: "Archangel Hospital", position: LatLng(27.18157959, 31.18672562)),
  Hospital(name: "Asiout General Hospital", position: LatLng(27.17743111, 31.18348122)),
  Hospital(name: "Abou Tig Central Hospital", position: LatLng(27.17936325, 31.18836212)),
  Hospital(name: "Al Iman General Hospital", position: LatLng(27.17187309, 31.18624115)),
  Hospital(name: "Police Hospital in Assiut", position: LatLng(27.19322777, 31.17954254)),
  Hospital(name: "Assiut University Hospitals", position: LatLng(27.18708611, 31.16552734)),
  Hospital(name: "Clinics University Hospital, Al-Azhar University, Assiut", position: LatLng(27.19996834, 31.17141342)),
  Hospital(name: "Children University Hospital - Assiut University", position: LatLng(27.18610191, 31.1750679)),
  Hospital(name: "NBE ATM - Police Hospital - Assiut - مستشفى الشرطة - أسيوط", position: LatLng(27.19000244, 31.16632652)),
  Hospital(name: "Oriflame Asyut", position: LatLng(27.18779945, 31.19190979)),
  Hospital(name: "المستشفى الجامعى الجديد", position: LatLng(31.20137024, 29.90422058)),
  Hospital(name: "مستشفيات جامعة الاسكندرية-الصفحة الرسمية", position: LatLng(31.2010994, 29.9029007)),
  Hospital(name: "المركز الملكي للأوعية الدموية والقدم السكري", position: LatLng(31.20421219, 29.90581131)),
  Hospital(name: "مستشفى الأسكندرية للكلى و المسالك البولية", position: LatLng(31.16786003, 29.93090248)),
  Hospital(name: "Alex Specialized Hospital مستشفى اليكس التخصصي", position: LatLng(31.22140312, 29.94590569)),
  Hospital(name: "City Hospital - مستشفى سيتي", position: LatLng(31.23844719, 29.96635628)),
  Hospital(name: "Hassab Labs For Medical tests", position: LatLng(31.18912506, 29.88755226)),
  Hospital(name: "مستشفى الميرى الجامعى الإسكندرية", position: LatLng(31.20110321, 29.9093399)),
  Hospital(name: "Arafat Medical Center", position: LatLng(31.18787956, 29.91114998)),
  Hospital(name: "Sahla Hospital", position: LatLng(31.19092369, 29.90896797)),
  Hospital(name: "مستشفى أورام الإسماعيلية التعليمي", position: LatLng(30.59490585, 32.26947021)),
  Hospital(name: "Dar El Shefaa Specialized Hospital", position: LatLng(30.61150169, 32.26212311)),
  Hospital(name: "Juhaina Central Hospital", position: LatLng(30.59516907, 32.27320099)),
  Hospital(name: "Sadr El Ismaileya Hospital", position: LatLng(30.58099174, 32.25577927)),
  Hospital(name: "Ismaileya General Hospital", position: LatLng(30.62097168, 32.28750992)),
  Hospital(name: "مستشفى هيئة قناة السويس", position: LatLng(30.5964241, 32.30835342)),
  Hospital(name: "El Amal", position: LatLng(30.61126709, 32.28644562)),
  Hospital(name: "International Physical Therapy Center", position: LatLng(30.59274101, 32.27348328)),
  Hospital(name: "مستشفي الطلبه (التأمين الصحي مؤقتا)", position: LatLng(30.59083748, 32.26454926)),
   Hospital(name: "Regional Center For Blood Transfusion", position: LatLng(30.59617615, 32.27326965)),
  Hospital(name: "Shefaa El Orman Oncology Hospital", position: LatLng(25.69598389, 32.64565277)),
  Hospital(name: "مستشفي الكمال فرع الأقصر", position: LatLng(25.72633934, 32.66014862)),
  Hospital(name: "مستشفي الأقصر الدولي", position: LatLng(25.70307732, 32.66730118)),
  Hospital(name: "Luxor International Hospital", position: LatLng(25.68772507, 32.64097214)),
  Hospital(name: "مستشفى الكرنك الدولي", position: LatLng(25.70488548, 32.64193726)),
  Hospital(name: "مستشفى الأقصر العام", position: LatLng(25.70828056, 32.64562225)),
  Hospital(name: "مستشفى العيون الدولى", position: LatLng(25.69128418, 32.63625336)),
  Hospital(name: "مستشفي الاقصر الأورمان", position: LatLng(25.68724442, 32.6395874)),
  Hospital(name: "International Eye Hospital", position: LatLng(25.68550301, 32.62963867)),
  Hospital(name: "مستشفى الندى الطبى التخصصى", position: LatLng(25.70828247, 32.64916229)),
  Hospital(name: "مستشفى الجيزة التخصصى", position: LatLng(30.00405693, 31.19953156)),
  Hospital(name: "مستشفى الجيزة الدولي-التطبيقيين.", position: LatLng(30.01186371, 31.20742607)),
  Hospital(name: "Al Gazeera Hospital", position: LatLng(30.0102005, 31.19231033)),
  Hospital(name: "مستشفى الرمد بالجيزة", position: LatLng(30.01551819, 31.21679306)),
  Hospital(name: "جامعة القاهرة مستشفى الطلبة", position: LatLng(30.01516533, 31.21175003)),
  Hospital(name: "Ophthalmology Hospital", position: LatLng(30.01554871, 31.21585655)),
  Hospital(name: "El Gabry Hospital", position: LatLng(30.0107193, 31.19197083)),
  Hospital(name: "Dr. Yousry Gohar Hospital", position: LatLng(30.01272774, 31.2227478)),
  Hospital(name: "Resala Hospital", position: LatLng(30.0104866, 31.1913929)),
  Hospital(name: "El Nile Hospital", position: LatLng(30.01618385, 31.21250343)),
  Hospital(name: "مستشفى السلام التخصصي بالفيوم", position: LatLng(29.30426025, 30.84645081)),
  Hospital(name: "مستشفى الزهراء التخصصى", position: LatLng(29.30443954, 30.85108566)),
  Hospital(name: "Makka Specialized Hospital", position: LatLng(29.30678558, 30.85532951)),
  Hospital(name: "الحياة للخدمات الطبية", position: LatLng(29.32369995, 30.8576889)),
  Hospital(name: "مستشفى الفيوم الدولي / مستشفى الطب التخصصي", position: LatLng(29.3069458, 30.89175224)),
  Hospital(name: "مستشفى الشفاء", position: LatLng(29.30952644, 30.84131622)),
  Hospital(name: "مستشفى الندى التخصصي بالفيوم | Faiyum", position: LatLng(29.3121624, 30.8562336)),
  Hospital(name: "El Nabawy El Mohandes General Hospital", position: LatLng(29.31628227, 30.85051537)),
  Hospital(name: "مستشفى الفيوم الدولى", position: LatLng(29.30796051, 30.88565445)),
  Hospital(name: "مستشفي حميات الفيوم", position: LatLng(29.2965126, 30.83158875)),
  Hospital(name: "Cairo Fatemy Hospital", position: LatLng(30.04668427, 31.27088356)),
  Hospital(name: "Children's Cancer Hospital Egypt", position: LatLng(30.02276039, 31.23852921)),
  Hospital(name: "El Houd El Marsoud Hospital", position: LatLng(30.03207207, 31.24709511)),
  Hospital(name: "Cairo University Hospitals", position: LatLng(30.03422356, 31.2277813)),
  Hospital(name: "مستشفى أطفال مصر", position: LatLng(30.02799034, 31.23653984)),
  Hospital(name: "Dr. Said Korraa Hospital", position: LatLng(30.04727364, 31.23849869)),
  Hospital(name: "ElGomhoria Teaching Hospital مستشفى الجمهورية التعليمى", position: LatLng(30.02722549, 31.24122238)),
  Hospital(name: "Al Dorrah Heart Care Hospital", position: LatLng(30.04211998, 31.24383926)),
  Hospital(name: "El Mounira General Hospital", position: LatLng(30.03482628, 31.23807144)),
  Hospital(name: "University Children Hospital At El Mounira - Abulreesh", position: LatLng(30.0293026, 31.23495293)),
  Hospital(name: "Cairo Fatemy Hospital", position: LatLng(30.04668427, 31.27088356)),
  Hospital(name: "Children's Cancer Hospital Egypt", position: LatLng(30.02276039, 31.23852921)),
  Hospital(name: "El Houd El Marsoud Hospital", position: LatLng(30.03207207, 31.24709511)),
  Hospital(name: "Cairo University Hospitals", position: LatLng(30.03422356, 31.2277813)),
  Hospital(name: "مستشفى أطفال مصر", position: LatLng(30.02799034, 31.23653984)),
  Hospital(name: "Dr. Said Korraa Hospital", position: LatLng(30.04727364, 31.23849869)),
  Hospital(name: "ElGomhoria Teaching Hospital مستشفى الجمهورية التعليمى", position: LatLng(30.02722549, 31.24122238)),
  Hospital(name: "Al Dorrah Heart Care Hospital", position: LatLng(30.04211998, 31.24383926)),
  Hospital(name: "El Mounira General Hospital", position: LatLng(30.03482628, 31.23807144)),
  Hospital(name: "University Children Hospital At El Mounira - Abulreesh", position: LatLng(30.0293026, 31.23495293)),
  Hospital(name: "Menouf General Hospital", position: LatLng(30.4709816, 30.92564011)),
  Hospital(name: "مستشفى مصر الحياة التخصصى بالشهداء - المنوفية", position: LatLng(30.59676933, 30.90526962)),
  Hospital(name: "El Safa Hospital", position: LatLng(30.46533775, 30.88595963)),
  Hospital(name: "El Safa Specialized Hospital", position: LatLng(30.46481514, 30.92939568)),
  Hospital(name: "Monofeya University Hospital", position: LatLng(30.57487488, 31.01191521)),
  Hospital(name: "مستشفى الجمعية الشرعية ببهناي", position: LatLng(30.39098167, 31.06875229)),
  Hospital(name: "El Salam Hospital", position: LatLng(30.46331787, 30.93546104)),
  Hospital(name: "Psychological Health & Addiction Treatment Hospital", position: LatLng(30.54461479, 31.04793358)),
  Hospital(name: "مستشفى ميت ربيعه", position: LatLng(30.46519089, 30.9948597)),
  Hospital(name: "Alrwad Specialized Hospital", position: LatLng(30.46713829, 30.93371773)),
  Hospital(name: "بيت النغم", position: LatLng(28.10059166, 30.75586128)),
  Hospital(name: "Omar Ibn El Khattab Specialized Hospital", position: LatLng(28.08272743, 30.76492691)),
  Hospital(name: "مستشفي المنيا الجامعه", position: LatLng(28.05653, 30.76390839)),
  Hospital(name: "El Menia General Hospital", position: LatLng(28.1009903, 30.75406265)),
  Hospital(name: "EL Menia University Hospital", position: LatLng(28.08953476, 30.76632118)),
  Hospital(name: "مستشفي المنيا الدولي", position: LatLng(28.09608841, 30.77749825)),
  Hospital(name: "El Menia Hospital For Mental Health & Addiction Treatment", position: LatLng(28.08109283, 30.80702019)),
  Hospital(name: "El Menia Psychiatric Hospital", position: LatLng(28.04374695, 30.77428246)),
  Hospital(name: "مستشفى دار الهلال بطهنشا", position: LatLng(28.03615952, 30.75492096)),
  Hospital(name: "El Farafra Central Hospital", position: LatLng(27.06783295, 27.97322845)),
  Hospital(name: "مستشفى الحميات", position: LatLng(25.44145584, 30.55953217)),
  Hospital(name: "El Kharga General Hospital", position: LatLng(25.44227982, 30.55042267)),
  Hospital(name: "مشروع إنشاء مستشفى الداخله العام", position: LatLng(25.50407982, 29.00006866)),
  Hospital(name: "Sadr El Kharga Hospital", position: LatLng(25.44127083, 30.55976486)),
  Hospital(name: "مستشفى غرب الموهوب", position: LatLng(25.87672424, 28.55901527)),
  Hospital(name: "مستشفى باريس المركزي", position: LatLng(24.67482376, 30.60162735)),
  Hospital(name: "مستشفي", position: LatLng(26.33594513, 31.77669907)),
  Hospital(name: "مستشفي الاورمان للاطفال", position: LatLng(26.43630981, 31.6619339)),
  Hospital(name: "NBE ATM - Al Sadr Hospital (Kharga) - مستشفى الصدر (الخارجة)", position: LatLng(25.4412365, 30.55970573)),
  Hospital(name: "Banisuef General Hospital", position: LatLng(29.06395149, 31.10288811)),
  Hospital(name: "مستشفى بنى سويف الجامعى", position: LatLng(29.08039665, 31.105299)),
  Hospital(name: "Al Banna Specialized Center", position: LatLng(29.07803345, 31.0905838)),
  Hospital(name: "مستشفى الزهور الحياه", position: LatLng(28.81825066, 30.89974022)),
  Hospital(name: "مستشفى حميات بني سويف", position: LatLng(29.06844139, 31.09557724)),
  Hospital(name: "Faculty Of Medicine - Banisuef University", position: LatLng(29.07384872, 31.08964729)),
  Hospital(name: "Dar El Oyoun Hospitals", position: LatLng(29.07575417, 31.11478615)),
  Hospital(name: "Somosta Central Hospital", position: LatLng(28.913311, 30.85264778)),
  Hospital(name: "Beba Central Hospital", position: LatLng(28.92635536, 30.97284126)),
  Hospital(name: "مستشفى السلام الخيري - الأشعة", position: LatLng(29.07260704, 31.09710121)),
  Hospital(name: "مستشفى المعلمين (مجموعة اللوتس)", position: LatLng(31.26964378, 32.28581619)),
  Hospital(name: "Al Youssif Hospital مستشفي ال يوسف التخصصي", position: LatLng(31.27223778, 32.28497314)),
  Hospital(name: "Al Soliman Hospital", position: LatLng(31.26957512, 32.29239655)),
  Hospital(name: "Sadr Port Said Hospital - El Masah El Bahary", position: LatLng(31.27048492, 32.29190826)),
  Hospital(name: "مستشفى عطاء التخصصي", position: LatLng(31.26172447, 32.28569031)),
  Hospital(name: "El Tadamon Specialized Hospital", position: LatLng(31.26995659, 32.2939682)),
  Hospital(name: "مستشفى الرحمه", position: LatLng(31.26142693, 32.30140305)),
  Hospital(name: "Location Studio", position: LatLng(31.26998329, 32.2964592)),
  Hospital(name: "Port Said General Hospital", position: LatLng(31.26459885, 32.30456161)),
  Hospital(name: "مستشفى المبرة", position: LatLng(31.26958275, 32.29655457)),
  Hospital(name: "مستشفى أورام الإسماعيلية التعليمي", position: LatLng(30.59490585, 32.26947021)),
  Hospital(name: "Dar El Shefaa Specialized Hospital", position: LatLng(30.61150169, 32.26212311)),
  Hospital(name: "Juhaina Central Hospital", position: LatLng(30.59516907, 32.27320099)),
  Hospital(name: "Sadr El Ismaileya Hospital", position: LatLng(30.58099174, 32.25577927)),
  Hospital(name: "Ismaileya General Hospital", position: LatLng(30.62097168, 32.28750992)),
  Hospital(name: "مستشفى هيئة قناة السويس", position: LatLng(30.5964241, 32.30835342)),
  Hospital(name: "El Amal", position: LatLng(30.61126709, 32.28644562)),
  Hospital(name: "International Physical Therapy Center", position: LatLng(30.59274101, 32.27348328)),
  Hospital(name: "مستشفي الطلبه (التأمين الصحي مؤقتا)", position: LatLng(30.59083748, 32.26454926)),
  Hospital(name: "Regional Center For Blood Transfusion", position: LatLng(30.59617615, 32.27326965)),
  Hospital(name: "Al Salam Hospital", position: LatLng(31.41025734, 31.8101368)),
    Hospital(name: "مستشفى الصدر بدمياط", position: LatLng(31.41733932, 31.82057571)),
    Hospital(name: "El Safa Hospital", position: LatLng(31.42456055, 31.80190468)),
    Hospital(name: "Damietta Specialized Hospital", position: LatLng(31.43728256, 31.80107307)),
    Hospital(name: "El Helal Health Insurance Hospital", position: LatLng(31.41558456, 31.8111763)),
    Hospital(name: "معهد الأورام بدمياط - الصفحة الرسمية", position: LatLng(31.43763351, 31.80220032)),
    Hospital(name: "Edfou Fever Hospital", position: LatLng(31.40175056, 31.8097496)),
    Hospital(name: "El Zarqa Central Hospital", position: LatLng(31.40532494, 31.80950737)),
    Hospital(name: "مستشفى دار العيون دمياط", position: LatLng(31.40963936, 31.81816864)),
    Hospital(name: "Damietta Specialized Hospital", position: LatLng(31.43645668, 31.80093956)),
    Hospital(name: "مستشفي الرحمة", position: LatLng(26.77656937, 31.49487686)),
    Hospital(name: "Rashed Specialized Hospital", position: LatLng(26.56071091, 31.70910835)),
    Hospital(name: "Misr Hospital In Sohag", position: LatLng(26.55392075, 31.70637703)),
    Hospital(name: "مستشفي دار الطب بسوهاج", position: LatLng(26.5542984, 31.68901253)),
    Hospital(name: "مستشفى نور الحياه طهطا", position: LatLng(26.7647953, 31.4982872)),
    Hospital(name: "مستشفى النور", position: LatLng(26.53277779, 31.70111656)),
    Hospital(name: "El Maragha Central Hospital", position: LatLng(26.70087624, 31.60046768)),
    Hospital(name: "Geziret Shandawil Central Hospital", position: LatLng(26.62348557, 31.6396656)),
    Hospital(name: "مستشفي فزارة", position: LatLng(26.69194221, 31.5285759)),
    Hospital(name: "مستشفى الحياة التخصصية", position: LatLng(26.77816582, 31.49677277)),
    Hospital(name: "Abu Rudeis Central Hospital", position: LatLng(29.60061264, 32.70996475)),
    Hospital(name: "El Nakhl Central Hospital", position: LatLng(29.9104538, 33.74654007)),
    Hospital(name: "Beaar El Abd Central Hospital", position: LatLng(31.0170269, 33.02954865)),
    Hospital(name: "El Arish General Hospital", position: LatLng(31.13755417, 33.80860138)),
    Hospital(name: "El Sheikh Zowaid Central Hospital", position: LatLng(31.22278786, 34.12280273)),
    Hospital(name: "Rafah Central Hospital", position: LatLng(31.25654221, 34.22780991)),
    Hospital(name: "مستشفى بئر العبد المركزى", position: LatLng(31.01066208, 32.99472046)),
    Hospital(name: "El Arish Military Hospital", position: LatLng(31.14426041, 33.82823563)),
    Hospital(name: "مستشفى العريش العام", position: LatLng(30.60847282, 33.6175766)),
    Hospital(name: "El Canal International Hospital", position: LatLng(29.9715538, 32.5506134)),
    Hospital(name: "مستشفى قنا الجامعى", position: LatLng(26.15917969, 32.30971527)),
    Hospital(name: "Qena Health Insurance Hospital", position: LatLng(26.18553543, 32.75247955)),
    Hospital(name: "Sadr Qena Hospital", position: LatLng(26.15712357, 32.71022034)),
    Hospital(name: "مستشفى الصدر بقنا", position: LatLng(26.17026901, 32.71291733)),
    Hospital(name: "Qena New General Hospital", position: LatLng(26.18933105, 32.73168182)),
    Hospital(name: "Dar El Oyoun Hospitals", position: LatLng(26.16002083, 32.7088356)),
    Hospital(name: "مستشفى اليوم الواحد", position: LatLng(26.18943405, 32.73189163)),
    Hospital(name: "مستشفى قنا العام", position: LatLng(26.15894318, 32.70698166)),
    Hospital(name: "مستشفي الرضي بالسوق الفوقاني", position: LatLng(26.16147614, 32.7197113)),
    Hospital(name: "مستشفى النيل للجراحة", position: LatLng(26.16193008, 32.70690918)),
    Hospital(name: "Archangel Hospital", position: LatLng(27.18157959, 31.18672562)),
    Hospital(name: "Asiout General Hospital", position: LatLng(27.17743111, 31.18348122)),
    Hospital(name: "Abou Tig Central Hospital", position: LatLng(27.17936325, 31.18836212)),
    Hospital(name: "Al Iman General Hospital", position: LatLng(27.17187309, 31.18624115)),
    Hospital(name: "Police Hospital in Assiut..", position: LatLng(27.19322777, 31.17954254)),
    Hospital(name: "Assiut University Hospitals", position: LatLng(27.18708611, 31.16552734)),
    Hospital(name: "Clinics University Hospital, Al-Azhar University, Assiut", position: LatLng(27.19996834, 31.17141342)),
    Hospital(name: "Children University Hospital - Assiut University", position: LatLng(27.18610191, 31.1750679)),
    Hospital(name: "NBE ATM - Police Hospital - Assiut - مستشفى الشرطة - أسيوط", position: LatLng(27.19000244, 31.16632652)),
    Hospital(name: "Oriflame Asyut", position: LatLng(27.18779945, 31.19190979)),
    Hospital(name: "Archangel Hospital", position: LatLng(27.18157959, 31.18672562)),
    Hospital(name: "Asiout General Hospital", position: LatLng(27.17743111, 31.18348122)),
    Hospital(name: "Abou Tig Central Hospital", position: LatLng(27.17936325, 31.18836212)),
    Hospital(name: "Al Iman General Hospital", position: LatLng(27.17187309, 31.18624115)),
    Hospital(name: "Police Hospital in Assiut..", position: LatLng(27.19322777, 31.17954254)),
    Hospital(name: "Assiut University Hospitals", position: LatLng(27.18708611, 31.16552734)),
    Hospital(name: "Clinics University Hospital, Al-Azhar University, Assiut", position: LatLng(27.19996834, 31.17141342)),
    Hospital(name: "Children University Hospital - Assiut University", position: LatLng(27.18610191, 31.1750679)),
    Hospital(name: "NBE ATM - Police Hospital - Assiut - مستشفى الشرطة - أسيوط", position: LatLng(27.19000244, 31.16632652)),
    Hospital(name: "Oriflame Asyut", position: LatLng(27.18779945, 31.19190979)),
  ];



   final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  bool _isTracking = false;
  StreamSubscription<Position>? _positionStreamSubscription;
  Hospital? selectedHospital;
  

  @override
  void initState() {
    super.initState();
    determinePosition();
  }

  Future<void> determinePosition() async {
    Position currentPosition = await Geolocator.getCurrentPosition();

    hospitals.sort((a, b) => Geolocator.distanceBetween(
      currentPosition.latitude,
      currentPosition.longitude,
      a.position.latitude,
      a.position.longitude,
    ).compareTo(
      Geolocator.distanceBetween(
        currentPosition.latitude,
        currentPosition.longitude,
        b.position.latitude,
        b.position.longitude,
      ),
    ));

    final closestHospitals = hospitals.sublist(0, 5);

    setState(() {
      closestHospitals.forEach((hospital) {
        myMarkers.add(
          Marker(
            markerId: MarkerId(hospital.name),
            position: hospital.position,
            icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
            infoWindow: InfoWindow(title: hospital.name),
            onTap: () {
              _onHospitalMarkerTapped(hospital, currentPosition);
            },
          ),
        );
      });
    });

    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(
      CameraUpdate.newLatLng(
        LatLng(currentPosition.latitude, currentPosition.longitude),
      ),
    );

    _positionStreamSubscription = Geolocator.getPositionStream().listen((Position? position) {
      if (_isTracking && position != null) {
        _updateMarkers(position);
        if (selectedHospital != null) {
          _updateRoute(position, selectedHospital!.position);
        }
      }
    });
  }

  void _updateMarkers(Position position) {
    setState(() {
      myMarkers.removeWhere((marker) => marker.markerId.value == 'userLocation');
      myMarkers.add(
        Marker(
          markerId: MarkerId('userLocation'),
          position: LatLng(position.latitude, position.longitude),
          icon: BitmapDescriptor.defaultMarker,
          infoWindow: InfoWindow(title: 'موقع المستخدم'),
        ),
      );
    });
  }

  void _onHospitalMarkerTapped(Hospital hospital, Position currentPosition) {
    setState(() {
      selectedHospital = hospital;

      double distance = Geolocator.distanceBetween(
        currentPosition.latitude,
        currentPosition.longitude,
        hospital.position.latitude,
        hospital.position.longitude,
      );

      double distanceInKm = distance / 1000;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Distance to ${hospital.name}: ${distanceInKm.toStringAsFixed(2)} Km'),
        ),
      );

      _updateRoute(currentPosition, hospital.position);
      _updateMarkers(currentPosition);
    });
  }

  void _updateRoute(Position userPosition, LatLng hospitalPosition) {
    setState(() {
      polylines.clear(); // Clear previous polyline
      polylines.add(
        Polyline(
          polylineId: PolylineId('route'),
          points: [LatLng(userPosition.latitude, userPosition.longitude), hospitalPosition],
          width: 5,
          color: Colors.blue,
        ),
      );
    });
  }

  @override
  void dispose() {
    super.dispose();
    _positionStreamSubscription?.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(
          child: Text(
            AppLocalizations.of(context)!.map_title,
            style: TextStyle(fontSize: 27, fontWeight: FontWeight.bold, color: Colors.white),
          ),
        ),
        backgroundColor: const Color.fromARGB(255, 65, 111, 149),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              setState(() {
                selectedHospital = null;
                polylines.clear();
              });
            },
            icon: Icon(Icons.delete_forever_sharp),
          )
        ],
      ),
      body: Stack(
        children: [
          GoogleMap(
            zoomGesturesEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: LatLng(26.558173, 31.699592),
              zoom: 14,
            ),
            markers: myMarkers,
            polylines: polylines,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
            myLocationEnabled: _isTracking,
            myLocationButtonEnabled: false,
          ),
          Positioned(
            bottom: 25,
            right: 250,
            left: 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _isTracking = !_isTracking;
                    });
                    if (_isTracking) {
                      determinePosition();
                    } else {
                      _positionStreamSubscription?.cancel();
                      setState(() {
                        myMarkers.removeWhere((marker) => marker.markerId.value == 'userLocation');
                        polylines.clear();
                      });
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _isTracking ? Colors.green : const Color.fromARGB(255, 65, 111, 149),
                  ),
                  child: Text(
                    _isTracking ? AppLocalizations.of(context)!.map_tracking_1 : AppLocalizations.of(context)!.map_tracking_2,
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}