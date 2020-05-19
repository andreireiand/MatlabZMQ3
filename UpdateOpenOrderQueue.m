function UpdateOpenOrderQueue(rows, newQueueSize)
%UpdateOrder Summary of this function goes here
%   
%   play with queueNr=3, oldQueueSize=4
%   Options:
%   
%   1) newQueueSize > oldQueueSize => oldQueueSize <= newQueueSize, queueNr stays unchanged, 
%   unless it's -1 and then queueNr <= newQueueSize. If newQueueSize < queueNr => queueNr = newQueueSize
%   
%   2) newQueueSize < oldQueueSize => if newQueueSize < queueNr then queueNr <= oldQueueSize <= newQueueSize
%   else oldQueueSize <= newQueueSize
%   
%   
    global ordersOpen
try 
%     if newQueueSize == 1
%         u = 0;
%     end
    
    disp(strcat('In UpdateOrder, inputs are: rows = ', num2str(rows), '; newQueueSize = ', num2str(newQueueSize)));
    for i = 1:numel(rows)
        rowID = rows(i);
        row = ordersOpen(rowID,:);
        if numel(row) < 4 
            row(4) = 0; 
            row(5) = 0; 
        end
        oldQueueSize    = row(4);
        queueNr         = row(3);
        
        if newQueueSize > oldQueueSize
            oldQueueSize = newQueueSize;
            if queueNr == -1 
                queueNr = newQueueSize;
                oldQueueSize = newQueueSize;
            else
                if newQueueSize < queueNr
                    queueNr = newQueueSize;
                end
            end
        elseif newQueueSize < oldQueueSize
            if queueNr == -1 || newQueueSize < queueNr
                queueNr = newQueueSize;
                oldQueueSize = newQueueSize;
            else
                oldQueueSize = newQueueSize;
            end
        end
        ordersOpen(rowID,4) = oldQueueSize;
        ordersOpen(rowID,3) = queueNr;
        disp(strcat('In UpdateOrder, rowID=',num2str(rowID),'; updating with queneNr=',num2str(queueNr),';oldQueueSize=',num2str(oldQueueSize)));
    end
catch ME
    disp(ME.getReport);
    rethrow(ME);
end    
end

