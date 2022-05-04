trigger test_trig on Account (Before Insert) {
    for(Account a : trigger.new){
        if(a.Industry=='Banking')
         a.Description = 'Banking Guys';     
        }
    }