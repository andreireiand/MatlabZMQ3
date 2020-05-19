function UpdateOrders(tokens, updateType)
%UpdateOrders Summary of this function goes here
%   
%   updateType = 1 for bid (previously, true), or -1 for ask (previously, false)    
%   Expected format for ordersOpen matrix: 
%
%   1 Type (1=long, -1=short, 0=goFlat)
%   2 Price/key (value)
%   3 QueueNr (ordre number in queue; -1=needs set initial val; 0=executed;)
%   4 Queue total size (Required)
%   5 Exit Price ... order execution should open another order to be used for exit of position % order volSize (assumed 1)
%   6 Unused !!! % Result (1=Opened/Active, 0=Closed/Executed)
%
%   Minimum to fill into the OrdersOpen is: 
%   
%   {-1,0,1}    Price   -1 (this will place order in queue)
%
%   Tokens numbering is done based on:
%   ES 09-19 Globex; Bid; 2869.5; 12; 8/5/2019 3:34:23 PM; False; 50; 0.25; 2869.5; 2869.75

%   format of ordersOpen array vector, shown below - first 3 fields
%   mandatory

global ordersOpen

try 
    if ~isempty(ordersOpen)

        key = str2double(tokens{3});    % as in price

        if updateType == 1
            % for a bid update, close down any shorts/go-flats at a price equal or LOWER  than key
            order = find(ordersOpen(:,2) <= key & (ordersOpen(:,1) == -1 | ordersOpen(:,1) == 0 | ordersOpen(:,1) ==  2));
        elseif updateType == -1
            % for a ask update, close down any  longs/go-flats at a price equal or HIGHER than key
            order = find(ordersOpen(:,2) >= key & (ordersOpen(:,1) ==  1 | ordersOpen(:,1) == 0 | ordersOpen(:,1) == -2));
        end
        
        if ~isempty(order) 
            assert(numel(order)==1);
            CloseOrder(order,key); % orders to be executed anyways 
        end
        
        % catch limit orders of same direction and at same price - we need to update their queueSize (if necessary)
        orderAtPrice = find(ordersOpen(:,2) == key & ordersOpen(:,1) == updateType, 1);
        
        if ~isempty(orderAtPrice) % if is not empty
            assert(numel(orderAtPrice)==1);
            queueSize = str2double(tokens{4});
            UpdateOpenOrderQueue(orderAtPrice, queueSize);
        else % if it is empty (this branch needed for the disp statements below)
%             ordersAtPrice = -1;
%             queueSize = -1;
        end

%         if updateType == 1
%             disp(strcat('In UpdateOrders, bidUpdate, price: ',tokens{3},'; Calling UpdateOrder w/ buyOrdersAtPriceRowID :',num2str(ordersAtPrice),';bidQueueSize =',num2str(queueSize),'_on tokens=',tokens{2},';',tokens{5}));
%         elseif updateType == -1
%             disp(strcat('In UpdateOrders, askUpdate, price: ',tokens{3},'; Calling UpdateOrder w/ sellOrdersAtPriceRowID :',num2str(ordersAtPrice),';askQueueSize =',num2str(queueSize),'_on tokens=',tokens{2},';',tokens{5}));            
%         end    
    end
catch ME
    disp(ME.getReport);
    rethrow(ME);
end
end

