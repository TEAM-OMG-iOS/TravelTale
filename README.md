# 🛺 TravelTale

<p align='center'><bold>대한민국 여행의 시작과 끝을 함께하는 ✈️TravelTale✈️</bold></p>
<p align='center'><bold>당신의 여행이야기를 들려주세요</bold></p>

![thumbnail](https://github.com/user-attachments/assets/533dfdc8-48fc-428f-90f7-209d6ebd5b99)

<div align="center">

[<img width="220" alt="link" src="https://github.com/user-attachments/assets/344cea29-042f-45ad-b227-16da622abdda">](https://apps.apple.com/kr/app/travel-tale-%ED%8A%B8%EB%9E%98%EB%B8%94-%ED%85%8C%EC%9D%BC/id6505096183)

</div>

1. 여행 등록 기능
   > 다가오는 여행과 다녀온 여행을 손쉽게 등록할 수 있습니다.
   
   > 각 여행에 대해 장소와 메모를 추가하여 기억을 기록해보세요.

   > 언제든지 원하는 대로 수정이 가능합니다.


2. 추억 남기기 기능
   > 다녀온 여행을 소중한 추억으로 남길 수 있습니다.

   > 사진과 함께 남기고 싶은 글귀를 작성하여 아름다운 기억을 보존해보세요.


3. 둘러보기 기능
   > 대한민국의 다양한 장소들을 한눈에 둘러볼 수 있습니다.

   > 관광지, 음식점, 숙박시설, 놀이시설 등 원하는 장소를 찾아보세요.

<br>

## 📗 라이브러리
| 라이브러리명 | 용도 | 깃허브 |
| --- | --- | --- |
| UIKit | UI | - |
| MapKit | 지도 | - |
| UserDefaults | 영구 저장소 | - |
| SnapKit | UI | https://github.com/SnapKit/SnapKit |
| Then | UI | https://github.com/devxoul/Then |
| FloatingPanel | UI | https://github.com/scenee/FloatingPanel |
| IQKeyboardManager | UX | https://github.com/hackiftekhar/IQKeyboardManager |
| HorizonCalendar | 달력 | https://github.com/airbnb/HorizonCalendar |
| XLPagerTabStrip | 탭 | https://github.com/xmartlabs/XLPagerTabStrip |
| Alamofire | 네트워킹 | https://github.com/Alamofire/Alamofire |
| Kingfisher | 이미지 | https://github.com/onevcat/Kingfisher |
| Realm | 영구 저장소 | https://github.com/realm/realm-swift |

<br>

## 🧩 아키텍처

<img width="600" alt="architecture" src="https://github.com/user-attachments/assets/abc24257-5186-4cf7-b33d-1d91187d838d">

<br>

## 🗂️ 폴더 구조

```
📁 TravelTale
├── Application
│   ├── AppDelegate.swift
│   ├── SceneDelegate.swift
│   └── Config.xcconfig
├── Presentation
│   ├── Feature..
│       ├── View
│       └── Controller
│   └── Utils
│       ├── Extensions
│       ├── Views
│           ├── Bases
│           └── Reusables
│       └── Fonts
├── Entities
├── Data
│   ├── Network
│   │   ├── NetworkManager.swift
│   │   └── DataMapping
│   └── PersistentStorages
│       ├── RealmStorage
│       └── UserDefaultsStorage
└── Resources
```
- `Presentation`: 기능별로 View와 Controller를 포함합니다.
  - `Util`: 앱 전역적으로 사용되는 클래스, Extension, 폰트 등을 포함합니다.
- `Resource`: LaunchScreen, .xcassets 파일, .plist 파일, .rtf 파일을 포함합니다.

<br>

## 🧑‍🤝‍🧑 팀
<div align="center">

| **김정호** | **배지해** | **김유림** | **박윤희** | **방기남** |
:---:|:---:|:---:|:---:|:---:|
| [<img src="https://github.com/TEAM-OMG-iOS/TravelTale/assets/157277372/1a94246c-426b-44a7-bf9d-d763563f23df" height=150 width=150> <br/> @ohhoooo](https://github.com/ohhoooo) | [<img src="https://github.com/TEAM-OMG-iOS/TravelTale/assets/157277372/5e36e982-472b-45b3-a228-6da7ead20a4a" height=150 width=150> <br/> @BaeJihae](https://github.com/BaeJihae) | [<img src="https://github.com/TEAM-OMG-iOS/TravelTale/assets/157277372/f47cc3ad-0bd3-4805-bd44-16e3df0af7c7" height=150 width=150> <br/> @yurim830](https://github.com/yurim830) | [<img src="https://github.com/TEAM-OMG-iOS/TravelTale/assets/157277372/42f22024-e637-41a9-974e-993db08e4f5b" height=150 width=150> <br/> @yoon3208](https://github.com/yoon3208) | [<img src="https://github.com/TEAM-OMG-iOS/TravelTale/assets/157277372/821c54a1-49a6-4fda-a16c-06ee42755185" height=150 width=150> <br/> @Bread-kn72](https://github.com/Bread-kn72) |

</div>
