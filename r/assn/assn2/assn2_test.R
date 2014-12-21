library('RUnit')

source('cachematrix.R')

test.suite <- defineTestSuite('cachematrix',
                              dirs=file.path('tests'),
                              testFileRegexp='^\\w+_test.R')

test.result <- runTestSuite(test.suite)

printTextProtocol(test.result)