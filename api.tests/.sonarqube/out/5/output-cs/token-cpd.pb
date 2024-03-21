ó
@D:\proj\DemoServerlessPlatform\api\Controllers\DemoController.cs
	namespace 	"
DemoServerlessPlatform
  
.  !
Controllers! ,
{ 
[ 
ApiController 
] 
[ 
Route 

(
 
$str 
) 
] 
public		 

class		 
DemoController		 
:		  !
ControllerBase		" 0
{

 
private 
readonly 
IDividerRepository +
dividerRepository, =
;= >
public 
DemoController 
( 
IDividerRepository 0
dividerRepository1 B
)B C
{ 	
this 
. 
dividerRepository "
=# $
dividerRepository% 6
;6 7
} 	
[ 	
HttpPost	 
( 
$str ,
), -
]- .
public 
async 
Task 
< 
IActionResult '
>' (
DivisionToWrite) 8
(8 9
int9 <
number= C
)C D
{ 	
try 
{ 
await 
dividerRepository '
.' (
WriteToDatabase( 7
(7 8
new8 ;
Divider< C
(C D
numberD J
,J K
$numL M
)M N
)N O
;O P
return   
Ok   
(   
number    
)    !
;  ! "
}!! 
catch"" 
("" 
	Exception"" 
ex"" 
)""  
{## 
return$$ 

BadRequest$$ !
($$! "
ex$$" $
.$$$ %
Message$$% ,
)$$, -
;$$- .
}%% 
}&& 	
}'' 
}(( ›
6D:\proj\DemoServerlessPlatform\api\LambdaEntryPoint.cs
	namespace 	"
DemoServerlessPlatform
  
;  !
public		 
class		 
LambdaEntryPoint		 
:		 
Amazon 

.
 
Lambda 
. 
AspNetCoreServer "
." ##
APIGatewayProxyFunction# :
{ 
	protected 
override 
void 
Init  
(  !
IWebHostBuilder! 0
builder1 8
)8 9
{ 
builder 
.   

UseStartup   
<   
Startup   
>    
(    !
)  ! "
;  " #
}!! 
	protected** 
override** 
void** 
Init**  
(**  !
IHostBuilder**! -
builder**. 5
)**5 6
{++ 
},, 
}-- 

5D:\proj\DemoServerlessPlatform\api\LocalEntryPoint.cs
	namespace 	"
DemoServerlessPlatform
  
;  !
public 
class 
LocalEntryPoint 
{ 
public 

static 
void 
Main 
( 
string "
[" #
]# $
args% )
)) *
{		 
CreateHostBuilder

 
(

 
args

 
)

 
.

  
Build

  %
(

% &
)

& '
.

' (
Run

( +
(

+ ,
)

, -
;

- .
} 
public 

static 
IHostBuilder 
CreateHostBuilder 0
(0 1
string1 7
[7 8
]8 9
args: >
)> ?
=>@ B
Host 
.  
CreateDefaultBuilder !
(! "
args" &
)& '
. $
ConfigureWebHostDefaults %
(% &

webBuilder& 0
=>1 3
{ 

webBuilder 
. 

UseStartup %
<% &
Startup& -
>- .
(. /
)/ 0
;0 1
} 
) 
; 
} Õ
-D:\proj\DemoServerlessPlatform\api\Startup.cs
	namespace 	"
DemoServerlessPlatform
  
;  !
public 
class 
Startup 
{ 
public 

Startup 
( 
IConfiguration !
configuration" /
)/ 0
{ 
Configuration		 
=		 
configuration		 %
;		% &
}

 
public 

IConfiguration 
Configuration '
{( )
get* -
;- .
}/ 0
public 

void 
ConfigureServices !
(! "
IServiceCollection" 4
services5 =
)= >
{ 
services 
. 
AddServices 
( 
) 
; 
} 
public 

void 
	Configure 
( 
IApplicationBuilder -
app. 1
,1 2
IWebHostEnvironment3 F
envG J
)J K
{ 
if 

( 
env 
. 
IsDevelopment 
( 
) 
)  
{ 	
app 
. %
UseDeveloperExceptionPage )
() *
)* +
;+ ,
} 	
app 
. 
UseHttpsRedirection 
(  
)  !
;! "
app 
. 

UseRouting 
( 
) 
; 
app   
.   
UseAuthorization   
(   
)   
;   
app"" 
."" 
UseEndpoints"" 
("" 
	endpoints"" "
=>""# %
{## 	
	endpoints$$ 
.$$ 
MapControllers$$ $
($$$ %
)$$% &
;$$& '
	endpoints%% 
.%% 
MapGet%% 
(%% 
$str%%  
,%%  !
async%%" '
context%%( /
=>%%0 2
{&& 
await'' 
context'' 
.'' 
Response'' &
.''& '

WriteAsync''' 1
(''1 2
$str''2 a
)''a b
;''b c
}(( 
)(( 
;(( 
})) 	
)))	 

;))
 
}** 
}++ 