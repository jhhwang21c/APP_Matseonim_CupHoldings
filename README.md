<div align="center">

<img src="https://raw.githubusercontent.com/osamhack2021/APP_Matseonim_CupHoldings/main/resources/matseonim.png" alt="osamhack2021/APP_Matseonim_CupHoldings"><br>

![license badge](https://img.shields.io/github/license/osamhack2021/APP_Matseonim_CupHoldings?style=flat-square)
![codefactor badge](https://img.shields.io/codefactor/grade/github/osamhack2021/APP_Matseonim_CupHoldings?style=flat-square)
![code size badge](https://img.shields.io/github/languages/code-size/osamhack2021/APP_Matseonim_CupHoldings?style=flat-square)
  
'맞선임'은 군생활 중 특정 분야에 도움이 필요할 때 맞선임 같은 전문가를 매칭시켜주는 군생활의 동반자 서비스입니다.

[주요 기능](#주요-기능) &mdash;
[필수 조건](#필수-조건) &mdash;
[빌드 방법](#빌드-방법) &mdash;
[기술 스택](#기술-스택) &mdash;
[팀원 정보](#팀원-정보)

</div>

# 주요 기능

(추가 예정)

# 필수 조건

## Flutter 설치하기

'맞선임' 앱을 빌드하기 위해서는 Flutter 2.5.0 이상의 버전이 필요합니다. [여기](https://flutter.dev/docs/get-started/install)를 클릭하여 Flutter를 설치하세요.

## Git 저장소 복제하기

```console
$ git clone https://github.com/osamhack2021/APP_Matseonim_CupHoldings.git
```

## Firebase 설정하기

1. [Firebase 콘솔 페이지](https://console.firebase.google.com/)에서 새로운 Firebase 프로젝트를 생성합니다.
- "이 프로젝트에서 Google 애널리틱스 사용 설정" 버튼은 체크 해제하고 "프로젝트 만들기" 버튼을 클릭합니다.

2. 프로젝트의 "빌드" 탭에서 "Authentication"을 클릭하고, "시작하기" 버튼을 클릭하세요.
- "첫 번째 로그인 방법을 추가하여 Firebase 인증 시작하기"에서 "이메일/비밀번호"를 체크합니다.
- "이메일/비밀번호"의 "사용 설정" 버튼을 클릭합니다.

3. 프로젝트의 "빌드" 탭에서 "Firestore Database"를 클릭하고, "데이터베이스 만들기" 버튼을 클릭합니다.
- "Cloud Firestore의 보안 규칙"은 "테스트 모드에서 시작"에 체크합니다.
- "Cloud Firestore 위치 설정"은 ["asia-northeast3"](https://firebase.google.com/docs/firestore/locations?hl=ko)로 설정합니다.

### 안드로이드 앱에 Firebase 추가하기

(추가 예정)

### 웹 앱에 Firebase 추가하기

1. Firebase 프로젝트 메인 화면에서 "Web"을 클릭하고, 앱 닉네임을 설정합니다.

2. "Firebase SDK 추가"에서 "`<script>` 태그 사용"을 클릭하고, `const firebaseConfig`로 시작하는 코드를 복사하세요.

```javascript
const firebaseConfig = {
    apiKey: /* ... */,
    authDomain: /* ... */,
    projectId: /* ... */,
    storageBucket: /* ... */,
    messagingSenderId: /* ... */,
    appId: /* ... */
};
```

3. 아까 복제했던 Git 저장소의 `matseonim/web` 디렉토리로 이동합니다.

4. `index.html` 파일에서 `<body>`로 시작하는 줄을 찾고, 그 다음 줄에 아래 내용을 그대로 붙여넣습니다.

```html
  <script src="https://www.gstatic.com/firebasejs/8.6.1/firebase-app.js"></script>
  <script src="https://www.gstatic.com/firebasejs/8.6.1/firebase-auth.js"></script>
  <script src="https://www.gstatic.com/firebasejs/8.6.1/firebase-firestore.js"></script>
  <script src="https://www.gstatic.com/firebasejs/8.6.1/firebase-storage.js"></script>

  <script>
    // 2번에서 복사했던 코드를 여기에 붙여넣을 것!
    const firebaseConfig = {
        apiKey: /* ... */,
        authDomain: /* ... */,
        projectId: /* ... */,
        storageBucket: /* ... */,
        messagingSenderId: /* ... */,
        appId: /* ... */
    };

    // Initialize Firebase
    firebase.initializeApp(firebaseConfig);
  </script>
```

## Flutter 패키지 업데이트하기 

```console
$ flutter pub get
```

# 빌드 방법

## GNU/Linux (Ubuntu 18.04.1 LTS)

### 안드로이드 앱으로 빌드하기

(추가 예정)

### 웹 앱으로 빌드하기

```console
$ git clone https://github.com/osamhack2021/APP_Matseonim_CupHoldings.git
$ cd APP_Matseonim_CupHoldings/matseonim
$ flutter run -d web-server --web-hostname=0.0.0.0
```

# 기술 스택

## 프론트엔드

- [Dart 2.14.0 (stable)](https://github.com/dart-lang/sdk/commit/4c8a4f0d7ad055fa7dea5e80862cd2074f4454d3)
- [Flutter 2.5.0 (stable)](https://github.com/flutter/flutter/commit/4cc385b4b84ac2f816d939a49ea1f328c4e0b48e)

### [플러그인](https://github.com/osamhack2021/APP_Matseonim_CupHoldings/blob/main/matseonim/pubspec.yaml)

- [`cached_network_image: ^3.1.0`](https://pub.dev/packages/cached_network_image)
- [`carousel_slider: ^4.0.0`](https://pub.dev/packages/carousel_slider)
- [`cloud_firestore: ^2.5.3`](https://pub.dev/packages/cloud_firestore)
- [`cupertino_icons: ^1.0.2`](https://pub.dev/packages/cupertino_icons)
- [`get: ^4.3.8`](https://pub.dev/packages/get)
- [`image_picker: ^0.8.4+2`](https://pub.dev/packages/image_picker)
- [`firebase_auth: ^3.1.1`](https://pub.dev/packages/firebase_auth)
- [`firebase_core: ^1.6.0`](https://pub.dev/packages/firebase_core)
- [`firebase_storage: ^10.0.4`](https://pub.dev/packages/firebase_storage)
- [`flutter_chat_ui: ^1.4.4`](https://pub.dev/packages/flutter_chat_ui)
- [`flutter_rating_bar: ^4.0.0`](https://pub.dev/packages/flutter_rating_bar)
- [`flutter_typeahead: ^3.2.1`](https://pub.dev/packages/flutter_typeahead)
- [`validators: ^3.0.0`](https://pub.dev/packages/validators)

## 백엔드

- [Firebase](https://firebase.google.com/?hl=en)

# 팀원 정보

- [John Hwang (h.jungho21c@gmail.com)](https://github.com/jhhwang21c)
- [Jaedeok Kim (jdeokkim@protonmail.com)](https://github.com/jdeokkim)

# 라이선스

[MIT License](https://github.com/osamhack2021/APP_Matseonim_CupHoldings/blob/main/LICENSE)
