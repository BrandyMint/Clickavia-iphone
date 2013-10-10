#Clickavia-iphone

###представление CAOrderDetails хранится в:
		
		CAOrderDetails.h
		CAOrderDetails.m
		
		
###представление CAOrderDetailsPersonal хранится в:
		
		CAOrderDetailsPersonal.h
		CAOrderDetailsPersonal.m
		
		
###Описание методов:

		- (UIView*) initByOfferModel:(Offer*)offers passangers:(CAFlightPassengersCount*)passangers;


Передаем 2 объекта Offer и CAFlightPassengersCount на выходе получаем готовый View. 


### подсказки к экранам [CA-AssistView]:

        -(UIView*) initByAssistText:(NSString*)assistText font:(UIFont*)font indentsBorder:(float)indentsBorder;

Передаем строку с подсказкой, шрифт и отспуп текста от границ создаваемого View. 
На выходе получаем готовое представление в верхней части экрана.
