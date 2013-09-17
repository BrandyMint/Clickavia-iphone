#Clickavia-iphone

####В основном проекте находится модель объекта пассажиров: FlightPassengersCount
		
		@property NSUInteger adults;
		@property NSUInteger kids;
		@property NSUInteger babies;

###представление CAOrderDetails хранится в:
		
		CAOrderDetails.h
		CAOrderDetails.m
		
		
###представление CAOrderDetailsPersonal хранится в:
		
		CAOrderDetailsPersonal.h
		CAOrderDetailsPersonal.m
		
		
###Описание методов:

		- (UIView*) initByOfferModel:(Offer*)offers passangers:(FlightPassengersCount*)passangers;


Передаем 2 объекта Offer и FlightPassengersCount на выходе получаем готовый View. 

