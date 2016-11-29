% Author:       Austin Small
% Class:        CIS-581
% Project:      4A
% File Name:    getSolutionVect.m
% Input:        indexes:    h' x w' matrix representing the indices of each
%                           replacement pixel.
%               source:     h x w matrix representing one channel of source
%                           image.
%               target:     h' x w' matrix representing one channel of 
%                           target image.
%               offsetX:    the x axis offset of source image regard of 
%                           target image.
%               offsetY:    the y axis offset of source image regard of 
%                           target image.
% Output:       solVector:  1 x n vector representing the solution vector.

function [solVector] = getSolutionVect(indexes, source, target, offsetX, offsetY)
    newSource = zeros(size(target, 1), size(target, 2));
    newSource(offsetY + 1 : offsetY + size(source, 1), ...
              offsetX + 1 : offsetX + size(source, 2)) = source;
          
    % Determine the number of replacement pixels.
    count = 0;
    
    for i = 1 : size(indexes, 1)
        for j = 1 : size(indexes, 2)
            if (indexes(i, j) > 0)
                count = count + 1;
            end
        end
    end

    solVector = zeros(count, 1);
    
    % Generate coefficient matrix.
    for i = 1 : size(indexes, 1)
        for j = 1 : size(indexes, 2)
            % First check if we are at a replacement pixel.
            index = indexes(i, j);
            
            if (index > 0)
                % Evaluate all four bordering pixels of source.
                numSourceNeighbors = 0;
                
                try
                	numSourceNeighbors = numSourceNeighbors + 1;
                	solVector(index, 1) = solVector(index, 1) - newSource(i - 1, j);
                catch
                end
                
                try
                	numSourceNeighbors = numSourceNeighbors + 1;
                	solVector(index, 1) = solVector(index, 1) - newSource(i + 1, j);
                catch
                end
                
                try
                    numSourceNeighbors = numSourceNeighbors + 1;
                    solVector(index, 1) = solVector(index, 1) - newSource(i, j - 1);
                catch
                end
                
                try
                    numSourceNeighbors = numSourceNeighbors + 1;
                    solVector(index, 1) = solVector(index, 1) - newSource(i, j + 1);
                catch
                end
                
                solVector(index, 1) = solVector(index, 1) + numSourceNeighbors * newSource(i, j);
                
                % Evaluate all four bordering pixels of target.                
                try
                    if (indexes(i - 1, j) == 0)
                        solVector(index, 1) = solVector(index, 1) + target(i - 1, j);
                    end
                catch
                end
                
                try
                    if (indexes(i + 1, j) == 0)
                        solVector(index, 1) = solVector(index, 1) + target(i + 1, j);
                    end
                catch
                end
                
                try
                    if (indexes(i, j - 1) == 0)
                        solVector(index, 1) = solVector(index, 1) + target(i, j - 1);
                    end
                catch
                end
                
                try
                    if (indexes(i, j + 1) == 0)
                        solVector(index, 1) = solVector(index, 1) + target(i, j + 1);
                    end
                catch
                end
            end  
        end
    end
end