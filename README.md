## Environment configuration
### Java Development Kit

Go to [this link to download JDK 1.8 ](https://www.oracle.com/sa/java/technologies/javase/javase-jdk8-downloads.html), go to *Java SE Development Kit* tab and download *Windows x64* version

#### Configure environment variable

1. Right click the Computer icon.
2. Choose Properties from the context menu.
3. Click the Advanced system settings link.
4. Click Environment Variables. 
5. In the section System Variables, create or edit **"JAVA_HOME"** variable and set path of java jdk. For example
```
Name  : JAVA_HOME
Value : C:\Program Files\Java\jdk1.8.0_211
```
6. In the section System Variables, create or edit **"path"** variable and set *%JAVA_HOME%\bin*. For example
```
Name  : path
Value : %JAVA_HOME%\bin
```



### Apache maven
Download the stable version from [this link](https://maven.apache.org/download.cgi). Select **Binary zip archive**

#### Configure environment variable
1. Right click the Computer icon.
2. Choose Properties from the context menu.
3. Click the Advanced system settings link.
4. Click Environment Variables. 
5. In the section System Variables, create or edit **"MAVEN_HOME"** variable and set path of apache maven. For example
```
Name  : MAVEN_HOME
Value : C:\Automatizacion\apache-maven-3.6.3
```
6. In the section System Variables, create or edit **"path"** variable and set *%MAVEN_HOME%\bin*. For example
```
Name  : path
Value : %MAVEN_HOME%\bin
```

### Intellij IDEA Community
Download the community version from [this link](https://www.jetbrains.com/es-es/idea/download/)

### Linux Tools For Windows


## Project structure

```
└───Karate-Gatling
    ├───scripts
    |    ├───pet-simulation.sh
    |    └───user-simulation.sh
    ├───src
    │   └───test
    │       └───java
    │           └───petsswagger
    │           │    ├───features
    │           │    ├───request
    │           │    └───response
    │           └───performance
    |           |    ├───data
    |           |    ├───PetSimulation.scala        
    |           |    └───UserSimulation.scala        
    │           └───core
    │           │    ├───constants
    │           │    └───environment
    │           │
    │           └───utils
    │                └───DataGenerator.java
    │
    └───target
```


## Run test by console
Open command promt, go to project folder and run this command:
```
mvn clean test-compile gatling:test -Dgatling.simulationClass=performance.UserSimulation
```
## Run test using scripts
`scripts` directory has some scripts to run specific **Gatling Simulation**. 

Before to execute simulation using scripts, change permissions of scripts with command:
```
chmod +x user-simulation.sh
```
Open command promt, go to project folder and run script, for example:
```
user-simulation.sh
```