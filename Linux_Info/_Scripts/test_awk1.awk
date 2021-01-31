BEGIN {
	print "--------Let i show home dir in passwd file---------------"
	print "---------------------------------------------------------"
	print "user\t\t\thome path"
	pring "------ \t\t\t ----------"
	FS=":"
	OFS="\t\t\t"
}
{
	comment1 = " has home dir "
	print $1, $6
}
END {
	print "---------------------------------------"
	print "end awk script"
}

