#!/bin/bash
javac -cp ../tools/commons-text-1.2.jar:../tools/java-cup-11b-runtime.jar:. @files.lst
java -cp ../tools/commons-text-1.2.jar:../tools/java-cup-11b-runtime.jar:. fr.n7.stl.block.Driver

