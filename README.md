
# Nexus Medical AI – Your AI Medical Assistant

**Nexus Medical AI** is an intelligent medical assistant built with Flutter and Google Gemini API. It enables users to search conditions, track symptoms, understand medications, and receive personalized health insights—all through a clean, accessible interface.

---

## 🧠 Features

- **AI Medical Search** – Ask health-related questions in natural language  
- **Condition Insights** – Understand symptoms, causes, and treatments  
- **Medication Guide** – Pill identifiers, dosage, and interaction details  
- **Symptom Tracker** – Log and monitor severity over time  
- **Smart Bookmarks** – Save and organize useful medical content  
- **AI Chat Assistant** – Conversational, context-aware medical Q&A  
- **Accessibility Options** – Dark mode, high contrast, scalable text  

---

## 🧱 Project Structure

```bash
lib/
├── main.dart

├── models/             # Data models
├── providers/          # State management
├── repositories/       # Data sources
├── services/           # Business logic
├── widgets/            # UI components
└── screens/            # Screens for each feature

````

---

## 🛠️ Tech Stack

| Layer             | Technology                            |
| ----------------- | ------------------------------------- |
| Framework         | Flutter 3.13+                         |
| AI Integration    | Google Gemini API                     |
| State Management  | Provider                              |
| Networking        | Dio                                   |
| Caching & Storage | CachedNetworkImage, SharedPreferences |
| Analytics & Logs  | Firebase Analytics, Sentry            |
| Testing           | Widget, Golden, Integration           |

---

## 🚀 Getting Started

### Prerequisites

* Flutter SDK 3.13+
* Dart SDK 3.1+
* Google Gemini API Key
* Firebase Project (optional for analytics)

### Setup

```bash
# Clone the repo
git clone https://github.com/muhammadnouman758/nexus-medical-ai.git
cd nexus-medical-ai

# Install dependencies
flutter pub get

# Configure environment
cp .env.example .env
# Add your API keys

# Run the app
flutter run
```

---

## 🧪 Testing

```bash
# Run all tests
flutter test

# Update golden images
flutter test --update-goldens
```

---

## 📌 Roadmap

* ✅ AI Health Search
* ✅ Symptom Tracking
* ✅ Medication Information
* ✅ Context-Aware AI Assistant
* 🔄 UI/UX Optimization
* 🔜 Multilingual Support, Wearable Integration

---

## 📄 License

Licensed under the [MIT License](LICENSE).

---

## ⚠️ Disclaimer

> Nexus Medical AI provides general health information and does not replace medical advice from qualified healthcare professionals.

---

## 🙌 Credits

* Google Gemini API
* Flutter & Dart Community
* Open Source Libraries

```

Let me know if you'd like:
- A logo/banner design
- A `CONTRIBUTING.md` or `CHANGELOG.md`


Just say the word.
```
