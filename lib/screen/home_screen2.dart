// // lib/screens/home_screen.dart
// import 'package:medical/screen/home_screen.dart';
//
// class _HomeScreenState extends State<HomeScreen> {
//   // Add to build method:
//
//   // Personalized recommendations section
//   if (personalizedRecs.isNotEmpty) ...[
//   const SizedBox(height: 20),
//   const Text('For You', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
//   ...personalizedRecs.map((rec) => Card(
//   elevation: 0,
//   color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
//   margin: const EdgeInsets.only(bottom: 12),
//   child: ListTile(
//   leading: Container(
//   width: 40,
//   height: 40,
//   decoration: BoxDecoration(
//   shape: BoxShape.circle,
//   color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//   ),
//   child: Icon(Icons.person, color: Theme.of(context).colorScheme.primary),
//   ),
//   title: Text(rec, style: Theme.of(context).textTheme.bodyMedium),
//   ),
//   )).toList(),
//   ],
//
//   // Add AI Assistant card
//   Card(
//   elevation: 2,
//   margin: const EdgeInsets.only(top: 20),
//   child: InkWell(
//   borderRadius: BorderRadius.circular(12),
//   onTap: () => Navigator.push(
//   context,
//   MaterialPageRoute(builder: (context) => const ChatScreen())
//   ),
//   child: Padding(
//   padding: const EdgeInsets.all(16),
//   child: Row(
//   children: [
//   Container(
//   width: 60,
//   height: 60,
//   decoration: BoxDecoration(
//   color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
//   shape: BoxShape.circle,
//   ),
//   child: Icon(
//   Icons.medical_services,
//   color: Theme.of(context).colorScheme.primary,
//   size: 30,
//   ),
//   ),
//   const SizedBox(width: 16),
//   Expanded(
//   child: Column(
//   crossAxisAlignment: CrossAxisAlignment.start,
//   children: [
//   Text(
//   'AI Medical Assistant',
//   style: Theme.of(context).textTheme.titleMedium?.copyWith(
//   fontWeight: FontWeight.bold,
//   ),
//   ),
//   const SizedBox(height: 4),
//   Text(
//   'Get answers to your health questions',
//   style: Theme.of(context).textTheme.bodyMedium,
//   ),
//   ],
//   ),
//   ),
//   const Icon(Icons.chevron_right),
//   ],
//   ),
//   ),
//   ),
//   ),