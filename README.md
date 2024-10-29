![image](https://github.com/user-attachments/assets/6ea94f6e-4b24-4ada-a3fb-d60e694f9598)

# 👋 HiBike 🚲
**너와 내가 만난 순간 새로운 출발이 시작**

## ⭐️ App Statement 
**사용자가 스테이션에 직접 돌아가지 않고도 원하는 위치에 자전거를 반납할 수 있도록 도와주자!**

### 💡 Solution 설명 
자전거를 대여한 후, 다른 장소에서 일시 잠금을 진행할 때 사용자는 자전거 소유권을 다른 사람에게 넘길 수 있는 옵션을 선택할 수 있습니다. 이 옵션을 선택하면, 자전거를 대신 사용할 지원자를 모집하게 됩니다.만약 지원자가 나타나면, 처음 대여한 사용자는 자전거의 소유권을 새로운 사용자에게 양도하며, 이후 자전거를 반납할 필요가 없습니다. 대신, 자전거를 넘겨받은 사용자가 자전거를 자유롭게 사용한 후, 기존 사용자가 대여한 충전 스테이션에 반납해야 합니다. 만약 지원자가 나타나지 않는다면, 기존 사용자가 자전거를 직접 반납해야 하는 구조입니다.

## 🧩 Team 
<table style="width: 100%; table-layout: fixed;">
  <tr>
    <td style="text-align: center; padding: 10px;">
      <h3>김리</h3>
    </td>
    <td style="text-align: center; padding: 10px;">
      <h3>마리</h3>
    </td>
    <td style="text-align: center; padding: 10px;">
      <h3>제이비</h3>
    </td>
    <td style="text-align: center; padding: 10px;">
      <h3>파인</h3>
    </td>
  </tr>
  <tr>
    <td style="text-align: center; padding: 10px;">
      <img src="https://github.com/user-attachments/assets/f81df4d7-530c-4887-acd5-1c8cb1ab2f86" width="100" alt="Image 1">
    </td>
    <td style="text-align: center; padding: 10px;">
      <img src="https://github.com/user-attachments/assets/155562e5-a3ac-4aea-9418-c60242e5803d" width="100" alt="Image 2">
    </td>
    <td style="text-align: center; padding: 10px;">
      <img src= "https://github.com/user-attachments/assets/2c591b0c-c274-4b86-9b29-94529ce9f75f" width="100" alt="Image 3">
    </td>
    <td style="text-align: center; padding: 10px;">
      <img src="https://github.com/user-attachments/assets/9447f050-638f-4411-a273-19fa869d0d25" width="100" alt="Image 4">
    </td>
  </tr>
</table>


## 🚰 App Flow
![image](https://github.com/user-attachments/assets/c7079d82-de6d-4bbf-ad52-7469f2ecec50)


## 📜 App Architecture
```mermaid
graph TD
    subgraph App
        BikeShareApp[BikeShareApp] --> RootView
        RootView --> AppState[AppState Store]
        RootView --> Router[Navigation Router]
        
        subgraph Core Module
            CoreNetwork[Network Layer]
            CoreError[Error Handling]
            CoreLogging[Logging]
            CoreExtensions[Extensions]
        end

        subgraph Auth Flow
            AuthView[Authentication View]
            AuthView --> AuthVM[Auth ViewModel]
            AuthVM --> AuthRepo[Auth Repository]
            AuthRepo --> AuthAPI[Auth API]
            AuthRepo --> AuthLocal[Auth Local Storage]
        end

        subgraph Main Flow
            MainTabView[Main Tab View]
            MainTabView --> MapView
            MainTabView --> RentalView
            MainTabView --> ProfileView
        end

        subgraph Map Feature
            MapView --> MapVM[Map ViewModel]
            MapVM --> MapRepo[Map Repository]
            MapRepo --> MapAPI[Map API]
            MapRepo --> MapLocal[Map Local Cache]
        end

        subgraph Rental Feature
            RentalView --> RentalVM[Rental ViewModel]
            RentalVM --> RentalRepo[Rental Repository]
            RentalRepo --> RentalAPI[Rental API]
            RentalRepo --> RentalLocal[Rental Local Storage]
        end

        subgraph Payment Feature
            PaymentView[Payment View]
            PaymentView --> PaymentVM[Payment ViewModel]
            PaymentVM --> PaymentRepo[Payment Repository]
            PaymentRepo --> PaymentAPI[Payment API]
            PaymentRepo --> PaymentLocal[Payment Local Storage]
        end

        %% Core Dependencies
        CoreNetwork -.-> AuthAPI
        CoreNetwork -.-> MapAPI
        CoreNetwork -.-> RentalAPI
        CoreNetwork -.-> PaymentAPI
        
        CoreError -.-> AuthVM
        CoreError -.-> MapVM
        CoreError -.-> RentalVM
        CoreError -.-> PaymentVM
    end

    style App fill:#f9f9f9,stroke:#333,stroke-width:2px
    style Core Module fill:#e1f5fe,stroke:#333,stroke-width:1px
    style Auth Flow fill:#f3e5f5,stroke:#333,stroke-width:1px
    style Map Feature fill:#e8f5e9,stroke:#333,stroke-width:1px
    style Rental Feature fill:#fff3e0,stroke:#333,stroke-width:1px
    style Payment Feature fill:#fce4ec,stroke:#333,stroke-width:1px
```

## 🐈‍⬛ Github Convention

### 이슈 종류

| 이슈 종류        | 설명                                                                                         |
|------------------|----------------------------------------------------------------------------------------------|
| `feat`     | **Feature**: 새로운 기능을 추가하거나 구현할 때 사용하는 이슈입니다. 예: 다크 모드 지원 추가.               |
| `bug`          | **Bug**: 예상과 다른 동작이나 코드 오류를 해결할 때 사용하는 이슈입니다. 예: 로그인 화면에서 앱 충돌.   |
| `enh`  | **Enhancement** 기존 기능을 개선하거나 확장할 때 사용하는 이슈입니다. 예: List 컴포넌트의 성능 최적화.         |
| `ref`   | **Refactor**: 기능을 변경하지 않고 코드 구조를 개선할 때 사용하는 이슈입니다. 예: 상태 관리를 ViewModel로 분리.|
| `chore`    | **Chore**: 유지보수 작업이나 설정 업데이트 같은 비기능적 작업에 사용하는 이슈입니다. 예: Xcode 프로젝트 설정 업데이트. |
| `doc`| **Documentation**: 문서화 작업이 필요할 때 사용하는 이슈입니다. 예: 새로운 기능에 대한 사용자 가이드 업데이트.    |

### 이슈 제목 ➡️ `[이슈 종류] 이슈 이름` 
ex) `[feat] 로그인 기능 추가`

### 브랜치 이름 ➡️ `이슈종류/#이슈 번호/적업할내용`
ex) `feat/#3-Login`

### 커밋 이름 ➡️ `이슈종류: 이슈번호 - 작업내용`  
ex) `feat:#3-로그인 버튼 추가` 

### 풀리퀘스트 이름 ➡️ `[이슈종류] 작업내용`
ex) `[feat] 로그인 기능 완료`
