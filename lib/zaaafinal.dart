import 'db_helper.dart';
import 'homeza.dart';

class _HomeScreen1State extends State<HomeScreen1> {
  final DBHelper dbHelper = DBHelper();
  String name = "Loading...";
  String transliteration = "";
  String meaning = "";
  String imagePath = "assets/images/sunset.jpg";

  String prophetName = "Loading...";
  String prophetTransliteration = "";
  String prophetMeaning = "";
  String prophetImagePath = "assets/images/night.jpg";

  final CollectionReference quranCollection =
      FirebaseFirestore.instance.collection('quran_arabic');

  late Timer _verseTimer;
  late Timer _nameTimer;
  late Timer _prophetTimer;

  final List<String> imagePaths = [
    "assets/images/sunset.jpg",
    "assets/images/night.jpg",
    "assets/images/bird.jpg"
  ];

  @override
  void initState() {
    super.initState();
    fetchRandomName();
    fetchRandomProphetName();
    fetchVerse();

    _verseTimer = Timer.periodic(const Duration(seconds: 6), (timer) {
      fetchVerse();
    });
    _nameTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      fetchRandomName();
    });
    _prophetTimer = Timer.periodic(const Duration(seconds: 7), (timer) {
      fetchRandomProphetName();
    });
  }

  Future<void> fetchRandomName() async {
    var randomName = await dbHelper.getRandomName();
    if (randomName != null) {
      setState(() {
        name = randomName["name"];
        transliteration = randomName["transliteration"];
        meaning = randomName["meaning"];
        imagePath = imagePaths[Random().nextInt(imagePaths.length)];
      });
    } else {
      setState(() {
        name = "No data found!";
      });
    }
  }

  Future<void> fetchRandomProphetName() async {
    var box = await Hive.openBox('prophet_names');
    if (box.isNotEmpty) {
      var randomIndex = Random().nextInt(box.length);
      var randomProphet = box.getAt(randomIndex);
      setState(() {
        prophetName = randomProphet["name"];
        prophetTransliteration = randomProphet["transliteration"];
        prophetMeaning = randomProphet["meaning"];
        prophetImagePath = imagePaths[Random().nextInt(imagePaths.length)];
      });
    } else {
      setState(() {
        prophetName = "No data found!";
      });
    }
  }

  @override
  void dispose() {
    _verseTimer.cancel();
    _nameTimer.cancel();
    _prophetTimer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Other UI elements...
            _buildAllahNameSection(),
            const SizedBox(height: 16),
            _buildProphetNameSection(), // ✅ New Card for Prophet's Name
            const SizedBox(height: 16),
            _buildVerseOfTheDay(),
          ],
        ),
      ),
    );
  }

  Widget _buildProphetNameSection() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      margin: const EdgeInsets.symmetric(horizontal: 20),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        image: DecorationImage(
          image: AssetImage(prophetImagePath), // ✅ Dynamic Image Change
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            blurRadius: 8,
            offset: const Offset(2, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          Text(
            prophetName,
            style: const TextStyle(
              fontSize: 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          Text(
            prophetTransliteration,
            style: const TextStyle(
              fontSize: 20,
              fontStyle: FontStyle.italic,
              color: Colors.white,
            ),
          ),
          Text(
            prophetMeaning,
            style: const TextStyle(
              fontSize: 18,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }
}
