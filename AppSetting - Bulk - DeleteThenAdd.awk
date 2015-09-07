{
# if slot is named Running, then it means we're working on all instances, else we need to set slot
if($3=="Running"){
	system("echo Processing: --------- " $2 " -------------");
	system("echo ----------- Delete: %keyname%");
	system("azure site appsetting delete %keyname% " $2 " -q");
	system("echo ----------- Add: %keyname%=%keyvalue%");
	system("azure site appsetting add %keyname%=%keyvalue% " $2);
}else{
	system("echo Processing: ---------" $2 " " $3 " -------------");
	system("echo ----------- Delete: %keyname%");
	system("azure site appsetting delete %keyname% " $2 " --slot " $3 " -q");
	system("echo ----------- Add: %keyname%=%keyvalue%");
	system("azure site appsetting add %keyname%=%keyvalue% " $2 " --slot " $3);
	}
}