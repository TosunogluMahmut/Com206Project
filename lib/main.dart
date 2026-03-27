import 'package:flutter/material.dart';

void main() {
  runApp(const CekiciApp());
}
class CekiciApp extends StatelessWidget {
  const CekiciApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 25),
          ),
        ),
      ),
      home: const GirisSayfasi(),
    );
  }
}

class Cekici {
  String plaka, surucu, tip;
  bool musaitMi;
  Cekici(this.plaka, this.surucu, this.tip, this.musaitMi);
}

class GirisSayfasi extends StatelessWidget {
  const GirisSayfasi({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.fire_truck_rounded, size: 80, color: Colors.orange),
            const SizedBox(height: 10),
            const Text("GELİŞİM LOGO", style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: Colors.orange)),
            const SizedBox(height: 40),
            TextField(decoration: InputDecoration(labelText: "Kullanıcı", border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
            const SizedBox(height: 15),
            TextField(obscureText: true, decoration: InputDecoration(labelText: "Şifre", border: OutlineInputBorder(borderRadius: BorderRadius.circular(15)))),
            const SizedBox(height: 30),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const AnaSayfa())),
                child: const Text("Giriş Yap", style: TextStyle(fontSize: 16)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class AnaSayfa extends StatefulWidget {
  const AnaSayfa({super.key});
  @override
  State<AnaSayfa> createState() => _AnaSayfaState();
}

class _AnaSayfaState extends State<AnaSayfa> {

  List<Cekici> filo = [

    Cekici("34 ABC 123", "Mahmut Eren", "Kayar Kasa", true),

    Cekici("34 DEF 123", "Ahmet Yılmaz", "Ahtapot", false),

  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Yol Yardım Filosu", style: TextStyle(fontWeight: FontWeight.bold)), centerTitle: true),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: filo.length,
              itemBuilder: (context, index) {
                return Card(
                  elevation: 2,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    contentPadding: const EdgeInsets.all(15),
                    leading: CircleAvatar(backgroundColor: Colors.orange.withOpacity(0.1), child: const Icon(Icons.local_shipping, color: Colors.orange)),
                    title: Text(filo[index].plaka, style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text("${filo[index].surucu}\n${filo[index].tip}"),
                    trailing: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.circle, color: filo[index].musaitMi ? Colors.green : Colors.red, size: 14),
                        Text(filo[index].musaitMi ? "Müsait" : "Meşgul", style: TextStyle(fontSize: 10, color: Colors.grey[600])),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(24.0),
            child: OutlinedButton(
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(double.infinity, 55),
                side: const BorderSide(color: Colors.orange, width: 2),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              onPressed: () async {
                final yeni = await Navigator.push(context, MaterialPageRoute(builder: (context) => const EklemeSayfasi()));
                if (yeni != null) setState(() => filo.add(yeni));
              },
              child: const Text("Filomuza Katılmak İster Misiniz?", style: TextStyle(color: Colors.orange, fontWeight: FontWeight.bold)),
            ),
          ),
        ],
      ),
    );
  }
}

class EklemeSayfasi extends StatelessWidget {
  const EklemeSayfasi({super.key});
  @override
  Widget build(BuildContext context) {
    final pKontrol = TextEditingController();
    final sKontrol = TextEditingController();
    final tKontrol = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: const Text("Yeni Araç Kaydı")),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            TextField(controller: pKontrol, decoration: InputDecoration(labelText: "Plaka", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 15),
            TextField(controller: sKontrol, decoration: InputDecoration(labelText: "Sürücü", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 15),
            TextField(controller: tKontrol, decoration: InputDecoration(labelText: "Araç Tipi", border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)))),
            const SizedBox(height: 30),
            ElevatedButton(
              onPressed: () => Navigator.pop(context, Cekici(pKontrol.text, sKontrol.text, tKontrol.text, true)),
              child: const Center(child: Text("Kaydı Tamamla")),
            ),
          ],
        ),
      ),
    );
  }
}
