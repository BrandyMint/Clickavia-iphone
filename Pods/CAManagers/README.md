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
<li><a href="#Зависимости">Зависимости</a></li>
</ul>

### Routes.h

Содержит пути, по которым идут запросы на получение данных.

<div id="citiesmanager"><h3>CitiesManager</h3></div>

#### Используемые модели:


#####Destination

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

#####Примеры использования класса:

coming soon

<div id="authmanager"><h3>AuthManager</h3></div>

####Используемые модели

#####LoginForm

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

#####User

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

<a href="#">LoginForm</a>

#####PersonInfo
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

#####Order
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

#####BookingStatus

```objective-c
@property (strong,nonatomic) Order *order;
```
Заказ - экземпляр <a href="#">Order</a>

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

####Примеры использования
coming soon

<div id="chatmanager"><h3>ChatManager</h3></div>

####Используемые модели

#####AcceptedOrder
```objective-c
@property (strong,nonatomic) NSString *orderCode
```
код заказа
```objective-c
@property (strong,nonatomic) NSString *countryDeparture;
```
название страны отправления
```objective-c
@property (strong,nonatomic) NSString *countryArrival;
```
название страны прибытия
```objective-c
@property (strong,nonatomic) NSString *cityDeparture;
```
название города отправления
```objective-c
@property (strong,nonatomic) NSString *cityArrival;
```
название города прибытия
```objective-c
@property (strong,nonatomic) NSDate *dateDeparture;
```
дата отправления
```objective-c
@property (strong,nonatomic) NSDate *dateArrival;
```
дата возврата
```objective-c
@property (strong,nonatomic) NSString *state;
```
статус
####Описание методов

