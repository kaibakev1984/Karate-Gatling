# /bin/bash

mvn clean test-compile gatling:test -Dgatling.simulationClass=performance.UserSimulation -f ..
rm -rf target