import "classes/*.pp"
class users {
	include usersList
	#include GroupsList
}

class usersList {	
    add_user { "boopathi":
        uid=>1000
    }
}