```objective-c
- (void) getMessages:(LoginForm*) byLoginForm forOrder:(AcceptedOrder*) forOrder withCompleteBlock:(void(^)(NSArray *messages))block andFailedBlock:(void(^)(NSException *exception))failedBlock;
```
Возвращает список сообщений для пользовательских данных из byLoginForm для заказа forOrder. Если в byLoginForm содержится accessToken, то для авторизации будет использован, иначе сначала будет пройдена авторизация, а только затем будут получены сообщения. В случае успеха отрабатывает блок withCompleteBlock, в случае неудачи andFailedBlock
```objective-c
- (void) sendMessage:(LoginForm*) byLoginForm forOrder:(AcceptedOrder*) forOrder message:(NSString*)message withCompleteBlock:(void(^)(NSString *status))block andFailedBlock:(void(^)(NSException *exception))failedBlock;
```
Метод выполняет отправку сообщения для пользовательских данных из byLoginForm для заказа forOrder, message - сообщение. В случае успеха отрабатывает блок withCompleteBlock, в случае неудачи andFailedBlock. Параметр status - статус сервера
####Примеры использования
comingsoon
<div id="flightdescriptionmanager"><h3>FlightDescriptiongManager</h3></div>
####Используемые модели
#####OfferConditions
```objective-c
@property (strong,nonatomic) SearchConditions *searchConditions;
```
Экземпляр <a href="#">SearchConditions</a>
```objective-c
@property (strong,nonatomic) NSDate *departureDate;
```
Дата отправления
```objective-c
@property (strong,nonatomic) NSDate *returnDate;
```
Дата возврата
```objective-c
-(id) initWithSearchConditions:(SearchConditions*) searchConditions withDepartureDate:(NSDate*) departureDate andReturnDate:(NSDate*) returnDate;
```
Создание объекта с параметрами
#####Flight
```objective-c
@property (strong,nonatomic) NSString *ID;
```
Номер перелета
```objective-c
@property (strong,nonatomic) NSDate *dateAndTimeDeparture;
```
Дата и время вылета
```objective-c
@property (strong,nonatomic) NSDate *dateAndTimeArrival;
```
Дата и время прилета
```objective-c
@property (strong,nonatomic) NSDate *timeInFlight;
```
Время в пути
```objective-c
@property (strong,nonatomic) NSString *cityDeparture;
```
Город вылета
```objective-c
@property (strong,nonatomic) NSString *cityArrival;
```
Город прилета
```objective-c
@property (strong,nonatomic) NSString *airportDeparture;
```
Аэропорт вылета
```objective-c
@property (strong,nonatomic) NSString *airportArrival;
```
Аэропорт прилета
```objective-c
@property (strong,nonatomic) NSString *airlineTitle;
```
Название авиалинии
```objective-c
@property (strong,nonatomic) NSString *airlineSite;
```
Код авиалинии
```objective-c
@property (strong,nonatomic) NSDecimalNumber *price;
```
Цена
#####Offer
```objective-c
@property (strong,nonatomic) OfferConditions *offerConditions;
```
Условия перелета, экземпляр <a href="#offerconditions">OfferConditions</a>
```objective-c
@property BOOL isSpecial;
```
Спецпредложение?
```objective-c
@property BOOL isMomentaryConfirmation;
```
Мгновенное подтверждение?
```objective-c
@property (strong,nonatomic) Flight *flightDeparture;
```
Перелет туда, экземпляр <a href="#flight">Flight</a>
```objective-c
@property (strong,nonatomic) Flight *flightReturn;
```
Перелет обратно, экземпляр <a href="#flight">Flight</a>
```objective-c
@property (strong,nonatomic) NSDecimalNumber *bothPrice;
```
Стоимость, сумма обоих <a href="flight">Flight</a>
####Описание методов
```objective-c
@property (strong,nonatomic) OfferConditions *offerConditions;
```
Условия перелета
```objective-c
- (id) init:(OfferConditions*) offerConditions;
```
Инициализация с заданными условиями перелета
```objective-c
- (void) getFlightsDepartureByDateWithCompleteBlock:(void (^) (NSArray *flights))block;
```
Получение списка полетов туда. Условия поиска берутся из offerCondtions. flights - список, содержащий экземпляры <a href="#">Flight</a>. В этом списке находятся полученные данные
```objective-c
- (void) getFlightsReturnByDateWithCompleteBlock:(void (^) (NSArray *flights))block;
```
Получение списка полетов обратно. Условия поиска берутся из offerConditions. flights - список, содержащий экземлпяры <a href="#">Flight</a>. В этом списке находятся полученные данные
```objective-c
- (void) getAvailableOffersWithCompleteBlock:(void (^) (NSArray *offers))block;
```
Получение списка предложений перелета. Условия поиска берутся из offerConditions. offers - список, содержащий экземпляры <a href="#">Offer</a>. В этом списке находятся полученные данные
####Примеры использования
coming soon
###FlightsManager
####Используемые модели
####SearchConditions
```objective-c
@property BOOL isBothWays;
```
Туда/обратно?
```objective-c
@property NSNumber *countOfTickets;
```
Количество билетов
```objective-c
typedef enum
{
    business,
    econom
} flightType;
@property flightType typeOfFlight;
```
Тип полета: бизнес, эконом
```objective-c
@property (strong,nonatomic) Destination *direction_departure;
```
Направление туда. Экземпляр <a href="#destination">Destination</a>
```objective-c
@property (strong,nonatomic) Destination *direction_return;
```
Направление обратно. Экземпляр <a href="#destination">Destination</a>
####Описание методов
```objective-c
- (void) getAvailableDepartureDates: (SearchConditions*) forConditions departureDate:(NSDate*)withDepartureDate completeBlock:(void (^)(NSArray *dates))block;
```
Возвращает список дат доступных для вылета. withDepartureDate - дата вылета, forConditions - условия поиска. Полученные данные (это экземпляры NSDate) содержатся в списке dates
```objective-c
- (void) getAvailableReturnDates:(SearchConditions*) forConditions withDepartureDate:(NSDate*)withDepartureDate completeBlock:(void (^)(NSArray *dates))block;
```
Возвращает список дат доступных для вылета для возврата. withDepartureDate - дата вылета, forConditions - условия поиска. Полученные данные (это экземпляры NSDate) содержатся в списке dates
####Примеры использования
coming soon
<div id="ordersmanager"><h3>OrdersManager</h3></div>

####Используемые модели
<a href="#">AcceptedOrder</a>
<a href="#">LoginForm</a>
####Описание методов
```objective-c
- (void) getOrders: (LoginForm*) loginForm completeBlock:(void(^)(NSArray *orders))block authFailedBlock:(void(^)(NSException *exception)) failedBlock;
```
Возвращает список заказов для пользователя с данными из loginForm. В случае успеха выполняется блок completeBlock, неудачи - failedBlock
```objective-c
- (void) sendTicketsToEmail:(LoginForm*) loginForm byOrder:(AcceptedOrder*)byOrder;
```
Данный метод пока не реализован, но был запланирован. Его лучше не использовать
####Примеры использования
coming soon
<div id="specialoffersmanager"><h3>SpecialOffersManager</h3></div>

