#!/bin/bash

#Environment variables
# APP="tw"
# DEVELOPER="main"
# BRANCH=${bamboo.planRepository.branchName}
###

#{{{ Variables
#GREP_STR='TagesWoche | Die Wochenzeitung'
test $APP = 'tw' && GREP_STR='Die Wochenzeitung'
URL="$BRANCH.$DEVELOPER.$APP.newscoop-test.sourcefabric.org"
#}}}

TESTS=1
ERRORS=0
FAILURES=0
SKIP=0

#{{{ TestCase
START_TIME=$(date +%s)
DOC=$(curl "$URL") > /dev/null || ERRORS=1
TEST=$(echo "$DOC" | grep "$GREP_STR")
TIME=$(expr $(date +%s) - $START_TIME)

echo '<testcase classname="classname" name="our_test_name" time="'$TIME'">' >> tmp.xml
if test $ERRORS -ne 0
then
   echo '<error type="execution_error">' >> tmp.xml
   echo 'some error occured, check out the logs\n</error>' >> tmp.xml
fi
if test -z "$TEST"
then
   FAILURES=1
   echo '<error type="assertion_error">' >> tmp.xml
   echo "no '$GREP_STR' text found on page ""$URL""</error>" >> tmp.xml
fi
echo '</testcase>' >> tmp.xml
#}}}

#{{{ Writing test results:
echo '<?xml version="1.0" encoding="UTF-8"?>' > results.xml
echo '<testsuite name="nosetests" tests="'$TESTS'" errors="'$ERRORS'" failures="'$FAILURES'" skip="'$SKIP'">' >> results.xml
cat tmp.xml >> results.xml
echo '</testsuite>' >> results.xml
rm tmp.xml
touch -t $(date -d "1 sec" +%Y%m%d%H%M.%S) results.xml
#}}}

