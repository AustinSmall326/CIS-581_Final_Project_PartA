% Author:       Austin Small
% Class:        CIS-581
% Project:      4A
% File Name:    carv.m
% Input:        I:      n x m x 3 matrix representing the input image.
%               nr:     the number of rows to be removed from the image.
%               nc:     the number of columns to be removed from the image.
% Output:       Ic:     (n - nr) x (m - nc) x 3 matrix representing the 
%                       carved image.
%               T:      (nr + 1) x (nc + 1) matrix representing the 
%                       transport map.

function [Ic, T] = carv(I, nr, nc)
    T = zeros(nr+1, nc+1);
    TI = cell(nr+1, nc+1);
    TI{1,1} = I;
    % TI is a trace table for images. TI{r+1,c+1} records the image removed r rows and c columns.

    % Fill transport map and trace table.
    for i = 1 : nr + 1
        disp(i / (nc + 1));

        for j = 1 : nc + 1  
            
            if (i == 1 && j == 1)
                continue;
            end
            
            % Check if we are at a border.
            if (j == 1)
                IU        = TI{i - 1, j};
                e         = genEngMap(IU);
                [Mx, Tbx] = cumMinEngHor(e);
                [Ix, E]   = rmHorSeam(IU, Mx, Tbx);

                T(i, j)  = T(i - 1, j) + E;
                TI{i, j} = Ix;
            elseif (i == 1)
                IL        = TI{i, j - 1};
                e         = genEngMap(IL);
                [My, Tby] = cumMinEngVer(e);
                [Iy, E]   = rmVerSeam(IL, My, Tby);

                T(i, j)  = T(i, j - 1) + E;
                TI{i, j} = Iy;
            else
                IU        = TI{i - 1, j};
                e         = genEngMap(IU);
                [Mx, Tbx] = cumMinEngHor(e);
                [Ix, EU]   = rmHorSeam(IU, Mx, Tbx);
                
                IL        = TI{i, j - 1};
                e         = genEngMap(IL);
                [My, Tby] = cumMinEngVer(e);
                [Iy, EL]  = rmVerSeam(IL, My, Tby);

                if (EU <= EL)
                    T(i, j)  = T(i - 1, j) + EU;
                    TI{i, j} = Ix;
                else
                    T(i, j) = T(i, j - 1) + EL;
                    TI{i, j} = Iy;
                end
            end
        end
    end
    
    Ic = TI{nr+1,nc+1};
end