# Sub Chat 애플리케이션 아키텍처

이 문서는 Sub Chat 애플리케이션의 전체적인 구조, 핵심 컴포넌트, 데이터 흐름에 대해 설명합니다.

## 1. 핵심 아키텍처 원칙

이 앱은 **관심사 분리(Separation of Concerns)** 원칙을 기반으로 설계되었습니다. 코드베이스는 기능에 따라 다음과 같은 명확한 계층으로 나뉩니다.

- **UI (Presentation Layer):** 사용자에게 보여지는 화면 (`screens`, `widgets`)
- **비즈니스 로직 (Business Logic Layer):** 앱의 핵심 로직 및 상태 관리 (`services`)
- **데이터 (Data Layer):** 데이터 모델 및 외부 서비스와의 통신 (`models`, `services`)

이러한 구조는 코드의 유지보수성, 재사용성, 테스트 용이성을 높여줍니다.

## 2. 디렉토리 구조 (`lib`)

`lib` 디렉토리는 앱의 핵심 소스 코드를 포함하며, 다음과 같이 구성됩니다.

```
lib/
├── models/         # 데이터 모델 (예: Message)
├── screens/        # 개별 화면 UI (예: 로그인, 채팅방 리스트)
├── services/       # 비즈니스 로직 (예: 인증, 위치, 채팅)
├── widgets/        # 여러 화면에서 재사용되는 UI 위젯
├── firebase_options.dart # Firebase 설정
└── main.dart       # 앱의 시작점
```

- **`main.dart`**: 앱의 진입점입니다. Firebase 초기화, 앱 테마 설정, 그리고 사용자의 인증 상태에 따라 `LoginScreen` 또는 `MainNavigationScreen`을 보여주는 `AuthWrapper`를 포함합니다.

- **`screens/`**: 각기 다른 화면을 나타내는 위젯들이 위치합니다. 각 스크린은 주로 UI를 구성하고 `services`를 통해 필요한 데이터를 받거나 액션을 요청하는 역할을 합니다.

- **`services/`**: 앱의 "두뇌"에 해당합니다. Firebase와의 통신, 위치 정보 가져오기, 사용자 인증 처리 등 핵심 비즈니스 로직이 모두 이 디렉토리의 서비스 클래스들에 의해 처리됩니다.

- **`models/`**: 앱에서 사용되는 데이터의 구조를 정의합니다. 예를 들어, `Message` 모델은 채팅 메시지의 구조(작성자, 내용, 시간 등)를 정의합니다.

- **`widgets/`**: 여러 화면에서 공통적으로 사용되는 UI 조각들입니다. 예를 들어, 로딩 중을 나타내는 `LoadingOverlay`나 메시지를 보여주는 `MessageBubble` 등이 있습니다.

## 3. 주요 컴포넌트 및 데이터 흐름

### 인증 흐름

1.  **앱 시작**: `main.dart`의 `AuthWrapper`가 `AuthService.authStateChanges` 스트림을 구독합니다.
2.  **상태 확인**: 스트림이 사용자의 로그인 상태 변경(로그인 또는 로그아웃)을 감지합니다.
3.  **화면 전환**:
    -   로그인 상태이면 `MainNavigationScreen`을 보여줍니다.
    -   로그아웃 상태이면 `LoginScreen`을 보여줍니다.
4.  **로그인/회원가입**: `LoginScreen`에서 사용자가 입력한 정보는 `AuthService`로 전달되어 Firebase Authentication을 통해 처리됩니다.

### 위치 기반 채팅방 로딩 흐름

1.  **위치 요청**: `ChatRoomListScreen`이 활성화되면 `LocationService`를 통해 사용자의 현재 위치를 요청합니다.
2.  **지하철 정보 조회**: `LocationService`에서 얻은 좌표는 `SubwayService`로 전달됩니다. `SubwayService`는 이 좌표를 사용하여 백엔드 API에 근처 지하철역 정보를 요청합니다.
3.  **채팅방 필터링**: `ChatService`는 `SubwayService`가 반환한 지하철 정보를 기반으로 Firestore에 있는 전체 채팅방 리스트에서 사용자 근처(예: 100m 이내)의 채팅방만 필터링합니다.
4.  **UI 업데이트**: `ChatRoomListScreen`은 `ChatService`가 제공하는 실시간 채팅방 리스트 스트림을 `StreamBuilder`로 구독하여 화면에 표시합니다.

## 4. 상태 관리

이 앱은 주로 **`StreamBuilder`** 위젯을 사용하여 상태를 관리합니다. 이는 Firebase의 실시간 데이터 스트림(예: 인증 상태, 채팅 메시지, 채팅방 리스트)을 UI에 직접 연결하는 반응형 프로그래밍 방식입니다.

- **장점**: 코드가 간결해지고, 데이터 소스(Firebase)가 변경될 때마다 별도의 상태 관리 코드 없이 UI가 자동으로 업데이트됩니다.
- **주요 사용처**: `AuthWrapper`, `ChatRoomListScreen`, `ChatRoomScreen` 등 실시간 데이터 표시가 필요한 거의 모든 곳에서 사용됩니다.

## 5. Firebase 통합

Sub Chat은 백엔드 인프라로 Firebase를 적극적으로 활용합니다.

- **Authentication**: 이메일/비밀번호 및 Google 소셜 로그인을 통한 사용자 인증을 처리합니다.
- **Firestore**: 채팅 메시지, 채팅방 정보, 사용자 정보 등 앱의 모든 데이터를 저장하는 NoSQL 데이터베이스입니다.
- **Storage**: (필요시) 사용자가 전송하는 이미지나 파일을 저장하는 데 사용될 수 있습니다.
- **Messaging (FCM)**: (필요시) 새로운 메시지에 대한 푸시 알림을 보내는 데 사용될 수 있습니다.
