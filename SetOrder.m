function SetOrder(orderID, val_1, val_2, val_3, val_4, val_5, val_6)
%UNTITLED Summary of this function goes here
%   
%
%
    global ordersOpen
try    
    if orderID == -1
        orderID = size(ordersOpen,1) + 1; 
    end
    ordersOpen(orderID,1) = val_1;
    ordersOpen(orderID,2) = val_2;
    ordersOpen(orderID,3) = val_3;
    ordersOpen(orderID,4) = val_4;
    assert(isnumeric(val_5) & numel(val_5)==1);
    ordersOpen(orderID,5) = val_5;  
    assert(isnumeric(val_6) & numel(val_6)==1);
    ordersOpen(orderID,6) = val_6;  
catch ME
    disp(ME.getReport);
    rethrow(ME);
end     
end

