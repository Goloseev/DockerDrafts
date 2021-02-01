BEGIN {
	SectionName = "_Scripts_on_RED"
	print "--------PUBLISHING " + SectionName + " IN FSTAB---------------"
	print "---------------------------------------------------------"
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

