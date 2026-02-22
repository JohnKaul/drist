# fleet

A quick example of how to use drist to manage a server fleet.


## deps

* drist
* a freebsd machine (might work elsewhere)


## quickstart

1. replace TODO's with the ip addresses of your machines
    
    rg TODO .

    ./server_a/files/_drist/new/pf.conf:ext_if="TODO: add your interface here"
    ./server_a/files/_drist/new/pf.conf:# TODO: replace with IPs that make sense for you
    ./server_a/files/_drist/new/rc.conf:hostname="TODO: add your hostname here"
    ./server_a/files/_drist/new/rc.conf:# TODO: change the ifconfig_XXX below to match your network interface
    ./server_a/files/_drist/new/rc.conf:ifconfig_vtnet0="TODO: change this line to fit your system"
    ./server_a/files/_drist/new/rc.conf:defaultrouter="TODO"
    ./server_a/files/_drist/new/authorized_keys:TODO: add your pubkeys here
    ./server_a/mgr.sh:# TODO: change this to your target server hostname
    ./server_b/mgr.sh:# TODO: change this to your server host name
    ./server_b/files/_drist/new/rc.conf:hostname="TODO"
    ./server_b/files/_drist/new/rc.conf:ifconfig_em0="TODO"
    ./server_b/files/_drist/new/rc.conf:defaultrouter="TODO"
    ./server_b/files/_drist/new/pf.conf:ext_if="TODO"
    ./server_b/files/_drist/new/pf.conf:ssh_source_ips = "{ TODO }"
    ./server_b/files/_drist/new/authorized_keys:TODO: add your pub keys here


2. run through the commands on the server_a

    cd server_a
    ./mgr.sh


    Deploy to server_a... 
    Help                  
    h : help              
    c : changed           
    d : diff              
    t : test              
    x : deploy            
    q : quit


3. run through the commands on server_b

    cd server_b
    ./mgr.sh
    
etc.

## architecture

* mgr.sh is the CLI to manage the server(s)
* mgr.sh patches the target scripts with ../lib.sh
* most functions are implemeted in ../lib.sh
* the scripts: [test.sh, deploy.sh, etc.] are custom for each server

## goals

1. kiss

keep it really really simple. no need to re-invent ansible here.

2. idempotent

it's not hard to make commands idempotent, spend the time to do this

