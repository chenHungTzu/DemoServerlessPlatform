‚
?D:\proj\DemoServerlessPlatform\infrastructure.DI\DIExtension.cs
	namespace 	
infrastructure
 
. 
DI 
{ 
public		 

static		 
class		 
DIExtension		 #
{

 
public 
static 
IServiceCollection (
AddServices) 4
(4 5
this5 9
IServiceCollection: L
servicesM U
)U V
{ 	
services 
. 
AddControllers #
(# $
)$ %
;% &
if 
( 
EnvironmentVariable #
.# $
MODE$ (
(( )
)) *
==+ -
$str. 5
)5 6
{ 
services 
. 
AddSingleton %
<% &
IAmazonDynamoDB& 5
>5 6
(6 7
_7 8
=>9 ;
{ 
var 
config 
=  
new! $ 
AmazonDynamoDBConfig% 9
{ 

ServiceURL "
=# $
EnvironmentVariable% 8
.8 9
DDB_ENDPOINT9 E
(E F
)F G
,G H 
AuthenticationRegion ,
=- .
$str/ ?
,? @
UseHttp 
=  !
true" &
,& '
} 
; 
var 
awsCredentials &
=' (
new) ,
BasicAWSCredentials- @
(@ A
$strA L
,L M
$strN Y
)Y Z
;Z [
return 
new  
AmazonDynamoDBClient 3
(3 4
awsCredentials4 B
,B C
configD J
)J K
;K L
} 
) 
; 
} 
else 
{ 
services 
. 
AddSingleton %
<% &
IAmazonDynamoDB& 5
>5 6
(6 7
_7 8
=>9 ;
{ 
var   
clientConfig   $
=  % &
new  ' * 
AmazonDynamoDBConfig  + ?
{!! 
RegionEndpoint"" &
=""' (
Amazon"") /
.""/ 0
RegionEndpoint""0 >
.""> ?
APNortheast1""? K
}## 
;## 
return$$ 
new$$  
AmazonDynamoDBClient$$ 3
($$3 4
clientConfig$$4 @
)$$@ A
;$$A B
}%% 
)%% 
;%% 
}&& 
services'' 
.'' 
AddSingleton'' !
<''! "
IDividerRepository''" 4
,''4 5
DividerRepository''6 G
>''G H
(''H I
)''I J
;''J K
services(( 
.(( 
AddAWSLambdaHosting(( (
(((( )
LambdaEventSource(() :
.((: ;
RestApi((; B
)((B C
;((C D
return** 
services** 
;** 
}++ 	
},, 
}-- 