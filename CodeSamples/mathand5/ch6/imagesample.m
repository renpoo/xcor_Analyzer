classdef imagesample < handle
%classdef imagesample 
    properties
        gazou;
    end
    methods
        function obj=imagesample(gazou)
            obj.gazou = gazou;
        end
        function obj=filtering(obj)
            obj.gazou = conv2(obj.gazou,ones(3)/9,'same');
        end
        function imshow(obj)
            image(obj.gazou);
            axis equal;axis off;
            colormap gray;
        end
    end
    
end
