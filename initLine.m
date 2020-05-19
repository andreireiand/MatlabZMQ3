function lineItem = initLine(a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11, oldLineItem)
%
%
%

try
    
    lineItem = []; 
    
    if nargin == 11
        lineItem = [a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11];
    elseif nargin == 12
        lineItem = [oldLineItem; a1,a2,a3,a4,a5,a6,a7,a8,a9,a10,a11];
    end
    
    assert(~isempty(lineItem));
    
catch ME
    disp(ME.getReport);
    rethrow(ME);
end      
end

