import 'package:flutter/material.dart';
import 'package:tp/services/firebase.dart';
import 'package:url_launcher/url_launcher.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final TextEditingController _controller = TextEditingController();

  void openDialogCode() async {
    await showDialog<String>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: const Text('Ajouter un Code',
              style: TextStyle(fontWeight: FontWeight.bold)),
          content: TextField(
            controller: _controller,
            decoration: InputDecoration(
              hintText: 'Ton code gojo',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              filled: true,
              fillColor: Colors.grey[200],
            ),
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () => Navigator.of(context).pop('Cancel'),
              child: const Text('Annuler', style: TextStyle(color: Colors.red)),
            ),
            ElevatedButton(
              onPressed: () {
                FirebaseService().createCode(_controller.text);
                Navigator.of(context).pop('OK');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text('Ajouter'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _launchURL(String urlString) async {
    final Uri url = Uri.parse(urlString);
    if (!await launchUrl(url, mode: LaunchMode.externalApplication)) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Mes Codes',
            style: TextStyle(fontWeight: FontWeight.bold)),
        elevation: 0,
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: Stack(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  width: 200,
                  height: 200,
                  child: Image.network(
                    'https://media1.tenor.com/m/dLlQ0y-KcPYAAAAd/dog-smile-dog.gif',
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    'Ce GIF mérite bien un 20, n\'est-ce pas ?\n'
                    'Appuyez sur le bouton + pour ajouter un nouveau code',
                    style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 16,
            bottom: 16,
            child: ElevatedButton(
              onPressed: () =>
                  _launchURL('https://portfolio-jorel-mathivon.netlify.app/'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("Qui est-ce?"),
            ),
          ),
          Positioned(
            left: 16,
            bottom: 16,
            child: ElevatedButton(
              onPressed: () => _launchURL(
                  'https://www.tiktok.com/@capitainebarbarossa/video/7292693821022932256?is_from_webapp=1&sender_device=pc&web_id=7403043065056118304'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              child: const Text("C'est bon de rire"),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: openDialogCode,
        tooltip: 'Ajouter un Code',
        icon: const Icon(Icons.add),
        label: const Text('Ajouter'),
        backgroundColor: Colors.blue,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }
}
