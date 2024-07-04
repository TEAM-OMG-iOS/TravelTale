# 📖 Travel Tale

![readme-mockup](https://github.com/TEAM-OMG-iOS/TravelTale/assets/157277372/8e6b5b40-75b7-413e-b6fb-b2ae1a784300)


- 배포 URL : 
- API : Encoding 키를 config 파일에 입력해수제요.

<br>

## 1. 프로젝트 소개

- 국내 여행을 계획하고 기록하는 것을 도와주는 앱입니다.

<br>


## 2. 개발 환경
- OS : macOS Sonoma 14.5
- IDE : Xcode 15.4

|       |          |
| ----- | -------- |
| Design | <img src="https://img.shields.io/badge/figma-%23F24E1E.svg?style=flat-square&logo=figma&logoColor=white"> |
| Develop | <img src="https://img.shields.io/badge/Swift-F05138?style=flat-square&logo=Swift&logoColor=white"> <img src="https://img.shields.io/badge/uikit-2396F3?style=flat-square&logo=Swift&logoColor=white"> |
| Communication | <img src="https://img.shields.io/badge/Github-181717?style=flat-square&logo=Github&logoColor=white"> <img src="https://img.shields.io/badge/Git-F05032?style=flat-square&logo=git&logoColor=white"> <img src="https://img.shields.io/badge/Slack-4A154B?style=flat-square&logo=slack&logoColor=white"> |
| API | [<img src="https://github.com/TEAM-OMG-iOS/TravelTale/assets/157277372/5f5c41a9-f435-4ae0-bc78-c8a271ba2d5c" height="25">](https://api.visitkorea.or.kr/#/) |

<br>

## 3. 채택한 개발 기술과 브랜치 전략

### 3-1. Third Party Libraries
    
- **Alamofire :** 네트워크 요청과 서버 응답 처리를 쉽고 효율적으로 하기 위해 사용했습니다.
- **Kingfisher :** 이미지를 다운로드하고 캐시하여 빠르고 부드러운 이미지 로딩을 보장하기 위해 사용했습니다.
- **Snapkit :** 코드로 Auto Layout 제약 조건을 간단하게 생성하고 관리하기 위해 사용했습니다.
- **Then :** 객체 초기화를 더 깔끔하고 읽기 쉽게 하기 위해 사용되었습니다.
- **Realm :** 로컬 데이터 저장소에 빠르고 쉽게 접근하기 위해 사용했습니다.
- **기타 :** FloatingPanel, XLPagerStrip,HorizonCalendar, IQKeyboardManager


### 3-2. 브랜치 전략
- Github-flow 전략을 기반으로 main, develop 브랜치와 feature 보조 브랜치를 운용했습니다.
- main, develop, Feat 브랜치로 나누어 개발했습니다.
    - **main** 브랜치는 배포 단계에서만 사용하는 브랜치입니다.
    - **develop** 브랜치는 개발 단계에서 git-flow의 master 역할을 하는 브랜치입니다.
    - **Feat** 브랜치는 기능 단위로 독립적인 개발 환경을 위하여 사용했습니다.

<br>

## 4. 프로젝트 구조

<details>
<summary>토글 접기/펼치기</summary>
<div markdown="1">

```
📁TravelTale
├── Application
│   ├── AppDelegate.swift
│   ├── Config.xcconfig
│   └── SceneDelegate.swift
├── Config.xcconfig
├── Data
│   ├── Network
│   │   ├── DataMapping
│   │   │   ├── PlaceDetailResponseDTO+Mapping.swift
│   │   │   ├── PlaceResponseDTO+Mapping.swift
│   │   │   ├── PlaceSearchResponseDTO+Mapping.swift
│   │   │   ├── SidoResponseDTO+Mapping.swift
│   │   │   └── SigunguResponseDTO+Mapping.swift
│   │   └── NetworkManager.swift
│   └── PersistentStorages
│       ├── RealmStorage
│       │   └── RealmManager.swift
│       └── UserDefaultsStorage
│           └── UserDefaultsManager.swift
├── Entities
│   ├── Bookmark.swift
│   ├── Place.swift
│   ├── PlaceDetail.swift
│   ├── PlaceSearch.swift
│   ├── Region.swift
│   ├── Schedule.swift
│   ├── Sido.swift
│   ├── Sigungu.swift
│   └── Travel.swift
├── Presentation
│   ├── Common
│   │   ├── CategoryTab
│   │   │   └── View
│   │   │       ├── CategoryTabTableViewCell.swift
│   │   │       └── CategoryTabView.swift
│   │   ├── DetailSchedule
│   │   │   ├── DetailScheduleAdd
│   │   │   │   └── View
│   │   │   │       ├── DetailScheduleAddView.swift
│   │   │   │       └── DetailScheduleAddViewController.swift
│   │   │   └── DetailScheduleSelect
│   │   │       └── View
│   │   │           ├── DetailScheduleSelectView.swift
│   │   │           └── DetailScheduleSelectViewController.swift
│   │   ├── PlaceDetails
│   │   │   ├── PlaceDetail
│   │   │   │   └── View
│   │   │   │       ├── PlaceDetailDiscoveryViewController.swift
│   │   │   │       ├── PlaceDetailTravelViewController.swift
│   │   │   │       └── PlaceDetailView.swift
│   │   │   ├── PlaceDetailAlert
│   │   │   │   └── View
│   │   │   │       ├── PlaceDetailAlertView.swift
│   │   │   │       └── PlaceDetailAlertViewController.swift
│   │   │   └── PlaceDetailToast
│   │   │       └── View
│   │   │           └── PlaceDetailToastView.swift
│   │   ├── Popover
│   │   │   ├── PopoverDay
│   │   │   │   └── View
│   │   │   │       ├── PopoverDayView.swift
│   │   │   │       └── PopoverDayViewController.swift
│   │   │   └── PopoverTime
│   │   │       └── View
│   │   │           ├── PopoverTimeView.swift
│   │   │           └── PopoverTimeViewController.swift
│   │   ├── Region
│   │   │   └── View
│   │   │       ├── RegionTableViewCell.swift
│   │   │       └── RegionView.swift
│   │   └── Searchs
│   │       ├── Search
│   │       │   └── View
│   │       │       ├── SearchTableViewCell.swift
│   │       │       ├── SearchView.swift
│   │       │       └── SearchViewController.swift
│   │       └── SearchResults
│   │           ├── SearchResult
│   │           │   └── View
│   │           │       └── SearchResultViewController.swift
│   │           └── SearchResultTab
│   │               └── View
│   │                   ├── SearchResultTabAccommodationViewController.swift
│   │                   ├── SearchResultTabEntertainmentViewController.swift
│   │                   ├── SearchResultTabRestaurantViewController.swift
│   │                   ├── SearchResultTabTableViewCell.swift
│   │                   ├── SearchResultTabTotalViewController.swift
│   │                   ├── SearchResultTabTouristViewController.swift
│   │                   └── SearchResultTabView.swift
│   ├── Discoveries
│   │   ├── Discovery
│   │   │   └── View
│   │   │       ├── DiscoveryCollectionViewCell.swift
│   │   │       ├── DiscoveryView.swift
│   │   │       └── DiscoveryViewController.swift
│   │   ├── DiscoveryCategories
│   │   │   ├── DiscoveryCategory
│   │   │   │   └── View
│   │   │   │       └── DiscoveryCategoryViewController.swift
│   │   │   └── DiscoveryCategoryTab
│   │   │       └── View
│   │   │           ├── DiscoveryCategoryTabAccommodationViewController.swift
│   │   │           ├── DiscoveryCategoryTabEntertainmentViewController.swift
│   │   │           ├── DiscoveryCategoryTabRestaurantViewController.swift
│   │   │           └── DiscoveryCategoryTabTouristSpotViewController.swift
│   │   ├── DiscoveryRegion
│   │   │   └── View
│   │   │       ├── DiscoveryRegionView.swift
│   │   │       └── DiscoveryRegionViewController.swift
│   │   └── DiscoveryRegionModal
│   │       └── View
│   │           ├── DiscoveryRegionModalSidoViewController.swift
│   │           └── DiscoveryRegionModalSigunguViewController.swift
│   ├── MyPages
│   │   ├── MyPage
│   │   │   └── View
│   │   │       ├── Component
│   │   │       │   └── MyPageBookMarkButton.swift
│   │   │       ├── MyPageTableViewCell.swift
│   │   │       ├── MyPageView.swift
│   │   │       └── MyPageViewController.swift
│   │   ├── MyPageCategories
│   │   │   ├── MyPageCategory
│   │   │   │   └── View
│   │   │   │       └── MyPageCategoryViewController.swift
│   │   │   └── MyPageCategoryTab
│   │   │       └── View
│   │   │           ├── MyPageCategoryTabAccommodationViewController.swift
│   │   │           ├── MyPageCategoryTabEntertainmentViewController.swift
│   │   │           ├── MyPageCategoryTabRestaurantViewController.swift
│   │   │           ├── MyPageCategoryTabTotalViewController.swift
│   │   │           └── MyPageCategoryTabTouristSpotViewController.swift
│   │   └── MyPageTerm
│   │       └── View
│   │           ├── MyPageTermOpenSourceViewController.swift
│   │           ├── MyPageTermPrivacyPolicyViewController.swift
│   │           └── MyPageTermView.swift
│   ├── TabBar
│   │   └── View
│   │       └── TabBarViewController.swift
│   ├── Travels
│   │   ├── MemoryAddEditPhotoCollectionViewCell.swift
│   │   ├── MemoryAddEditView.swift
│   │   ├── MemoryAddEditViewController.swift
│   │   ├── MemoryDetailTableHeaderView.swift
│   │   ├── MemoryDetailTableViewCell.swift
│   │   ├── MemoryDetailView.swift
│   │   ├── MemoryDetailViewController.swift
│   │   ├── MemorySelectView.swift
│   │   ├── MemorySelectViewController.swift
│   │   ├── MemoryView.swift
│   │   ├── MemoryViewController.swift
│   │   ├── Plans
│   │   │   ├── Plan
│   │   │   │   └── View
│   │   │   │       ├── PlanTableFooterView.swift
│   │   │   │       ├── PlanTableHeaderView.swift
│   │   │   │       ├── PlanView.swift
│   │   │   │       └── PlanViewController.swift
│   │   │   ├── PlanAdds
│   │   │   │   ├── PlanAddDates
│   │   │   │   │   ├── PlanAddDate
│   │   │   │   │   │   └── View
│   │   │   │   │   │       ├── PlanAddDateView.swift
│   │   │   │   │   │       └── PlanAddDateViewController.swift
│   │   │   │   │   └── PlanAddDateCalendar
│   │   │   │   │       └── View
│   │   │   │   │           ├── PlanAddDateCalendarBaseView.swift
│   │   │   │   │           ├── PlanAddDateCalendarDayRangeIndicatorView.swift
│   │   │   │   │           ├── PlanAddDateCalendarDayView.swift
│   │   │   │   │           ├── PlanAddDateCalendarMonthDayView.swift
│   │   │   │   │           └── PlanAddDateCalendarMonthView.swift
│   │   │   │   ├── PlanAddSidos
│   │   │   │   │   ├── PlanAddSido
│   │   │   │   │   │   └── View
│   │   │   │   │   │       ├── PlanAddSidoView.swift
│   │   │   │   │   │       └── PlanAddSidoViewController.swift
│   │   │   │   │   └── PlanAddSidoModal
│   │   │   │   │       └── View
│   │   │   │   │           └── PlanAddSidoModalViewController.swift
│   │   │   │   └── PlanAddTitle
│   │   │   │       └── View
│   │   │   │           ├── PlanAddTitleView.swift
│   │   │   │           └── PlanAddTitleViewController.swift
│   │   │   ├── PlanDetail
│   │   │   │   └── View
│   │   │   │       ├── TravelDetailView.swift
│   │   │   │       └── TravelDetailViewController.swift
│   │   │   ├── PlanEdits
│   │   │   │   ├── PlanEdit
│   │   │   │   │   └── View
│   │   │   │   │       ├── PlanEditView.swift
│   │   │   │   │       └── PlanEditViewController.swift
│   │   │   │   └── PlanEditDate
│   │   │   │       └── View
│   │   │   │           ├── PlanEditDateView.swift
│   │   │   │           └── PlanEditDateViewController.swift
│   │   │   └── PlanSchedules
│   │   │       ├── PlanSchedule
│   │   │       │   └── View
│   │   │       │       ├── TravelDetailPlanContentCell.swift
│   │   │       │       ├── TravelDetailPlanFooterCell.swift
│   │   │       │       ├── TravelDetailPlanHeaderCell.swift
│   │   │       │       ├── TravelDetailPlanHeaderContentCell.swift
│   │   │       │       ├── TravelDetailPlanView.swift
│   │   │       │       └── TravelDetailPlanViewController.swift
│   │   │       ├── PlanScheduleAddEditMemo
│   │   │       │   └── View
│   │   │       │       ├── PlanScheduleAddEditMemoView.swift
│   │   │       │       ├── PlanScheduleAddMemoViewController.swift
│   │   │       │       └── PlanScheduleEditMemoViewController.swift
│   │   │       └── PlanScheduleAddEditPlace
│   │   │           └── View
│   │   │               ├── PlanScheduleAddEditPlaceView.swift
│   │   │               ├── PlanScheduleAddPlaceViewController.swift
│   │   │               └── PlanScheduleEditPlaceViewController.swift
│   │   └── Travel
│   │       └── View
│   │           ├── TravelView.swift
│   │           └── TravelViewController.swift
│   └── Utils
│       ├── Extensions
│       │   ├── String+Extension.swift
│       │   ├── UIButton+Extension.swift
│       │   ├── UIColor+Extension.swift
│       │   ├── UIFont+Extension.swift
│       │   ├── UIImage+Extension.swift
│       │   ├── UILabel+Extension.swift
│       │   └── UIView+Extension.swift
│       ├── Fonts
│       │   ├── OAGothic
│       │   │   ├── OAGothic-ExtraBold.otf
│       │   │   └── OAGothic-Medium.otf
│       │   └── Pretendard
│       │       ├── Pretendard-Black.otf
│       │       ├── Pretendard-Bold.otf
│       │       ├── Pretendard-ExtraBold.otf
│       │       ├── Pretendard-ExtraLight.otf
│       │       ├── Pretendard-Light.otf
│       │       ├── Pretendard-Medium.otf
│       │       ├── Pretendard-Regular.otf
│       │       ├── Pretendard-SemiBold.otf
│       │       └── Pretendard-Thin.otf
│       └── Views
│           ├── Bases
│           │   ├── BaseCollectionViewCell.swift
│           │   ├── BaseTableViewCell.swift
│           │   ├── BaseView.swift
│           │   └── BaseViewController.swift
│           └── Reusables
│               ├── Button
│               │   ├── GrayButton.swift
│               │   ├── GreenButton.swift
│               │   └── LightGreenButton.swift
│               ├── Cell
│               │   └── TravelTableViewCell.swift
│               └── View
│                   ├── GrayBackgroundView.swift
│                   └── NotFoundView.swift
└── Resources
    ├── Assets.xcassets
    │   ├── AccentColor.colorset
    │   │   └── Contents.json
    │   ├── AppIcon.appiconset
    │   │   ├── 1024.png
    │   │   ├── 114.png
    │   │   ├── 120.png
    │   │   ├── 180.png
    │   │   ├── 29.png
    │   │   ├── 40.png
    │   │   ├── 57.png
    │   │   ├── 58.png
    │   │   ├── 60.png
    │   │   ├── 80.png
    │   │   ├── 87.png
    │   │   └── Contents.json
    │   ├── Contents.json
    │   ├── category
    │   │   ├── Contents.json
    │   │   └── category_place_thumnail.imageset
    │   │       ├── Contents.json
    │   │       └── category_place_thumnail.svg
    │   ├── data
    │   │   ├── Contents.json
    │   │   └── place_profile.imageset
    │   │       ├── Contents.json
    │   │       └── place_profile.svg
    │   ├── detail
    │   │   ├── Contents.json
    │   │   ├── annotation.imageset
    │   │   │   ├── Contents.json
    │   │   │   └── notification.svg
    │   │   └── detail_place_thumnail.imageset
    │   │       ├── Contents.json
    │   │       └── detail_place_thumnail.svg
    │   ├── discovery
    │   │   ├── Contents.json
    │   │   ├── accommodation.imageset
    │   │   │   ├── Contents.json
    │   │   │   └── accommodation.svg
    │   │   ├── discovery_place_thumnail.imageset
    │   │   │   ├── Contents.json
    │   │   │   └── discovery_place_thumnail.svg
    │   │   ├── entertainment.imageset
    │   │   │   ├── Contents.json
    │   │   │   └── entertainment.svg
    │   │   ├── line.imageset
    │   │   │   ├── Contents.json
    │   │   │   └── line.svg
    │   │   ├── restaurant.imageset
    │   │   │   ├── Contents.json
    │   │   │   └── restaurant.svg
    │   │   └── tourist_spot.imageset
    │   │       ├── Contents.json
    │   │       └── tourist_spot.svg
    │   ├── mypage
    │   │   ├── Contents.json
    │   │   ├── accommodation_circle.imageset
    │   │   │   ├── Contents.json
    │   │   │   └── accommodation_circle.svg
    │   │   ├── entertainment_circle.imageset
    │   │   │   ├── Contents.json
    │   │   │   └── entertainment_circle.svg
    │   │   ├── restaurant_circle.imageset
    │   │   │   ├── Contents.json
    │   │   │   └── restaurant_circle.svg
    │   │   └── tourist_spot_circle.imageset
    │   │       ├── Contents.json
    │   │       └── tourist_spot_circle.svg
    │   ├── search
    │   │   ├── Contents.json
    │   │   ├── search.imageset
    │   │   │   ├── Contents.json
    │   │   │   └── search.svg
    │   │   └── search_clock.imageset
    │   │       ├── Contents.json
    │   │       └── search_clock.svg
    │   ├── splash
    │   │   ├── Contents.json
    │   │   └── splash_scale.imageset
    │   │       ├── Contents.json
    │   │       ├── splash-1.png
    │   │       ├── splash-2.png
    │   │       └── splash-3.png
    │   ├── tabbar
    │   │   ├── Contents.json
    │   │   ├── discovery.imageset
    │   │   │   ├── Contents.json
    │   │   │   └── discovery.svg
    │   │   └── my_travel.imageset
    │   │       ├── Contents.json
    │   │       └── tabbar_mytravel_unselected.svg
    │   └── travel
    │       ├── Contents.json
    │       ├── not_found_train.imageset
    │       │   ├── Contents.json
    │       │   └── not_found_train.svg
    │       ├── plan_details_cell_ellipsis.imageset
    │       │   ├── Contents.json
    │       │   └── plan_details_cell_ellipsis.svg
    │       ├── plan_details_left_arrow.imageset
    │       │   ├── Contents.json
    │       │   └── plan_details_left_arrow.svg
    │       ├── plan_details_location.imageset
    │       │   ├── Contents.json
    │       │   └── plan_details_location.svg
    │       ├── plan_details_plus.imageset
    │       │   ├── Contents.json
    │       │   └── plan_details_plus.svg
    │       └── plan_details_setting.imageset
    │           ├── Contents.json
    │           └── plan_details_setting.svg
    ├── Base.lproj
    │   └── LaunchScreen.storyboard
    ├── Info.plist
    ├── OpenSourceLicense.rtf
    └── TermPrivacyPolicy.rtf
```


</div>
</details>


<br>



## 5. 개발 기간 및 작업 관리

### 5-1. 개발 기간

- 전체 개발 기간 : 2024-05-27 ~ 2024-07-05
- UI 구현 : 2024-05-27 ~ 2024-06-03
- 기능 구현 : 2024-06-03 ~ 2024-07-05

<br>

### 5-2. 작업 관리

- GitHub Projects와 Issues를 사용하여 진행 상황을 공유했습니다.
- 1일 1회의로 작업 현황을 공유하며 방향성에 대한 고민을 나누었고, 노션(링크 추가)에 기록했습니다.

<br>



## 6. 트러블 슈팅

### Data
<details>
<summary>Model</summary>
<div markdown="1">
    
**② 발생한 이슈**

- API를 사용할 때 필요한 데이터 모델을 Data 계층에서 구현 하였는데 불편함이 있었음
    - Data Layer와 UI Layer에서 각각 활용 되는 모델 사이에 차이가 있음
    - 여러 Layer가 동시에 얽혀있다 보니, 개발 및 유지 & 보수할 때 불편함이 있음

**④ 해결 방법**

1. DTO와 Entity로 나누었음 <br>
&ensp; a. Data Layer - DTO<br>
&ensp; b. UI Layer - Entity<br>
2. DTO를 Entity로 맵핑해서 사용<br>
    
</div>
</details>

### UI

<details>
<summary>TabBar</summary>
<div markdown="1">
    
**1. 구현하고자 했던 부분**<br>
&ensp; 흰색 배경의 탭바<br>
<br>
**2. 발생한 이슈** <br>
&ensp; 세 번째 탭이 스크롤뷰이기 때문에 탭바의 색이 회색으로 변함<br>

**3. 시도한 방법** <br>
아래 두 가지 방법 모두 성공적이나, 각각 장단점이 있음 <br>
- `tabBar.backgroundImage = UIImage()` <br>
    → 단점: 간단하지만 UITabBarAppearance API에 비해 미래지향적이지 않음 <br>

- `tabBar.isTranslucent = false` <br>
    → 단점 1. 다음 뷰에서 tabBar.isHidden = true를 했을 때 탭바 영역이 사라지지 않고 까맣게 보임.<br>
    → 단점 2. 탭바 전체의 투명도에 영향을 미치기 때문에 바람직하지 않음<br>

**4. 해결 방법 : `UITabBarAppearance` 설정** <br>
- `configureWithOpaqueBackground()` 메소드 사용 <br>
    → 탭바를 불투명하게 함<br>

- `scrollEdgeAppearance` 를 `standardAppearance`로 설정 <br>
    → 탭바 뒤에서 컨텐츠가 스크롤될 때도 탭바의 외양이 유지되도록 함.
    
</div>
</details>


<details>
<summary>Animation</summary>
<div markdown="1">
    
**1. 구현하고자 했던 부분**<br>
&ensp;progressbar의 animation 추가<br>

**2-1 발생한 이슈** <br>
&ensp;기준으로 둔 UI객체의 생성시점이 animate가 실행되는 시점과 동일하여 의도하던대로 애니메이션이 적용되지 않는 이슈<br>

**3-1 해결 방법**<br>
&ensp;기준점이 되는 UI Component 가 생성된 이후인 ViewDidAppear에서 animation이 실행될 수 있도록 설정<br>


**2-2 발생한 이슈**<br>
&ensp;이전 뷰로부터 화면을 전환하는 navigation 동작을 false로 변경한 뒤, loadingBar로 진행도를 나타내는 애니메이션이 제대로 작동하지 않고 화면 전체가 움직임 <br>

**3-2 해결 방법**<br>
&ensp;.layoutIfNeeded()메서드 삭제 및 CGAffineTransform을 사용하여 loadingBar의 scale값을 조정<br>
    
</div>
</details>


<details>
<summary>Placeholder</summary>
<div markdown="1">

**1. 구현하고자 했던 부분**<br>
&ensp; TextView Placeholder

**2. 발생한 이슈**<br>
&ensp; TextView에는 애초에 placeholder를 넣는 속성이 없음

**3. 해결 방법**<br>
&ensp; Delegate패턴으로 텍스트뷰의 에디팅이 시작할때, 끝날때의 행동을 구현하여 placeholder를 대신하게 하여 해결

</div>
</details>

<details>
<summary>탭바 VC 이동</summary>
<div markdown="1">

**1. 구현하고자 했던 부분**<br>
&ensp; 탭바를 통해 여러 VC으로 이동하는 부분 구현

**2. 발생한 이슈**<br>
&ensp; XLPagerTabStrip 라이브러리를 통해 VC 이동하는 과정에서 첫 번째 탭의 VC 위치만 다른 이슈 발생

**3. 해결 방법**<br>
&ensp; 방법 1. 각각의 VC에서 View 위에 있는 오토레이아웃을 변경을 시도
  - 중복되는 코드가 많이 발생하여 좋은 해결책이 아니라고 생각
  - 각각의 탭마다 다른 오토레이아웃을 잡아주어야 함
  - SE와 15 기종에서 오토레이아웃 조절이 불가능함.

&ensp; 방법 2. XLPagerTabStrip 라이브러리 코드를 분석하여 self.reloadPagerTabStripView() 함수를 호출
  - 해결!

**4. 해결 방법**<br>
Tab 바를 가지고 있는 ViewController에서 접근하는 버튼에 따른 탭의 ViewController를 리로드하는 함수를 비동기적으로 실행하여 해결

</div>
</details>

<details>
<summary>Calendar 커스텀</summary>
<div markdown="1">

**1. 구현하고자 했던 부분**<br>
&ensp; 캘린더 커스텀(날짜 선택하는 기능)

**2. 발생한 이슈**<br>
&ensp; 사용한 라이브러리인 Horizontal Calendar에서 선택한 날짜를 표시하는 .dayRangeItemProvider()메서드를 사용해도 날짜 선택 표시가 안 나타남

**3. 해결 방법**<br>
&ensp; Horizontal Calendar 라이브러리에서 제공하는 예시 코드를 참고하여 protocol 및  BaseView 코드 생성 및 적용

</div>
</details>


<br>



## 7. 개선 목표
- MVVM 아키텍처 & RxSwift 도입

- 추억 페이지
    - 사진선택 기능 보완
        - 사진 선택 삭제 기능
        - 사진 선택 시 넘버링 기능
    - 그 밖의 UI 디테일 보완

- 둘러보기 페이지
    - 지역 선택 수정
        - 기존에 설정한 시가 디폴트로 보이도록 설정
        - 전체 지역을 선택할 수 있도록 설정
    - 필터링 기능 - 최신순, 제목순 등

- 상세 페이지
    - 제공되는 정보 보완 - 행사기간, 영업시간 등

- 계획 페이지
    - 앱 실행시 가이드 페이지 구현
    - 캘린더 기능 보완
    - 시간선택 - 수정 전 시간 표기
    - 지도 페이지 메모추가 시 메모 위치 개선

- 탭바
    - 둘러보기 탭 버튼 영역 확실히 하기 (뒷 뷰가 눌리지 않도록)
 
- 여행 지도
    - 내가 갔던 모든 여행지를 지도에서 모아 볼 수 있는 기능
    
    
<br>

## 8. 팀원 소개

<div align="center">

| **김정호** | **배지해** | **김유림** | **박윤희** | **방기남** |
| :------: |  :------: | :------: | :------: | :------: |
| [<img src="https://github.com/TEAM-OMG-iOS/TravelTale/assets/157277372/1a94246c-426b-44a7-bf9d-d763563f23df" height=150 width=150> <br/> @ohhoooo](https://github.com/ohhoooo) | [<img src="https://github.com/TEAM-OMG-iOS/TravelTale/assets/157277372/5e36e982-472b-45b3-a228-6da7ead20a4a" height=150 width=150> <br/> @BaeJihae](https://github.com/BaeJihae) | [<img src="https://github.com/TEAM-OMG-iOS/TravelTale/assets/157277372/f47cc3ad-0bd3-4805-bd44-16e3df0af7c7" height=150 width=150> <br/> @yurim830](https://github.com/yurim830) | [<img src="https://github.com/TEAM-OMG-iOS/TravelTale/assets/157277372/42f22024-e637-41a9-974e-993db08e4f5b" height=150 width=150> <br/> @yoon3208](https://github.com/yoon3208) | [<img src="https://github.com/TEAM-OMG-iOS/TravelTale/assets/157277372/821c54a1-49a6-4fda-a16c-06ee42755185" height=150 width=150> <br/> @Bread-kn72](https://github.com/Bread-kn72) |

</div>

### 맡은 역할

<div>
    
| **팀원** | **맡은 역할** |
| :----:| ------------------------------ |
| 김정호 | 데이터, 여행 스케쥴 페이지, 검색 페이지 |
| 배지해 | 디자인, 둘러보기 페이지, 마이페이지, 북마크 페이지 |
| 김유림 | 디자인, 탭바, 여행 메인페이지, 여행 추억 페이지 |
| 박윤희 | 여행 생성 페이지 |
| 방기남 | 일정 추가 페이지, 메모 추가 페이지 |
    
</div>
