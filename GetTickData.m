        function tick = GetTickData(newTickData)
            if size(newTickData,1) > 1
                tick = native2unicode(newTickData');
            else 
                tick = newTickData;
            end
        end