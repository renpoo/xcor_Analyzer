%AC_Test.m

classdef AC_Test < matlab.unittest.TestCase
    % ??????????????? param ???
    methods (Test)
        function testRealSolution(testCase)
            x = {0};            
            actSolution = AC_(x);
            expSolution = {0};
            testCase.verifyEqual(actSolution,expSolution);
        end
    end

end