function D = dumpData_serial_( X )

D = sprintf('%0.4f', X(1));

for i = 2 : length( X )
    D = sprintf('%s, %0.04f', D, X(i));
end

%D = sprintf('D = [%s];', D);
