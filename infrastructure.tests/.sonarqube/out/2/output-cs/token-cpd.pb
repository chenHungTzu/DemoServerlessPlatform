¶
Z/Users/hungtzuchen/Desktop/proj/DemoServerlessPlatform/infrastructure/DividerRepository.cs
	namespace 	
infrastructure
 
; 
public		 
class		 
DividerRepository		 
:		  
IDividerRepository		! 3
{

 
private 
readonly 
IAmazonDynamoDB $
_amazonDynamoDB% 4
;4 5
public 

DividerRepository 
( 
IAmazonDynamoDB ,
amazonDynamoDB- ;
); <
{ 
_amazonDynamoDB 
= 
amazonDynamoDB (
;( )
} 
public 

async 
Task 
WriteToDatabase %
(% &
Divider& -
divider. 5
)5 6
{ 
var 
request 
= 
new 
PutItemRequest (
{ 	
	TableName 
= 
$" 
{ 
divider "
." #
	TableName# ,
}, -
$str- .
{. /
EnvironmentVariable/ B
.B C
MODEC G
(G H
)H I
}I J
"J K
,K L
Item 
= 
new 

Dictionary !
<! "
string" (
,( )
AttributeValue* 8
>8 9
{ 
{ 
$str 
, 
new  #
AttributeValue$ 2
{3 4
N5 6
=7 8
divider9 @
.@ A
NumberA G
.G H
ToStringH P
(P Q
)Q R
}S T
}U V
} 
, 
} 	
;	 

await 
_amazonDynamoDB 
. 
PutItemAsync *
(* +
request+ 2
)2 3
;3 4
} 
} 