# caip
Check another IP

# Description
The resource checks the strings for the presence of foreign IP address and port.
A search algorithm based on shuffling sequential character combinations of numerals from the check line.
Available settings associated with the IP address mask and range of ports.
Resource exports server function *checkAnotherIP* to check table of string for matching ip:port.

# Installation
Create a new directory with name **caip** in resource directory of your MTA server.
Download the repository files to this folder
```
git clone https://github.com/victor192/caip path/to/directory/caip
```
To start resource, enter the following command in the server console
```
start caip
```
In case of successful start you will see the message
```
[CAIP] Resource was successfully loaded!
```
otherwise, you will see a message with the place and the error code.
If you want to run a resource with the server running, then edit the configuration file *mtaserver.conf*, adding following string
```
<resource src="caip" startup="1" protected="0"/>
```

# Settings
Resource settings are available in the `meta.xml` file.

Group of settings related to IP address and port of your MTA server.
* **ServerIP**
  
  IP address of your MTA server.
  
* **ServerPort**
  
  Port of your MTA server.
  
Group of settings related to the mask of IP address.
* **FirstIPNumberMinRange**
  
  The minimum value of the first digit of IP address.
  Must be a whole number from 0 to 255.
  
* **FirstIPNumberMaxRange**
  
  The maximum value of the first digit of IP address.
  Must be a whole number from 0 to 255 and greater than the value of *FirstIPNumberMinRange*.
  
* **SecondIPNumberMinRange**
  
  The minimum value of the second digit of of IP address.
  Must be a whole number from 0 to 255.
  
* **SecondIPNumberMaxRange**
  
  The maximum value of the second digit of IP address.
  Must be a whole number from 0 to 255 and greater than the value of *SecondIPNumberMinRange*.
  
* **ThirdIPNumberMinRange**
  
  The minimum value of the third digit of IP address.
  Must be a whole number from 0 to 255.
  
* **ThirdIPNumberMaxRange**
  
  The maximum value of the third digit of IP address.
  Must be a whole number from 0 to 255 and greater than the value of *ThirdIPNumberMinRange*.
  
* **FourthIPNumberMinRange**
  
  The minimum value of the fourth digit of IP address.
  Must be a whole number from 0 to 255.
  
* **FourthIPNumberMaxRange**
  
  The maximum value of the fourth digit of IP address.
  Must be a whole number from 0 to 255 and greater than the value of *FourthIPNumberMinRange*.

Group of settings related to the port range.
* **PortMinRange**
  
  The minimum value of the port.
  Must be an integer greater than zero.
  
* **PortMaxRange**
  
  The maximum value of the port.
  Must be a integer greater than the value of *PortMinRange*.
  
Other settings.
* **NotDgitsWordsMaxLength**

  Maximum length of the substring located between the numbers in coincidence type ip: port.

# Exported functions
* **checkAnotherIP**
  
  Checks a table of strings for the presence of foreign combination of the form ip:port.
  Comparison of the found combinations are made with the data of IP address and port specified in the settings of the resource.

  * **Type**:
    Server-only function

  * **Syntax**:
    >table **checkAnotherIP**(table **Strings**)

  * **Required Arguments**:
    * **Strings**: Table of string to check.

  * **Returns**:
    Returns a table that contains the keys `ErrorCode` and `Checked`.
    In case of successful execution, `ErrorCode` must be equal to *0*.
    The result of strings check is written to the key `Checked`.
    If `Checked` is equal to *true*, then the table of strings contains foreign combination of the form ip:port, *false* otherwise.

# Example