####Используемые модели
#####SpecialOfferCity
```objective-c
@property (strong,nonatomic) NSString *title;
```
Название города
#####SpecialOfferCountry
```objective-c
@property (strong,nonatomic) NSString *title;
```
Название страны
```objective-c
@property NSInteger countOfOffers;
```
Количество предложений
#####SpecialOffer
```objective-c
@property BOOL isHot;
```
Горячее предложение или нет
```objective-c
@property BOOL isReturn;
```
В оба конца или нет
```objective-c
@property (strong,nonatomic) NSString *flightCity;
```
Город прибытия
```objective-c
@property (strong,nonatomic) NSDecimalNumber *price;
```
Цена
```objective-c
@property (strong,nonatomic) NSArray *dates;
```
Даты
```objective-c
@property (strong,nonatomic) NSArray *flightIds;
```
ID перелетов
```objective-c
@property (strong,nonatomic) NSString *departureCity;
```
Город прибытия
####Описание методов
```objective-c
- (void) getCitiesWithCompleteBlock:(void (^)(NSArray*))block;
```
Отдает список городов, для которых есть спецперелеты. Параметр блока - массив экземпляров <a href="#">SpecialOfferCity</a>
```objective-c
- (void) getAvailableCountries: (SpecialOfferCity*) forCity completeBlock:(void (^) (NSArray*))block;
```
Отдает список стран, для которых есть спецперелеты для города forCity. Параметр блока - массив экземпляров <a href="#">SpecialOfferCountry</a>
```objective-c
- (void) getSpecialOffers:(SpecialOfferCity*) forCity : (SpecialOfferCountry*) forCountry completeBlock:(void (^) (NSArray*))block;
```
Получение списка спецпредложений для заданной страны и города. Параметр блока - массив экземпляров <a href="#">SpecialOffer</a>
####Примеры использования

<div id="usermanager"><h3>UserManager</h3></div>

####Используемые модели
#####CountryCodes
```objective-c
@property (strong,nonatomic) NSString *title;
```
Название страны
```objective-c
@property (strong,nonatomic) NSNumber *ID;
```
ID страны
```objective-c
@property (strong,nonatomic) NSNumber *phoneCode;
```
Код телефона
#####User
```objective-c
@property (strong,nonatomic) NSString *name;
```
Имя пользователя
```objective-c
@property (strong,nonatomic) NSString *email;
```
Email
```objective-c
@property (strong,nonatomic) NSString *phoneNumber;
```
Номер телефона
```objective-c
@property (strong,nonatomic) NSString *authKey;
```
Токен доступа. При получении экземпляра User от какого-то метода, можно этот токен передавать в соответствующем свойстве LoginForm, чтобы избежать повторных авторизаций для методов других менеджеров, требующих авторизаций
#####RegistrationForm
```objective-c
@property (strong,nonatomic) NSString *name;
```
Имя пользователя
```objective-c
@property (strong,nonatomic) NSString *email;
```
Email пользователя
```objective-c
@property (strong,nonatomic) NSString *phoneNumber;
```
Номер телефона
```objective-c
@property (strong,nonatomic) NSString *countryCode;
```
Код страны
```objective-c
@property (strong,nonatomic) NSString *password;
```
Пароль
####Описание методов
```objective-c
- (void) getUser:(LoginForm *) withLoginForm completeBlock:(void (^) (User *user)) block  failBlock:(void (^) (NSException *exception)) blockException;
```
Получение данных пользователя для withLoginForm. completeBlock выполняется в случае успеха, failBlock в случае неудачи.
```objective-c
- (void) registrateUser:(RegistrationForm *) withRegistrationForm completeBlock:(void (^) (User *user)) block failBlock:(void (^) (NSException *exception)) blockException;
```
Регистрация пользователя, используя данные из withRegistrationForm. В случае успешной регистрации отрабатывает блок completeBlock, в случае неудачи failBlock. В exception.reason будет содержаться ответ сервера со всеми ошибками, которые были допущены в форме регистрации.
```objective-c
- (void) getCountryCodes:(void (^) (NSArray *codes))block;
```
Получение списка кодов стран. codes - список экземпляров <a href="#">CountryCodes</a>
###Зависимости

```
pod 'EasyMapping', '0.4.3'
pod 'LRResty', '0.11.0'
pod 'RestKit', '0.20.0'
pod 'Base64', '1.0.1'
```