# common vars
expectedversion="0.1.2"
scriptname="fibo-check"
libname="test-lib"
svcname="test-service"

# support functions
get-result-part () {
    result=$1
    echo "$result"|head -2|tail -1
}

# unit tests
testHelp () {
    result1=`./lfetool -h`
    expected1="Script: lfetool, v$expectedversion"
    assertEquals "$expected1" "`get-result-part "$result1"`"
    result2=`./lfetool help`
    expected2="Script: lfetool, v$expectedversion"
    assertEquals "$expected2" "`get-result-part "$result2"`"
    assertEquals "$result1" "$result2"
}

testVersion () {
    result1=`./lfetool -v`
    assertEquals "$result1" "$expectedversion"
    result2=`./lfetool version`
    assertEquals "$result2" "$expectedversion"
    assertEquals "$result1" "$result2"
}

testNewScript () {
    ./lfetool new script $scriptname
    result=`./fibo-check 42`
    expected="factorial 42 = 1405006117752879898543142606244511569936384000000000"
    assertEquals "$expected" "$result"
}

oneTimeTearDown () {
    rm $scriptname
    rm -rf $libname $svcname
}

# pull in the framework
. ./test/shunit2