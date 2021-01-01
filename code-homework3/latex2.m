function f = latex2(A, precision)
% 没输入精度参数时，默认精度为小数后4位
if nargin == 1
    precision = '4';
else
    precision = int2str(precision);
end
% 定义单一元素输出格式
out_num = [' %0.' precision 'f &'];
% 用作整数输出判断
z = zeros(1, str2num(precision) + 1);
z(1) = '.';
z(2 : end) = '0';
z = char(z);
% 求矩阵大小
[r c] = size(A);
nc = zeros(1, c);
nc = 99;  % 存放character c
% 生成第一句Latex语句
out = sprintf('\\left(\n\t\\begin{array}{%s}', char(nc));
% 二重循环，用作生成整个矩阵的Latex语句
for i = 1 : r
    out = [out sprintf('\n\t')]; % 换行
    for j = 1 : c
        temp = sprintf(out_num, A(i, j));
        % 小数位皆为零时，把数取整。如1.0001取为1
        dot_position = find(temp == '.');
        if temp(dot_position : end - 2) == z
            temp = temp(1 : dot_position - 1);
            temp = [temp ' &'];
            % 要取整时，如有负号，则必须丢掉
            if temp(2) == '-'
               temp = [temp(1) temp(3 : end)];
            end
        end
        out = [out temp];
    end
    % 丢掉最后的'&'号
    out = out(1 : end - 1);
    % 行末加上'\\'号
    out = [out '\\'];
end
% 加上最后一句结束代码
out = [out sprintf('\n\t\\end{array}\n\\right)')];
f = out;
