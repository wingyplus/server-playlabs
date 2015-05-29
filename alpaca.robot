*** Settings ***
Library         SSHLibrary
Suite Teardown  Close All Connections


*** Test Cases ***
Install Go API Service On UAT
    Open Connection   192.168.33.11
    Login   vagrant   vagrant
    Binary File Should Copy To Folder /home/vagrant/api
    Configuration File Should Copy To Folder /home/vagrant/api/conf.d
    Configuration File Should Set Port To    9005

Install Go API Service On Production
    Open Connection   192.168.33.10
    Login   vagrant   vagrant
    Binary File Should Copy To Folder /home/vagrant/api
    Configuration File Should Copy To Folder /home/vagrant/api/conf.d
    Configuration File Should Set Port To    9006


*** Keywords ***
Binary File Should Copy To Folder /home/vagrant/api
    File Should Be Exist  /home/vagrant/api/alpaca

Configuration File Should Copy To Folder /home/vagrant/api/conf.d
    File Should Be Exist  /home/vagrant/api/conf.d/alpaca.json

File Should Be Exist
    [Arguments]   ${file}
    ${rc}=  Execute Command   [ -f ${file} ] && true || false   return_stdout=False   return_rc=True
    Should Be Equal   ${rc}   ${0}   msg=File ${file} doesn't exist   values=False

Configuration File Should Set Port To
    [Arguments]   ${port}
    ${line_str}=  Execute Command   grep -r '"port": ${port}' | grep -v grep | wc -l   return_stdout=True   return_rc=False
    ${line}=  Convert To Integer  ${line_str}
    Should Not Be Equal   ${line}   ${0}   msg=Configuration file should not set port to ${port}  values=False
