 clear,clc
 Ms = 1250;
 Ks = 44000;
 Cs = 4000;
 Mus = 200;
 Kus = 400000;
 Cus = 100;
 A = [0,1,0,0;-Kus/Mus,-(Cs+Cus)/Mus,Ks/Mus,Cs/Mus;0,-1,0,1;0,Cs/Ms,-Ks/Ms,-Cs/Ms];
B = [0;Ms/Mus;0;-1]/Ms;
B2 = [-1;Cus/Mus;0;0];
C = [-1;Cus/Mus;0;0];
% Controllablity matrix 
Qc = [B,A*B,A*A*B,A*A*A*B];
rank(Qc); % = 4
% Design of LQ controller
Q = 1000*eye(4);
R = 0.01;
K = lqr(A,B,Q,R);

plot_bode_graph(A,B,B2,Q,R,"Q11")
plot_bode_graph(A,B,B2,Q,R,"Q22")
plot_bode_graph(A,B,B2,Q,R,"Q33")
plot_bode_graph(A,B,B2,Q,R,"Q44")
plot_bode_graph(A,B,B2,Q,R,"R")

function plot_bode_graph(A,B1,B2,Q,R,variable)
    K = {[],[],[],[]};
    if variable == "Q11"
        for i = 2:5
           Q(1,1) = 10^i;
           K{i-1} = lqr(A,B1,Q,R);
        end
    elseif variable == "Q22"
        for i = 2:5
           Q(2,2) = 10^i;
           K{i-1} = lqr(A,B1,Q,R);
        end
    elseif variable == "Q33"
        for i = 2:5
           Q(3,3) = 10^i;
           K{i-1} = lqr(A,B1,Q,R);
        end 
    elseif variable == "Q44"
        for i = 2:5
           Q(4,4) = 10^i;
           K{i-1} = lqr(A,B1,Q,R);
        end
    elseif variable == "R"
        for i = 0:3
           R = 10^(-i);
           K{i+1} = lqr(A,B1,Q,R);
        end 
    end
    title_set = ["z_{us}-z_0","d(z_{us})/dt","z_s-z_{us}","dz_s/dt"];
    color_set = ["r","g","b","k"];
    figure()
    for i = 1:4
        subplot(2,2,i)
        for j = 1:size(K,2)
            sys = ss(A-B1*K{j},B2,eye(4),zeros(4,1));
            bode(sys(i),color_set(j))
            hold on 
        end
        if variable == 'R'
            legend('R = 10^0','R = 10^{-1}','R = 10^{-2}','R = 10^{-3}') 
        else
            legend(variable+" = 10^2",variable+" = 10^{3}",variable+" = 10^{4}",variable+" = 10^{5}") 
        end
        title(title_set(i)) 
    end
    
end