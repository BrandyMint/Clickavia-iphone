CA-managerslib
==============

Библиотека менеджеров даных

Данная библиотека предоставляет API, которое может быть использовано для получения данных от сервера

<ul>
<li><a href="#citiesmanager">CitiesManager</a> 
Поиск отправлений при автокомплите</li>
<li><a href="#authmanager">AuthManager</a>
Авторизация пользователя. Служебный, используется в BookingManager</li>
<li><a href="#bookingmanager">BookingManager</a>
Бронирование</li>
<li><a href="#chatmanager">ChatManager</a>
Переписка с менеджером</li>
<li><a href="#flightdescriptionmanager">FlightDescriptionManager</a>
Результаты поиска по датам и параметрам перелета</li>
<li><a href="#flightsmanager">FlightsManager</a>
Список дат доступных для вылета и возврата</li>
<li><a href="#ordersmananager">OrdersManager</a>
Заказы пользователя</li>
<li><a href="#specialoffersmanager">SpecialOffersManager</a>
Поиск спецпредложений</li>
<li><a href="#usermanager">UserManager</a>
Регистрация, список кодов стран</li>
<li><a href="#dependecies">Зависимости</a></li>
</ul>

### Routes.h

Содержит пути, по которым идут запросы на получение данных.

<div id="citiesmanager"><h3>CitiesManager</h3></div>

#### Используемые модели:


Destination

```objective-c
@property (strong,nonatomic) NSString* title
```

Название найденного пункта.

```objective-c
@property (strong,nonatomic) NSString* code
```

Трехбуквенный код найденного пункта.

```objective-c
@property DestinationType destinationType
```

Тип найденного пункта.

```objective-c
@property (strong,nonatomic) NSString* cityCode
```

Код города найденного пункта.

```objective-c
@property (strong,nonatomic) NSString* countryTitle
```

Название страны найденного пункта.

```objective-c
@property (strong,nonatomic) NSString* cityTitle
```

Название города найденного пункта.

```objective-c
@property (strong,nonatomic) NSString* airportTitle
```

Название аэропорта найденного пункта.


#### Описание методов:

```objective-c
@property NSInteger delay
```
Задержка между запросами на сервер в миллисекундах. По умолчанию - 300. Если вызовы методов происходят чаще, чем delay, то будут возвращены результаты предыдущего запроса.

```objective-c
- (void) getDestinationsForDeparture: (NSString*) byText completeBlock:(void(^)(NSArray *array))block
```

возвращает список направлений для вылета. Обработка направлений должна проходить в блоке (void(^)(NSArray *array))block . Параметр array содержит экземпляры класса Destination.

```objective-c
- (void) getDestinationsForReturn:(NSString*) byText forDepartureDestination:(Destination*) forDepartureDestination completeBlock:(void(^)(NSArray *array))
```

возвращает список направлений для возврата в соответствии с установленным направлением вылета. Обработка направление должна проходить в блоке (void(^)(NSArray *array)). byText и forDepartureDestination могут быть пустыми.

Примеры использования класса:

coming soon

<div id="authmanager"><h3>AuthManager</h3></div>

####Используемые модели

<div id="modelloginform">LoginForm</div>

```objective-c
@property (strong,nonatomic) NSString *email;
```
Адрес электронной почты

```objective-c
@property (strong,nonatomic) NSString *password;
```
Пароль

```objective-c
@property (strong,nonatomic) NSString *accessToken;
```
Токен для доступа

User

```objective-c
@property (strong,nonatomic) NSString *name;
```
Имя пользователя

```objective-c
@property (strong,nonatomic) NSString *email;
```
Адрес электронной почты

```objective-c
@property (strong,nonatomic) NSString *phoneNumber;
```
Номер телефона

```objective-c
@property (strong,nonatomic) NSString *authKey;
```
Токен для доступа

####Описание методов
```objective-c
- (void) getUser:(LoginForm *) withLoginForm completeBlock:(void (^) (User *user)) block  failBlock:(void (^) (NSException *exception)) blockException
```
проводит авторизацию пользователя с данными из LoginForm. В случае успеха отрабатывает completeBlock, неудачи failBlock.

<div id="bookingmanager"><h3>BookingManager</h3></div>

####Используемые модели

<a href="#modelloginform">LoginForm</a>

