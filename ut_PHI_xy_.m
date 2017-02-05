%ut_PHI_xy_.m


classdef ut_PHI_xy_ < matlab.unittest.TestCase
    properties
        comparison
        tolerance
        tolVal
    end
    
    methods (TestMethodSetup)
        function setParams(testCase)
            %testCase.comparison = 'value';
            testCase.comparison = 'xcorr';
            
            testCase.tolerance = 'AbsTol';
            %testCase.tolerance = 'RelTol';
            
            testCase.tolVal = 0.001;
        end
    end
    
    
    
    
    methods (Test)
        
        function testPHI_xy_ZerosRow_10(testCase)
            x = [0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000];
            y = x;
            actSolution = PHI_xy_( x, y );
            %expSolution = [0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000, 0.0000];
            expSolution = [NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN, NaN];
            if (strcmp(testCase.comparison, 'xcorr'))
                expSolution = xcorr(x, y, 'coeff');
            end
            testCase.verifyEqual(actSolution, expSolution, testCase.tolerance, testCase.tolVal);
        end
        
        
        function testPHI_xy_OnesRow_10(testCase)
            x = [1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000, 1.0000];
            y = x;
            actSolution = PHI_xy_( x, y );
            expSolution = [0.1000, 0.2000, 0.3000, 0.4000, 0.5000, 0.6000, 0.7000, 0.8000, 0.9000, 1.0000, 0.9000, 0.8000, 0.7000, 0.6000, 0.5000, 0.4000, 0.3000, 0.2000, 0.1000];
            if (strcmp(testCase.comparison, 'xcorr'))
                expSolution = xcorr(x, y, 'coeff');
            end
            testCase.verifyEqual(actSolution, expSolution, testCase.tolerance, testCase.tolVal);
        end
        
        
        function testPHI_xy_Self_10(testCase)
            x = [1,2,3,4,5,6,7,8,9,10];
            y = x;
            actSolution = PHI_xy_( x, y );
            expSolution = [0.0260, 0.0753, 0.1455, 0.2338, 0.3377, 0.4545, 0.5818, 0.7169, 0.8571, 1.0000, 0.8571, 0.7169, 0.5818, 0.4545, 0.3377, 0.2338, 0.1455, 0.0753, 0.0260];
            if (strcmp(testCase.comparison, 'xcorr'))
                expSolution = xcorr(x, y, 'coeff');
            end
            testCase.verifyEqual(actSolution, expSolution, testCase.tolerance, testCase.tolVal);
        end
        
        
        function testPHI_xy_Different_10(testCase)
            x = [1,2,3,4,5,6,7,8,9,10];
            y = [10,9,8,7,6,5,4,3,2,1];
            actSolution = PHI_xy_( x, y );
            expSolution = [0.0026, 0.0104, 0.0260, 0.0519, 0.0909, 0.1455, 0.2182, 0.3117, 0.4286, 0.5714, 0.6857, 0.7688, 0.8182, 0.8312, 0.8052, 0.7377, 0.6260, 0.4675, 0.2597];
            if (strcmp(testCase.comparison, 'xcorr'))
                expSolution = xcorr(x, y, 'coeff');
            end
            testCase.verifyEqual(actSolution, expSolution, testCase.tolerance, testCase.tolVal);
        end
        
        
        function testPHI_xy_Sinewave_11(testCase)
            x = [0.0000, 0.5878, 0.9511, 0.9511, 0.5878, 0.0000, -0.5878, -0.9511, -0.9511, -0.5878, -0.0000];
            %x = generateSinWave_(1.0, 1, 10, 1, 0 );
            y = x;
            actSolution = PHI_xy_( x, y );
            expSolution = [-0.0000, -0.0000, -0.0691, -0.2236, -0.4045, -0.5000, -0.4045, -0.0854, 0.3781, 0.8090, 1.0000, 0.8090, 0.3781, -0.0854, -0.4045, -0.5000, -0.4045, -0.2236, -0.0691, -0.0000, -0.0000];
            if (strcmp(testCase.comparison, 'xcorr'))
                expSolution = xcorr(x, y, 'coeff');
            end
            testCase.verifyEqual(actSolution, expSolution, testCase.tolerance, testCase.tolVal);
        end
        
        
        function testPHI_xy_Sinewave_w_Cosinewave_11(testCase)
            x = [0.0000, 0.5878, 0.9511, 0.9511, 0.5878, 0.0000, -0.5878, -0.9511, -0.9511, -0.5878, -0.0000];
            y = [1.0000, 0.8090, 0.3090, -0.3090, -0.8090, -1.0000, -0.8090, -0.3090, 0.3090, 0.8090, 1.0000];
            actSolution = PHI_xy_( x, y );
            expSolution = [0.0000, 0.1073, 0.2605, 0.3473, 0.2683, -0.0000, -0.3756, -0.6946, -0.7814, -0.5366, 0.0000, 0.5366, 0.7814, 0.6946, 0.3756, 0.0000, -0.2683, -0.3473, -0.2605, -0.1073, -0.0000];
            if (strcmp(testCase.comparison, 'xcorr'))
                expSolution = xcorr(x, y, 'coeff');
            end
            testCase.verifyEqual(actSolution, expSolution, testCase.tolerance, testCase.tolVal);
        end
        
        
        function testPHI_xy_Cosinewave_w_Sinewave_11(testCase)
            x = [1.0000, 0.8090, 0.3090, -0.3090, -0.8090, -1.0000, -0.8090, -0.3090, 0.3090, 0.8090, 1.0000];
            y = [0.0000, 0.5878, 0.9511, 0.9511, 0.5878, 0.0000, -0.5878, -0.9511, -0.9511, -0.5878, -0.0000];
            actSolution = PHI_xy_( x, y );
            expSolution = [-0.0000, -0.1073, -0.2605, -0.3473, -0.2683, 0.0000, 0.3756, 0.6946, 0.7814, 0.5366, 0.0000, -0.5366, -0.7814, -0.6946, -0.3756, -0.0000, 0.2683, 0.3473, 0.2605, 0.1073, 0.0000];
            if (strcmp(testCase.comparison, 'xcorr'))
                expSolution = xcorr(x, y, 'coeff');
            end
            testCase.verifyEqual(actSolution, expSolution, testCase.tolerance, testCase.tolVal);
        end
        
        
    end
    
end
