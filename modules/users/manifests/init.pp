import "classes/*.pp"
class users {
	include usersList
	#include GroupsList
}

class usersList {	
    add_user { "user":
        uid=>1000
    }
}
