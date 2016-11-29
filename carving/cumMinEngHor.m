% Author:       Austin Small
% Class:        CIS-581
% Project:      4A
% File Name:    cumMinEngVer.m
% Input:        e:      n x m matrix representing the energy map.
% Output:       My:     n x m matrix representing the cumulative minimum
%                       energy map along horizontal direction.
%               Tby:    n x m matrix representing the backtrack table along
%                       horizontal direction.

function [My, Tby] = cumMinEngHor(e)
    % e is the energy map.
    % My is the cumulative minimum energy map along horizontal direction.
    % Tby is the backtrack table along horizontal direction.

    [ny,nx] = size(e);
    My = zeros(ny, nx);
    Tby = zeros(ny, nx);
    
    % Initialize first column of cumulative energy map.
    My(:,1) = e(:,1);
    
    % Implement bottom-up dynamic programming approach.  Iterate through
    % columns 2 thru end.
    for j = 2 : nx
        for i = 1 : ny
            minIndex = 2;
            
            % Check if this table element lies at the edge of the table.
            if (i == 1)
                if (My(i + 1, j - 1) < My(i, j - 1))
                    minIndex = 3;
                end
            elseif (i == ny)
                if (My(i - 1, j - 1) < My(i, j - 1))
                    minIndex = 1;
                end
            else
                if (My(i - 1, j - 1) < My(i, j - 1) && My(i - 1, j - 1) < My(i + 1, j - 1))
                    minIndex = 1;
                elseif (My(i + 1, j - 1) < My(i, j - 1) && My(i + 1, j - 1) < My(i - 1, j - 1))
                    minIndex = 3;
                end
            end
            
            % Update Tby and My.
            Tby(i, j) = minIndex;
            My(i, j)  = e(i, j) + My(i + (minIndex - 2), j - 1);
        end 
    end
end