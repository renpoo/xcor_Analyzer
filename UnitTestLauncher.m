% Unit Test Launcher

%clear;

import matlab.unittest.TestSuite
suiteClass = TestSuite.fromClass(?ut_PHI_xy_);
result = run(suiteClass);
