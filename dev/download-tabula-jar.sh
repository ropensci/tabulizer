#/bin/bash

cd ~/github/tabulizer

git clone --depth 1 git@github.com:tabulapdf/tabula-java.git

cd tabula-java

mvn clean compile assembly:single

mv target/tabula-1.0.6-SNAPSHOT-jar-with-dependencies.jar target/tabula.jar

mv target/tabula.jar ../inst/java/tabula.jar
