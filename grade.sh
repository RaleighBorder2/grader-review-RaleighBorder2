CPATH='.:lib/hamcrest-core-1.3.jar:lib/junit-4.13.2.jar'
failCode='0'

rm -rf student-submission
rm -rf grading-area

mkdir grading-area

git clone $1 student-submission
echo 'Finished cloning'

[[ -f ./student-submission/ListExamples.java ]] && echo 'correct file' || failCode = '4'

if [[ $failCode -eq '0' ]]
then
  cp ./student-submission/ListExamples.java ./grading-area
  cp ./*.java ./grading-area
  cp -r ./lib ./grading-area

  cd ./grading-area

  javac -cp $CPATH *.java
  java -cp $CPATH org.junit.runner.JUnitCore TestListExamples > junitOutput.txt

  echo "YOUR GRADE:"

  [[ `grep -c "initializationError" junitOutput.txt` -eq '1' ]] && echo "compilation error, 0%"
  [[ `grep -c "Failures: 2" junitOutput.txt` -eq '1' ]] && echo "2 failures, 0%"
  [[ `grep -c "Tests run: 2,  Failures: 1" junitOutput.txt` -eq '1' ]] && echo "1 failure, 50%"
  [[ `grep -c "OK (2 tests)" junitOutput.txt` -eq '1' ]] && echo "No failures, 100%"
fi

[[ $failCode == 4 ]] && echo "incorrect file, 0%"

# heyyyyyyy
