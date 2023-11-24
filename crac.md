### Showcase SpringBoot 3.2 automatic checkpoint at start on Linux

#### Setup the environment
1. Download a JDK with support for CRaC e.g.
- [Azul Zulu 21.0.1 + CRaC X64](https://cdn.azul.com/zulu/bin/zulu21.30.19-ca-crac-jdk21.0.1-linux_x64.tar.gz)
- [Azul Zulu 21.0.1 + CRaC AARCH64](https://cdn.azul.com/zulu/bin/zulu21.30.19-ca-crac-jdk21.0.1-linux_aarch64.tar.gz)

2. Unpack the tar.gz file and copy the JDK in a folder
- ```sudo tar zxvf zulu21.30.19-ca-crac-jdk21.0.1-linux_x64.tar.gz```
- ```mv zulu21.30.19-ca-crac-jdk21.0.1-linux_x64 zulu-21.jdk```
- ```sudo mv zulu-21.jdk /usr/lib/jvm```

3. Set the $JAVA_HOME environment variable to the JDK with CRaC support e.g.
- ```export JAVA_HOME=/usr/lib/jvm/zulu-21.jdk```

4. Make sure you have the permissions to run CRIU
- ```sudo chown root:root $JAVA_HOME/lib/criu```
- ```sudo chmod u+s $JAVA_HOME/lib/criu```

5. Make sure you have the dependency to org.crac added to your build file
- gradle: <br>
```implementation 'org.crac:crac:1.4.0'```
- maven :
```
<dependency>
  <groupId>org.crac</groupId>
  <artifactId>crac</artifactId>
  <version>1.4.0</version>
</dependency>  
```

<br><br>

#### Build the application
1. Open the project folder
2. run ```gradlew clean build```
3. Now you should find the the jar at ```build/libs/spring-petclinic-3.2.0.jar```
4. Create a folder named ```tmp_checkpoint``` in the project folder (besides the ```src``` folder)

<br><br>

#### Start the application without any CRaC
1. Start the application normally
- ```bash start.sh```

<br>

#### Start the application and automatically create a checkpoint after startup
1. Make sure the folder ```tmp_checkpoint``` exists
2. Remove all files from the folder ```tmp_checkpoint``` with ```rm ./tmp_checkpoint/*.*```
3. Start the application and automatically create a checkpoint
- ```bash start-autocrac.sh```

<br>

#### Start the application and manually create a snapshot
1. Make sure the folder ```tmp_checkpoint``` exists
2. Remove all files from the folder ```tmp_checkpoint``` with ```rm ./tmp_checkpoint/*.*```
3. Start the application and automatically create a checkpoint
- ```java -XX:CRaCCheckpointTo=./tmp_checkpoint -jar spring-petclinic-3.2.0.jar```
4. Start a second shell window
5. Go to the project folder
6. Create the checkpoint manually with
- ```jcmd spring-petclinic-3.2.0.jar JDK.checkpoint```

<br>

#### Restore the application from the previously created checkpoint
1. Restore the application from the stored checkpoint
- ```bash restore-autocrac.sh```
- 