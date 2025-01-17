function img2 = img2mif(imgfile,outfile,mysize)

img=imread(imgfile);
img=img(mysize(1):mysize(2),mysize(3):mysize(4),:);

height = mysize(2)-mysize(1)+1;
width = mysize(4)-mysize(3)+1;
s = fopen(outfile,'wb');
fprintf(s,'%s\n','--VGA Memory Map');
fprintf(s,'---Height: %d,Width: %d\n\n',height,width);
fprintf(s,'%s\n','WIDTH=12;');
fprintf(s,'DEPTH=%d;\n',height*width);
fprintf(s,'%s\n','ADDRESS_RADIX=HEX;');
fprintf(s,'%s\n','DATA_RADIX=HEX;');

fprintf(s,'%s\n','CONTENT');
fprintf(s,'%s\n','BEGIN');
cnt = 0;
img2 =img;
for r=1 :height
    for c=1:width
        cnt = cnt+1;
        if(c<=height)
            R = img(r,c,1);
            G = img(r,c,2);
            B = img(r,c,3);
        else
            R = 15;
            G = 15;
            B = 15;
        end
        fprintf(s,'%06X: %01X%01X%01X;\n',cnt-1,bitand(R,240)/16,bitand(G,240)/16,bitand(B,240)/16);
    end
end
fprintf(s,'%s\n','END;');

fclose(s);

        
        
        