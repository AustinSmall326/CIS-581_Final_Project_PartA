% Author:       Austin Small
% Class:        CIS-581
% Project:      4A
% File Name:    cumMinEngVer.m
% Input:        e:      n x m matrix representing the energy map.
% Output:       Mx:     n x m matrix representing the cumulative minimum
%                       energy map along vertical direction.
%               Tbx:    n x m matrix representing the backtrack table along
%                       vertical direction.

function [Mx, Tbx] = cumMinEngVer(e)
    % e is the energy map.
    % Mx is the cumulative minimum energy map along vertical direction.
    % Tbx is the backtrack table along vertical direction.

    [ny,nx] = size(e);
    Mx = zeros(ny, nx);
    Tbx = zeros(ny, nx);
    
    % Initialize first row of cumulative energy map.
    Mx(1,:) = e(1,:);
    
    % Implement bottom-up dynamic programming approach.  Iterate through
    % rows 2 thru end.
    for i = 2 : ny
        for j = 1 : nx
            minIndex = 2;
            
            % Check if this table element lies at the edge of the table.
            if (j == 1)
                if (Mx(i - 1, j + 1) < Mx(i - 1, j))
                    minIndex = 3;
                end
            elseif (j == nx)
                if (Mx(i - 1, j - 1) < Mx(i - 1, j))
                    minIndex = 1;
                end
            else
                if (Mx(i - 1, j - 1) < Mx(i - 1, j) && Mx(i - 1, j - 1) < Mx(i - 1, j + 1))
                    minIndex = 1;
                elseif (Mx(i - 1, j + 1) < Mx(i - 1, j) && Mx(i - 1, j + 1) < Mx(i - 1, j - 1))
                    minIndex = 3;
                end
            end
            
            % Update Tbx and Mx.
            Tbx(i, j) = minIndex;
            Mx(i, j)  = e(i, j) + Mx(i - 1, j + (minIndex - 2));
        end 
    end
end