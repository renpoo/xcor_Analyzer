%SolverTest.m

classdef SolverTest < matlab.unittest.TestCase
    % SolverTest tests solutions to the quadratic equation
    % a*x^2 + b*x + c = 0

    % ????????????????? ---------------   
    properties
        param
    end

    methods (TestMethodSetup)
        function setParams(testCase)
            testCase.param = 1
        end
    end
    %------------------------------------------------   

    % ??????????????? param ???
    methods (Test)
        function testRealSolution(testCase)
            actSolution = quadraticSolver(testCase.param,-3,2);
            expSolution = [2,1];
            testCase.verifyEqual(actSolution,expSolution);
        end
        function testImaginarySolution(testCase)
            actSolution = quadraticSolver(testCase.param,2,10);
            expSolution = [-1+3i, -1-3i];
            testCase.verifyEqual(actSolution,expSolution);
        end
    end

end