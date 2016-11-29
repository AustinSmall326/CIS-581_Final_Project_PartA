% Author:       Austin Small
% Class:        CIS-581
% Project:      4A
% File Name:    getCoefMatrix.m
% Input:        indexes:    h' x w' matrix representing the indices of each
%                           replacement pixel.
% Output:       coefM:      n x n sparse matrix representing the 
%                           coefficient matrix.  n is the number of 
%                           replacement pixels.

function coefM = getCoefMatrix(indexes)
    % Determine the number of replacement pixels.
    count = 0;
    
    for i = 1 : size(indexes, 1)
        for j = 1 : size(indexes, 2)
            if (indexes(i, j) > 0)
                count = count + 1;
            end
        end
    end

    coefM = sparse(count, count);
    
    % Generate coefficient matrix.
    for i = 1 : size(indexes, 1)
        for j = 1 : size(indexes, 2)
            % First check if we are at a replacement pixel.
            index = indexes(i, j);
            
            if (index > 0)
                % Evaluate all four bordering pixels.
                numNeighbors = 0;
                
                try
                    if (indexes(i - 1, j) > 0)
                        numNeighbors = numNeighbors + 1;
                        coefM(index, indexes(i - 1, j)) = -1;
                    else
                        numNeighbors = numNeighbors + 1;
                    end
                catch
                end
                
                try
                    if (indexes(i + 1, j) > 0)
                        numNeighbors = numNeighbors + 1;
                        coefM(index, indexes(i + 1, j)) = -1;
                    else
                        numNeighbors = numNeighbors + 1;
                    end
                catch
                end
                
                try
                    if (indexes(i, j - 1) > 0)
                        numNeighbors = numNeighbors + 1;
                        coefM(index, indexes(i, j - 1)) = -1;
                    else
                        numNeighbors = numNeighbors + 1;
                    end
                catch
                end
                
                try
                    if (indexes(i, j + 1) > 0)
                        numNeighbors = numNeighbors + 1;
                        coefM(index, indexes(i, j + 1)) = -1;
                    else
                        numNeighbors = numNeighbors + 1;
                    end
                catch
                end
                
                coefM(index, index) = numNeighbors;
            end
        end
    end
end