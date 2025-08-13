# sub_chat

A new Flutter project.

## Getting Started

This project is a starting point for a Flutter application.

A few resources to get you started if this is your first Flutter project:

- [Lab: Write your first Flutter app](https://docs.flutter.dev/get-started/codelab)
- [Cookbook: Useful Flutter samples](https://docs.flutter.dev/cookbook)

For help getting started with Flutter development, view the
[online documentation](https://docs.flutter.dev/), which offers tutorials,
samples, guidance on mobile development, and a full API reference.

## 프로젝트 구조

이 프로젝트는 다음과 같은 주요 디렉토리 구조를 가집니다.

-   `lib/`: 애플리케이션의 핵심 Dart 코드가 위치합니다.
    -   `main.dart`: 앱의 시작점입니다.
    -   `models/`: 데이터 모델 클래스들이 정의되어 있습니다. (예: `MessageModel`)
    -   `screens/`: 각 화면을 구성하는 위젯들이 있습니다. (예: `ChatRoomListScreen`, `LoginScreen`)
    -   `services/`: Firebase 인증, 데이터베이스, 위치 서비스 등 백엔드 로직 및 외부 서비스 연동을 처리합니다.
    -   `widgets/`: 여러 화면에서 재사용되는 공통 위젯들이 있습니다.
    -   `utils/`: 유틸리티 함수 및 헬퍼 클래스가 위치합니다.
-   `android/`, `ios/`, `web/` 등: 각 플랫폼별 네이티브 설정 및 코드가 위치합니다.
-   `pubspec.yaml`: 프로젝트의 의존성 및 메타데이터를 관리합니다.
-   `README.md`: 프로젝트에 대한 설명 및 문서입니다.