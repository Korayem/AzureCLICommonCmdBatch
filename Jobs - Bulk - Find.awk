{
# to degub, add echo before "azure"
# if slot is named Running, then it means we're working on all instances, else we need to set slot
if($3=="Running"){
	system("echo Processing: --------- " $2 " -------------");
	system("azure site job list " $2);
}else{
	system("echo Processing: ---------" $2 " " $3 " -------------");
	system("azure site job list " $2 " --slot " $3);
}
}