% This would be a good function to have

remain = path;
allStr = {};
while ~strcmp(remain,'')
   [token, remain] = strtok(remain,pathsep);
   dircontents = dir([token filesep '*.m']);
   for i=1:numel(dircontents)
       filename = strtok(dircontents(i).name,'.m');
       str = which(dircontents(i).name,'-all');
       if (length(str) > 1 & ~contains(str{1},'Contents') && ~contains(str{1},'Applications'))
           disp(str)
           allStr = [allStr;str];
       end
   end
end
