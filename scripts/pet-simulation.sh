# /bin/bash

mvn clean test-compile gatling:test -Dgatling.simulationClass=performance.PetSimulation -f ..
rm -rf target