<div id="modelpersoninfo">PersonInfo</div>

```objective-c
@property (strong,nonatomic) NSString *lastName;
```
Фамилия
```objective-c
@property (strong,nonatomic) NSString *name;
```
Имя
```objective-c
typedef enum
{
    male,
    female,
    children,
    infant
} PersonType;
@property PersonType personType;
```
Тип пассажира: мужчина, женщина, ребенок, младенец

```objective-c
@property (strong,nonatomic) NSDate *birthDate;
```
Дата рождения

```objective-c
@property (strong,nonatomic) NSDate *validDate;
```
Срок действия паспорта

```objective-c
@property (strong,nonatomic) NSString *passportSeries;
```
Серия паспорта

```objective-c
@property (strong,nonatomic) NSString *passportNumber;
```
Номер паспорта

<div id="modelorder">Order</div>
```objective-c
@property (strong,nonatomic) NSNumber *idRaceDeparture;
```
id рейса вылета
```objective-c
@property (strong,nonatomic) NSNumber *idRaceReturn;
```
id обратного рейса
```objective-c
@property (strong,nonatomic) NSNumber *adultsCount;
```
количество взрослых
```objective-c
@property (strong,nonatomic) NSNumber *childCount;
```
количество детей
```objective-c
@property (strong,nonatomic) NSNumber *infantCount;
```
количество младенцев
```objective-c
typedef enum
{
    evrosetOrSvyaznoy = 1,
    masterCardOrVisa = 2,
    cash = 3
} PaymentType;
@property PaymentType paymentType;
```
тип оплаты: Евросеть или Связной, MasterCard или Visa, наличными в офисе

```objective-c
@property (strong,nonatomic) NSArray *personsInfo;
```
Пассажиры. Массив экземпляров <a href="#modelpersoninfo">PersonInfo</a>

BookingStatus

```objective-c
@property (strong,nonatomic) Order *order;
```
Заказ - экземпляр <a href="#modelorder">Order</a>

```objective-c
@property (strong,nonatomic) NSString *state;
```
статус заказа
```objective-c
@property (strong,nonatomic) NSString *managerName;
```
имя менеджера
```objective-c
@property (strong,nonatomic) NSString *orderID;
```
номер заказа

####Описание методов
```objective-c
- (void) bookFlight:(LoginForm*) byLogin withOrder:(Order*) order withComplete:(void(^)(BookingStatus* bookingStatus))block withFailed:(void(^)(NSException* exception)) failedBlock;
```
метод узнает статус заказа. Для авторизации используется byLogin. Если в byLogin нет токена доступа, то сначала происходит авторизация и получения токена, а затем получение статуса заказа. В случае успеха отрабатывает блок withComplete, в случае неудачи withFailed
<div id="chatmanager"><h3>ChatManager</h3></div>

####Используемые модели

####Описание методов

```objective-c
- (void) getMessages:(LoginForm*) byLoginForm forOrder:(AcceptedOrder*) forOrder withCompleteBlock:(void(^)(NSArray *messages))block andFailedBlock:(void(^)(NSException *exception))failedBlock;
```
Получение сообщений для пользователя с данными byLoginForm по заказу forOrder
```objective-c
- (void) sendMessage:(LoginForm*) byLoginForm forOrder:(AcceptedOrder*) forOrder message:(NSString*)message withCompleteBlock:(void(^)(NSString *status))block andFailedBlock:(void(^)(NSException *exception))failedBlock;
```

<div id="flightdescriptionmanager"><h3>FlightDescriptiongManager</h3></div>

####Используемые модели

####Описание методов

<div id="flightsmanager"><h3>FlightsManager</h3></div>

####Используемые модели

####Описание методов

<div id="ordersmanager"><h3>OrdersManager</h3></div>

####Используемые модели

####Описание методов

<div id="specialoffersmanager"><h3>SpecialOffersManager</h3></div>

####Используемые модели

####Описание методов

<div id="usermanager"><h3>UserManager</h3></div>

####Используемые модели

####Описание методов

<div id="dependecies"><h3>Зависимости</h3></div>

```
pod 'EasyMapping', '0.4.3'
pod 'LRResty', '0.11.0'
pod 'RestKit', '0.20.0'
pod 'Base64', '1.0.1'
```